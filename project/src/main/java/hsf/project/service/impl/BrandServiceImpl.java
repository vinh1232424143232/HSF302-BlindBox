package hsf.project.service.impl;

import hsf.project.pojo.Brand;
import hsf.project.repository.BrandRepository;
import hsf.project.service.BrandService;
import jakarta.servlet.ServletContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class BrandServiceImpl implements BrandService {

    @Value("${upload.path:/uploads}")
    private String uploadPath;
    
    private static final String IMAGES_DIR = "images";
    
    private final BrandRepository brandRepository;
    private final ServletContext servletContext;
    
    @Autowired
    public BrandServiceImpl(BrandRepository brandRepository, ServletContext servletContext) {
        this.brandRepository = brandRepository;
        this.servletContext = servletContext;
    }
    
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
    public Brand createBrand(Brand brand, MultipartFile logo) {
        if (logo != null && !logo.isEmpty()) {
            String logoPath = saveLogoFile(logo);
            if (logoPath != null) {
                brand.setLogoPath(logoPath);
            }
        }
        
        return brandRepository.save(brand);
    }
    
    @Override
    @Transactional
    public Brand updateBrand(int id, Brand brand, MultipartFile logo) {
        Optional<Brand> existingBrand = brandRepository.findById(id);
        
        if (existingBrand.isPresent()) {
            Brand brandToUpdate = existingBrand.get();
            
            // Update fields
            brandToUpdate.setName(brand.getName());
            brandToUpdate.setDescription(brand.getDescription());
            brandToUpdate.setActive(brand.isActive());
            
            // Handle logo update if provided
            if (logo != null && !logo.isEmpty()) {
                // Log the file details
                System.out.println("Processing logo update: " + logo.getOriginalFilename() + 
                                  " (Size: " + logo.getSize() + " bytes)");
                
                try {
                    // Delete old logo if exists
                    if (brandToUpdate.getLogoPath() != null) {
                        deleteLogoFile(brandToUpdate.getLogoPath());
                    }
                    
                    // Save new logo
                    String logoPath = saveLogoFile(logo);
                    if (logoPath != null) {
                        brandToUpdate.setLogoPath(logoPath);
                    }
                } catch (Exception e) {
                    System.err.println("Error updating logo: " + e.getMessage());
                    e.printStackTrace();
                    // Continue with the update even if logo update fails
                }
            } else {
                System.out.println("No new logo provided, keeping existing logo");
            }
            
            return brandRepository.save(brandToUpdate);
        }
        
        return null;
    }
    
    @Override
    @Transactional
    public boolean deleteBrand(int id) {
        Optional<Brand> brand = brandRepository.findById(id);
        
        if (brand.isPresent()) {
            Brand brandToDelete = brand.get();
            
            // Delete logo file if exists
            if (brandToDelete.getLogoPath() != null) {
                deleteLogoFile(brandToDelete.getLogoPath());
            }
            
            brandRepository.delete(brandToDelete);
            return true;
        }
        
        return false;
    }
    
    @Override
    @Transactional
    public boolean toggleBrandStatus(int id) {
        Optional<Brand> brand = brandRepository.findById(id);
        
        if (brand.isPresent()) {
            Brand brandToUpdate = brand.get();
            brandToUpdate.setActive(!brandToUpdate.isActive());
            brandRepository.save(brandToUpdate);
            return true;
        }
        
        return false;
    }
    
    @Override
    public String getLogoUrl(String logoPath) {
        if (logoPath == null || logoPath.isEmpty()) {
            return "/images/default-brand.png"; // Default image path
        }
        
        return "/images/" + logoPath;
    }
    
    // Helper method to save logo file
    private String saveLogoFile(MultipartFile logo) {
        // Check if logo is null or empty
        if (logo == null || logo.isEmpty()) {
            System.out.println("Logo file is null or empty");
            return null;
        }
        
        try {
            // Generate unique filename
            String uniqueFilename = UUID.randomUUID().toString() + "_" + logo.getOriginalFilename();
            
            // Save to webapp/images directory
            String realPathToImages = servletContext.getRealPath("/" + IMAGES_DIR);
            File imagesDir = new File(realPathToImages);
            
            // Create images directory if it doesn't exist
            if (!imagesDir.exists()) {
                imagesDir.mkdirs();
            }
            
            File destFile = new File(imagesDir, uniqueFilename);
            logo.transferTo(destFile);
            
            // Also save to the configured upload path for backup (if different from webapp/images)
            Path uploadDir = Paths.get(uploadPath);
            if (!Files.exists(uploadDir)) {
                Files.createDirectories(uploadDir);
            }
            
            // Copy from the first saved file instead of using the input stream again
            Path uploadFilePath = uploadDir.resolve(uniqueFilename);
            Files.copy(destFile.toPath(), uploadFilePath, StandardCopyOption.REPLACE_EXISTING);
            
            System.out.println("Logo saved to webapp: " + destFile.getAbsolutePath());
            System.out.println("Logo saved to upload path: " + uploadFilePath.toAbsolutePath());
            
            return uniqueFilename;
            
        } catch (IOException e) {
            System.err.println("Error saving logo file: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    // Helper method to delete logo file
    private void deleteLogoFile(String logoPath) {
        try {
            // Delete from webapp/images
            String realPathToImages = servletContext.getRealPath("/" + IMAGES_DIR);
            File imageFile = new File(realPathToImages, logoPath);
            if (imageFile.exists()) {
                imageFile.delete();
            }
            
            // Also delete from the configured upload path
            Path filePath = Paths.get(uploadPath).resolve(logoPath);
            Files.deleteIfExists(filePath);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
} 