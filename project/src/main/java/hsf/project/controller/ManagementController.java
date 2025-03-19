package hsf.project.controller;

import hsf.project.pojo.Roles;
import hsf.project.pojo.Users;
import hsf.project.service.RoleService;
import hsf.project.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequestMapping("/management")
public class ManagementController {
    UserService userService;
    RoleService roleService;

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

    @GetMapping("/user")
    public String userManagement(HttpSession session, Model model) {
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        } else {
            if (!user.getRole().getRole().equals("ADMIN")) {
                return "redirect:/login";
            }
        }
        session.setAttribute("user", user);
        List<Users> listUser = userService.getAllUsers();
        List<Roles> listRole = roleService.getAllRoles();
        model.addAttribute("users", listUser);
        model.addAttribute("roles", listRole);
        return "userManagement";
    }

    @GetMapping("/order")
    public String orderManagement(HttpSession session) {
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        } else {
            if (!user.getRole().getRole().equals("ADMIN")) {
                return "redirect:/login";
            }
        }
        return "orderManagement";
    }

    @PostMapping("/user/update")
    public String updateUser(String email, String fullName, String phone, int roleId, boolean status) {
        userService.adminUpdate(email, fullName, phone, roleId, status);
        return "redirect:/management/user";
    }

    @PostMapping("/user/delete")
    public String deleteUser(int id) {
        userService.deleteById(id);
        return "redirect:/management/user";
    }

    @PostMapping("/user/create")
    public String createUser(String email, String fullName, String phone, String password, int roleId) {
        Users user = Users.builder()
                .fullName(fullName)
                .email(email)
                .phone(phone)
                .password(password)
                .role(roleService.getRolesById(roleId))
                .active(true)
                .build();
        userService.create(user);
        return "redirect:/management/user";
    }
}
