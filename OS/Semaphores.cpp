#include <iostream>
#include <thread>
#include <mutex>
#include <vector>
#include <chrono>
#include<random>

#define N 5 // Number of philosophers

std::mutex forks[N]; // One mutex per fork

std::mutex output_mtx;


size_t my_rand(size_t min, size_t max) 
{
    static std::mt19937 rnd(std::time(nullptr));
    return std::uniform_int_distribution<>(min, max)(rnd);
}


enum State { THINKING, HUNGRY, EATING };
State state[N] = { THINKING };

// Function to simulate the philosopher's actions
void philosopher(int i) {
    while (true) {
        std::this_thread::sleep_for(std::chrono::milliseconds(my_rand(100,400))); //think
        {
            std::unique_lock<std::mutex> left_fork_lock(forks[i]); // Acquire left fork
            std::unique_lock<std::mutex> right_fork_lock(forks[(i + 1) % N]); // Acquire right fork
            // If successful in acquiring both forks
            std::this_thread::sleep_for(std::chrono::milliseconds(my_rand(100,400))); //eat
            // Both forks are released when leaving the scope
        }
    }
}

int main() {
    std::jthread t0([&] { philosopher(0); });
    std::jthread t1([&] { philosopher(1); });
    std::jthread t2([&] { philosopher(2); });
    std::jthread t3([&] { philosopher(3); });
    std::jthread t4([&] { philosopher(4); });
    return 0;
}

