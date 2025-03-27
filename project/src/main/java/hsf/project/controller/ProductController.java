package hsf.project.controller;

import hsf.project.pojo.Blindbox;
import hsf.project.pojo.Brand;
import hsf.project.service.BlindboxService;
import hsf.project.service.BrandService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequestMapping("/product")
public class ProductController {
    BlindboxService blindboxService;
    BrandService brandService;

    @GetMapping()
    public String product(Model model) {
        List<Blindbox> blindboxList = blindboxService.getActiveBlindBoxes();
        List<Brand> brandList = brandService.getAllActiveBrands();
        model.addAttribute("brandList", brandList);
        model.addAttribute("blindboxList", blindboxList);
        return "product";
    }

    @GetMapping("/search")
    public String search(@RequestParam String searchProduct, Model model) {
        List<Blindbox> blindboxList = blindboxService.getAllBySearch(searchProduct);
        if (blindboxList.isEmpty()) {
            List<Brand> brandList = brandService.getAllActiveBrands();
            model.addAttribute("error","Product not found");
            model.addAttribute("brandList", brandList);
            model.addAttribute("blindboxList", blindboxList);
            return "product";
        }
        List<Brand> brandList = brandService.getAllActiveBrands();
        model.addAttribute("brandList", brandList);
        model.addAttribute("blindboxList", blindboxList);
        return "product";
    }

    @GetMapping("/ascending")
    public String ascending(Model model) {
        List<Blindbox> blindboxList = blindboxService.ascendListBlindbox();
        List<Brand> brandList = brandService.getAllActiveBrands();
        model.addAttribute("brandList", brandList);
        model.addAttribute("blindboxList", blindboxList);
        return "product";
    }

    @GetMapping("/brand")
    public String brand(Model model, @RequestParam int id) {
        List<Blindbox> blindboxList = blindboxService.getBlindBoxesByBrand(id);
        List<Brand> brandList = brandService.getAllActiveBrands();
        model.addAttribute("brandList", brandList);
        model.addAttribute("blindboxList", blindboxList);
        return "product";
    }

    @GetMapping("/price")
    public String price(Model model, @RequestParam int low, @RequestParam int high) {
        List<Blindbox> blindboxList = blindboxService.findBlindboxByPriceBetween(low, high);
        if (blindboxList.isEmpty()) {
            List<Brand> brandList = brandService.getAllActiveBrands();
            model.addAttribute("error","Product not found");
            model.addAttribute("brandList", brandList);
            model.addAttribute("blindboxList", blindboxList);
            return "product";
        }
        List<Brand> brandList = brandService.getAllActiveBrands();
        model.addAttribute("brandList", brandList);
        model.addAttribute("blindboxList", blindboxList);
        return "product";
    }

    @GetMapping("/descending")
    public String descending(Model model) {
        List<Blindbox> blindboxList = blindboxService.descendListBlindbox();
        List<Brand> brandList = brandService.getAllActiveBrands();
        model.addAttribute("brandList", brandList);
        model.addAttribute("blindboxList", blindboxList);
        return "product";
    }

    @GetMapping("/productDetail/{id}")
    public String productDetail(Model model, @PathVariable int id) {
        Blindbox blindbox = blindboxService.getBlindBoxById(id);
        if (blindbox == null) {
            return "error";
        }
        List<Blindbox> relatedProducts = blindboxService.getBlindBoxesByBrand(blindbox.getBrand().getId());
        relatedProducts.removeIf(p -> p.getId() == blindbox.getId());
        model.addAttribute("blindbox", blindbox);
        model.addAttribute("relatedProducts", relatedProducts);
        return "productDetail";
    }


}
