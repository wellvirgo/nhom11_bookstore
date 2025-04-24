package com.nhom11.Book_Store.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.lang.NonNull;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@Configuration
@EnableWebMvc
public class WebConfig implements WebMvcConfigurer {
    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/views/");
        viewResolver.setSuffix(".jsp");
        viewResolver.setViewClass(JstlView.class);

        return viewResolver;
    }

    @Override
    public void configureViewResolvers(@NonNull ViewResolverRegistry registry) {
        registry.viewResolver(viewResolver());
    }

    @Override
    public void addResourceHandlers(@NonNull ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/css/admin/**")
                .addResourceLocations("/resources/css/admin/");
        registry.addResourceHandler("/js/admin/**")
                .addResourceLocations("/resources/js/admin/");

        registry.addResourceHandler("/css/user/**")
                .addResourceLocations("/resources/css/user/");
        registry.addResourceHandler("/js/user/**")
                .addResourceLocations("/resources/js/user/");

        registry.addResourceHandler("/vendor/**")
                .addResourceLocations("/resources/vendor/");
        registry.addResourceHandler("/images/**")
                .addResourceLocations("/resources/images/");
    }
}
