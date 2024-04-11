#include<iostream>
#include<omp.h>


const int rows = 100000;
const int cols = 1000;

int arr[rows][cols];

void init_arr() {
    srand(time(0));
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            arr[i][j] = rand() % 100;
        }
    }
}

long long get_sum(int num_threads, double& execution_time) {
    long long sum = 0;
    double t1 = omp_get_wtime();

    #pragma omp parallel for num_threads(num_threads) reduction(+:sum) 
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            sum += arr[i][j];
        }
    }
    double t2 = omp_get_wtime();
    execution_time = t2 - t1;
    return sum;
}

void get_min_row(int num_threads, int& min_row, int& min_sum, double& execution_time) {
    min_sum = INT_MAX;
    min_row = -1;
    double t1 = omp_get_wtime();

    #pragma omp parallel for num_threads(num_threads)
    for (int i = 0; i < rows; i++) {
        long long row_sum = 0;
        for (int j = 0; j < cols; j++) {
            row_sum += arr[i][j];
        }
        if (row_sum < min_sum) {
            #pragma omp critical
            {
                if (row_sum < min_sum) {
                    min_sum = row_sum;
                    min_row = i;
                }
            }
        }
    }
    double t2 = omp_get_wtime();
    execution_time = t2 - t1;
}

int main() {
    int const max_thread = 8;
    long long sum[max_thread];
    int min_sum[max_thread];
    int min_row[max_thread];
    double executed_time[2][max_thread];
    init_arr();

    omp_set_nested(1);
    double t1 = omp_get_wtime();
    #pragma omp parallel sections
    {
        #pragma omp section
        {
            for (int i = 0; i < max_thread; i++)
            {
               sum[i] = get_sum(i + 1,executed_time[0][i]);
            }
        }
        #pragma omp section
        {
            for (int i = 0; i < max_thread; i++)
            {
                get_min_row(i + 1, min_row[i], min_sum[i], executed_time[1][i]);
            }
        }
    }
    double t2 = omp_get_wtime();

    for (int i = 0; i < max_thread; i++) {
        std::cout << "Threads used: " << i + 1 << ", all sum: " << sum[i] << " and executed time: " 
            << executed_time[0][i] << " seconds" << std::endl;
    }

    for (int i = 0; i < max_thread; i++) {
        std::cout << "Threads used: " << i + 1 << ", Min row: " << min_row[i] << " with min sum " << min_sum[i]
            << " and executed time: " << executed_time[1][i] << " seconds" << std::endl;
    }
    std::cout << "Total time - " << t2 - t1 << " seconds" << std::endl;

    return 0;
}