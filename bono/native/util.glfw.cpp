#include <ctime>

class util {
public:
    int static GetTimestamp() {
        return std::time(0);
    }

    void static OpenUrl(String url) {
        system("open " + url);
    }
};
