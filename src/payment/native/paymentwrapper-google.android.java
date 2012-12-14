import android.util.Log;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;

import net.robotmedia.billing.BillingController;
import net.robotmedia.billing.helper.AbstractBillingObserver;
import net.robotmedia.billing.model.Transaction.PurchaseState;
import net.robotmedia.billing.BillingRequest.ResponseCode;

class PaymentWrapper
{
    private static final String KEY_TRANSACTIONS_RESTORED = "net.robotmedia.billing.transactionsRestored";
    private AbstractBillingObserver billingObserver;
    private boolean billingSupported = false;
    private Set<String> pendingItems = new HashSet<String>();
    private Set<String> ownedItems = new HashSet<String>();

    /**
     * ---- MONKEY INTERFACE START ----
     */

    public void Init(String publicKey)
    {
        BillingController.setDebug(true);
        BillingController.setConfiguration(getConfiguration());

        billingObserver = getBillingObserver();
        BillingController.registerObserver(billingObserver);

        BillingController.checkBillingSupported(MonkeyGame.activity);
        BillingController.checkSubscriptionSupported(MonkeyGame.activity);
    }

    public boolean Purchase(String productId) {
        pendingItems.add(productId);
        BillingController.requestPurchase(MonkeyGame.activity, productId, true, null);
        return false;
    }

    public boolean IsBought(String productId) {
        return ownedItems.contains(productId);
    }

    public boolean IsPurchaseInProgress() {
        if (!billingSupported || !billingObserver.isTransactionsRestored()) {
            return true;
        } else {
            return !pendingItems.isEmpty();
        }
    }

    /**
     * ---- MONKEY INTERFACE END ----
     */

    private AbstractBillingObserver getBillingObserver()
    {
        return new AbstractBillingObserver(MonkeyGame.activity) {
            public void onBillingChecked(boolean supported) {
                PaymentWrapper.this.onBillingChecked(supported);
            }

            public void onPurchaseStateChanged(String itemId, PurchaseState state) {
                PaymentWrapper.this.onPurchaseStateChanged(itemId, state);
            }

            public void onRequestPurchaseResponse(String itemId, ResponseCode response) {
                PaymentWrapper.this.onRequestPurchaseResponse(itemId, response);
            }

            public void onSubscriptionChecked(boolean supported) {
                // Ignored
            }

            @Override
            public boolean isTransactionsRestored() {
                final SharedPreferences prefs = MonkeyGame.activity.getPreferences(Context.MODE_PRIVATE);
                return prefs.getBoolean(KEY_TRANSACTIONS_RESTORED, false);
            }

            @Override
            public void onTransactionsRestored() {
                final SharedPreferences prefs = MonkeyGame.activity.getPreferences(Context.MODE_PRIVATE);
                final Editor edit = prefs.edit();
                edit.putBoolean(KEY_TRANSACTIONS_RESTORED, true);
                edit.commit();
            }
        };
    }

    private BillingController.IConfiguration getConfiguration()
    {
        return new BillingController.IConfiguration() {
            public byte[] getObfuscationSalt() {
                return new byte[] {41, -90, -116, -41, 66, -53, 122, -110, -127, -96, -88, 77, 127, 115, 1, 73, 57, 110, 48, -116};
            }

            public String getPublicKey() {
                return "TODO";
            }
        };
    }

    public void onBillingChecked(boolean supported) {
        billingSupported = supported;
        if (billingSupported && !billingObserver.isTransactionsRestored()) {
            BillingController.restoreTransactions(MonkeyGame.activity);
        }
    }

    public void onPurchaseStateChanged(String itemId, PurchaseState state) {
        pendingItems.remove(itemId);
        if (state == PurchaseState.PURCHASED) {
            ownedItems.add(itemId);
        }
    }

    public void onRequestPurchaseResponse(String itemId, ResponseCode response) {
        pendingItems.remove(itemId);
        if (ResponseCode.isResponseOk(response.ordinal())) {
            ownedItems.add(itemId);
        }
    }

    protected void finalize() throws Throwable {
        BillingController.unregisterObserver(billingObserver);
    }
}
