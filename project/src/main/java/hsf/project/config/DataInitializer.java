package hsf.project.config;

import hsf.project.pojo.Roles;
import hsf.project.pojo.Users;
import hsf.project.repository.RoleRepository;
import hsf.project.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
public class DataInitializer implements CommandLineRunner {

    private final RoleRepository roleRepository;
    private final UserRepository userRepository;

    @Autowired
    public DataInitializer(RoleRepository roleRepository, UserRepository userRepository) {
        this.roleRepository = roleRepository;
        this.userRepository = userRepository;
    }

    @Override
    @Transactional
    public void run(String... args) {
        // Check if roles already exist
        if (roleRepository.count() == 0) {
            System.out.println("Initializing roles...");
            
            // Create ADMIN role
            Roles adminRole = new Roles();
            adminRole.setRole("ADMIN");
            roleRepository.save(adminRole);
            
            // Create USER role
            Roles userRole = new Roles();
            userRole.setRole("USER");
            roleRepository.save(userRole);
            
            System.out.println("Roles created successfully!");
        }
        
        // Check if admin user exists
        if (userRepository.findByEmail("admin@blindbox.com") == null) {
            System.out.println("Creating admin user...");
            
            // Get the ADMIN role
            Roles adminRole = roleRepository.findByRole("ADMIN");
            
            if (adminRole != null) {
                // Create admin user
                Users admin = new Users();
                admin.setFullName("Admin User");
                admin.setEmail("admin@blindbox.com");
                admin.setPassword("admin123"); // In a real application, use a password encoder
                admin.setPhone("1234567890");
                admin.setActive(true);
                admin.setRole(adminRole);
                
                userRepository.save(admin);
                System.out.println("Admin user created successfully!");
            } else {
                System.err.println("ADMIN role not found, could not create admin user");
            }
        }
    }
} 