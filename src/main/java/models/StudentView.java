package models;

public class StudentView {
    private String id;
    private String name;
    private String email;
    private String course;
    private String status;

    public StudentView(String id, String name, String email, String course, String status) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.course = course;
        this.status = status;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

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

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return id + "," + name + "," + email + "," + course + "," + status;
    }
} 