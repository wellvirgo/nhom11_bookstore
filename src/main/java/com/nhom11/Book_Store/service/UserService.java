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
            throw new AppException("Email is already in use.");

        String hashedPassword = passwordEncoder.encode(userCreation.getPassword());
        User user = User.builder()
                .email(email)
                .password(hashedPassword)
                .userType(UserType.USER.getValue())
                .build();

        return userRepository.save(user);
    }
}
