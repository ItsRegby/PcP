import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

public class Main {
    public static void main(String[] args) {
        BreakThread breakThread = new BreakThread();
        int numThreads = 3;
        int step = 1;

        ExecutorService executor = Executors.newFixedThreadPool(numThreads+1);
        executor.execute(breakThread);


        /*for (int i = 0; i < numThreads; i++) {
            SequenceSumThread thread = new SequenceSumThread(i + 1, step, breakThread);
            executor.execute(thread);
        }*/

        SequenceSumThread thread1 = new SequenceSumThread(1992, 2, breakThread);
        SequenceSumThread thread2 = new SequenceSumThread(2030, 10, breakThread);
        SequenceSumThread thread3 = new SequenceSumThread(100001, 3, breakThread);
        executor.execute(thread1);
        executor.execute(thread2);
        executor.execute(thread3);

        executor.shutdown();

        try {
            if (!executor.awaitTermination(10, TimeUnit.SECONDS)) {
                executor.shutdownNow();
            }
        } catch (InterruptedException e) {
            executor.shutdownNow();
        }

        System.out.println("All threads have finished their work.");
    }
}