package hsf.project.controller;

import hsf.project.pojo.Users;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/management")
public class ManagementController {
    @GetMapping
    public String management(HttpSession session) {
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        } else {
            if (!user.getRole().getRole().equals("ADMIN")) {
                return "redirect:/login";
            }
        }
        return "management";
    }
}
