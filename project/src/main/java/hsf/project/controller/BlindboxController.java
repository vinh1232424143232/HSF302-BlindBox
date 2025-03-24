package hsf.project.controller;

import hsf.project.pojo.*;
import hsf.project.service.BlindBoxService;
import hsf.project.service.BrandService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/admin/blindbox")
public class BlindboxController {

    private final BlindBoxService blindBoxService;
    private final BrandService brandService;

    @Autowired
    public BlindboxController(BlindBoxService blindBoxService, BrandService brandService) {
        this.blindBoxService = blindBoxService;
        this.brandService = brandService;
    }
    
    // Check if user is admin
    private boolean isAdmin(HttpSession session) {
        Users user = (Users) session.getAttribute("user");
        return user != null && "ADMIN".equals(user.getRole().getRole());
    }

    // Helper method to populate primary image paths
    private void populatePrimaryImagePaths(List<Blindbox> blindboxes) {
        for (Blindbox blindbox : blindboxes) {
            String primaryImagePath = blindBoxService.getPrimaryImagePath(blindbox.getId());
            blindbox.setPrimaryImagePath(primaryImagePath);
        }
    }
    
    // Manage blind boxes
    @GetMapping("/manage")
    public String manageBlindBoxes(
            @RequestParam(required = false) Integer brandId,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String search,
            Model model, 
            HttpSession session, 
            RedirectAttributes redirectAttributes) {
        
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        List<Blindbox> blindboxes = blindBoxService.getAllBlindBoxes();
        List<Brand> brands = brandService.getAllBrands();
        
        // Apply filters
        if (blindboxes != null && !blindboxes.isEmpty()) {
            // Filter by brand if brandId is provided
            if (brandId != null && brandId > 0) {
                blindboxes = blindboxes.stream()
                    .filter(b -> b.getBrand() != null && b.getBrand().getId() == brandId)
                    .collect(java.util.stream.Collectors.toList());
            }
            
            // Filter by status if provided
            if (status != null && !status.isEmpty()) {
                boolean isActive = "true".equals(status);
                blindboxes = blindboxes.stream()
                    .filter(b -> b.isActive() == isActive)
                    .collect(java.util.stream.Collectors.toList());
            }
            
            // Filter by search term if provided
            if (search != null && !search.trim().isEmpty()) {
                String searchLower = search.toLowerCase();
                blindboxes = blindboxes.stream()
                    .filter(b -> 
                        (b.getName() != null && b.getName().toLowerCase().contains(searchLower)) || 
                        (b.getDescription() != null && b.getDescription().toLowerCase().contains(searchLower)) ||
                        (b.getBrand() != null && b.getBrand().getName() != null && 
                         b.getBrand().getName().toLowerCase().contains(searchLower))
                    )
                    .collect(java.util.stream.Collectors.toList());
            }
        }
        
        // Set primary image path for each blind box
        populatePrimaryImagePaths(blindboxes);
        
        model.addAttribute("blindboxes", blindboxes);
        model.addAttribute("brands", brands);
        model.addAttribute("newBlindbox", new Blindbox());
        model.addAttribute("selectedBrandId", brandId);
        model.addAttribute("selectedStatus", status);
        model.addAttribute("searchTerm", search);
        
        return "admin/blindbox/manage";
    }
    
    // Show create form
    @GetMapping("/create")
    public String showCreateForm(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        List<Brand> brands = brandService.getAllBrands();
        
        model.addAttribute("blindbox", new Blindbox());
        model.addAttribute("brands", brands);
        model.addAttribute("isNewBlindbox", true);
        
        return "admin/blindbox/form";
    }
    
    // Create new blind box
    @PostMapping("/create")
    public String createBlindBox(
            @ModelAttribute Blindbox blindbox,
            @RequestParam("brandId") int brandId,
            @RequestParam(value = "imageFiles", required = false) MultipartFile[] imageFiles,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        // Set the brand
        Brand brand = brandService.getBrandById(brandId);
        if (brand == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Invalid brand selected.");
            return "redirect:/admin/blindbox/manage";
        }
        
        blindbox.setBrand(brand);
        
        // Convert array to list (handle null images)
        List<MultipartFile> imagesList = new ArrayList<>();
        if (imageFiles != null && imageFiles.length > 0) {
            imagesList = new ArrayList<>(Arrays.asList(imageFiles));
        }
        
        // Create the blind box
        Blindbox createdBox = blindBoxService.createBlindBox(blindbox, imagesList);
        
        if (createdBox != null) {
            redirectAttributes.addFlashAttribute("successMessage", "Blind box created successfully.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to create blind box.");
        }
        
        return "redirect:/admin/blindbox/manage";
    }
    
    // Show edit form
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable int id, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        Blindbox blindbox = blindBoxService.getBlindBoxById(id);
        if (blindbox == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Blind box not found.");
            return "redirect:/admin/blindbox/manage";
        }
        
        // Set primary image path
        String primaryImagePath = blindBoxService.getPrimaryImagePath(blindbox.getId());
        blindbox.setPrimaryImagePath(primaryImagePath);
        
        List<Brand> brands = brandService.getAllBrands();
        
        model.addAttribute("blindbox", blindbox);
        model.addAttribute("brands", brands);
        model.addAttribute("isNewBlindbox", false);
        
        return "admin/blindbox/form";
    }
    
    // Update blind box
    @PostMapping("/update/{id}")
    public String updateBlindBox(
            @PathVariable int id,
            @ModelAttribute Blindbox blindbox,
            @RequestParam("brandId") int brandId,
            @RequestParam(value = "imageFiles", required = false) MultipartFile[] imageFiles,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        // Set the brand
        Brand brand = brandService.getBrandById(brandId);
        if (brand == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Invalid brand selected.");
            return "redirect:/admin/blindbox/edit/" + id;
        }
        
        blindbox.setBrand(brand);
        
        // Update the blind box (without images for now)
        Blindbox updatedBox = blindBoxService.updateBlindBox(id, blindbox);
        
        // Handle images separately if provided
        if (imageFiles != null && imageFiles.length > 0) {
            for (MultipartFile image : imageFiles) {
                if (!image.isEmpty()) {
                    blindBoxService.addImageToBlindBox(id, image, false);
                }
            }
        }
        
        if (updatedBox != null) {
            redirectAttributes.addFlashAttribute("successMessage", "Blind box updated successfully.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update blind box.");
        }
        
        return "redirect:/admin/blindbox/manage";
    }
    
    // Delete blind box
    @PostMapping("/delete/{id}")
    public String deleteBlindBox(@PathVariable int id, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        boolean deleted = blindBoxService.deleteBlindBox(id);
        
        if (deleted) {
            redirectAttributes.addFlashAttribute("successMessage", "Blind box deleted successfully.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to delete blind box.");
        }
        
        return "redirect:/admin/blindbox/manage";
    }
    
    // Toggle blind box status
    @PostMapping("/toggle/{id}")
    public String toggleBlindBoxStatus(@PathVariable int id, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        boolean toggled = blindBoxService.toggleBlindBoxStatus(id);
        
        if (toggled) {
            redirectAttributes.addFlashAttribute("successMessage", "Blind box status updated successfully.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update blind box status.");
        }
        
        return "redirect:/admin/blindbox/manage";
    }
    
    // Manage images for a blind box
    @GetMapping("/images/{id}")
    public String manageImages(@PathVariable int id, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        Blindbox blindbox = blindBoxService.getBlindBoxById(id);
        if (blindbox == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Blind box not found.");
            return "redirect:/admin/blindbox/manage";
        }
        
        // Get the images for this blind box
        List<BlindBoxImage> images = blindBoxService.getBlindBoxImages(id);
        
        model.addAttribute("blindbox", blindbox);
        model.addAttribute("images", images);
        
        return "admin/blindbox/images";
    }
    
    // Add image to blind box
    @PostMapping("/images/add/{id}")
    public String addImageToBlindBox(
            @PathVariable int id,
            @RequestParam("image") MultipartFile image,
            @RequestParam(value = "setPrimary", required = false, defaultValue = "false") boolean setPrimary,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        BlindBoxImage addedImage = blindBoxService.addImageToBlindBox(id, image, setPrimary);
        
        if (addedImage != null) {
            redirectAttributes.addFlashAttribute("successMessage", "Image added successfully.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to add image.");
        }
        
        return "redirect:/admin/blindbox/images/" + id;
    }
    
    // Delete image
    @PostMapping("/images/delete/{id}")
    public String deleteImage(
            @PathVariable int id,
            @RequestParam("blindboxId") int blindboxId,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        boolean deleted = blindBoxService.deleteImage(blindboxId, id);
        
        if (deleted) {
            redirectAttributes.addFlashAttribute("successMessage", "Image deleted successfully.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to delete image.");
        }
        
        return "redirect:/admin/blindbox/images/" + blindboxId;
    }
    
    // Set primary image
    @PostMapping("/images/primary/{id}")
    public String setPrimaryImage(
            @PathVariable int id,
            @RequestParam("blindboxId") int blindboxId,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        boolean set = blindBoxService.setPrimaryImage(blindboxId, id);
        
        if (set) {
            redirectAttributes.addFlashAttribute("successMessage", "Primary image set successfully.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to set primary image.");
        }
        
        return "redirect:/admin/blindbox/images/" + blindboxId;
    }
    
    // GET method for setting primary image (redirects to POST)
    @GetMapping("/images/primary/{id}")
    public String setPrimaryImageGet(
            @PathVariable int id,
            @RequestParam("imageId") int imageId,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        redirectAttributes.addFlashAttribute("warningMessage", "Please use the proper form submission to set the primary image.");
        return "redirect:/admin/blindbox/images/" + id;
    }
    
    // GET method for deleting an image (redirects to POST)
    @GetMapping("/images/delete/{id}")
    public String deleteImageGet(
            @PathVariable int id,
            @RequestParam("imageId") int imageId,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        redirectAttributes.addFlashAttribute("warningMessage", "Please use the proper form submission to delete an image.");
        return "redirect:/admin/blindbox/images/" + id;
    }
    
    // GET method for delete (redirects to POST)
    @GetMapping("/delete/{id}")
    public String deleteBlindBoxGet(@PathVariable int id, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        redirectAttributes.addFlashAttribute("warningMessage", "Please use the proper form submission to delete a blind box.");
        return "redirect:/admin/blindbox/manage";
    }
    
    // GET method for toggle (redirects to POST)
    @GetMapping("/toggle/{id}")
    public String toggleBlindBoxStatusGet(@PathVariable int id, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Admin role required.");
            return "redirect:/login";
        }
        
        redirectAttributes.addFlashAttribute("warningMessage", "Please use the proper form submission to toggle a blind box status.");
        return "redirect:/admin/blindbox/manage";
    }
} 