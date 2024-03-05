class SequenceSumThread implements Runnable {
    private int sequenceNumber = 0;
    private final int threadNumber;
    private final int step;
    private int sum;
    private int elementsCount;
    private final BreakThread breakThread;

    public SequenceSumThread(int threadNumber, int step, BreakThread breakThread) {
        this.threadNumber = threadNumber;
        this.step = step;
        this.sum = 0;
        this.elementsCount = 0;
        this.breakThread = breakThread;
    }

    @Override
    public void run() {
        long startTime = System.currentTimeMillis();
        do {
            sum += sequenceNumber;
            elementsCount++;
            sequenceNumber += step;
            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }while(!breakThread.isCanBreak());

        long endTime = System.currentTimeMillis();
        long totalTime = endTime - startTime;

        System.out.println("Thread " + threadNumber + ": Sum = " + sum + ", Elements Count = " + elementsCount+ ", Time taken: " + totalTime + " milliseconds");
    }
}
