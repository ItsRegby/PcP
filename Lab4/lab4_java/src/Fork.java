public class Fork {

    public final int id;
    private boolean forkIsOnTheTable = true;
    private int philosopherUsingThisFork;

    public Fork(int id) {
        this.id = id;
    }

    public synchronized void take(int philosopher) {

        while (!forkIsOnTheTable) {
            try {
                wait();
            }
            catch (InterruptedException ignored) {}
        }

        philosopherUsingThisFork = philosopher;

        forkIsOnTheTable = false;
    }

    public synchronized void put(int philosopher) {

        if (!forkIsOnTheTable && philosopherUsingThisFork == philosopher) {
            forkIsOnTheTable = true;
            notifyAll();
        }
    }
}
