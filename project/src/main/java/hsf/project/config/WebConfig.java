package hsf.project.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Serve static resources from webapp/images directory
        registry.addResourceHandler("/images/**")
                .addResourceLocations("/images/");
        
        // Serve static resources from webapp/uploads directory
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("/uploads/");
                
        // Add other resource handlers if needed
        registry.addResourceHandler("/css/**")
                .addResourceLocations("/css/");
                
        registry.addResourceHandler("/js/**")
                .addResourceLocations("/js/");
    }
} 