import java.util.Scanner;
import java.util.Arrays;

public class Java {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        String input = scanner.nextLine();
        String[] numbers = input.split(" ");
        int n = numbers.length;
        int[] binaryValues = new int[n];

        for (int i = 0; i < n; i++) {
            int decimalValue = Integer.parseInt(numbers[i]);
            // конвертуємо десяткове число в бінарне представлення
            String binaryValue = Integer.toBinaryString(decimalValue < 0 ? Integer.MAX_VALUE : decimalValue);
            binaryValues[i] = Integer.parseInt(binaryValue, 2);
        }
        // сортування алгоритмом bubble sort
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (binaryValues[j] > binaryValues[j+1]) {
                    int temp = binaryValues[j];
                    binaryValues[j] = binaryValues[j+1];
                    binaryValues[j+1] = temp;
                }
            }
        }
        // виведення відсортованих значень
        System.out.println("Sorted binary values:");
        for (int value : binaryValues) {
            System.out.println(value);
        }
        // обчислення медіани та середнього значення
        int median = n % 2 == 0 ? (binaryValues[n/2 - 1] + binaryValues[n/2]) / 2 : binaryValues[n/2];
        int sum = Arrays.stream(binaryValues).sum();
        int average = sum / n;
        // виведення результатів
        System.out.println("Median: " + median);
        System.out.println("Average: " + average);

    }
}