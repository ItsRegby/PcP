import java.util.concurrent.Semaphore;
class ForkSem {
    private int id;
    public Semaphore semaphore;

    public ForkSem(int id) {
        this.id = id;
        semaphore = new Semaphore(1);
    }

    public void pickUp() throws InterruptedException {
        semaphore.acquire();
    }

    public void putDown() {
        semaphore.release();
    }
}
