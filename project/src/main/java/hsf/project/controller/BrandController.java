package hsf.project.controller;

import hsf.project.pojo.Brand;
import hsf.project.pojo.Users;
import hsf.project.service.BrandService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/brand")
public class BrandController {

    private final BrandService brandService;

    @Autowired
    public BrandController(BrandService brandService) {
        this.brandService = brandService;
    }
    
    // Check if user is admin
    private boolean isAdmin(HttpSession session) {
        Users user = (Users) session.getAttribute("user");
        return user != null && "ADMIN".equals(user.getRole().getRole());
    }
    
    // List all brands
    @GetMapping("/manage")
    public String manageBrands(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        List<Brand> brands = brandService.getAllBrands();
        
        model.addAttribute("brands", brands);
        model.addAttribute("newBrand", new Brand());
        
        return "admin/brand/manage";
    }
    
    // Create new brand
    @PostMapping("/create")
    public String createBrand(
            @ModelAttribute Brand brand,
            @RequestParam(value = "logo", required = false) MultipartFile logo,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        Brand createdBrand = brandService.createBrand(brand, logo);
        
        if (createdBrand != null) {
            redirectAttributes.addFlashAttribute("success", "Brand created successfully.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to create brand.");
        }
        
        return "redirect:/admin/brand/manage";
    }
    
    // Show edit form
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable int id, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        Brand brand = brandService.getBrandById(id);
        if (brand == null) {
            redirectAttributes.addFlashAttribute("error", "Brand not found.");
            return "redirect:/admin/brand/manage";
        }
        
        model.addAttribute("brand", brand);
        
        return "admin/brand/edit";
    }
    
    // Update brand
    @PostMapping("/update/{id}")
    public String updateBrand(
            @PathVariable int id,
            @ModelAttribute Brand brand,
            @RequestParam(value = "logo", required = false) MultipartFile logo,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        Brand updatedBrand = brandService.updateBrand(id, brand, logo);
        
        if (updatedBrand != null) {
            redirectAttributes.addFlashAttribute("success", "Brand updated successfully.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to update brand.");
        }
        
        return "redirect:/admin/brand/manage";
    }
    
    // Delete brand
    @PostMapping("/delete/{id}")
    public String deleteBrand(@PathVariable int id, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        boolean deleted = brandService.deleteBrand(id);
        
        if (deleted) {
            redirectAttributes.addFlashAttribute("success", "Brand deleted successfully.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to delete brand.");
        }
        
        return "redirect:/admin/brand/manage";
    }
    
    // Toggle brand status
    @PostMapping("/toggle/{id}")
    public String toggleBrandStatus(@PathVariable int id, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        boolean toggled = brandService.toggleBrandStatus(id);
        
        if (toggled) {
            redirectAttributes.addFlashAttribute("success", "Brand status updated successfully.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to update brand status.");
        }
        
        return "redirect:/admin/brand/manage";
    }
}
