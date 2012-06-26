public class util {
    public static int GetTimestamp() {
        return (int) (DateTime.Now.Ticks) / 10000;
    }
}
