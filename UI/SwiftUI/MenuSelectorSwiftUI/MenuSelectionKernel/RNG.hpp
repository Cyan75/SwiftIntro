#include <cstdlib>
class RNG {
   private:
    int *m_randomNum;

   public:
    RNG() {
        *m_randomNum = std::rand();
    }
    auto GetRN();
};