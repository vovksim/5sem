#include <fstream>
#include <iomanip>
#include <stdio.h>
#include <time.h>
#include <vector>

const std::vector<std::size_t> MATRIX_SIZE_VECTOR = {
    5000, 10, 100, 1000, 2000, 3000, 4000, 6000, 7000, 8000, 9000, 10000
};

// Function for simple setting the matrix and vector elements
void DummyDataInitialization(double *pMatrix, double *pVector, int Size) {
    int i, j; // Loop variables
    for (i = 0; i < Size; i++) {
        pVector[i] = 1;
        for (j = 0; j < Size; j++)
            pMatrix[i * Size + j] = i;
    }
}

// Function for random setting the matrix and vector elements
void RandomDataInitialization(double *pMatrix, double *pVector, int Size) {
    int i, j; // Loop variables
    srand(unsigned(clock()));
    for (i = 0; i < Size; i++) {
        pVector[i] = rand() / double(1000);
        for (j = 0; j < Size; j++)
            pMatrix[i * Size + j] = rand() / double(1000);
    }
}

// Function for memory allocation and data initialization
void ProcessInitialization(double * &pMatrix, double * &pVector,
                           double * &pResult, int &Size) {
    // Memory allocation
    pMatrix = new double [Size * Size];
    pVector = new double [Size];
    pResult = new double [Size];
    // Setting the values of the matrix and vector elements
    //DummyDataInitialization(pMatrix, pVector, Size);
    RandomDataInitialization(pMatrix, pVector, Size);
}

// Function for formatted matrix output
void PrintMatrix(double *pMatrix, int RowCount, int ColCount) {
    int i, j; // Loop variables
    for (i = 0; i < RowCount; i++) {
        for (j = 0; j < ColCount; j++)
            printf("%7.4f ", pMatrix[i * RowCount + j]);
        printf("\n");
    }
}

// Function for formatted vector output
void PrintVector(double *pVector, int Size) {
    int i;
    for (i = 0; i < Size; i++)
        printf("%7.4f ", pVector[i]);
}

// Function for matrix-vector multiplication
void ResultCalculation(double *pMatrix, double *pVector, double *pResult,
                       int Size) {
    int i, j; // Loop variables
    for (i = 0; i < Size; i++) {
        pResult[i] = 0;
        for (j = 0; j < Size; j++)
            pResult[i] += pMatrix[i * Size + j] * pVector[j];
    }
}

// Function for computational process termination
void ProcessTermination(double *pMatrix, double *pVector, double *pResult) {
    delete [] pMatrix;
    delete [] pVector;
    delete [] pResult;
}

double calcTheoreticalTime(const double singleIterationTime, const int size) {
    return singleIterationTime * size * (2 * size - 1);
}


int main() {
    double *pMatrix; // First argument - initial matrix
    double *pVector; // Second argument - initial vector
    double *pResult; // Result vector for matrix-vector multiplication
    // Sizes of initial matrix and vector
    double singleIterTime = 0.0;
    for (auto size: MATRIX_SIZE_VECTOR) {
        int size_ = static_cast<const int>(size);
        ProcessInitialization(pMatrix, pVector, pResult, size_);
        time_t start = clock();
        ResultCalculation(pMatrix, pVector, pResult, size_);
        time_t finish = clock();
        double duration = (finish - start) / static_cast<double>(CLOCKS_PER_SEC);
        // Printing the time spent by matrix-vector multiplication
        printf("%f\n", duration);
        // Computational process termination
        ProcessTermination(pMatrix, pVector, pResult);
    }
}
