public class Main {
    public static void main(String[] args) {
        int capacity = 3;
        int totalItems = 10;
        int producersCount = 3;
        int consumersCount = 2;

        Storage storage = new Storage(capacity);

        for (int i = 0; i < producersCount; i++) {
            Thread producerThread = new Thread(new Producer(storage, totalItems, i + 1), "Producer " + (i + 1));
            producerThread.start();
        }

        for (int i = 0; i < consumersCount; i++) {
            Thread consumerThread = new Thread(new Consumer(storage, totalItems * producersCount), "Consumer " + (i + 1));
            consumerThread.start();
        }
    }
}
