package com.nhom11.Book_Store.service;

import com.nhom11.Book_Store.constrant.UserType;
import com.nhom11.Book_Store.dto.UserCreation;
import com.nhom11.Book_Store.exception.AppException;
import com.nhom11.Book_Store.model.User;
import com.nhom11.Book_Store.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Service
public class UserService {
    UserRepository userRepository;
    PasswordEncoder passwordEncoder;

    public boolean isExistUser(String email) {
        return userRepository.existsByEmail(email);
    }

    public User create(UserCreation userCreation) {
        String email = userCreation.getEmail();
        if (isExistUser(email))
            throw new AppException("Email đã tồn tại trong hệ thống.");

        String hashedPassword = passwordEncoder.encode(userCreation.getPassword());
        User user = User.builder()
                .email(email)
                .password(hashedPassword)
                .userType(UserType.USER.getValue())
                .build();

        return userRepository.save(user);
    }

    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }
}

// package com.nhom11.Book_Store.service;

// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Service;

// import com.nhom11.Book_Store.model.User;
// import com.nhom11.Book_Store.repository.UserRepository;

// @Service
// public class UserService {
//     @Autowired
//     private UserRepository userRepository;
//     // public boolean authenticate(String username, String password) {
//     //     // Assuming you have a UserRepository to interact with the database
//     //     User user = userRepository.findByUsername(username);
//     //     if (user != null && user.getPassword().equals(password)) {
//     //         return true;
//     //     }
//     //     return false;
//     // }
//     // Add this method to the UserService class
//     public boolean authenticate(String username, String password) {
//         // Implement authentication logic here
//         User user = findByUsername(username);
//         return user != null && user.getPassword().equals(password);
//     }
//     public User findByUsername(String username) {
//         return userRepository.findByUsername(username);
//     }
// }
