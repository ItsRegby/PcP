#include <omp.h>
#include <iostream>
#include <mutex>

int main(int argc, char** argv)
{
    int counter = 0;
    double t0 = omp_get_wtime();
#pragma omp parallel num_threads(4) shared(counter)
    {
        for (int i = 0; i < 1000000; i++)
        {
            counter += 1;
        }
    }
    double t1 = omp_get_wtime();
    double t = (t1 - t0) * 1000;

    std::cout<< "origin counter = "<< counter << " cost "<< t << " ms."<<std::endl;

    std::mutex mtx;
    counter = 0;
    t0 = omp_get_wtime();
#pragma omp parallel num_threads(4) shared(counter)
    {
        for (int i = 0; i < 1000000; i++)
        {
            mtx.lock();
            counter += 1;
            mtx.unlock();
        }
    }
    t1 = omp_get_wtime();
    t = (t1 - t0) * 1000;
    std::cout<< "lock counter = "<< counter << " cost "<< t << " ms."<<std::endl;

    counter = 0;
    t0 = omp_get_wtime();
#pragma omp parallel num_threads(4) shared(counter)
    {
        for (int i = 0; i < 1000000; i++)
        {
#pragma omp atomic 
            counter += 1;
        }
    }
    t1 = omp_get_wtime();
    t = (t1 - t0) * 1000;
    std::cout<< "atomic counter = "<< counter << " cost "<< t << " ms."<<std::endl;

    counter = 0;
    t0 = omp_get_wtime();
#pragma omp parallel num_threads(4) shared(counter)
    {
        for (int i = 0; i < 1000000; i++)
        {
#pragma omp critical 
            counter += 1;
        }
    }
    t1 = omp_get_wtime();
    t = (t1 - t0) * 1000;
    std::cout<< "critical counter = "<< counter << " cost "<< t << " ms."<<std::endl;
    return 0;
}
