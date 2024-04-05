import java.util.concurrent.Semaphore;
public class PhilosopherRoom implements Runnable {
    private int id;
    private ForkSem leftFork;
    private ForkSem rightFork;
    private Semaphore diningRoom;

    public PhilosopherRoom(int id, ForkSem leftFork, ForkSem rightFork, Semaphore diningRoom) {
        this.id = id;
        this.leftFork = leftFork;
        this.rightFork = rightFork;
        this.diningRoom = diningRoom;
    }

    private void pickUpForks() throws InterruptedException {
        leftFork.pickUp();
        rightFork.pickUp();
        System.out.println("Philosopher " + id + " is eating.");
        putDownForks();
    }

    private void putDownForks() {
        leftFork.putDown();
        rightFork.putDown();
        System.out.println("Philosopher " + id + " finished eating.");
    }

    @Override
    public void run() {
        for (int i = 0; i < 100; i++)  {
            try {
                Thread.sleep(1000);
                diningRoom.acquire();
                pickUpForks();
                diningRoom.release();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
