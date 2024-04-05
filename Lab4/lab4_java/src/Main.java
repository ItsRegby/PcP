import java.util.concurrent.Semaphore;

public class Main {
    public static void PhilosopherRoomStart(int n){
        ForkSem[] forks = new ForkSem[n];
        PhilosopherRoom[] philosophers = new PhilosopherRoom[n];
        Semaphore diningRoom = new Semaphore(2); // Initialize the dining room with a semaphore to limit the number of philosophers

        for (int i = 0; i < forks.length; i++) {
            forks[i] = new ForkSem(i);
        }

        for (int i = 0; i < 5; i++) {
            philosophers[i] = new PhilosopherRoom(i, forks[i], forks[(i + 1) % 5], diningRoom);
            new Thread(philosophers[i]).start();
        }
    }

    public static Philosopher2[] createPhilosophers2(int n) {

        Fork[] forks = new Fork[n];

        for (int i = 0; i < n; i++) {
            forks[i] = new Fork(i);
        }

        Philosopher2[] philosophers = new Philosopher2[n];

        for (int i = 0; i < n; i++) {

            Fork leftFork = forks[i];
            Fork rightFork = forks[(i + 1) % n];

            philosophers[i] = new Philosopher2(i, leftFork, rightFork);

        }

        return philosophers;

    }
    public static Philosopher[] createPhilosophers(int n) {

        Fork[] forks = new Fork[n];

        for (int i = 0; i < n; i++) {
            forks[i] = new Fork(i);
        }

        Philosopher[] philosophers = new Philosopher[n];

        for (int i = 0; i < n; i++) {

            Fork leftFork = forks[i];
            Fork rightFork = forks[(i + 1) % n];

            philosophers[i] = new Philosopher(i, leftFork, rightFork);

        }

        return philosophers;

    }


    public static void main(String[] args) {
        int numPhilosophers = 5;

        /*Philosopher[] philosophers = createPhilosophers(numPhilosophers);

        for (Philosopher philosopher : philosophers) {
            philosopher.start();
        }*/

        /*Philosopher2[] philosophers2 = createPhilosophers2(numPhilosophers);

        for (Philosopher2 philosopher2 : philosophers2) {
            philosopher2.start();
        }*/

        /*PhilosopherToken[] philosophersToken = new PhilosopherToken[numPhilosophers];
        Thread[] threads = new Thread[numPhilosophers];

        for (int i = 0; i < numPhilosophers; i++) {
            philosophersToken[i] = new PhilosopherToken(i);
        }

        for (int i = 0; i < numPhilosophers; i++) {
            philosophersToken[i].setLeftPhilosopher(philosophersToken[(i + numPhilosophers-1) % numPhilosophers]);
            philosophersToken[i].setRightPhilosopher(philosophersToken[(i + numPhilosophers-(numPhilosophers-1)) % numPhilosophers]);
            threads[i] = new Thread(philosophersToken[i]);
            threads[i].start();
        }*/


        PhilosopherRoomStart(numPhilosophers);

    }
}