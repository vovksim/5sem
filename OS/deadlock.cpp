#include <iostream>
#include <thread>
#include <mutex>
#include <vector>
#include <chrono>
#include<random>

#define N 4 // Number of philosophers

// Forks represented as mutexes
std::mutex forks[N]; // One mutex per fork

std::mutex output_mtx;


size_t my_rand(size_t min, size_t max) 
{
    static std::mt19937 rnd(std::time(nullptr));
    return std::uniform_int_distribution<>(min, max)(rnd);
}


// Enum for the state of philosophers
enum State { THINKING, HUNGRY, EATING };
State state[N] = { THINKING };

// Function to simulate the philosopher's actions
void philosopher(int i) {
    while (true) {
        // Thinking
        // Try to acquire both forks
        std::this_thread::sleep_for(std::chrono::milliseconds(100));
        {
            std::lock_guard<std::mutex> lk(output_mtx);  
            std::cout << "Starting acquiring forks" << " Thread: " << std::this_thread::get_id() << std::endl;
        }
        {
            std::unique_lock<std::mutex> left_fork_lock(forks[i]); // Acquire left fork
            std::unique_lock<std::mutex> right_fork_lock(forks[(i + 1) % N]); // Acquire right fork
            // If successful in acquiring both forks
            std::lock_guard<std::mutex> lk(output_mtx);
            std::cout << "Philosopher " << i << " is eating.\n";
            std::this_thread::sleep_for(std::chrono::milliseconds(100));   
            // Both forks are released when leaving the scope
        }
        {
            std::lock_guard<std::mutex> lk(output_mtx);
            // Release forks
            std::cout << "Philosopher " << i << " is thinking.\n";
      
        }
    }
}

int main() {
    std::jthread t0([&] { philosopher(0); }); // [&] means every variable outside the ensuing lambda 
    std::jthread t1([&] { philosopher(1); }); // is captured by reference
    std::jthread t2([&] { philosopher(2); });
    std::jthread t3([&] { philosopher(3); });
    //std::jthread t4([&] { philosopher(4); });
    return 0;
}

