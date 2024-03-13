import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        int arrayLength = 1000000;
        int numThreads = 4;

        int[] array = ArrayProcessor.generateArray(arrayLength);
        int minIndex = ArrayProcessor.getMinIndex();

        System.out.println("Generated array: " + Arrays.toString(array));
        System.out.println("Minimal element index: " + minIndex +
               "; " + "Value at minimal element index: " + array[minIndex] + "\n");

        Thread[] threads = new Thread[numThreads];
        int blockSize = arrayLength / numThreads;

        long startTime = System.currentTimeMillis();

        MinElementFinder minElementFinder = new MinElementFinder();

        for (int i = 0; i < numThreads; i++) {
            int startIndex = i * blockSize;
            int endIndex = (i == numThreads - 1) ? arrayLength : (i + 1) * blockSize;
            threads[i] = new Thread(new MinElementFinderRunnable(array, startIndex, endIndex, minElementFinder));
            threads[i].start();
        }

        try {
            for (Thread thread : threads) {
                thread.join();
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        long endTime = System.currentTimeMillis();

        long totalTime = endTime - startTime;

        System.out.println("Time elapsed: " + totalTime + " мс");

        System.out.println("Minimum element: " + minElementFinder.getMin());
        System.out.println("Index of minimum element: " + minElementFinder.getMinIndex());
    }
}