public class Device 
{
    public static int GetTimestamp() 
    {
        return (int) (DateTime.Now.Ticks) / 10000;
    }

    public static void OpenUrl(String url) 
    {
        #if WINDOWS
            System.Diagnostics.Process.Start(url);
        #elif WINDOWS_PHONE
            WebBrowserTask webBrowserTask = new WebBrowserTask();
            webBrowserTask.Uri = new Uri(url, UriKind.Absolute);
            webBrowserTask.Show();
        #endif
    }

    public static string GetLanguage()
    {
        return "en";
    }

    public static void Close()
    {
    }
}
