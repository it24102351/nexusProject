package utils;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import model.Testimonial;

// This class handles reading and writing testimonials to file
public class testimonialFileHandler {

    private static final String DESKTOP_PATH = System.getProperty("user.home") + "/Desktop/finalProject";
    private static final String DATA_DIR = DESKTOP_PATH + "/web/data";
    private static final String TESTIMONIAL_FILE = DATA_DIR + "/testimonial.txt";

    // Function to read testimonials from the file
    public static List<Testimonial> readTestimonials(String filePath) throws IOException {
        List<Testimonial> list = new ArrayList<>();
        File file = new File(filePath);
        
        // Create directory and file if they don't exist
        file.getParentFile().mkdirs();
        if (!file.exists()) {
            file.createNewFile();
            return list; // Return empty list for new file
        }

        // Open the file to read
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            // Read each line from the file
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length == 3) {
                    list.add(new Testimonial(parts[0], parts[1], parts[2]));
                }
            }
        }
        return list;
    }

    // Function to write a new testimonial to the file
    public static void writeTestimonial(String filePath, Testimonial testimonial) throws IOException {
        File file = new File(filePath);
        
        // Create directory and file if they don't exist
        file.getParentFile().mkdirs();
        if (!file.exists()) {
            file.createNewFile();
        }

        // Open the file in append mode
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
            // Write the testimonial data separated by |
            writer.write(testimonial.getName() + "|" + testimonial.getPhoto() + "|" + testimonial.getMessage());
            writer.newLine(); // Move to next line
        }
    }
}
