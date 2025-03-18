package hsf.project.controller;

import hsf.project.pojo.Users;
import hsf.project.service.RoleService;
import hsf.project.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    // Các chức năng liên quan đến người dùng khác nếu có
    @GetMapping()
    public String userProfile() {
        return "user";
    }

    @GetMapping("/register")
    public String registerRequest() {
        return "register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String fullName, @RequestParam String email, @RequestParam String password, @RequestParam String confirmPassword, @RequestParam String phone) {
        if (password.equals(confirmPassword)) {
            Users user = new Users(fullName, email, password, phone);
            user.setRole(roleService.getRolesById(2));
            userService.create(user);
        }
        return "login";
    }

}
