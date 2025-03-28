package hsf.project.controller;


import hsf.project.pojo.Address;
import hsf.project.pojo.Users;
import hsf.project.service.AddressService;
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
@RequestMapping("/address")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AddressController {
    AddressService addressService;
    UserService userService;

    @GetMapping()
    public String address(HttpSession session, Model model) {
        Users user = (Users) session.getAttribute("user");
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        String email = user.getEmail();
        Users newUser = userService.getUserByEmail(email);
        session.setAttribute("user", newUser);
        List<Address> list = addressService.getAll(newUser);
        model.addAttribute("addresses", list);
        return "address";
    }

    @GetMapping("/all")
    public String all(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        } else {
            Users user = (Users) session.getAttribute("user");
            List<Address> list = addressService.getAll(user);
            model.addAttribute("addresses", list);
        }
        return "address";
    }


    @PostMapping("/create")
    public String create(HttpSession session, Model model, String street, String city, String number) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        } else {
            Users user = (Users) session.getAttribute("user");
            String email = user.getEmail();
            addressService.create(number, street, city, email);
        }
        return "redirect:/address";
    }

    @PostMapping("/edit")
    public String update(HttpSession session, Model model, int id, String street, String city, String number) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        } else {
            boolean status = addressService.update(id ,street, city, number);
            if (status) {
                model.addAttribute("status", "Update successful");
            } else {
                model.addAttribute("status", "Update failed");
            }
        }
        return "redirect:/address";
    }

    @PostMapping("/delete")
    public String delete(HttpSession session, int id, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        } else {
            boolean status = addressService.deleteById(id);
            if (status) {
                model.addAttribute("status", "Delete successful");
                return "redirect:/address";
            } else {
                model.addAttribute("status", "Delete failed");
                return "redirect:/home";
            }
        }

    }

}
