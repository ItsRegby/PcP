#include <omp.h>
#include <iostream>

int main(int argc, char** argv)
{
    int master_v = 100;
#pragma omp parallel
    {
        int v = 0;
#pragma omp master
	{
	    v = master_v;
		#pragma omp critical
	    std::cout << "master thread, v = "<< v << std::endl;
	}
#pragma omp critical
	std::cout << "v = "<< v  << std::endl;
    } 
    return 0;
}