package utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import model.NewStudent;

public class StudentSorter {
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    // Sort students by registration time using insertion sort
    public static void sortByRegistrationTime(List<NewStudent> students) {
        int n = students.size();
        for (int i = 1; i < n; i++) {
            NewStudent key = students.get(i);
            Date keyDate = parseDate(key.getRegistrationTime());
            
            int j = i - 1;
            while (j >= 0 && parseDate(students.get(j).getRegistrationTime()).after(keyDate)) {
                students.set(j + 1, students.get(j));
                j = j - 1;
            }
            students.set(j + 1, key);
        }
    }

    // Helper method to parse date string
    private static Date parseDate(String dateStr) {
        try {
            return dateFormat.parse(dateStr);
        } catch (ParseException e) {
            // If parsing fails, return epoch time
            return new Date(0);
        }
    }

    // Sort students by name using insertion sort
    public static void sortByName(List<NewStudent> students) {
        int n = students.size();
        for (int i = 1; i < n; i++) {
            NewStudent key = students.get(i);
            String keyName = key.getName().toLowerCase();
            
            int j = i - 1;
            while (j >= 0 && students.get(j).getName().toLowerCase().compareTo(keyName) > 0) {
                students.set(j + 1, students.get(j));
                j = j - 1;
            }
            students.set(j + 1, key);
        }
    }
} 