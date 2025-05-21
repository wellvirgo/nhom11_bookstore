package com.nhom11.Book_Store.config;

import com.nhom11.Book_Store.model.User;
import com.nhom11.Book_Store.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import java.io.IOException;

@NoArgsConstructor
@Component
public class LoginSuccessHandler implements AuthenticationSuccessHandler {
    private UserService userService;
    // private final SavedRequestAwareAuthenticationSuccessHandler
    //         delegateSuccessHandler = new SavedRequestAwareAuthenticationSuccessHandler();

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    protected void setSessionAttributes(HttpServletRequest request, Authentication authentication) {
        HttpSession session = request.getSession(false);
        if (session == null)
            return;

        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
        String email = authentication.getName();
        User user = userService.getUserByEmail(email);

        session.setAttribute("userId", user.getId());
        session.setAttribute("name", String.format("%s %s", user.getFirstName(), user.getLastName()));
        session.setAttribute("userTyp", user.getUserType());
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        if (response.isCommitted())
            return;
        setSessionAttributes(request, authentication);

        SavedRequest s = new HttpSessionRequestCache().getRequest(request, response);
        if (s != null) {
            String targetUrl = s.getRedirectUrl();
            response.sendRedirect(targetUrl);
            return;
        }
        HttpSession session = request.getSession(false);
        if (session != null){
            String userType = (String) session.getAttribute("userTyp");
            if ("ADMIN".equals(userType)) {
                // Thêm userType vào URL
                response.sendRedirect(request.getContextPath() + "/admin/das?userType=" + userType);
            } else {    
                response.sendRedirect(request.getContextPath() + "/user/home?userType=" + userType);
            }
        }

        // delegateSuccessHandler.onAuthenticationSuccess(request, response, authentication);
    }
}
