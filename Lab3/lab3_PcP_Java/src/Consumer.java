class Consumer implements Runnable {
    private final Storage storage;
    private final int totalItems;

    public Consumer(Storage storage, int totalItems) {
        this.storage = storage;
        this.totalItems = totalItems;
    }

    @Override
    public void run() {
        try {
            for (int i = 0; i < totalItems; i++) {
                storage.consume();
                Thread.sleep(100);
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            System.err.println("Consumer thread interrupted.");
        }
    }
}