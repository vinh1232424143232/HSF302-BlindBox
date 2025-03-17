package hsf.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserController {
    // Các chức năng liên quan đến người dùng khác nếu có
    @GetMapping()
    public String userProfile() {
        return "user";
    }

}
