package hsf.project.controller;

import hsf.project.pojo.Blindbox;
import hsf.project.service.BlindboxService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequestMapping("/product")
public class ProductController {
    BlindboxService blindboxService;

    @GetMapping()
    public String product(Model model) {
        List<Blindbox> blindboxList = blindboxService.getActiveBlindBoxes();
        model.addAttribute("blindboxList", blindboxList);
        return "product";
    }

    @GetMapping("/productDetail/{id}")
    public String productDetail(Model model, @PathVariable int id) {
        Blindbox blindbox = blindboxService.getBlindBoxById(id);
        if (blindbox == null) {
            return "error";
        }
        
        // Lấy các sản phẩm cùng thương hiệu
        List<Blindbox> relatedProducts = blindboxService.getBlindBoxesByBrand(blindbox.getBrand().getId());
        // Loại bỏ sản phẩm hiện tại khỏi danh sách liên quan
        relatedProducts.removeIf(p -> p.getId() == blindbox.getId());
        
        model.addAttribute("blindbox", blindbox);
        model.addAttribute("relatedProducts", relatedProducts);
        return "productDetail";
    }
}
