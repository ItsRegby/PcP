#include <stdio.h>
#include <omp.h>

int main()
{
	int t_id = 0;
	int i = 10;
	omp_set_num_threads(8); 
#pragma omp parallel private(t_id)
	{
		t_id = omp_get_thread_num();
		printf("t_id = %d  i = %d \n", t_id, i);
		i++;
	}
	printf("t_id = %d  i = %d \n", t_id, i);
}