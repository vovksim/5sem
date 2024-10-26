#include <algorithm>
#include <chrono>
#include <iostream>
#include <vector>
#include <random>
#include <ctime>
#include <iomanip>
#include <fstream>

typedef std::vector<std::vector<double> > Matrix;
typedef std::vector<double> Vector;
typedef std::tuple<std::size_t, double, double> iterationStat;
typedef std::vector<iterationStat> statTable;


const std::vector<std::size_t> MATRIX_SIZE_VECTOR = {
    5000, 10, 100, 1000, 2000, 3000, 4000, 6000, 7000, 8000, 9000, 10000
};

std::random_device rd; // a seed source for the random number engine
std::mt19937 gen(rd()); // mersenne_twister_engine seeded with rd()
std::uniform_real_distribution<> distrib(0,RAND_MAX);

void multiply(Matrix &a, Vector &b, Vector &result) {
    for (int i = 0; i < a.size(); i++) {
        for (int j = 0; j < a.size(); j++) {
            result[i] += a[i][j] * b[j];
        }
    }
}

void randomDataInitialization(Matrix &matrix, Vector &vector, const std::size_t size) {
    srand(unsigned(clock()));
    matrix.resize(size);
    vector.resize(size);
    for (std::size_t i = 0; i < size; i++) {
        matrix[i].resize(size);
        vector[i] = rand() / double(1000);
        for (std::size_t j = 0; j < size; j++) {
            matrix[i][j] = rand() / double(1000);
        }
    }
}

std::size_t calcTotalIterationQuantity(const std::size_t size) {
    return size * (2 * size - 1);
}


double theoreticalIterationTime(const std::time_t startTime, const std::time_t endTime, const std::size_t size) {
    const double duration = (endTime - startTime) / static_cast<double>(CLOCKS_PER_SEC);
    return duration / static_cast<double>(calcTotalIterationQuantity(size));
}

int main() {
    //statistics [size, actual_time, theoretical_time]
    statTable statistics;
    //value which represents theoretical iteration time
    double theoreticalSingleIterationTime = 0;
    //timers
    std::time_t startTime, endTime;
    //matrix and vector for multiplication
    Matrix matrix;
    Vector vector;
    Vector result;
    for (unsigned long i: MATRIX_SIZE_VECTOR) {
        randomDataInitialization(matrix, vector, i);
        result.resize(i);
        startTime = clock();
        multiply(matrix, vector, result);
        endTime = clock();
        if (i == 5000) {
            theoreticalSingleIterationTime = theoreticalIterationTime(startTime, endTime, i);
        }
        statistics.emplace_back(i, (endTime - startTime) / static_cast<double>(CLOCKS_PER_SEC),
                                theoreticalSingleIterationTime * calcTotalIterationQuantity(i));
    }
}
