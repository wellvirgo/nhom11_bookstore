package com.nhom11.Book_Store.controller;

import com.nhom11.Book_Store.dto.UserCreation;
import com.nhom11.Book_Store.service.UserService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Slf4j
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Controller
public class UserController {
    UserService userService;

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/register")
    public String register(Model model) {
        UserCreation userCreation = new UserCreation();
        model.addAttribute("userCreation", userCreation);
        return "user/register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute(name = "userCreation") @Valid UserCreation userCreation,
                           BindingResult bindingResult) {
        if (bindingResult.hasErrors())
            return "user/register";

        userService.create(userCreation);
        return "redirect:/login";
    }
}
