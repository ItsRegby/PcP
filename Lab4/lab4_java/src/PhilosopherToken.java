import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
public class PhilosopherToken implements Runnable{
    private int id;
    private Lock leftFork;
    private Lock rightFork;
    private PhilosopherToken leftPhilosopher;
    private PhilosopherToken rightPhilosopher;
    private static volatile int token = 0; // Shared token among philosophers
    private static volatile boolean[] isEating = new boolean[5];

    public PhilosopherToken(int id) {
        this.id = id;
        this.leftFork = new ReentrantLock();
        this.rightFork = new ReentrantLock();
    }

    public void setLeftPhilosopher(PhilosopherToken leftPhilosopher) {
        this.leftPhilosopher = leftPhilosopher;
    }

    public void setRightPhilosopher(PhilosopherToken rightPhilosopher) {
        this.rightPhilosopher = rightPhilosopher;
    }

    private void pickUpForks() {
        if (!isEating[leftPhilosopher.id] && !isEating[rightPhilosopher.id] && (token == id || (token == (id + 2) % 5))) {
            leftFork.lock();
            rightFork.lock();
            isEating[id] = true;
            System.out.println("Philosopher " + id + " is eating.");
            token = (token + 1) % 5; // Passing the token to the next philosopher
            putDownForks();
        }
        /*if (token == id) {
            leftFork.lock();
            rightFork.lock();
            System.out.println("Philosopher " + id + " is eating.");
            token = (token + 1) % 5;
            putDownForks();
        }*/
    }

    private void putDownForks() {
        leftFork.unlock();
        rightFork.unlock();
        isEating[id] = false;
        System.out.println("Philosopher " + id + " finished eating.");
    }

    @Override
    public void run() {
        for (int i = 0; i < 100; i++)  {
            try {
                Thread.sleep(1000);
                pickUpForks();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
