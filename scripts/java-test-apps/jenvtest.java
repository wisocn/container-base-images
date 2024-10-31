import java.util.Properties;

/**
 * Yes, i know. non-standard name but please spare me.
 */
public class jenvtest {
    public static void main(String[] args) {
        System.out.println("=== Full Java Environment and System Metrics ===\n");

        // Output all system properties
        Properties properties = System.getProperties();
        System.out.println("System Properties:");
        properties.forEach((key, value) -> System.out.println(key + ": " + value));
        
        System.out.println("\n=== Runtime Metrics ===");

        // Available processors
        int processors = Runtime.getRuntime().availableProcessors();
        System.out.println("Available Processors: " + processors);

        // JVM memory metrics
        long maxMemory = Runtime.getRuntime().maxMemory();
        long totalMemory = Runtime.getRuntime().totalMemory();
        long freeMemory = Runtime.getRuntime().freeMemory();

        System.out.println("JVM Max Memory (bytes): " + maxMemory);
        System.out.println("JVM Total Memory (bytes): " + totalMemory);
        System.out.println("JVM Free Memory (bytes): " + freeMemory);
        System.out.println("JVM Used Memory (bytes): " + (totalMemory - freeMemory));
        
        System.out.println("\nJava is working with full metrics displayed!");
    }
}
