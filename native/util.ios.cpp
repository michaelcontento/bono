class util {
public:
    int static GetTimestamp() {
        time_t unixTime = (time_t) [[NSDate date] timeIntervalSince1970];
        return static_cast<int>(unixTime);
    }
};
