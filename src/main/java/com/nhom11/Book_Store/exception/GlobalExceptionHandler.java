package com.nhom11.Book_Store.exception;

import com.nhom11.Book_Store.dto.UserCreation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(AppException.class)
    public String handleAppException(AppException e, Model model) {
        model.addAttribute("userCreation", new UserCreation());
        model.addAttribute("errMessage", e.getMessage());
        return "user/register";
    }
}
