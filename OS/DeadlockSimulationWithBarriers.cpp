#include <iostream>
#include <thread>
#include <mutex>
#include <barrier>
#include <chrono>
#include <random>

const int N = 5;
std::mutex forks[N];
std::mutex output_mtx;
std::barrier barrier(N);

size_t my_rand(size_t min, size_t max) {
    static std::mt19937 rnd(std::time(nullptr));
    return std::uniform_int_distribution<>(min, max)(rnd);
}

void philosopher(int i) {
    while (true) {
        {
            std::lock_guard<std::mutex> lk(output_mtx);
            std::cout << "Philosopher " << i << " is thinking.\n";
        }

        std::this_thread::sleep_for(std::chrono::milliseconds(100));

        {
            std::lock_guard<std::mutex> lk(output_mtx);
            std::cout << "Philosopher " << i << " is hungry.\n";
        }

        //Waiting till all reach this point
        barrier.arrive_and_wait();

        std::unique_lock<std::mutex> left_fork_lock(forks[i]);
        std::this_thread::sleep_for(std::chrono::milliseconds(1));
        std::unique_lock<std::mutex> right_fork_lock(forks[(i + 1) % N]);

        {
            std::lock_guard<std::mutex> lk(output_mtx);
            std::cout << "Philosopher " << i << " is eating.\n";
        }
        std::this_thread::sleep_for(std::chrono::milliseconds(100));
    }
}

int main() {
    std::jthread philosophers[N];

    for (int i = 0; i < N; ++i) {
        philosophers[i] = std::jthread([i] { philosopher(i); });
    }

    return 0;
}

