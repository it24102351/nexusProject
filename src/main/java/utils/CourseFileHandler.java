package utils;

// Import important Java classes
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletContext;
import model.Course;

public class CourseFileHandler {

    // Set where to save data: Desktop/finalProject/web/data
    private static final String DESKTOP_PATH = System.getProperty("user.home") + "/Desktop/finalProject";
    private static final String DATA_DIR = DESKTOP_PATH + "/web/data";
    private static final String COURSES_FILE = DATA_DIR + "/courses.txt";

    // This block runs once when class is loaded
    static {
        try {
            // Create "data" folder if it does not exist
            Files.createDirectories(Paths.get(DATA_DIR));
            System.out.println("Data directory created at: " + DATA_DIR);

            // Create "courses.txt" file if it does not exist
            if (!Files.exists(Paths.get(COURSES_FILE))) {
                Files.createFile(Paths.get(COURSES_FILE));
                System.out.println("Created file: " + COURSES_FILE);
            }
        } catch (IOException e) {
            System.err.println("Error creating data directory: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Save ServletContext object (for web application path)
    private static ServletContext servletContext;

    // Set ServletContext from outside
    public static void setServletContext(ServletContext context) {
        servletContext = context;
    }

    // Get real file path (optional if needed)
    private static String getFilePath() {
        if (servletContext == null) {
            throw new IllegalStateException("ServletContext not set");
        }
        return servletContext.getRealPath("/WEB-INF/data/" + COURSES_FILE);
    }

    // Read all courses from courses.txt file
    public static List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();
        try {
            System.out.println("Attempting to read from: " + COURSES_FILE);
            if (Files.exists(Paths.get(COURSES_FILE))) {
                // Open file to read
                try (BufferedReader reader = new BufferedReader(new FileReader(COURSES_FILE))) {
                    String line;
                    // Read each line one by one
                    while ((line = reader.readLine()) != null) {
                        System.out.println("Read line: " + line);
                        String[] parts = line.split("\\|"); // Split by |
                        if (parts.length == 8) {
                            // Create new Course object
                            Course course = new Course();
                            course.setId(Integer.parseInt(parts[0]));
                            course.setCourseName(parts[1]);
                            course.setDescription(parts[2]);
                            course.setInstructor(parts[3]);
                            course.setPrice(Double.parseDouble(parts[4]));
                            course.setDuration(parts[5]);
                            course.setLevel(parts[6]);
                            course.setCategory(parts[7]);
                            courses.add(course); // Add course to list
                            System.out.println("Successfully parsed course: " + course.getCourseName());
                        }
                    }
                }
            } else {
                System.out.println("Courses file does not exist at: " + COURSES_FILE);
            }
        } catch (IOException e) {
            System.err.println("Error reading courses: " + e.getMessage());
            e.printStackTrace();
        }
        return courses;
    }

    // Get one course by ID
    public static Course getCourseById(int courseId) {
        List<Course> courses = getAllCourses();
        return courses.stream()
                .filter(course -> course.getId() == courseId)
                .findFirst()
                .orElse(null);
    }

    // Add new course to the file
    public static void addCourse(Course course) {
        try {
            System.out.println("Attempting to save course to: " + COURSES_FILE);
            List<Course> courses = getAllCourses(); // Get current courses

            // Create new ID (last ID + 1)
            int newId = courses.isEmpty() ? 1 : courses.get(courses.size() - 1).getId() + 1;
            course.setId(newId);

            // Write new course data at the end of the file
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(COURSES_FILE, true))) {
                String data = String.format("%d|%s|%s|%s|%.2f|%s|%s|%s%n",
                        course.getId(),
                        course.getCourseName(),
                        course.getDescription(),
                        course.getInstructor(),
                        course.getPrice(),
                        course.getDuration(),
                        course.getLevel(),
                        course.getCategory());
                writer.write(data); // Write data
                writer.flush(); // Make sure it is saved
                System.out.println("Successfully saved course data: " + data);
            }
        } catch (IOException e) {
            System.err.println("Error saving course: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Update an existing course
    public static void updateCourse(Course updatedCourse) {
        System.out.println("Starting course update for course ID: " + updatedCourse.getId());
        System.out.println("New course name: " + updatedCourse.getCourseName());
        
        List<Course> courses = getAllCourses(); // Get all courses
        System.out.println("Current number of courses: " + courses.size());

        // Find course by ID and update it
        boolean found = false;
        for (int i = 0; i < courses.size(); i++) {
            if (courses.get(i).getId() == updatedCourse.getId()) {
                System.out.println("Found course to update at index: " + i);
                System.out.println("Old course name: " + courses.get(i).getCourseName());
                courses.set(i, updatedCourse);
                found = true;
                break;
            }
        }

        if (!found) {
            System.out.println("Warning: Course with ID " + updatedCourse.getId() + " not found!");
            return;
        }

        System.out.println("Saving updated courses list...");
        saveCourses(courses); // Save updated list
        System.out.println("Course update completed successfully");
    }

    // Delete a course by ID
    public static boolean deleteCourse(int courseId) {
        List<Course> courses = getAllCourses(); // Get all courses
        boolean removed = false; // Track if any course was deleted

        // Use removeIf to delete matching course by ID
        removed = courses.removeIf(course -> course.getId() == courseId);

        // Save the updated courses back to the file
        if (removed) {
            saveCourses(courses);
        }

        return removed; // Return true if deleted, false if not found
    }

    // Save all courses back to the file
    private static void saveCourses(List<Course> courses) {
        try {
            System.out.println("Attempting to save all courses to: " + COURSES_FILE);
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(COURSES_FILE))) {
                for (Course course : courses) {
                    // Write each course
                    String data = String.format("%d|%s|%s|%s|%.2f|%s|%s|%s%n",
                            course.getId(),
                            course.getCourseName(),
                            course.getDescription(),
                            course.getInstructor(),
                            course.getPrice(),
                            course.getDuration(),
                            course.getLevel(),
                            course.getCategory());
                    writer.write(data);
                }
                writer.flush(); // Save all
                System.out.println("Successfully saved all courses");
            }
        } catch (IOException e) {
            System.err.println("Error saving courses: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
