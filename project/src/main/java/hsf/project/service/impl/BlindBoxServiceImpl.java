package hsf.project.service.impl;

import hsf.project.pojo.BlindBoxImage;
import hsf.project.pojo.Blindbox;
import hsf.project.pojo.Brand;
import hsf.project.repository.BlindBoxImageRepository;
import hsf.project.repository.BlindboxRepository;
import hsf.project.repository.BrandRepository;
import hsf.project.service.BlindBoxService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;
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
@Transactional
public class BlindBoxServiceImpl implements BlindBoxService {

    @Value("${upload.path:/uploads}")
    private String uploadPath;

    private final String UPLOAD_DIR = "uploads";
    private final ServletContext servletContext;
    private final BlindboxRepository blindboxRepository;
    private final BrandRepository brandRepository;
    private final BlindBoxImageRepository imageRepository;

    @Autowired
    public BlindBoxServiceImpl(BlindboxRepository blindboxRepository, 
                              BrandRepository brandRepository,
                              BlindBoxImageRepository imageRepository,
                              ServletContext servletContext) {
        this.blindboxRepository = blindboxRepository;
        this.brandRepository = brandRepository;
        this.imageRepository = imageRepository;
        this.servletContext = servletContext;
    }

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
    public Blindbox createBlindBox(Blindbox blindBox, List<MultipartFile> images) {
        // Save the blind box first
        Blindbox savedBlindBox = blindboxRepository.save(blindBox);
        
        // Process images if provided
        if (images != null && !images.isEmpty()) {
            boolean setFirstAsPrimary = true;
            for (MultipartFile image : images) {
                try {
                    String imagePath = saveImageFile(image);
                    BlindBoxImage blindBoxImage = BlindBoxImage.builder()
                            .blindbox(savedBlindBox)
                            .imagePath(imagePath)
                            .imageAlt(blindBox.getName() + " Image")
                            .primary(setFirstAsPrimary)
                            .build();
                    imageRepository.save(blindBoxImage);
                    setFirstAsPrimary = false;
                } catch (IOException e) {
                    // Log the error but continue processing
                    System.err.println("Failed to save image: " + e.getMessage());
                }
            }
        }
        
        return savedBlindBox;
    }

    @Override
    @Transactional
    public Blindbox updateBlindBox(int id, Blindbox blindBox) {
        Blindbox existingBlindBox = blindboxRepository.findById(id).orElse(null);
        if (existingBlindBox == null) {
            return null;
        }
        
        // Update fields
        existingBlindBox.setName(blindBox.getName());
        existingBlindBox.setDescription(blindBox.getDescription());
        existingBlindBox.setPrice(blindBox.getPrice());
        existingBlindBox.setQuantity(blindBox.getQuantity());
        existingBlindBox.setSize(blindBox.getSize());
        existingBlindBox.setMaterial(blindBox.getMaterial());
        existingBlindBox.setActive(blindBox.isActive());
        existingBlindBox.setStatus(blindBox.getStatus());
        
        // Update brand if specified
        if (blindBox.getBrand() != null) {
            Brand brand = brandRepository.findById(blindBox.getBrand().getId()).orElse(null);
            if (brand != null) {
                existingBlindBox.setBrand(brand);
            }
        }
        
        return blindboxRepository.save(existingBlindBox);
    }

    @Override
    @Transactional
    public boolean deleteBlindBox(int id) {
        if (!blindboxRepository.existsById(id)) {
            return false;
        }
        
        Blindbox blindBox = blindboxRepository.findById(id).get();
        
        // Delete associated images first
        List<BlindBoxImage> images = imageRepository.findByBlindboxOrderById(blindBox);
        for (BlindBoxImage image : images) {
            try {
                deleteImageFile(image.getImagePath());
            } catch (IOException e) {
                // Log the error but continue processing
                System.err.println("Failed to delete image file: " + e.getMessage());
            }
        }
        imageRepository.deleteByBlindbox(blindBox);
        
        // Delete the blind box
        blindboxRepository.deleteById(id);
        return true;
    }

    @Override
    @Transactional
    public boolean toggleBlindBoxStatus(int id) {
        Blindbox blindBox = blindboxRepository.findById(id).orElse(null);
        if (blindBox == null) {
            return false;
        }
        
        blindBox.setActive(!blindBox.isActive());
        blindboxRepository.save(blindBox);
        return true;
    }

    @Override
    public List<BlindBoxImage> getBlindBoxImages(int blindBoxId) {
        Blindbox blindBox = blindboxRepository.findById(blindBoxId).orElse(null);
        if (blindBox == null) {
            return List.of();
        }
        
        return imageRepository.findByBlindboxOrderById(blindBox);
    }

    @Override
    public String getPrimaryImagePath(int blindBoxId) {
        Blindbox blindBox = blindboxRepository.findById(blindBoxId).orElse(null);
        if (blindBox == null) {
            return null;
        }
        
        Optional<BlindBoxImage> primaryImage = imageRepository.findByBlindboxAndPrimaryTrue(blindBox);
        return primaryImage.map(BlindBoxImage::getImagePath).orElse(null);
    }

    @Override
    @Transactional
    public BlindBoxImage addImageToBlindBox(int blindBoxId, MultipartFile image, boolean setPrimary) {
        Blindbox blindBox = blindboxRepository.findById(blindBoxId).orElse(null);
        if (blindBox == null || image == null || image.isEmpty()) {
            return null;
        }
        
        try {
            String imagePath = saveImageFile(image);
            
            // If setting as primary, reset existing primary images
            if (setPrimary) {
                imageRepository.resetPrimaryImagesForBlindbox(blindBox);
            }
            
            BlindBoxImage blindBoxImage = BlindBoxImage.builder()
                    .blindbox(blindBox)
                    .imagePath(imagePath)
                    .imageAlt(blindBox.getName() + " Image")
                    .primary(setPrimary)
                    .build();
            
            return imageRepository.save(blindBoxImage);
        } catch (IOException e) {
            // Log the error
            System.err.println("Failed to save image: " + e.getMessage());
            return null;
        }
    }

    @Override
    @Transactional
    public boolean setPrimaryImage(int blindBoxId, int imageId) {
        Blindbox blindBox = blindboxRepository.findById(blindBoxId).orElse(null);
        BlindBoxImage image = imageRepository.findById(imageId).orElse(null);
        
        if (blindBox == null || image == null || image.getBlindbox().getId() != blindBox.getId()) {
            return false;
        }
        
        // Reset all primary flags for this blind box
        imageRepository.resetPrimaryImagesForBlindbox(blindBox);
        
        // Set the specified image as primary
        imageRepository.setPrimaryImage(imageId);
        
        return true;
    }

    @Override
    @Transactional
    public boolean deleteImage(int blindBoxId, int imageId) {
        Blindbox blindBox = blindboxRepository.findById(blindBoxId).orElse(null);
        BlindBoxImage image = imageRepository.findById(imageId).orElse(null);
        
        if (blindBox == null || image == null || image.getBlindbox().getId() != blindBox.getId()) {
            return false;
        }
        
        try {
            // Delete the physical file
            deleteImageFile(image.getImagePath());
            
            // Delete from database
            imageRepository.deleteById(imageId);
            
            // If this was the primary image, try to set a new one
            if (image.isPrimary()) {
                List<BlindBoxImage> remainingImages = imageRepository.findByBlindboxOrderById(blindBox);
                if (!remainingImages.isEmpty()) {
                    imageRepository.setPrimaryImage(remainingImages.get(0).getId());
                }
            }
            
            return true;
        } catch (IOException e) {
            // Log the error
            System.err.println("Failed to delete image file: " + e.getMessage());
            return false;
        }
    }
    
    // Helper methods for file operations
    
    private String saveImageFile(MultipartFile file) throws IOException {
        // Get the real path to the uploads directory within the webapp
        String realPathToUploads = servletContext.getRealPath("/" + UPLOAD_DIR);
        File uploadsDir = new File(realPathToUploads);
        
        // Create directory if it doesn't exist
        if (!uploadsDir.exists()) {
            uploadsDir.mkdirs();
        }
        
        // Generate a unique filename
        String filename = UUID.randomUUID() + "_" + file.getOriginalFilename();
        File destFile = new File(uploadsDir, filename);
        
        // Save the file
        file.transferTo(destFile);
        
        // Also save to the configured upload path for backup (if different from webapp/uploads)
        Path backupDir = Paths.get(uploadPath);
        if (!Files.exists(backupDir)) {
            Files.createDirectories(backupDir);
        }
        
        Path backupFilePath = backupDir.resolve(filename);
        Files.copy(destFile.toPath(), backupFilePath, StandardCopyOption.REPLACE_EXISTING);
        
        System.out.println("BlindBox image saved to webapp: " + destFile.getAbsolutePath());
        System.out.println("BlindBox image saved to backup path: " + backupFilePath.toAbsolutePath());
        
        // Return only the filename, not the full path
        return filename;
    }
    
    private void deleteImageFile(String filename) throws IOException {
        if (filename != null && !filename.isBlank()) {
            // Delete from webapp/uploads
            String realPathToUploads = servletContext.getRealPath("/" + UPLOAD_DIR);
            File imageFile = new File(realPathToUploads, filename);
            
            if (imageFile.exists()) {
                imageFile.delete();
            }
            
            // Also delete from the configured upload path
            Path backupFilePath = Paths.get(uploadPath).resolve(filename);
            Files.deleteIfExists(backupFilePath);
        }
    }
} 