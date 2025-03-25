package hsf.project.controller;

import hsf.project.pojo.Cart;
import hsf.project.pojo.Users;
import hsf.project.service.BlindBoxService;
import hsf.project.service.CartService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @Autowired
    private BlindBoxService blindBoxService;

    @GetMapping()
    public String cart(HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        } else {
            Users user = (Users) session.getAttribute("user");
            if (cartService.getCart(user) == null) {
                user.setCart(new Cart());
            }
        }
        return "cart";
    }

    @PostMapping("/addBlindbox")
    public void addBlindbox(HttpSession session, int blindboxId) {
        cartService.addBlindboxToCart((Users) session.getAttribute("user"), blindBoxService.getBlindBoxById(blindboxId));
    }

    @PostMapping("/removeBlindbox")
    public void removeBlindbox(HttpSession session, int blindboxId) {
        cartService.removeBlindboxFromCart((Users) session.getAttribute("user"), blindBoxService.getBlindBoxById(blindboxId));
    }

    @DeleteMapping("/delete")
    public String deleteCart(HttpSession session) {
        cartService.clearCart((Users) session.getAttribute("user"));
        return "redirect:/home";
    }

    @PostMapping("/updateQuantity")
    public String updateQuantity(HttpSession session, int blindboxId, int quantity) {
        cartService.changeBlinboxQuantity((Users) session.getAttribute("user"), blindBoxService.getBlindBoxById(blindboxId), quantity);
        return "redirect:/cart";
    }

}
