#include <chrono>
#include <iostream>
#include <thread>
#include <semaphore.h>
#include <queue>
#include <mutex>
#include <random>

#define N 5


enum { THINKING, HUNGRY, EATING };

int state[N];
std::queue<int> hungryQueue;
std::mutex queueMutex;
sem_t philosophers[N];
sem_t mutex;
std::vector<int> eatTimes(5);

int getRandomTime(int min = 400, int max = 1000) {
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> distr(min, max);
    return distr(gen);
}

// Test if the philosopher can eat (neighbors must not be eating)
void test(int philosopher) {
    int left = (philosopher + N - 1) % N;
    int right = (philosopher + 1) % N;

    if (state[philosopher] == HUNGRY && state[left] != EATING && state[right] != EATING) {
        state[philosopher] = EATING;
        sem_post(&philosophers[philosopher]);
    }
}


void pickup_forks(int philosopher) {
    sem_wait(&mutex);

    state[philosopher] = HUNGRY;

    queueMutex.lock();
    hungryQueue.push(philosopher);
    queueMutex.unlock();

    if (hungryQueue.front() == philosopher) {
        test(philosopher);
    }

    sem_post(&mutex);
    sem_wait(&philosophers[philosopher]);
}

void putdown_forks(int philosopher) {
    sem_wait(&mutex);

    state[philosopher] = THINKING;

    queueMutex.lock();
    if (!hungryQueue.empty() && hungryQueue.front() == philosopher) {
        hungryQueue.pop();
    }
    queueMutex.unlock();

    if (!hungryQueue.empty()) {
        test(hungryQueue.front());
    }

    sem_post(&mutex);
}

void philosopher_func(int philosopher) {
    while (true) {
        std::cout << "Philosopher " << philosopher << " is thinking." << std::endl;
        std::this_thread::sleep_for(std::chrono::milliseconds(std::chrono::milliseconds(100)));

        pickup_forks(philosopher);

        std::cout << "Philosopher " << philosopher << " is eating." << std::endl;

        eatTimes[philosopher]++;
        sem_wait(&mutex);
        for (auto i: eatTimes) {
            std::cout << i << " ";
        }
        sem_post(&mutex);

        std::this_thread::sleep_for(std::chrono::milliseconds(std::chrono::milliseconds(100)));

        putdown_forks(philosopher);
    }
}

int main() {
    sem_init(&mutex, 0, 1);
    for (int i = 0; i < N; i++) {
        sem_init(&philosophers[i], 0, 0);
        state[i] = THINKING;
    }

    std::thread philosophersThread[N];
    for (int i = 0; i < N; i++) {
        philosophersThread[i] = std::thread(philosopher_func, i);
    }

    for (int i = 0; i < N; i++) {
        philosophersThread[i].join();
    }

    return 0;
}
