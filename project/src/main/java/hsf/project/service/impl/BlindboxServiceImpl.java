package hsf.project.service.impl;

import hsf.project.pojo.Blindbox;
import hsf.project.pojo.Brand;
import hsf.project.repository.BlindboxRepository;
import hsf.project.repository.BrandRepository;
import hsf.project.service.BlindboxService;
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
public class BlindboxServiceImpl implements BlindboxService {

    BlindboxRepository blindboxRepository;
    BrandRepository brandRepository;
    SupabaseService supabaseService;

    @Override
    public List<Blindbox> getAllBlindBoxes() {
        return blindboxRepository.findAll();
    }

    @Override
    public List<Blindbox> getBlindBoxesByBrand(int brandId) {
        return blindboxRepository.findByBrandId(brandId);
    }

    @Override
    public List<Blindbox> getActiveBlindBoxes() {
        return blindboxRepository.findByActiveTrue();
    }

    @Override
    public Blindbox getBlindBoxById(int id) {
        return blindboxRepository.findById(id).orElse(null);
    }

    @Override
    @Transactional
    public Blindbox createBlindBox(String name, int price, int stock, int brandId, MultipartFile image) {
        try {
            Blindbox blindbox = Blindbox.builder()
                    .name(name)
                    .price(price)
                    .stock(stock)
                    .active(true)
                    .build();
            Brand brand = brandRepository.findById(brandId).orElse(null);
            if (brand != null) {
                blindbox.setBrand(brand);
            }
            blindboxRepository.save(blindbox);
            if (image != null) {
                supabaseService.upload(image,"Blindbox_"+blindbox.getId());
                String url = supabaseService.getImage("Blindbox_"+blindbox.getId());
                blindbox.setUrl(url);
            }
            blindboxRepository.save(blindbox);
        } catch (IOException e) {
            System.err.println("Failed to save image: " + e.getMessage());
        }
        return null;
    }

    @Override
    @Transactional
    public Blindbox updateBlindBox(int id, String name, int price, int stock, boolean status, int brandId, MultipartFile image) {
        //Update name, price, stock, status, brandId
        try {
            Blindbox blindbox = blindboxRepository.findById(id).orElse(null);
            Brand brand = brandRepository.findById(brandId).orElse(null);
            if (blindbox != null) {
                blindbox.setName(name);
                blindbox.setPrice(price);
                blindbox.setStock(stock);
                blindbox.setActive(status);
                if (brand != null) {
                    blindbox.setBrand(brand);
                }
                if (image != null) {
                    supabaseService.delete("Blindbox_"+id);
                    supabaseService.upload(image,"Blindbox_"+id);
                    String url = supabaseService.getImage("Blindbox_"+id);
                    blindbox.setUrl(url);
                }
                blindboxRepository.save(blindbox);
            }
        } catch (IOException e) {
            System.err.println("Failed to update: " + e.getMessage());
        }

        return null;
    }

    @Override
    @Transactional
    public boolean deleteBlindBox(int id) {
        try {
            Blindbox blindbox = blindboxRepository.findById(id).orElse(null);
            if (blindbox != null) {
                supabaseService.delete("Blindbox_"+id);
                blindboxRepository.delete(blindbox);
            }
        } catch (IOException e) {
            System.err.println("Failed to delete: " + e.getMessage());
        }
        return false;
    }

    @Override
    public int countTotalBlindBoxes() {
        return blindboxRepository.findAll().size();
    }

    @Override
    public int countActiveBlindBoxes() {
        return blindboxRepository.findByActiveTrue().size();
    }
}
