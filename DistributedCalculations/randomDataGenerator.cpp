#include <random>


class dataGenerator {
    static std::random_device rd; // a seed source for the random number engine
    static std::mt19937 gen(rd()); // mersenne_twister_engine seeded with rd()
    static std::uniform_real_distribution<> distrib(0,RAND_MAX);
}