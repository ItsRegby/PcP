class Producer implements Runnable {
    private final Storage storage;
    private final int totalItems;
    private final int producerId;

    public Producer(Storage storage, int totalItems, int producerId) {
        this.storage = storage;
        this.totalItems = totalItems;
        this.producerId = producerId;
    }

    @Override
    public void run() {
        try {
            for (int i = 1; i <= totalItems; i++) {
                int item = producerId + totalItems + i; // створюємо унікальний елемент для кожного виробника
                storage.produce(item);
                Thread.sleep(100); // симуляція виробництва
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            System.err.println("Producer thread interrupted.");
        }
    }
}