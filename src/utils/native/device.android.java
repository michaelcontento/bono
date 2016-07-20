import android.net.Uri;
import android.app.AlertDialog;

abstract class AlertDelegate
{
    public abstract void Call(int buttonIndex, String buttonTitle);
}

class CallbackOnClickListener implements DialogInterface.OnClickListener
{
    private AlertDelegate callback;
    private int buttonIndex;
    private String buttonTitle;

    public CallbackOnClickListener(AlertDelegate callback, int buttonIndex, String buttonTitle)
    {
        this.callback = callback;
        this.buttonIndex = buttonIndex;
        this.buttonTitle = buttonTitle;
    }

    public void onClick(DialogInterface dialog, int id)
    {
        callback.Call(buttonIndex, buttonTitle);
    }
}

class DeviceNative
{
    static String GetLanguage()
    {
        return Locale.getDefault().getLanguage();
    }

    static int GetTimestamp()
    {
        return (int) (System.currentTimeMillis() / 1000);
    }

    static void OpenUrl(String url)
    {
        Intent i = new Intent(Intent.ACTION_VIEW);
        i.setData(Uri.parse(url));

        Activity activity = BBAndroidGame.AndroidGame().GetActivity();
        activity.startActivity(i);
    }

    static void ShowAlertNative(String title, String message, String[] buttons, AlertDelegate callback)
    {
        Activity activity = BBAndroidGame.AndroidGame().GetActivity();

        AlertDialog.Builder alert = new AlertDialog.Builder(activity);
        alert.setTitle(title);
        alert.setMessage(message);
        alert.setNegativeButton(
            buttons[0],
            new CallbackOnClickListener(callback, 0, buttons[0])
        );
        if (buttons.length >= 2) {
            alert.setPositiveButton(
                buttons[1],
                new CallbackOnClickListener(callback, 1, buttons[1])
            );
        }
        if (buttons.length >= 3) {
            alert.setNeutralButton(
                buttons[2],
                new CallbackOnClickListener(callback, 2, buttons[2])
            );
        }
        alert.create().show();
    }

    static boolean FileExistsNative(String path)
    {
       try{
           if (path.toLowerCase().startsWith("monkey://data/")) {
               path = BBAndroidGame.AndroidGame().PathToAssetPath(path);

               Activity activity = BBAndroidGame.AndroidGame().GetActivity();
               InputStream in = activity.getAssets().open(path);
               in.close();
               return true;
           }else{
               return false;
           }
       }catch( IOException e ){
       }
       return false;
   }

   static void Close()
   {
       Activity activity = BBAndroidGame.AndroidGame().GetActivity();
       activity.finish();
   }
}
