import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;

import net.robotmedia.billing.BillingController;
import net.robotmedia.billing.BillingController.IConfiguration;
import net.robotmedia.billing.helper.AbstractBillingObserver;
import net.robotmedia.billing.model.Transaction;
import net.robotmedia.billing.model.Transaction.PurchaseState;
import net.robotmedia.billing.BillingRequest.ResponseCode;

class PaymentWrapper
{
    private static final String KEY_TRANSACTIONS_RESTORED = "net.robotmedia.billing.transactionsRestored";
    private static String publicKey = "";
    private AbstractBillingObserver billingObserver;
    private boolean billingSupported = false;
    private Set<String> pendingItems = new HashSet<String>();
    private Set<String> ownedItems = new HashSet<String>();
    public boolean transactionsRestored = false;

    /**
     * ---- MONKEY INTERFACE START ----
     */

    public void Init(String publicKey)
    {
        BillingController.setConfiguration(getConfiguration(publicKey));

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
        if (billingSupported && !billingObserver.isTransactionsRestored()) {
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
                return PaymentWrapper.this.transactionsRestored;
            }

            @Override
            public void onTransactionsRestored() {
                PaymentWrapper.this.restoreFromLocalTransactions();
                PaymentWrapper.this.transactionsRestored = true;
            }
        };
    }

    private IConfiguration getConfiguration(String publicKey)
    {
        PaymentWrapper.publicKey = publicKey;

        return new IConfiguration() {
            public byte[] getObfuscationSalt() {
                return new byte[] {41, -90, -116, -41, 66, -53, 122, -110, -127, -96, -88, 77, 127, 115, 1, 73, 57, 110, 48, -116};
            }

            public String getPublicKey() {
                return PaymentWrapper.publicKey;
            }
        };
    }

    public void restoreFromLocalTransactions() {
        for (Transaction trans : BillingController.getTransactions(MonkeyGame.activity)) {
            onPurchaseStateChanged(trans.productId, trans.purchaseState);
        }
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
        if (state == PurchaseState.CANCELLED) {
            ownedItems.remove(itemId);
        }

        BillingController.confirmNotifications(MonkeyGame.activity, itemId);
    }

    public void onRequestPurchaseResponse(String itemId, ResponseCode response) {
        pendingItems.remove(itemId);
    }

    protected void finalize() throws Throwable {
        BillingController.unregisterObserver(billingObserver);
        BillingController.setConfiguration(null);
    }
}
