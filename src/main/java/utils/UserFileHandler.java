package utils;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import model.Admin;
import model.Attendance;
import model.NewStudent;
import model.Student;

// This class handles file operations for New Students, Current Students, and Admins
@SuppressWarnings("ALL")
public class UserFileHandler {

    // Store files in the web/data folder inside finalproject
    private static final String DESKTOP_PATH = System.getProperty("user.home") + "/Desktop/finalProject";
    private static final String DATA_DIR = DESKTOP_PATH + "/web/data";

    // File paths for each type of user
    private static final String NEW_STUDENT_FILE = DATA_DIR + "/new_students.txt";
    private static final String CURRENT_STUDENT_FILE = DATA_DIR + "/current_students.txt";
    private static final String ADMIN_FILE = DATA_DIR + "/admins.txt";

    static {
        // Create the data directory if it doesn't exist
        try {
            Files.createDirectories(Paths.get(DATA_DIR));
            System.out.println("Data directory created at: " + DATA_DIR);

            // Create files if they don't exist
            createFileIfNotExists(NEW_STUDENT_FILE);
            createFileIfNotExists(CURRENT_STUDENT_FILE);
            createFileIfNotExists(ADMIN_FILE);
        } catch (IOException e) {
            System.err.println("Error creating data directory: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void createFileIfNotExists(String filePath) throws IOException {
        if (!Files.exists(Paths.get(filePath))) {
            Files.createFile(Paths.get(filePath));
            System.out.println("Created file: " + filePath);
        }
    }

    // New Student Methods
    public static void saveNewStudent(NewStudent student) {
        try {
            System.out.println("Attempting to save new student to: " + NEW_STUDENT_FILE);
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(NEW_STUDENT_FILE, true))) {
                String data = student.toFileString();
                writer.write(data);
                writer.newLine();
                System.out.println("Successfully saved new student data: " + data);
            }
        } catch (IOException e) {
            System.err.println("Error saving new student: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static List<NewStudent> getNewStudents() {
        List<NewStudent> newStudents = new ArrayList<>();
        try {
            System.out.println("Attempting to read from: " + NEW_STUDENT_FILE);
            if (Files.exists(Paths.get(NEW_STUDENT_FILE))) {
                try (BufferedReader reader = new BufferedReader(new FileReader(NEW_STUDENT_FILE))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        System.out.println("Read line: " + line);
                        String[] parts = line.split(",");
                        if (parts.length >= 5) {
                            NewStudent student = new NewStudent(parts[0], parts[1], parts[2]);
                            student.setRegistrationTime(parts[3]);
                            student.setStatus(parts[4]);
                            if (parts.length > 5) {
                                student.setCourse(parts[5]);
                            }
                            newStudents.add(student);
                            System.out.println("Successfully parsed new student: " + student.getEmail() +
                                    " with registration time: " + student.getRegistrationTime());
                        }
                    }
                }
            } else {
                System.out.println("New students file does not exist at: " + NEW_STUDENT_FILE);
            }
        } catch (IOException e) {
            System.err.println("Error reading new students: " + e.getMessage());
            e.printStackTrace();
        }
        return newStudents;
    }

    public static boolean newStudentExists(String email) {
        List<NewStudent> students = getNewStudents();
        return students.stream().anyMatch(s -> s.getEmail().equals(email));
    }

    public static boolean verifyNewStudent(String email, String password) {
        List<NewStudent> students = getNewStudents();
        for (NewStudent student : students) {
            if (student.getEmail().equals(email) && student.getPassword().equals(password)) {
                return true;
            }
        }
        return false;
    }

    // Current Student Methods
    public static void saveCurrentStudent(Student student) {
        try {
            System.out.println("Attempting to save current student to: " + CURRENT_STUDENT_FILE);
            System.out.println("Student data: " + student.toFileString());

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(CURRENT_STUDENT_FILE, true))) {
                String data = student.toFileString();
                writer.write(data);
                writer.newLine();
                writer.flush();
                System.out.println("Successfully wrote student data to file");
            }
        } catch (IOException e) {
            System.err.println("Error saving current student: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static List<Student> getCurrentStudents() {
        List<Student> students = new ArrayList<>();
        try {
            System.out.println("Attempting to read from: " + CURRENT_STUDENT_FILE);
            if (Files.exists(Paths.get(CURRENT_STUDENT_FILE))) {
                try (BufferedReader reader = new BufferedReader(new FileReader(CURRENT_STUDENT_FILE))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        System.out.println("Read line: " + line);
                        String[] parts = line.split(",");
                        if (parts.length >= 4) {
                            Student student = new Student(parts[0], parts[1], parts[2]);
                            LocalDateTime registrationTime = LocalDateTime.parse(parts[3]);
                            student.setRegistrationTime(registrationTime);
                            students.add(student);
                            System.out.println("Successfully parsed current student: " + student.getEmail() +
                                    " with registration time: " + student.getRegistrationTime());
                        }
                    }
                }
            } else {
                System.out.println("Current students file does not exist at: " + CURRENT_STUDENT_FILE);
            }
        } catch (IOException e) {
            System.err.println("Error reading current students: " + e.getMessage());
            e.printStackTrace();
        }
        return students;
    }

    public static boolean currentStudentExists(String email) {
        List<Student> students = getCurrentStudents();
        return students.stream().anyMatch(s -> s.getEmail().equals(email));
    }

    public static boolean verifyCurrentStudent(String email, String password) {
        List<Student> students = getCurrentStudents();
        for (Student student : students) {
            if (student.getEmail().equals(email) && student.getPassword().equals(password)) {
                return true;
            }
        }
        return false;
    }

    // Admin Methods
    public static List<Admin> getAdmins() {
        List<Admin> admins = new ArrayList<>();
        try {
            System.out.println("Attempting to read from: " + ADMIN_FILE);
            if (Files.exists(Paths.get(ADMIN_FILE))) {
                try (BufferedReader reader = new BufferedReader(new FileReader(ADMIN_FILE))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        System.out.println("Read line: " + line);
                        String[] parts = line.split(",");
                        if (parts.length >= 4) {
                            Admin admin = new Admin(parts[0], parts[1], parts[2], parts[3]);
                            admins.add(admin);
                            System.out.println("Successfully parsed admin: " + admin.getEmail());
                        }
                    }
                }
            } else {
                System.out.println("Admin file does not exist at: " + ADMIN_FILE);
            }
        } catch (IOException e) {
            System.err.println("Error reading admins: " + e.getMessage());
            e.printStackTrace();
        }
        return admins;
    }

    public static boolean verifyAdmin(String email, String password) {
        List<Admin> admins = getAdmins();
        for (Admin admin : admins) {
            if (admin.getEmail().equals(email) && admin.getPassword().equals(password)) {
                return true;
            }
        }
        return false;
    }

    // Update and Delete Methods
    public static boolean updateNewStudent(NewStudent student) {
        List<NewStudent> students = getNewStudents();
        boolean found = false;

        for (int i = 0; i < students.size(); i++) {
            if (students.get(i).getEmail().equals(student.getEmail())) {
                students.set(i, student);
                found = true;
                break;
            }
        }

        if (found) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(NEW_STUDENT_FILE))) {
                for (NewStudent s : students) {
                    writer.write(s.toFileString());
                    writer.newLine();
                }
                return true;
            } catch (IOException e) {
                System.err.println("Error updating new student: " + e.getMessage());
                e.printStackTrace();
            }
        }
        return false;
    }

    public static boolean updateCurrentStudent(Student updatedStudent) {
        List<Student> students = getCurrentStudents();
        boolean found = false;

        for (int i = 0; i < students.size(); i++) {
            if (students.get(i).getEmail().equals(updatedStudent.getEmail())) {
                students.set(i, updatedStudent);
                found = true;
                break;
            }
        }

        if (found) {
            try {
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(CURRENT_STUDENT_FILE))) {
                    for (Student student : students) {
                        writer.write(student.toFileString());
                        writer.newLine();
                    }
                }
                return true;
            } catch (IOException e) {
                System.err.println("Error updating current student: " + e.getMessage());
                e.printStackTrace();
            }
        }
        return false;
    }

    public static boolean deleteNewStudent(String email) {
        List<NewStudent> students = getNewStudents();
        boolean found = false;

        for (int i = 0; i < students.size(); i++) {
            if (students.get(i).getEmail().equals(email)) {
                students.remove(i);
                found = true;
                break;
            }
        }

        if (found) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(NEW_STUDENT_FILE))) {
                for (NewStudent student : students) {
                    writer.write(student.toFileString());
                    writer.newLine();
                }
                return true;
            } catch (IOException e) {
                System.err.println("Error deleting new student: " + e.getMessage());
                e.printStackTrace();
            }
        }
        return false;
    }

    public static boolean deleteCurrentStudent(String email) {
        List<Student> students = getCurrentStudents();
        boolean found = false;

        students.removeIf(student -> student.getEmail().equals(email));
        found = true;

        if (found) {
            try {
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(CURRENT_STUDENT_FILE))) {
                    for (Student student : students) {
                        writer.write(student.toFileString());
                        writer.newLine();
                    }
                }
                return true;
            } catch (IOException e) {
                System.err.println("Error deleting current student: " + e.getMessage());
                e.printStackTrace();
            }
        }
        return false;
    }

    public static void saveAttendance(LocalDate date, List<String> presentStudentIds) throws IOException {
        String attendanceDir = DATA_DIR + "/attendance";
        File dir = new File(attendanceDir);
        if (!dir.exists()) {
            dir.mkdir();
        }

        String filename = attendanceDir + "/attendance_" + date.toString() + ".txt";
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filename))) {
            for (String studentId : presentStudentIds) {
                Attendance attendance = new Attendance(studentId, date, true);
                writer.write(attendance.toFileString());
                writer.newLine();
            }
        }
    }

    public static List<Attendance> getAttendance(LocalDate date) throws IOException {
        String filename = DATA_DIR + "/attendance/attendance_" + date.toString() + ".txt";
        File file = new File(filename);
        if (!file.exists()) {
            return List.of();
        }

        List<Attendance> attendanceRecords = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Attendance attendance = Attendance.fromFileString(line.trim());
                if (attendance != null) {
                    attendanceRecords.add(attendance);
                }
            }
        }
        return attendanceRecords;
    }

    public static List<String> getPresentStudentEmails(LocalDate date) throws IOException {
        return getAttendance(date).stream()
                .filter(Attendance::isPresent)
                .map(Attendance::getStudentEmail)
                .collect(Collectors.toList());
    }

    // Approve a student by email
    public static void approveStudentByEmail(String email) {
        List<NewStudent> students = getNewStudents();
        boolean found = false;
        for (NewStudent s : students) {
            if (s.getEmail().equalsIgnoreCase(email)) {
                s.setStatus("approved");
                found = true;
                break;
            }
        }
        if (found) {
            saveNewStudents(students);
        }
    }

    // Save the updated list of students back to the file
    public static void saveNewStudents(List<NewStudent> students) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(NEW_STUDENT_FILE))) {
            for (NewStudent s : students) {
                writer.write(s.getName() + "," + s.getEmail() + "," + s.getPassword() + "," + s.getRegistrationTime() + "," + s.getStatus());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}