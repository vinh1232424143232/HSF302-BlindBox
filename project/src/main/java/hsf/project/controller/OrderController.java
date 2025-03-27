package hsf.project.controller;

import hsf.project.pojo.CartDetails;
import hsf.project.pojo.Users;
import hsf.project.service.CartService;
import hsf.project.service.impl.OrderServiceImpl;
import jakarta.servlet.http.HttpSession;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/order")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OrderController {
    CartService cartService;
    OrderServiceImpl orderService;

    @PostMapping("/create")
    public String createOrder(HttpSession session, int addressId, Model model) {
        Users users = (Users) session.getAttribute("user");
        if (users == null) {
            return "redirect:/login";
        }
        int total = cartService.totalCart(users.getCart());
        orderService.createOrder(users, addressId, total);
        return "redirect:/user/order/all";
    }
}
