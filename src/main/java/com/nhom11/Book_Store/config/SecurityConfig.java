package com.nhom11.Book_Store.config;

import com.nhom11.Book_Store.service.CustomUserDetailsService;
import jakarta.servlet.DispatcherType;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

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
            "/js/user/**"};

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider daoAuthenticationProvider(){
        DaoAuthenticationProvider provider=new DaoAuthenticationProvider();
        provider.setPasswordEncoder(passwordEncoder());
        provider.setUserDetailsService(userDetailsService);

        return provider;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth
                        .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE).permitAll()

                        .requestMatchers("/admin/das").hasRole("ADMIN")

                        .requestMatchers(PUBLIC_URLS).permitAll()

                        .requestMatchers(HttpMethod.GET, "/favicon.ico").permitAll())

                .formLogin(form->form
                        .loginPage("/login")
                        .failureUrl("/login?error")
                        .permitAll());

        return http.build();
    }
}
