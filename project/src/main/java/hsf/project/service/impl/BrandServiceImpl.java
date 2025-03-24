package hsf.project.service.impl;

import hsf.project.pojo.Blindbox;
import hsf.project.pojo.Brand;
import hsf.project.repository.BlindboxRepository;
import hsf.project.repository.BrandRepository;
import hsf.project.service.BrandService;
import hsf.project.service.SupabaseService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class BrandServiceImpl implements BrandService {
    BrandRepository brandRepository;
    BlindboxRepository blindboxRepository;
    SupabaseService supabaseService;

    @Override
    public List<Brand> getAllBrands() {
        return brandRepository.findAll();
    }

    @Override
    public Brand getBrandById(int id) {
        return brandRepository.findById(id).orElse(null);
    }

    @Override
    @Transactional
    public Brand createBrand(String name, String description, MultipartFile logo) {
        try {
            Brand brand = Brand.builder()
                    .name(name)
                    .description(description)
                    .active(true)
                    .build();
            brandRepository.save(brand);
            if (logo != null) {
                supabaseService.upload(logo, "Brand_" + brand.getId());
                String url = supabaseService.getImage("Brand_" + brand.getId());
                brand.setUrl(url);
            }
            brandRepository.save(brand);
        } catch (IOException e) {
            System.err.println("Failed to save image: " + e.getMessage());
        }
        return null;
    }

    @Override
    @Transactional
    public Brand updateBrand(int id, String name, String description, boolean status, MultipartFile logo) {
        try {
            Brand brand = brandRepository.findById(id).orElse(null);
            if (brand != null) {
                brand.setName(name);
                brand.setDescription(description);
                brand.setActive(status);
                if (!brand.isActive()) {
                    List<Blindbox> blindboxList = brand.getBlindboxList();
                    for (Blindbox blindbox : blindboxList) {
                        blindbox.setActive(false);
                        blindboxRepository.save(blindbox);
                    }
                }
                if (logo != null) {
                    supabaseService.delete("Brand_" + id);
                    supabaseService.upload(logo, "Brand_" + id);
                    String url = supabaseService.getImage("Brand_" + id);
                    brand.setUrl(url);
                }
                brandRepository.save(brand);
            }
        } catch (IOException e) {
            System.err.println("Failed to update: " + e.getMessage());
        }
        return null;
    }

    @Override
    @Transactional
    public boolean deleteBrand(int id) {
        try {
            Brand brand = brandRepository.findById(id).orElse(null);
            if (brand != null) {
                supabaseService.delete("Brand_" + id);
                brandRepository.delete(brand);
            }
        } catch (IOException e) {
            System.err.println("Failed to delete: " + e.getMessage());
        }
        return false;
    }

    @Override
    public int countTotalBrands() {
        return brandRepository.findAll().size();
    }

    @Override
    public int countActiveBrands() {
        return brandRepository.findByActive(true).size();
    }
}
