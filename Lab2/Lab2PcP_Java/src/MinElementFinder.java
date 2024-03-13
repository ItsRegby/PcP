public class MinElementFinder {
    private int min = Integer.MAX_VALUE;
    private int minIndex = -1;

    public synchronized void updateMin(int localMin, int localMinIndex) {
        if (localMin < min) {
            min = localMin;
            minIndex = localMinIndex;
        }
    }

    public synchronized int getMin() {
        return min;
    }

    public synchronized int getMinIndex() {
        return minIndex;
    }
}
