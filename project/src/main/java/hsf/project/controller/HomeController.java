package hsf.project.controller;

import hsf.project.pojo.Brand;
import hsf.project.service.BrandService;
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
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequestMapping("/home")
public class HomeController {
    BrandService brandService;

    @GetMapping()
    public String homePage(Model model, HttpSession session) {
        List<Brand> brandList = brandService.getAllActiveBrands();
        if (brandList.size() > 3) {
            brandList = brandList.subList(0, 3);
        }
        model.addAttribute("brandList", brandList);
        return "home";
    }

    @GetMapping("/error")
    public String errorPage(Model model, HttpSession session) {
        return "error";
    }
}
