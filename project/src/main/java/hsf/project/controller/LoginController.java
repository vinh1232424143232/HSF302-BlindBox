package hsf.project.controller;

import hsf.project.enums.CurrentRole;
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
            return "redirect:/home";
        } else {
            return "login";
        }
    }

    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password, HttpSession session, Model model) {
        Users user = userService.login(email);
        if (user != null) {
            if (!user.getPassword().equals(password)) {
                model.addAttribute("error", "Wrong password");
            } else {
                switch (user.getRole().getRole()) {
                    case "ADMIN":
                        session.setAttribute("currentRole", CurrentRole.ADMIN.toString());
                        session.setAttribute("user", user);
                        return "redirect:/admin/dashboard";
                    case "USER":
                        session.setAttribute("currentRole", CurrentRole.USER.toString());
                        session.setAttribute("user", user);
                        return "redirect:/home";

                }
            }
        } else {
            model.addAttribute("error", "User not found");
        }
        return "login";
    }


    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
