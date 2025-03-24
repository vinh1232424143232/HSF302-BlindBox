package hsf.project.controller;

import hsf.project.pojo.Users;
import hsf.project.service.BlindBoxService;
import hsf.project.service.BrandService;
import hsf.project.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final BlindBoxService blindBoxService;
    private final BrandService brandService;
    private final UserService userService;

    @Autowired
    public AdminController(BlindBoxService blindBoxService, BrandService brandService, UserService userService) {
        this.blindBoxService = blindBoxService;
        this.brandService = brandService;
        this.userService = userService;
    }
    
    // Check if user is admin
    private boolean isAdmin(HttpSession session) {
        Users user = (Users) session.getAttribute("user");
        return user != null && "ADMIN".equals(user.getRole().getRole());
    }
    
    // Admin dashboard
    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        // Gather statistics for the dashboard
        Map<String, Integer> stats = new HashMap<>();
        stats.put("totalBlindBoxes", blindBoxService.getAllBlindBoxes().size());
        stats.put("totalBrands", brandService.getAllBrands().size());
        stats.put("activeBlindBoxes", (int) blindBoxService.getAllBlindBoxes().stream().filter(b -> b.isActive()).count());
        stats.put("activeBrands", (int) brandService.getAllBrands().stream().filter(b -> b.isActive()).count());
        
        model.addAttribute("stats", stats);
        
        return "admin/dashboard";
    }
} 