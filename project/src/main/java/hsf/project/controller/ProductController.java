package hsf.project.controller;

import hsf.project.pojo.Blindbox;
import hsf.project.pojo.Brand;
import hsf.project.pojo.BlindBoxImage;
import hsf.project.service.BlindBoxService;
import hsf.project.service.BrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/product")
public class ProductController {
    
    private final BlindBoxService blindBoxService;
    private final BrandService brandService;
    
    @Autowired
    public ProductController(BlindBoxService blindBoxService, BrandService brandService) {
        this.blindBoxService = blindBoxService;
        this.brandService = brandService;
    }
    
    @GetMapping()
    public String product(Model model) {
        // Get all active blind boxes
        List<Blindbox> blindboxes = blindBoxService.getAllBlindBoxes();
        
        // Get all brands
        List<Brand> brands = brandService.getAllBrands();
        
        // Set primary image path and all images for each blind box
        if (blindboxes != null && !blindboxes.isEmpty()) {
            for (Blindbox box : blindboxes) {
                // Set primary image path
                String primaryImagePath = blindBoxService.getPrimaryImagePath(box.getId());
                box.setPrimaryImagePath(primaryImagePath);
                
                // Get all images for the blind box for the slider
                List<BlindBoxImage> images = blindBoxService.getBlindBoxImages(box.getId());
                box.setImages(images);
            }
        }
        
        // Add data to the model
        model.addAttribute("blindboxes", blindboxes);
        model.addAttribute("brands", brands);
        
        return "product";
    }
}
