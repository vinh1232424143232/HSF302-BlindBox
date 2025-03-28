package hsf.project.controller;

import hsf.project.pojo.Users;
import hsf.project.service.impl.UserServiceImpl;
import jakarta.servlet.http.HttpSession;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class LoginController {
    UserServiceImpl userServiceImpl;

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
        Users user = userServiceImpl.login(email);
        if (user != null) {
            if (!user.getPassword().equals(password)) {
                model.addAttribute("error", "Wrong password");
            } else {
                switch (user.getRole().getRole()) {
                    case "ADMIN":
                        session.setAttribute("user", user);
                        return "redirect:/management";
                    case "USER":
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
