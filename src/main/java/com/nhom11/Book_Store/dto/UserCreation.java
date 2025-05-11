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
    @Email(message = "Email không đúng định dạng.")
    String email;

    @StrongPassword(message = "Mật khẩu cần có tối thiểu 6 kí tự: chữ, số, kí tự đặc biệt")
    String password;
}
