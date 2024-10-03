#include <chrono>
#include <iostream>
#include <thread>
#include <semaphore.h>
#include <queue>
#include <unistd.h>
#include <mutex>
#include <random>

#define N 5 // Number of philosophers

// States
enum { THINKING, HUNGRY, EATING };

int state[N];
std::queue<int> philosopherQueue;
std::mutex queueMutex;
sem_t philosophers[N];
sem_t mutex;

int getRandomTime(int min=400, int max=1000) {
  std::random_device rd;
  std::mt19937 gen(rd());
  std::uniform_int_distribution<> distr(min,max);
  return distr(gen);
}

void pickup_forks(int philosopher) {
    sem_wait(&mutex);

    state[philosopher] = HUNGRY;
    queueMutex.lock();
    philosopherQueue.push(philosopher);
    queueMutex.unlock();

    if (philosopherQueue.front() == philosopher) {
        philosopherQueue.pop();
        sem_post(&philosophers[philosopher]);
    }

    sem_post(&mutex);
    sem_wait(&philosophers[philosopher]);
}

void putdown_forks(int philosopher) {
    sem_wait(&mutex);

    state[philosopher] = THINKING;

    if (!philosopherQueue.empty()) {
        sem_post(&philosophers[philosopherQueue.front()]);
    }

    sem_post(&mutex);
}

void philosopher_func(int philosopher) {
    while (true) {
        std::cout << "Philosopher " << philosopher << " is thinking." << std::endl;
        std::this_thread::sleep_for(std::chrono::milliseconds(getRandomTime()));

        pickup_forks(philosopher);

        std::cout << "Philosopher " << philosopher << " is eating." << std::endl;
        std::this_thread::sleep_for(std::chrono::milliseconds(getRandomTime()));

        putdown_forks(philosopher);
    }
}

int main() {
    sem_init(&mutex, 0, 1);
    for (int i = 0; i < N; i++) {
        sem_init(&philosophers[i], 0, 0);
        state[i] = THINKING;
    }

    philosopherQueue.push(1);
    philosopherQueue.push(3);


    std::thread philosophersThread[N];
    for (int i = 0; i < N; i++) {
        philosophersThread[i] = std::thread(philosopher_func, i);
    }

    for (int i = 0; i < N; i++) {
        philosophersThread[i].join();
    }

    return 0;
}

