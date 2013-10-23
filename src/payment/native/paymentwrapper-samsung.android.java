import java.text.SimpleDateFormat;
import java.util.List;
import java.util.ArrayList;
import java.util.Set;
import java.util.HashSet;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.SharedPreferences;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;

import com.sec.android.iap.sample.helper.SamsungIapHelper;
import com.sec.android.iap.sample.helper.SamsungIapHelper.OnGetInboxListListener;
import com.sec.android.iap.sample.helper.SamsungIapHelper.OnGetItemListListener;
import com.sec.android.iap.sample.helper.SamsungIapHelper.OnInitIapListener;
import com.sec.android.iap.sample.vo.InBoxVO;
import com.sec.android.iap.sample.vo.ItemVO;
import com.sec.android.iap.sample.vo.PurchaseVO;

class PaymentWrapper extends ActivityDelegate implements OnInitIapListener, OnGetItemListListener, OnGetInboxListListener
{
    private static final int iapMode = SamsungIapHelper.IAP_MODE_COMMERCIAL;
    /* private static final int iapMode = SamsungIapHelper.IAP_MODE_TEST_SUCCESS; */
    private static MonkeyGame activity = MonkeyGame.activity;

    private static final String TAG  = PaymentWrapper.class.getName();
    private static final String ITEM_DB_KEY = "avalon.payment.samsung";
    private static final int ITEM_AMOUNT = 25;
    private int transactionCounter = 0;
    private SamsungIapHelper helper = null;
    private String itemGroupId = null;
    private String pendingPurchaseItemId = null;
    private boolean isInitialized = false;
    private List<ItemVO> knownItems = new ArrayList<ItemVO>();
    private Set<String> ownedItems = new HashSet<String>();

    /**
     * STEP 1) Kicks off the whole IAP initialization process
     */
    private void initHelper()
    {
        if (isInitialized || !isInternetConnected()) {
            return;
        }
        isInitialized = true;

        activity.AddActivityDelegate(this);
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run()
            {
                helper = SamsungIapHelper.getInstance(activity, iapMode);
                helper.setOnInitIapListener(PaymentWrapper.this);
                helper.setOnGetItemListListener(PaymentWrapper.this);
                helper.setOnGetInboxListListener(PaymentWrapper.this);

                if (helper.isInstalledIapPackage(activity)) {
                    if (helper.isValidIapPackage(activity)) {
                        helper.showProgressDialog(activity);
                        helper.startAccountActivity(activity);
                    } else {
                        helper.showIapDialog(
                            activity,
                            helper.getValueString(activity, "title_iap"),
                            helper.getValueString(activity, "msg_invalid_iap_package"),
                            true,
                            null
                        );
                    }
                } else {
                    helper.installIapPackage(activity);
                }
            }
        });
    }

    /**
     * STEP 2) Call multiple times but the account certification request should
     *         be the second call in the initialization process. All other calls
     *         are real purchase responses.
     */
    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent intent)
    {
        switch (requestCode) {
            case SamsungIapHelper.REQUEST_CODE_IS_ACCOUNT_CERTIFICATION: {
                handleRequestCertification(requestCode, resultCode, intent);
                break;
            }

            case SamsungIapHelper.REQUEST_CODE_IS_IAP_PAYMENT: {
                handleRequestPayment(requestCode, resultCode, intent);
                break;
            }
        }
    }

    /**
     * STEP 3) Check the result and continue with binding the IAP service
     *         connector -- the next step in the initialization chain.
     */
    protected void handleRequestCertification(int requestCode, int resultCode, Intent intent)
    {
        if (resultCode == Activity.RESULT_OK) {
            bindIapService();
        } else if (resultCode == Activity.RESULT_CANCELED) {
            helper.dismissProgressDialog();
            helper.showIapDialog(
                activity,
                helper.getValueString(activity, "title_samsungaccount_authentication"),
                helper.getValueString(activity, "msg_authentication_has_been_cancelled"),
                false,
                null
            );
        }
    }

    /**
     * STEP 4) Request the IAP service binding and trigger InitIap() afterwards
     */
    public void bindIapService()
    {
        helper.bindIapService(new SamsungIapHelper.OnIapBindListener() {
            @Override
            public void onBindIapFinished(int result)
            {
                if (pendingPurchaseItemId == null) {
                    helper.dismissProgressDialog();
                }

                if (result == SamsungIapHelper.IAP_RESPONSE_RESULT_OK) {
                    helper.safeInitIap(activity);
                } else {
                    helper.showIapDialog(
                        activity,
                        helper.getValueString(activity, "title_iap"),
                        helper.getValueString(activity, "msg_iap_service_bind_failed"),
                        false,
                        null
                    );
                }
            }
        });
    }

    /**
     * STEP 5) Finally! At this point we're able to do "real work" with the
     *         IAP API. Everything before was just initialization stuff ...
     *         And we now request all items for this game.
     */
    @Override
    public void onSucceedInitIap()
    {
        helper.safeGetItemList(
            activity,
            itemGroupId,
            1, 1 + ITEM_AMOUNT,
            SamsungIapHelper.ITEM_TYPE_ALL
        );
    }

    /**
     * STEP 6) We received a list of all available items and request the
     *         current inbox for the current user.
     */
    @Override
    public void onSucceedGetItemList(ArrayList<ItemVO> itemList)
    {
        knownItems.addAll(itemList);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
        String today = sdf.format(new Date());
        helper.safeGetItemInboxTask(
            activity,
            itemGroupId,
            1, 1 + ITEM_AMOUNT,
            "20131001",
            today
        );
    }

    /**
     * STEP 7) With the inbox for the user everything is there and we're done
     *         with the full initialization of the IAP SDK and the gathering of
     *         all required informations.
     */
    @Override
    public void OnSucceedGetInboxList(ArrayList<InBoxVO> inboxList)
    {
        itemDbClear();
        for (InBoxVO inboxItem : inboxList) {
            itemDbAdd(inboxItem.getItemId());
        }
        itemDbSave();

        if (pendingPurchaseItemId != null) {
            startPurchase(pendingPurchaseItemId);
            pendingPurchaseItemId = null;
        }
    }

    /**
     * STEP 8) Use this method to start the purchase of a new item.
     */
    private void startPurchase(String itemId)
    {
        if (!isInternetConnected()) {
            showNoInternetDialog();
            return;
        }

        if (!isInitialized) {
            pendingPurchaseItemId = itemId;
            initHelper();
            return;
        }

        helper.showProgressDialog(activity);
        ++transactionCounter;
        helper.startPurchase(
            activity,
            SamsungIapHelper.REQUEST_CODE_IS_IAP_PAYMENT,
            itemGroupId,
            itemId
        );
    }

    /**
     * STEP 9) Handling of incoming payment responses.
     */
    private void handleRequestPayment(int requestCode, int resultCode, Intent intent)
    {
        if (intent == null) {
            return;
        }

        Bundle extras         = intent.getExtras();
        String itemId         = "";
        String thirdPartyName = "";
        int statusCode        = SamsungIapHelper.IAP_PAYMENT_IS_CANCELED;
        String errorString    = "";
        PurchaseVO purchaseVO = null;

        if (extras != null) {
            thirdPartyName = extras.getString(SamsungIapHelper.KEY_NAME_THIRD_PARTY_NAME);
            statusCode = extras.getInt(SamsungIapHelper.KEY_NAME_STATUS_CODE);
            errorString = extras.getString(SamsungIapHelper.KEY_NAME_ERROR_STRING);
            itemId = extras.getString(SamsungIapHelper.KEY_NAME_ITEM_ID);
        } else {
            helper.dismissProgressDialog();
            helper.showIapDialog(
                activity,
                helper.getValueString(activity, "title_iap"),
                helper.getValueString(activity, "msg_payment_was_not_processed_successfully"),
                false,
                null
            );
        }

        if (resultCode == Activity.RESULT_OK) {
            if (statusCode == SamsungIapHelper.IAP_ERROR_NONE) {
                purchaseVO = new PurchaseVO(extras.getString(SamsungIapHelper.KEY_NAME_RESULT_OBJECT));
                helper.verifyPurchaseResult(activity, purchaseVO);
                itemDbAdd(itemId);
                itemDbSave();
            } else {
                helper.dismissProgressDialog();
                helper.showIapDialog(
                    activity,
                    helper.getValueString(activity, "title_iap"),
                    errorString,
                    false,
                    null
                );
            }
        } else if (resultCode == Activity.RESULT_CANCELED) {
            helper.dismissProgressDialog();
            helper.showIapDialog(
                activity,
                helper.getValueString(activity, "title_iap"),
                helper.getValueString(activity, "msg_payment_cancelled"),
                false,
                null
            );
        }

        --transactionCounter;
    }

    /**
     * STEP 10) Cleanup and we're done :)
     */
    protected void onDestroy()
    {
        if (helper != null) {
            helper.stopRunningTask();
        }
    }

    /**
     * ---- ITEM STORE ----
     */

    private boolean itemDbContains(String productId)
    {
        return ownedItems.contains(productId);
    }

    private void itemDbAdd(String productId)
    {
        ownedItems.add(productId);
    }

    private void itemDbClear()
    {
        SharedPreferences.Editor edit = getUserPreferences().edit();
        edit.clear();
        edit.commit();
    }

    private void itemDbSave()
    {
        SharedPreferences.Editor edit = getUserPreferences().edit();
        edit.putString(ITEM_DB_KEY, getOwnedItemsAsString());
        edit.commit();
    }

    private void itemDbLoad()
    {
        try {
            loadOwnedItemsAsString(
                getUserPreferences().getString(ITEM_DB_KEY, "")
            );
        } catch (ClassCastException e) {
        }
    }

    private void loadOwnedItemsAsString(String input)
    {
        for (String productId : input.split("\n")) {
            ownedItems.add(productId);
        }
    }

    private String getOwnedItemsAsString()
    {
        String result = "";
        for (String item : ownedItems) {
            result += item + "\n";
        }
        return result.substring(0, result.length() - 1);
    }

    /**
     * ---- HELPER STUFF ----
     */

    private SharedPreferences getUserPreferences()
    {
        return activity.getPreferences(Context.MODE_PRIVATE);
    }

    private void showNoInternetDialog()
    {
        AlertDialog.Builder alert = new AlertDialog.Builder(activity);
        alert.setTitle(helper.getValueString(activity, "title_iap"));
        alert.setMessage(helper.getValueString(activity, "msg_no_internet"));
        alert.setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which)
            {}
        });
        alert.show();
    }

    private boolean isInternetConnected()
    {
        ConnectivityManager cm = (ConnectivityManager) activity.getSystemService(Activity.CONNECTIVITY_SERVICE);
        NetworkInfo activeNetwork = cm.getActiveNetworkInfo();

        boolean isConnected = activeNetwork != null && activeNetwork.isConnectedOrConnecting();
        return isConnected;
    }

    /**
     * ---- MONKEY INTERFACE START ----
     */

    public void Init(String itemGroupId)
    {
        this.itemGroupId = itemGroupId;
        itemDbLoad();
        initHelper();
    }

    public boolean Purchase(String itemId)
    {
        startPurchase(itemId);
        return true;
    }

    public boolean IsBought(String itemId)
    {
        return itemDbContains(itemId);
    }

    public boolean IsPurchaseInProgress()
    {
        return (transactionCounter > 0);
    }
}
