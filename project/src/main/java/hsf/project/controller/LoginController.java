package hsf.project.controller;

import hsf.project.pojo.Users;
import hsf.project.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {
    @Autowired
    UserService userService;

    @GetMapping("/login")
    public String login(HttpSession session) {
        if (session.getAttribute("user") != null) {
            return "redirect:/home-02";
        } else {
            return "login";
        }
    }

    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password, HttpSession session, Model model) {
        Users user = userService.login(email, password);
        if (user != null) {
            switch (user.getRole().getRole()) {
                case "ADMIN":
                    session.setAttribute("user", user);
                    return "redirect:/management";
                case "USER":
                    session.setAttribute("user", user);
                    return "redirect:/home";

            }
        } else {
            model.addAttribute("error", "Invalid username or password");
        }
        return "login";
    }


    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
