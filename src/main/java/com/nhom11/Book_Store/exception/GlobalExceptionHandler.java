package com.nhom11.Book_Store.exception;

import com.nhom11.Book_Store.dto.UserCreation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

import jakarta.servlet.http.HttpServletRequest;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(AppException.class)
    public String handleAppException(AppException e, Model model) {
        model.addAttribute("userCreation", new UserCreation());
        model.addAttribute("errMessage", e.getMessage());
        return "user/register";
    }

    @ExceptionHandler(NoHandlerFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ModelAndView handleNoHandlerFoundException(NoHandlerFoundException ex, HttpServletRequest request) {
        log.error("404 error occurred: {}", request.getRequestURL());
        ModelAndView mav = new ModelAndView("error/404");
        mav.addObject("url", request.getRequestURL());
        mav.addObject("exception", ex);
        return mav;
    }

    @ExceptionHandler(Exception.class)
    public ModelAndView handleException(Exception ex, HttpServletRequest request) {
        log.error("Unexpected error occurred: {}", ex.getMessage(), ex);
        ModelAndView mav = new ModelAndView("error/404");
        mav.addObject("url", request.getRequestURL());
        mav.addObject("exception", ex);
        return mav;
    }
}
