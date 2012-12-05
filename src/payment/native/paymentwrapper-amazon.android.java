import java.util.Date;
import java.util.LinkedList;
import java.util.Map;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.util.Log;

import com.amazon.inapp.purchasing.BasePurchasingObserver;
import com.amazon.inapp.purchasing.GetUserIdResponse;
import com.amazon.inapp.purchasing.GetUserIdResponse.GetUserIdRequestStatus;
import com.amazon.inapp.purchasing.Item;
import com.amazon.inapp.purchasing.ItemDataResponse;
import com.amazon.inapp.purchasing.Offset;
import com.amazon.inapp.purchasing.PurchaseResponse;
import com.amazon.inapp.purchasing.PurchaseUpdatesResponse;
import com.amazon.inapp.purchasing.PurchasingManager;
import com.amazon.inapp.purchasing.Receipt;
import com.amazon.inapp.purchasing.SubscriptionPeriod;

/**
 * Purchasing Observer will be called on by the Purchasing Manager asynchronously.
 * Since the methods on the UI thread of the application, all fulfillment logic is done via an AsyncTask. This way, any
 * intensive processes will not hang the UI thread and cause the application to become
 * unresponsive.
 */
class MonkeyPurchaseObserver extends BasePurchasingObserver {
    private static final String OFFSET = "offset";
    private static final String TAG = "Amazon-IAP";
    public Map<String, String> requestIds;
    private String userId;
    public Integer taskCount = 0;

    public MonkeyPurchaseObserver(Context context) {
        super(context);
    }

    /**
     * Invoked once the observer is registered with the Puchasing Manager If the boolean is false, the application is
     * receiving responses from the SDK Tester. If the boolean is true, the application is live in production.
     *
     * @param isSandboxMode
     *            Boolean value that shows if the app is live or not.
     */
    @Override
    public void onSdkAvailable(final boolean isSandboxMode) {
        Log.v(TAG, "onSdkAvailable recieved: Response -" + isSandboxMode);
        requestIds = new HashMap<String, String>();
        PurchasingManager.initiateGetUserIdRequest();
    }

    /**
     * Invoked once the call from initiateGetUserIdRequest is completed.
     * On a successful response, a response object is passed which contains the request id, request status, and the
     * userid generated for your application.
     *
     * @param getUserIdResponse
     *            Response object containing the UserID
     */
    @Override
    public void onGetUserIdResponse(final GetUserIdResponse getUserIdResponse) {
        Log.v(TAG, "onGetUserIdResponse recieved: Response -" + getUserIdResponse);
        Log.v(TAG, "RequestId:" + getUserIdResponse.getRequestId());
        Log.v(TAG, "IdRequestStatus:" + getUserIdResponse.getUserIdRequestStatus());
        new GetUserIdAsyncTask().execute(getUserIdResponse);
    }

    /**
     * Is invoked once the call from initiatePurchaseRequest is completed.
     * On a successful response, a response object is passed which contains the request id, request status, and the
     * receipt of the purchase.
     *
     * @param purchaseResponse
     *            Response object containing a receipt of a purchase
     */
    @Override
    public void onPurchaseResponse(final PurchaseResponse purchaseResponse) {
        Log.v(TAG, "onPurchaseResponse recieved");
        Log.v(TAG, "PurchaseRequestStatus:" + purchaseResponse.getPurchaseRequestStatus());
        taskCount++;
        new PurchaseAsyncTask().execute(purchaseResponse);
    }

    /*
     * Helper method to print out relevant receipt information to the log.
     */
    private void printReceipt(final Receipt receipt) {
        Log.v(
            TAG,
            String.format("Receipt: ItemType: %s Sku: %s SubscriptionPeriod: %s", receipt.getItemType(),
                receipt.getSku(), receipt.getSubscriptionPeriod()));
    }

    public SharedPreferences getSharedPreferencesForCurrentUser() {
        return MonkeyGame.activity.getSharedPreferences(userId, Context.MODE_PRIVATE);
    }

    /*
     * Started when the Observer receives a GetUserIdResponse. The Shared Preferences file for the returned user id is
     * accessed.
     */
    private class GetUserIdAsyncTask extends AsyncTask<GetUserIdResponse, Void, Boolean> {
        @Override
        protected Boolean doInBackground(final GetUserIdResponse... params) {
            GetUserIdResponse getUserIdResponse = params[0];

            if (getUserIdResponse.getUserIdRequestStatus() == GetUserIdRequestStatus.SUCCESSFUL) {
                userId = getUserIdResponse.getUserId();
                return true;
            } else {
                Log.v(TAG, "onGetUserIdResponse: Unable to get user ID.");
                return false;
            }
        }

        /*
         * Call initiatePurchaseUpdatesRequest for the returned user to sync purchases that are not yet fulfilled.
         */
        @Override
        protected void onPostExecute(final Boolean result) {
            super.onPostExecute(result);
            if (result) {
                PurchasingManager.initiatePurchaseUpdatesRequest(Offset.fromString(
                    getSharedPreferencesForCurrentUser()
                    .getString(OFFSET, Offset.BEGINNING.toString())));
            }
        }
    }

    /*
     * Started when the observer receives a Purchase Response
     * Once the AsyncTask returns successfully, the UI is updated.
     */
    private class PurchaseAsyncTask extends AsyncTask<PurchaseResponse, Void, Boolean> {
        @Override
        protected Boolean doInBackground(final PurchaseResponse... params) {
            final PurchaseResponse purchaseResponse = params[0];

            if (!purchaseResponse.getUserId().equals(userId)) {
                // currently logged in user is different than what we have so update the state
                userId = purchaseResponse.getUserId();
                PurchasingManager.initiatePurchaseUpdatesRequest(Offset.fromString(
                    getSharedPreferencesForCurrentUser()
                    .getString(OFFSET, Offset.BEGINNING.toString())));
            }
            final SharedPreferences settings = getSharedPreferencesForCurrentUser();
            final SharedPreferences.Editor editor = settings.edit();
            switch (purchaseResponse.getPurchaseRequestStatus()) {
            case SUCCESSFUL:
                /*
                 * You can verify the receipt and fulfill the purchase on successful responses.
                 */
                final Receipt receipt = purchaseResponse.getReceipt();
                String key = "";
                switch (receipt.getItemType()) {
                case CONSUMABLE:
                    editor.putInt(key, settings.getInt(key, 0) + 1);
                    break;
                case ENTITLED:
                    key = receipt.getSku();
                    editor.putBoolean(key, true);
                    break;
                case SUBSCRIPTION:
                    editor.putBoolean(key, true);
                    editor.putLong(key + "_START", new Date().getTime());
                    break;
                }
                editor.commit();

                printReceipt(purchaseResponse.getReceipt());
                return true;
            case ALREADY_ENTITLED:
                /*
                 * If the customer has already been entitled to the item, a receipt is not returned.
                 * Fulfillment is done unconditionally, we determine which item should be fulfilled by matching the
                 * request id returned from the initial request with the request id stored in the response.
                 */
                final String requestId = purchaseResponse.getRequestId();
                editor.putBoolean(requestIds.get(requestId), true);
                editor.commit();
                Log.v(TAG, "ENTITLED + " + requestIds.get(requestId));
                return true;
            case FAILED:
                /*
                 * If the purchase failed for some reason, (The customer canceled the order, or some other
                 * extraneous circumstance happens) the application ignores the request and logs the failure.
                 */
                Log.v(TAG, "Failed purchase for request" + requestIds.get(purchaseResponse.getRequestId()));
                return false;
            case INVALID_SKU:
                /*
                 * If the sku that was purchased was invalid, the application ignores the request and logs the failure.
                 * This can happen when there is a sku mismatch between what is sent from the application and what
                 * currently exists on the dev portal.
                 */
                Log.v(TAG, "Invalid Sku for request " + requestIds.get(purchaseResponse.getRequestId()));
                return false;
            }
            return false;
        }

        @Override
        protected void onPostExecute(final Boolean success) {
            super.onPostExecute(success);
            taskCount--;
        }
    }

    /*
     * Started when the observer receives a Purchase Updates Response Once the AsyncTask returns successfully, we'll
     * update the UI.
     */
    private class PurchaseUpdatesAsyncTask extends AsyncTask<PurchaseUpdatesResponse, Void, Boolean> {

        @Override
        protected Boolean doInBackground(final PurchaseUpdatesResponse... params) {
            final PurchaseUpdatesResponse purchaseUpdatesResponse = params[0];
            final SharedPreferences prefs = getSharedPreferencesForCurrentUser();
            final SharedPreferences.Editor editor = prefs.edit();
            if (!purchaseUpdatesResponse.getUserId().equals(userId)) {
                return false;
            }
            /*
             * If the customer for some reason had items revoked, the skus for these items will be contained in the
             * revoked skus set.
             */
            for (final String sku : purchaseUpdatesResponse.getRevokedSkus()) {
                Log.v(TAG, "Revoked Sku:" + sku);
                editor.putBoolean(sku, false);
                if (prefs.getLong(sku + "_START", 0) > 0) {
                    editor.putLong(sku + "_START", 0);
                }
                editor.commit();
            }

            switch (purchaseUpdatesResponse.getPurchaseUpdatesRequestStatus()) {
            case SUCCESSFUL:
                SubscriptionPeriod latestSubscriptionPeriod = null;
                final LinkedList<SubscriptionPeriod> currentSubscriptionPeriods = new LinkedList<SubscriptionPeriod>();
                for (final Receipt receipt : purchaseUpdatesResponse.getReceipts()) {
                    final String sku = receipt.getSku();
                    switch (receipt.getItemType()) {
                    case ENTITLED:
                        /*
                         * If the receipt is for an entitlement, the customer is re-entitled.
                         */
                        editor.putBoolean(sku, true);
                        editor.commit();
                        break;
                    case SUBSCRIPTION:
                        /*
                         * Purchase Updates for subscriptions can be done in one of two ways:
                         * 1. Use the receipts to determine if the user currently has an active subscription
                         * 2. Use the receipts to create a subscription history for your customer.
                         * This application checks if there is an open subscription the application uses the receipts
                         * returned to determine an active subscription.
                         * Applications that unlock content based on past active subscription periods, should create
                         * purchasing history for the customer.
                         * For example, if the customer has a magazine subscription for a year,
                         * even if they do not have a currently active subscription,
                         * they still have access to the magazines from when they were subscribed.
                         */
                        final SubscriptionPeriod subscriptionPeriod = receipt.getSubscriptionPeriod();
                        final Date startDate = subscriptionPeriod.getStartDate();
                        /*
                         * Keep track of the receipt that has the most current start date.
                         * Store a container of duplicate subscription periods.
                         * If there is a duplicate, the duplicate is added to the list of current subscription periods.
                         */
                        if (latestSubscriptionPeriod == null ||
                            startDate.after(latestSubscriptionPeriod.getStartDate())) {
                            currentSubscriptionPeriods.clear();
                            latestSubscriptionPeriod = subscriptionPeriod;
                            currentSubscriptionPeriods.add(latestSubscriptionPeriod);
                        } else if (startDate.equals(latestSubscriptionPeriod.getStartDate())) {
                            currentSubscriptionPeriods.add(receipt.getSubscriptionPeriod());
                        }

                        break;

                    }
                    printReceipt(receipt);
                }
                /*
                 * Check the latest subscription periods once all receipts have been read, if there is a subscription
                 * with an existing end date, then the subscription is not active.
                 */
                if (latestSubscriptionPeriod != null) {
                    boolean hasSubscription = true;
                    for (SubscriptionPeriod subscriptionPeriod : currentSubscriptionPeriods) {
                        if (subscriptionPeriod.getEndDate() != null) {
                            hasSubscription = false;
                            break;
                        }
                    }
                    editor.putBoolean("hasSubscription", hasSubscription);
                    editor.commit();
                }

                /*
                 * Store the offset into shared preferences. If there has been more purchases since the
                 * last time our application updated, another initiatePurchaseUpdatesRequest is called with the new
                 * offset.
                 */
                final Offset newOffset = purchaseUpdatesResponse.getOffset();
                editor.putString(OFFSET, newOffset.toString());
                editor.commit();
                if (purchaseUpdatesResponse.isMore()) {
                    Log.v(TAG, "Initiating Another Purchase Updates with offset: " + newOffset.toString());
                    PurchasingManager.initiatePurchaseUpdatesRequest(newOffset);
                }
                return true;
            case FAILED:
                /*
                 * On failed responses the application will ignore the request.
                 */
                return false;
            }
            return false;
        }

        @Override
        protected void onPostExecute(final Boolean success) {
            super.onPostExecute(success);
            taskCount--;
        }
    }
}

class PaymentWrapper {
    private MonkeyPurchaseObserver mPurchaseObserver;
    private Boolean started = false;

    public void Init()
    {
        mPurchaseObserver = new MonkeyPurchaseObserver(MonkeyGame.activity.getBaseContext());
        PurchasingManager.registerObserver(mPurchaseObserver);
        started = true;
    }

    public boolean Purchase(String productId)
    {
        String requestId = PurchasingManager.initiatePurchaseRequest(productId);
        mPurchaseObserver.requestIds.put(requestId, productId);
        return true;
    }

    public boolean IsBought(String productId)
    {
        if (!started) {
            return false;
        }
        return mPurchaseObserver
            .getSharedPreferencesForCurrentUser()
            .getBoolean(productId, false);
    }

    public boolean IsPurchaseInProgress()
    {
        if (!started) {
            return false;
        }
        return mPurchaseObserver.taskCount > 0;
    }
}
