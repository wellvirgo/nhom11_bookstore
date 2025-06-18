package com.nhom11.Book_Store.config;

import com.nhom11.Book_Store.constrant.UserType;
import com.nhom11.Book_Store.model.User;
import com.nhom11.Book_Store.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

@NoArgsConstructor
@Component
public class LoginSuccessHandler implements AuthenticationSuccessHandler {
    private UserService userService;
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    protected String determineTargetUrl(final Authentication authentication) {
        Map<String, String> roleTargetUrlMap=new HashMap<>();
        roleTargetUrlMap.put("ROLE_"+UserType.ADMIN.getValue(), "/admin/das");
        roleTargetUrlMap.put("ROLE_"+UserType.USER.getValue(), "/");

        final Collection<? extends GrantedAuthority> authorities=authentication.getAuthorities();
        for(GrantedAuthority authority : authorities){
            String authorityName = authority.getAuthority();
            if(roleTargetUrlMap.containsKey(authorityName)){
                return roleTargetUrlMap.get(authorityName);
            }
        }
        throw new IllegalArgumentException();
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
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        if (response.isCommitted())
            return;
        SavedRequest savedRequest=new HttpSessionRequestCache().getRequest(request, response);
        String targetUrl;
        if(savedRequest!=null){
            targetUrl=savedRequest.getRedirectUrl();
        }
        else{
            targetUrl=determineTargetUrl(authentication);
        }
        setSessionAttributes(request, authentication);
        redirectStrategy.sendRedirect(request, response, targetUrl);
    }
}
