package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class NewStudent {
    private String name;
    private String email;
    private String password;
    private String registrationTime;
    private String status; // "pending", "approved", "rejected"
    private String course; // Added course field

    public NewStudent(String name, String email, String password) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.registrationTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        this.status = "pending";
    }

    // Getters and Setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRegistrationTime() {
        return registrationTime;
    }

    public void setRegistrationTime(String registrationTime) {
        this.registrationTime = registrationTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    // Convert to string for file storage
    public String toFileString() {
        return name + "," + email + "," + password + "," + registrationTime + "," + status + "," + course;
    }
} 