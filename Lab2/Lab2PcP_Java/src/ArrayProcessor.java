import java.util.Arrays;
public class ArrayProcessor {
    private static int randomIndex = -1;
    public static int[] generateArray(int length){
        int[] array = new int[length];
        Arrays.fill(array, Integer.MAX_VALUE);

        for (int i = 0; i < length; i++) {
            array[i] = (int) (Math.random() * 100);
        }

        randomIndex = (int) (Math.random() * length);
        //randomIndex = 200;
        array[randomIndex] = -111;

        return array;
    }
    public static int getMinIndex() {
        return randomIndex;
    }
}
