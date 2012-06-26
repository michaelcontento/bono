#include <ctime>

class util {
public:
    int static GetTimestamp() {
        return std::time(0);
    }
};
