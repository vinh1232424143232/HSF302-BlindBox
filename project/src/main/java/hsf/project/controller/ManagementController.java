package hsf.project.controller;

import hsf.project.pojo.Blindbox;
import hsf.project.pojo.Brand;
import hsf.project.pojo.Roles;
import hsf.project.pojo.Users;
import hsf.project.service.BlindboxService;
import hsf.project.service.BrandService;
import hsf.project.service.RoleService;
import hsf.project.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequestMapping("/management")
public class ManagementController {
    UserService userService;
    RoleService roleService;
    BlindboxService blindboxService;
    BrandService brandService;
    //=======================================================================================================
    //Mapping
    @GetMapping
    public String management(HttpSession session, Model model) {
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        } else {
            if (!user.getRole().getRole().equals("ADMIN")) {
                return "redirect:/login";
            }
        }
        session.setAttribute("user", user);
        List<Blindbox> blindboxList = blindboxService.getAllBlindBoxes();
        List<Brand> brandList = brandService.getAllBrands();
        int totalBrand = brandService.countTotalBrands();
        int totalActiveBrand = brandService.countActiveBrands();
        int totalBlindbox = blindboxService.countTotalBlindBoxes();
        int totalActiveBlindbox = blindboxService.countActiveBlindBoxes();
        model.addAttribute("totalBrand", totalBrand);
        model.addAttribute("totalActiveBrand", totalActiveBrand);
        model.addAttribute("totalBlindbox", totalBlindbox);
        model.addAttribute("totalActiveBlindbox", totalActiveBlindbox);
        model.addAttribute("products", blindboxList);
        model.addAttribute("brands", brandList);
        return "management";
    }

    @GetMapping("/user")
    public String userManagement(HttpSession session, Model model) {
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        } else {
            if (!user.getRole().getRole().equals("ADMIN")) {
                return "redirect:/login";
            }
        }
        session.setAttribute("user", user);
        List<Users> listUser = userService.getAllUsers();
        List<Roles> listRole = roleService.getAllRoles();
        model.addAttribute("users", listUser);
        model.addAttribute("roles", listRole);
        return "userManagement";
    }

    @GetMapping("/order")
    public String orderManagement(HttpSession session) {
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        } else {
            if (!user.getRole().getRole().equals("ADMIN")) {
                return "redirect:/login";
            }
        }
        return "orderManagement";
    }
    //=======================================================================================================
    //Brand
    @PostMapping("/brand/create")
    public String createBrand(String name, String description, MultipartFile image) {
        brandService.createBrand(name, description, image);
        return "redirect:/management";
    }

    @PostMapping("/brand/update")
    public String updateBrand(int id, String name, String description, boolean status, MultipartFile image, RedirectAttributes redirectAttributes) {
        if (image.isEmpty()) {
            brandService.updateBrand(id, name, description, status, null);
        } else {
            brandService.updateBrand(id, name, description, status, image);
            redirectAttributes.addFlashAttribute("refreshCache", true);
        }
        return "redirect:/management";
    }

    @PostMapping("/brand/delete")
    public String deleteBrand(int id) {
        brandService.deleteBrand(id);
        return "redirect:/management";
    }


    //=======================================================================================================
    //Product
    @PostMapping("/product/create")
    public String createProduct(String name, int price, int stock, int brandId, MultipartFile image) {
        blindboxService.createBlindBox(name, price, stock, brandId, image);
        return "redirect:/management";
    }

    @PostMapping("/product/update")
    public String updateProduct(int id, String name, int price, int stock, int brandId, boolean status, MultipartFile image, RedirectAttributes redirectAttributes) {
        if (image.isEmpty()) {
            blindboxService.updateBlindBox(id, name, price, stock, status, brandId, null);
        } else {
            blindboxService.updateBlindBox(id, name, price, stock, status, brandId, image);
            redirectAttributes.addFlashAttribute("refreshCache", true);
        }

        return "redirect:/management";
    }

    @PostMapping("/product/delete")
    public String deleteProduct(int id) {
        blindboxService.deleteBlindBox(id);
        return "redirect:/management";
    }

    //=======================================================================================================
    //Order

    //=======================================================================================================
    //User
    @PostMapping("/user/create")
    public String createUser(String email, String fullName, String phone, String password, int roleId) {
        Users user = Users.builder()
                .fullName(fullName)
                .email(email)
                .phone(phone)
                .password(password)
                .role(roleService.getRolesById(roleId))
                .active(true)
                .build();
        userService.create(user);
        return "redirect:/management/user";
    }

    @PostMapping("/user/update")
    public String updateUser(String email, String fullName, String phone, int roleId, boolean status, RedirectAttributes redirectAttributes) {
        userService.adminUpdate(email, fullName, phone, roleId, status);
        redirectAttributes.addFlashAttribute("refreshCache", true);
        return "redirect:/management/user";
    }

    @PostMapping("/user/delete")
    public String deleteUser(int id) {
        userService.deleteById(id);
        return "redirect:/management/user";
    }


}
