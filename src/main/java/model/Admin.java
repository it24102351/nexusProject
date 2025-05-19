package model;

public class Admin extends User {
    private String adminId;

    public Admin(String name, String email, String password, String adminId) {
        super(name, email, password);
        this.adminId = adminId;
    }

    // Getter method
    public String getAdminId() {
        return adminId;
    }

    // Setter method for adminId
    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    // Setter and Getter for password (if needed)
    @Override
    public void setPassword(String password) {
        super.setPassword(password);
    }

    public boolean authenticate(String enteredPassword) {
        return this.password.equals(enteredPassword);
    }
    
    // Convert admin data to string format for file storage
    public String toFileString() {
        return name + "," + email + "," + password + "," + adminId;
    }
}
