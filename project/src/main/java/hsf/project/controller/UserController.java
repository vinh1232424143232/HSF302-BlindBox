package hsf.project.controller;

import hsf.project.pojo.Orders;
import hsf.project.pojo.Users;
import hsf.project.service.OrderService;
import hsf.project.service.UserService;
import hsf.project.service.impl.RoleServiceImpl;
import jakarta.servlet.http.HttpSession;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserController {
    UserService userService;
    RoleServiceImpl roleServiceImpl;
    OrderService orderService;


    @GetMapping()
    public String userProfile(HttpSession session) {
        Users user = (Users)session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        String email = user.getEmail();
        Users newUser = userService.getUserByEmail(email);
        session.setAttribute("user", newUser);
        return "user";

    }


    @GetMapping("/register")
    public String registerRequest(HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "register";
        } else {
            return "home";
        }
    }

    @GetMapping("/user/all")
    public String allUsers(HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        } else {
            Users user = (Users) session.getAttribute("user");
            if (!user.getRole().getRole().equals("ADMIN")) {
                return "redirect:/login";
            } else {
                List<Users> list = userService.getAllUsers();
                session.setAttribute("user", user);
                session.setAttribute("userList", list);
            }
        }
        return "management";
    }

    @GetMapping("/order/all")
    public String all(HttpSession session) {
        Users users = (Users) session.getAttribute("user");
        if (users == null) {
            return "redirect:/login";
        }
        List<Orders> ordersList = orderService.getOrdersByUser(users);
        session.setAttribute("orders", ordersList);

        return "order";
    }

    @PostMapping("/register")
    public String register(@RequestParam String fullName, @RequestParam String email, @RequestParam String password, @RequestParam String confirmPassword, @RequestParam String phone) {
        if (password.equals(confirmPassword)) {
            Users user = Users.builder()
                    .email(email)
                    .fullName(fullName)
                    .password(password)
                    .active(true)
                    .phone(phone)
                    .build();
            user.setRole(roleServiceImpl.getRolesById(2));
            userService.create(user);
        }
        return "login";
    }

    @PostMapping("/update")
    public String update(@RequestParam String fullName, @RequestParam String email, @RequestParam String newPassword, @RequestParam String currentPassword, @RequestParam String phone, Model model) {
        boolean status = userService.updateUser(email, fullName, currentPassword, newPassword, phone);
        if (status) {
            model.addAttribute("status", "Update successful");
        } else {
            model.addAttribute("status", "Can't update user information");
        }
        return "redirect:/user";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam String fullName, @RequestParam String email, @RequestParam String phone, Model model) {
        boolean status = userService.deleteUser(email);
        if (status) {
            model.addAttribute("status", "Deleted successfully");
            return "management";
        } else {
            model.addAttribute("status", "Can't delete user");
            return "management";
        }
    }

    private Date convertToDate(LocalDateTime localDateTime) {
        return Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
    }

}
