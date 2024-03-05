public class BreakThread implements Runnable {
    private boolean canBreak = false;
    private SequenceSumThread seqSumThread;
    @Override
    public void run() {
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        canBreak = true;
    }
    synchronized public boolean isCanBreak() {
        return canBreak;
    }
}
