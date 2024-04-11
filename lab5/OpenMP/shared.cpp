#include <stdio.h>
#include <omp.h>

int main()
{
	int a[10];
	int t_id, i;

    for (i = 0; i < 10; i++)
    {
        a[i] = 0;
    }

	omp_set_num_threads(8);
#pragma omp parallel shared(a) private(t_id)
	{
		t_id = omp_get_thread_num();
		a[t_id] = t_id + 2;
	}
	for (i = 0; i < 10; i++)
	{
		printf("a[%d] = %d\n", i, a[i]);
	}
	return 0;
}