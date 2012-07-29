
import com.payment.BillingService.RequestPurchase;
import com.payment.BillingService.RestoreTransactions;
import com.payment.Consts.PurchaseState;
import com.payment.Consts;
import com.payment.Consts.ResponseCode;
import com.payment.PurchaseObserver;
import com.payment.ResponseHandler;
import com.payment.PurchaseDatabase;
import android.database.Cursor;

class MonkeyPurchaseObserver extends PurchaseObserver {
    private static final String DB_INITIALIZED = "db_initialized";

    private PurchaseDatabase mPurchaseDatabase;
    private Set<String> mOwnedItems = new HashSet<String>();

    private com.payment.BillingService mBillingService;

    protected boolean inProgress = false;

    public void initDatabase()
    {
        mPurchaseDatabase = new PurchaseDatabase(MonkeyGame.activity);
    }

    public void destroy()
    {
        mPurchaseDatabase.close();
    }

    public void SetBillingService(com.payment.BillingService bs)
    {
        mBillingService = bs;
    }
    public void SetInProgress(boolean p)
    {
        inProgress = p;
    }

    public boolean IsInProgress()
    {
        return inProgress;
    }

    public MonkeyPurchaseObserver(Handler handler) {
        super(MonkeyGame.activity, handler);
        // bb_std_lang.print("Payment purchaseobserver started!");
        initDatabase();
    }

    @Override
    public void onBillingSupported(boolean supported) {
        // bb_std_lang.print("onBilling Support!");
       restoreDatabase();
    }

    public boolean IsBought(String productId)
    {
        return mOwnedItems.contains(productId);
    }

    @Override
    public void onRequestPurchaseResponse(RequestPurchase request,
            ResponseCode responseCode) {
        // bb_std_lang.print("Payment onRequestPurchaseResponse");
        // bb_std_lang.print("Payment "  + request.mProductId + ": " + responseCode);
        if (responseCode == ResponseCode.RESULT_OK) {
          // bb_std_lang.print("Payment purchase was successfully sent to server");


        } else if (responseCode == ResponseCode.RESULT_USER_CANCELED) {
            SetInProgress(false);

           // bb_std_lang.print("Payment user canceled purchase");


        } else {
            SetInProgress(false);

           // bb_std_lang.print("Payment purchase failed");


        }
    }

    @Override
    public void onRestoreTransactionsResponse(RestoreTransactions request,
            ResponseCode responseCode) {
        // bb_std_lang.print("Payment onRestoreTransactionsResponse");
        if (responseCode == ResponseCode.RESULT_OK) {
            if (Consts.DEBUG) {
                //bb_std_lang.print(TAG, "completed RestoreTransactions request");
            }
            SharedPreferences prefs = MonkeyGame.activity.getPreferences(Context.MODE_PRIVATE);
            SharedPreferences.Editor edit = prefs.edit();
            edit.putBoolean(DB_INITIALIZED, true);
            edit.commit();
            // bb_std_lang.print("set db initialized to TRUE");
        } else {
            if (Consts.DEBUG) {
                SharedPreferences prefs = MonkeyGame.activity.getPreferences(Context.MODE_PRIVATE);
                SharedPreferences.Editor edit = prefs.edit();
                edit.putBoolean(DB_INITIALIZED, true);
                edit.commit();
                // bb_std_lang.print("ResponseCode invalid");
            }
        }
        SetInProgress(false);
    }

    private void restoreDatabase() {
        // bb_std_lang.print("restoreDatabase");
        SharedPreferences prefs = MonkeyGame.activity.getPreferences(Context.MODE_PRIVATE);
        boolean initialized = prefs.getBoolean(DB_INITIALIZED, false);
        if (!initialized) {
            // bb_std_lang.print("restoreTransactions");
            mBillingService.restoreTransactions();
        }

        Cursor c = mPurchaseDatabase.queryAll();
        try {
            while (c.moveToNext()) {
                int quantity = c.getInt(1);
                if (quantity > 0) {
                    // bb_std_lang.print("add item: " + c.getString(0));
                    mOwnedItems.add(c.getString(0));
                }
            }
        } finally {
                Log.d("_DB", "_DB FINALLY");
            if (c != null) {
                c.close();
            }
        }
     }


    @Override
    public void onPurchaseStateChange(PurchaseState purchaseState, String itemId,
            int quantity, long purchaseTime, String developerPayload) {
        // bb_std_lang.print("Payment -> onPurchaseStateChange");
           //  bb_std_lang.print("onPurchaseStateChange() itemId: " + itemId + " " + purchaseState);

        if (developerPayload == null) {

        } else {

        }

        if (purchaseState == PurchaseState.PURCHASED) {
            // bb_std_lang.print("Payment bought!!!! " + itemId);
            SetInProgress(false);
            //bb_std_lang.print("add to owned items!!!! " + itemId);
            mOwnedItems.add(itemId);
            //bb_std_lang.print("update db!!!! " + itemId);
            mPurchaseDatabase.updatePurchasedItem(itemId, 1);
            //bb_std_lang.print("done db!!!! " + itemId);
        }
    }
}

class PaymentWrapper {
    private MonkeyPurchaseObserver mPurchaseObserver;
    private Handler mHandler;
    private com.payment.BillingService mBillingService;

    public void Init()
    {
        mHandler = new Handler();
        mPurchaseObserver = new MonkeyPurchaseObserver(mHandler);
        mBillingService = new com.payment.BillingService();
        mBillingService.setContext(MonkeyGame.activity);
        mPurchaseObserver.SetBillingService(mBillingService);

        // Check if billing is supported.
        ResponseHandler.register(mPurchaseObserver);
        if (!mBillingService.checkBillingSupported()) {
            // showDialog(DIALOG_CANNOT_CONNECT_ID);
        }
    }

    public boolean Purchase(String productId)
    {
        // android.test.purchased
        // bb_std_lang.print("Purchase");
        mPurchaseObserver.SetInProgress(true);
        return mBillingService.requestPurchase(productId, null);
    }

    public boolean IsBought(String productId)
    {
        return mPurchaseObserver.IsBought(productId);
    }

    public boolean IsPurchaseInProgress()
    {
        return mPurchaseObserver.IsInProgress();
    }

    protected void finalize() throws Throwable
    {
        mPurchaseObserver.destroy();
        mBillingService.unbind();
    }
}
