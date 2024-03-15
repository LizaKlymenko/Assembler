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
    }
}