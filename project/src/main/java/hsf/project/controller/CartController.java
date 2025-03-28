package hsf.project.controller;

import hsf.project.pojo.Address;
import hsf.project.pojo.Cart;
import hsf.project.pojo.CartDetails;
import hsf.project.pojo.Users;
import hsf.project.service.AddressService;
import hsf.project.service.CartDetailService;
import hsf.project.service.CartService;
import hsf.project.service.impl.CartServiceImpl;
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
@RequestMapping("/cart")
public class CartController {
    CartService cartService;
    CartDetailService cartDetailService;


    @GetMapping()
    public String cart(HttpSession session, Model model) {
        Users user = (Users) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = cartService.getCartByUser(user);
            if(cart == null) {
                cart = cartService.createCart(user);
            }
            session.setAttribute("cart", cart);
        }
        List<CartDetails> cartDetails = cartDetailService.getCartDetailsByCart(cart);
        int total = cartService.totalCart(cart);
        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("total", total);
        return "cart";
    }

    @PostMapping("/add")
    public String addCart(HttpSession session, Model model, int blindboxId, int quantity) {
        Users user = (Users) session.getAttribute("user");
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        Cart cart = cartService.getCartByUser(user);
        cartService.addToCart(cart, blindboxId, quantity);
        List<CartDetails> cartDetails = cartDetailService.getCartDetailsByCart(cart);

        model.addAttribute("cart", cart);
        model.addAttribute("cartDetails", cartDetails);
        return "redirect:/cart";
    }

    @PostMapping("/update")
    public String updateCart(HttpSession session, Model model, int id, int quantity) {
        Users user = (Users) session.getAttribute("user");
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        Cart cart = cartService.getCartByUser(user);
        cartDetailService.updateCartDetail(id, quantity);
        List<CartDetails> cartDetails = cartDetailService.getCartDetailsByCart(cart);
        model.addAttribute("cart", cart);
        model.addAttribute("cartDetails", cartDetails);
        return "redirect:/cart";
    }

}
