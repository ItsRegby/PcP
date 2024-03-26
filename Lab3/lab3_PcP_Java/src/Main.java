public class Main {
    public static void main(String[] args) {
        int capacity = 3; // максимальна місткість сховища
        int totalItems = 10; // загальна кількість продукції
        int producersCount = 3; // кількість виробників
        int consumersCount = 2; // кількість споживачів

        Storage storage = new Storage(capacity);

        // Створюємо та запускаємо потоки виробників
        for (int i = 0; i < producersCount; i++) {
            Thread producerThread = new Thread(new Producer(storage, totalItems, i + 1), "Producer " + (i + 1));
            producerThread.start();
        }

        // Створюємо та запускаємо потоки споживачів
        for (int i = 0; i < consumersCount; i++) {
            Thread consumerThread = new Thread(new Consumer(storage, totalItems * producersCount), "Consumer " + (i + 1));
            consumerThread.start();
        }
    }
}
