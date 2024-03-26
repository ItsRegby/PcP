import java.util.LinkedList;
import java.util.Queue;

class Storage {
    private final Queue<Integer> buffer;
    private final int capacity;

    public Storage(int capacity) {
        this.capacity = capacity;
        this.buffer = new LinkedList<>();
    }

    public synchronized void produce(int item) throws InterruptedException {
        while (buffer.size() == capacity) {
            System.out.println("Storage is full. Waiting for space to produce.");
            wait(); // чекаємо, якщо сховище повне
        }
        buffer.offer(item);
        System.out.println("Produced item: " + item + ". Remaining space: " + (capacity - buffer.size()));
        notifyAll(); // сповіщаємо всіх чекаючих, що можна продовжити виконання
    }

    public synchronized int consume() throws InterruptedException {
        while (buffer.isEmpty()) {
            System.out.println("Storage is empty. Waiting for items to consume.");
            wait(); // чекаємо, якщо сховище порожнє
        }
        int item = buffer.poll();
        System.out.println("Consumed item: " + item + ". Remaining items: " + buffer.size());
        notifyAll(); // сповіщаємо всіх чекаючих, що можна продовжити виконання
        return item;
    }
}