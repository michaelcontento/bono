class util
{
    static int GetTimestamp()
    {
        return (int) (System.currentTimeMillis() / 1000);
    }

    static void OpenUrl(String url)
    {
        Intent i = new Intent(Intent.ACTION_VIEW);
        i.setData(Uri.parse(url));
        MonkeyGame.activity.startActivity(i);
    }
}
