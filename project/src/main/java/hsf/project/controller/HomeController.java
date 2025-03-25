package hsf.project.controller;

import hsf.project.enums.CurrentRole;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/home")
public class HomeController {

    @GetMapping()
    public String homePage(Model model, HttpSession session) {
        if (session.getAttribute("currentRole") == null) {
            session.setAttribute("currentRole", CurrentRole.GUEST.toString());
        }
        return "home";
    }

//    @RequestMapping("/")
//    public String redirectToHomePage() {
//        return "redirect:/hsf/home";
//    }
}
