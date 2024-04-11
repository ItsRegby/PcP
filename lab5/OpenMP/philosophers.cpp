#include <stdlib.h>
#include <stdio.h>
#include <omp.h>
#include <windows.h>
#define sleep(x) Sleep(1000 * x)

#define NO_PHILO 5
#define NO_CHOPS 5

omp_lock_t chopstick[NO_CHOPS];

void think(int id)
{
    printf("Philosopher %d is thinking...\n", id);
    sleep(1 + (rand() % NO_PHILO));
}

void eat(int id)
{
    printf("Philosopher %d is hungry...\n", id);

    if (id == NO_PHILO - 1)
    {
        omp_set_lock(&chopstick[id]);
        printf("----Philosopher %d took left chopstick...\n", id);
        omp_set_lock(&chopstick[0]);
        printf("----Philosopher %d took right chopstick...\n", id);
        printf("----Philosopher %d is eating...\n", id);
        sleep(2);
        printf("----Philosopher %d finished eating -> releases chopsticks \n", id);
        omp_unset_lock(&chopstick[0]);
        omp_unset_lock(&chopstick[id]);
    }
    else
    {
        omp_set_lock(&chopstick[id]);
        printf("----Philosopher %d took left chopstick...\n", id);
        omp_set_lock(&chopstick[id + 1]);
        printf("----Philosopher %d took right chopstick...\n", id);
        printf("----Philosopher %d is eating...\n", id);
        sleep(2);
        printf("----Philosopher %d finished eating -> releases chopsticks \n", id);
        omp_unset_lock(&chopstick[id + 1]);
        omp_unset_lock(&chopstick[id]);
    }
}

void philosophize(int id)
{
    for (int j = 0; j < 1; j++)
    {
        think(id);
        eat(id);
    }
}

int main()
{
    omp_set_num_threads(NO_PHILO);

    int id;

    for (id = 0; id < NO_PHILO; id++)
    {
        omp_init_lock(&chopstick[id]);
    }

#pragma omp parallel for private(id)
    for (id = 0; id < NO_PHILO; id++)
    {
        philosophize(id);
    }

    return 0;
}