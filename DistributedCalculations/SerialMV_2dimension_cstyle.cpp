#include <ctime>
#include <iostream>
#include <ostream>
#include <random>
#include <fstream>
#include <iomanip>

std::random_device rd; // a seed source for the random number engine
std::mt19937 gen(rd()); // mersenne_twister_engine seeded with rd()
std::uniform_real_distribution<> distrib(0,RAND_MAX);


int sizeArray[12] = {5000, 10, 100, 1000, 2000, 3000, 4000, 6000, 7000, 8000, 9000, 10000};

void initRandomVals(double **&matrix, double *&vector, double *&result, const int size) {
    matrix = new double *[size];
    vector = new double[size];
    result = new double[size];
    for (int i = 0; i < size; i++) {
        matrix[i] = new double[size];
        vector[i] = distrib(gen);
        result[i] = 0;
        for (int j = 0; j < size; j++) {
            matrix[i][j] = distrib(gen);
        }
    }
}

void multiply(double **&matrix, double *&vector, double *&result, const int size) {
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            result[i] += matrix[i][j] * vector[j];
        }
    }
}

void deAllocResources(double **&matrix, double *&vector, double *&result, const int size) {
    for (int i = 0; i < size; i++) {
        delete[] matrix[i];
    }
    delete[] matrix;
    delete[] vector;
    delete[] result;
}

double calcTheoreticalTime(const double singleIterationTime, const int size) {
    return singleIterationTime * size * (2 * size - 1);
}


int main() {
    double **matrix = nullptr;
    double *vector = nullptr;
    double *result = nullptr;
    double singleIterTime = 0.0;
    std::ofstream file("serialStat.csv", std::ios::app);
    //file << "Using 2 dimensional c-style array as data storage." << std::endl;
    file << "Size, Actual time, Theoretical time" << std::endl;
    for (int i: sizeArray) {
        initRandomVals(matrix, vector, result, i);
        time_t startTime = clock();
        multiply(matrix, vector, result, i);
        time_t endTime = clock();
        double elapsedTime = (endTime - startTime) / static_cast<double>(CLOCKS_PER_SEC);
        if (i == 5000) {
            singleIterTime = elapsedTime / (i * (2 * i - 1));
        }
        file << i << "," << std::setprecision(10) << elapsedTime << "," << std::setprecision(10) <<
                calcTheoreticalTime(singleIterTime, i) << std::endl;
        deAllocResources(matrix, vector, result, i);
    }
    file.close();
    return 0;
}
