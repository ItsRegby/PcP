public class MinElementFinderRunnable implements Runnable {
    private final int[] array;
    private final int startIndex;
    private final int endIndex;
    private final MinElementFinder minElementFinder;

    public MinElementFinderRunnable(int[] array, int startIndex, int endIndex, MinElementFinder minElementFinder) {
        this.array = array;
        this.startIndex = startIndex;
        this.endIndex = endIndex;
        this.minElementFinder = minElementFinder;
    }

    @Override
    public void run() {
        int localMin = Integer.MAX_VALUE;
        int localMinIndex = -1;

        for (int i = startIndex; i < endIndex; i++) {
            if (array[i] < localMin) {
                localMin = array[i];
                localMinIndex = i;
            }
        }

        minElementFinder.updateMin(localMin, localMinIndex);
    }
}
