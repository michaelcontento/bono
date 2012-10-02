#include <ctime>

class device {
public:
    int static GetTimestamp() {
        return std::time(0);
    }

    void static OpenUrl(const String url) {
        String cmd("open ");
        cmd += url;
        system(cmd.ToCString<char>());
    }
};
