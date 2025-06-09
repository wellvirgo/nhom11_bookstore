package com.nhom11.Book_Store.config;

import com.nhom11.Book_Store.service.CustomUserDetailsService;
import jakarta.servlet.DispatcherType;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

@Slf4j
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {
    CustomUserDetailsService userDetailsService;

    private static final String[] PUBLIC_URLS = {
            "/css/admin/**",
            "/js/admin/**",
            "/css/user/**",
            "/vendor/**",
            "/images/**",
            "/js/user/**",
            // "/product/**",
            // "/product/add-to-card"

        };

    private static final String[] PUBLIC_GET_URLS = {
            "/favicon.ico",
            "/login",
            "/register"
    };

    private static final String[] PUBLIC_POST_URLS = {"/register"};

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider daoAuthenticationProvider() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setPasswordEncoder(passwordEncoder());
        provider.setUserDetailsService(userDetailsService);

        return provider;
    }

    @Bean
    public AuthenticationSuccessHandler authenticationSuccessHandler() {
        return new LoginSuccessHandler();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth
                        .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE).permitAll()

                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        .requestMatchers("/user/**").hasRole("USER")

                        .requestMatchers(PUBLIC_URLS).permitAll()

                        .requestMatchers(HttpMethod.GET, PUBLIC_GET_URLS).permitAll()

                        .requestMatchers(HttpMethod.POST, PUBLIC_POST_URLS).permitAll()

                        .anyRequest().authenticated())
                .csrf(csrf -> csrf.disable()) 
                .formLogin(form -> form
                        .loginPage("/login")
                        .successHandler(authenticationSuccessHandler())
                        .failureUrl("/login?error")
                        .permitAll())

                .logout(logout -> logout
                        .logoutSuccessHandler((request, response, authentication) -> {
                            log.info("User {} logged out", authentication.getName());
                            response.sendRedirect("/login?logout");
                        }))

                .sessionManagement(s -> s
                        .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED));

        return http.build();
        // http
        // .authorizeHttpRequests(auth -> auth
        //     .anyRequest().permitAll()  // Cho phép tất cả các request
        // )
        // .csrf(csrf -> csrf.disable());  // Tắt bảo vệ CSRF

        // return http.build();
    }
}
