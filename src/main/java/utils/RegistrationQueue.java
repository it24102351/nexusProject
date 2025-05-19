package utils;

import java.util.LinkedList;
import java.util.List;

import model.NewStudent;

public class RegistrationQueue {
    private static LinkedList<NewStudent> queue = new LinkedList<>();

    static {
        // Initialize queue from existing pending students
        List<NewStudent> existingStudents = UserFileHandler.getNewStudents();
        for (NewStudent student : existingStudents) {
            if ("pending".equals(student.getStatus())) {
                queue.addLast(student);
            }
        }
    }

    // Add a new student to the queue
    public static void enqueue(NewStudent student) {
        if (!contains(student.getEmail())) {
            queue.addLast(student);
        }
    }

    // Remove and return the first student from the queue
    public static NewStudent dequeue() {
        if (isEmpty()) {
            return null;
        }
        return queue.removeFirst();
    }

    // Remove a specific student from the queue (used when approving or deleting)
    public static void removeStudent(String email) {
        queue.removeIf(student -> student.getEmail().equals(email));
    }

    // Check if queue is empty
    public static boolean isEmpty() {
        return queue.isEmpty();
    }

    // Get the current size of the queue
    public static int size() {
        return queue.size();
    }

    // Get all students in the queue without removing them
    public static LinkedList<NewStudent> getQueue() {
        return new LinkedList<>(queue);
    }

    // Clear the queue
    public static void clear() {
        queue.clear();
    }

    // Check if a student is already in the queue
    public static boolean contains(String email) {
        return queue.stream().anyMatch(student -> student.getEmail().equals(email));
    }

    // Refresh the queue from the file system
    public static void refreshQueue() {
        queue.clear();
        List<NewStudent> existingStudents = UserFileHandler.getNewStudents();
        for (NewStudent student : existingStudents) {
            if ("pending".equals(student.getStatus())) {
                queue.addLast(student);
            }
        }
    }
} 