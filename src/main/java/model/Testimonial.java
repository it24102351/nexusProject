package model;

// This class holds one testimonial data
public class Testimonial {
    private String name;
    private String photo;
    private String message;

    // Constructor
    public Testimonial(String name, String photo, String message) {
        this.name = name;
        this.photo = photo;
        this.message = message;
    }

    // Getters
    public String getName() {
        return name;
    }

    public String getPhoto() {
        return photo;
    }

    public String getMessage() {
        return message;
    }
}

