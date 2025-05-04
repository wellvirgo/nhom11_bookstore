package com.nhom11.Book_Store.dto;

import com.nhom11.Book_Store.annotations.StrongPassword;
import jakarta.validation.constraints.Email;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserCreation {
    @Email(message = "Email is not incorrect format.")
    String email;

    @StrongPassword(message = "Password need to have at least 6 characters: letters, digits, special symbols")
    String password;
}
