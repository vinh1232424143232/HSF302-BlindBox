package hsf.project.service;

import hsf.project.pojo.Brand;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface BrandService {
    List<Brand> getAllBrands();

    Brand getBrandById(int id);

    Brand createBrand(String name, String description, MultipartFile logo);

    Brand updateBrand(int id, String name, String description, boolean status, MultipartFile logo);

    boolean deleteBrand(int id);

    int countTotalBrands();

    int countActiveBrands();
}
