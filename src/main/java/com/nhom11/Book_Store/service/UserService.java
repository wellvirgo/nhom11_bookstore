package com.nhom11.Book_Store.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nhom11.Book_Store.model.User;
import com.nhom11.Book_Store.repository.UserRepository;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;
    // public boolean authenticate(String username, String password) {
    //     // Assuming you have a UserRepository to interact with the database
    //     User user = userRepository.findByUsername(username);
    //     if (user != null && user.getPassword().equals(password)) {
    //         return true;
    //     }
    //     return false;
    // }
    // Add this method to the UserService class
    public boolean authenticate(String username, String password) {
        // Implement authentication logic here
        User user = findByUsername(username);
        return user != null && user.getPassword().equals(password);
    }
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }
}
