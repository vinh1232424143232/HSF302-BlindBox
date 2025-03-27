package hsf.project.controller;

import hsf.project.pojo.Cart;
import hsf.project.pojo.CartDetails;
import hsf.project.pojo.Users;
import hsf.project.service.CartService;
import jakarta.servlet.http.HttpSession;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/payment")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class PaymentController {
    CartService cartService;

    @GetMapping
    public String checkout(Model model, HttpSession session) {
        Users users = (Users) session.getAttribute("user");
        if (users == null) {
            return "redirect:/login";
        }
        Cart cart = cartService.getCartByUser(users);
        int total = cartService.totalCart(cart);
        List<CartDetails> cartDetails = cart.getCartDetailsList();
        model.addAttribute("user", users);
        model.addAttribute("total", total);
        model.addAttribute("cartDetails", cartDetails);
        return "checkout";
    }


}
