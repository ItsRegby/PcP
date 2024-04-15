#include <omp.h>
#include <iostream>

int main(int argc, char** argv)
{
    int master_v = 100;
	int id = 0;
#pragma omp parallel
    {
        int v = 0;
		#pragma omp master
		{
		    v = master_v;
			#pragma omp critical
				printf("master thread, v = %d\n", v);
		}
		#pragma omp critical
		{
			id = omp_get_thread_num();
			printf("v = %d  id = %d\n", v, id);
		}
    } 
    return 0;
}