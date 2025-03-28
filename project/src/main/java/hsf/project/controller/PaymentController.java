package hsf.project.controller;

import hsf.project.pojo.Cart;
import hsf.project.pojo.CartDetails;
import hsf.project.pojo.Users;
import hsf.project.service.CartService;
import hsf.project.service.UserService;
import hsf.project.service.VNPayService;
import hsf.project.service.impl.OrderServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/payment")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class PaymentController {
    CartService cartService;
    VNPayService vnPayService;



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

    @GetMapping("/success")
    public String checkoutSuccess() {
        return "success";
    }

    @GetMapping("/fail")
    public String checkoutFailed() {
        return "fail";
    }

    @PostMapping(path = "/create")
    public RedirectView createPayment(
            HttpServletRequest request,
            int orderId) {
        try {
            //Create payment url
            String ipAddress = getIpAddress(request);
            if (!StringUtils.hasText(ipAddress)) {
                throw new Exception("Invalid IP address");
            }
            String url = vnPayService.createPaymentUrl(orderId, ipAddress);
            //Redirect
            RedirectView redirectView = new RedirectView();
            redirectView.setUrl(url);
            return redirectView;
        } catch (Exception e) {
            e.getMessage().toString();
        }
        return new RedirectView("/hsf/payment/failed");
    }

    @GetMapping("/status")
    public RedirectView vnpayReturnStatus(@RequestParam Map<String, String> queryParams) {
        System.out.println("Received return from VNPAY: " + queryParams);
        RedirectView redirectView = new RedirectView();
        var result = vnPayService.processPaymentResponse(queryParams);
        redirectView.setUrl(result);
        return redirectView;
    }

    @PostMapping("/ipn")
    public Map<String, String> vnpayIPN(@RequestParam Map<String, String> queryParams) {
        System.out.println("Received return from VNPAY: " + queryParams);

        try {
            if (queryParams.isEmpty()) {
                throw new Exception("VNPAY_MISSING_PARAMS");
            }

            Map<String, String> response = vnPayService.processIPNResponse(queryParams);
            return response;
        } catch (Exception e) {
            e.getMessage().toString();
        }
        return null;
    }

    public String getIpAddress(HttpServletRequest request) {
        String ipAddress = request.getHeader("X-FORWARDED-FOR");
        if (!StringUtils.hasText(ipAddress)) {
            ipAddress = request.getHeader("X-Real-IP");
        }
        if (!StringUtils.hasText(ipAddress)) {
            ipAddress = request.getRemoteAddr();
        }

        // Nếu có nhiều IP (qua proxy), lấy IP đầu tiên
        if (StringUtils.hasText(ipAddress) && ipAddress.contains(",")) {
            ipAddress = ipAddress.split(",")[0].trim();
        }

        return ipAddress;
    }




}
