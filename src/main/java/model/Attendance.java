package model;

import java.time.LocalDate;

public class Attendance {
    private String studentEmail;
    private LocalDate date;
    private boolean present;

    public Attendance(String studentEmail, LocalDate date, boolean present) {
        this.studentEmail = studentEmail;
        this.date = date;
        this.present = present;
    }

    // Getters and Setters
    public String getStudentEmail() {
        return studentEmail;
    }

    public void setStudentEmail(String studentEmail) {
        this.studentEmail = studentEmail;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public boolean isPresent() {
        return present;
    }

    public void setPresent(boolean present) {
        this.present = present;
    }

    // Convert attendance data to string for file storage
    public String toFileString() {
        return studentEmail + "," + date.toString() + "," + present;
    }

    // Create Attendance object from file string
    public static Attendance fromFileString(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 3) {
            String email = parts[0];
            LocalDate date = LocalDate.parse(parts[1]);
            boolean present = Boolean.parseBoolean(parts[2]);
            return new Attendance(email, date, present);
        }
        return null;
    }
} 