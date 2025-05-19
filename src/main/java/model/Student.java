package model;

import java.time.LocalDateTime;

// This class extends User and includes registration time
public class Student extends User {
    private LocalDateTime registrationTime;

    // Constructor
    public Student(String name, String email, String password) {
        super(name, email, password);
        this.registrationTime = LocalDateTime.now(); // get current date and time
    }

    // Getter method
    public LocalDateTime getRegistrationTime() {
        return registrationTime;
    }

    // Setter method for registrationTime (if you need to change it later)
    public void setRegistrationTime(LocalDateTime registrationTime) {
        this.registrationTime = registrationTime;
    }

    // Convert student data to save in file
    public String toFileString() {
        return name + "," + email + "," + password + "," + registrationTime.toString();
    }
}