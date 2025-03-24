package hsf.project.service;

import hsf.project.pojo.BlindBoxImage;
import hsf.project.pojo.Blindbox;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface BlindBoxService {
    
    // BlindBox operations
    List<Blindbox> getAllBlindBoxes();
    
    List<Blindbox> getBlindBoxesByBrand(int brandId);
    
    List<Blindbox> getActiveBlindBoxes();
    
    Blindbox getBlindBoxById(int id);
    
    Blindbox createBlindBox(Blindbox blindBox, List<MultipartFile> images);
    
    Blindbox updateBlindBox(int id, Blindbox blindBox);
    
    boolean deleteBlindBox(int id);
    
    boolean toggleBlindBoxStatus(int id);
    
    // Image operations
    List<BlindBoxImage> getBlindBoxImages(int blindBoxId);
    
    String getPrimaryImagePath(int blindBoxId);
    
    BlindBoxImage addImageToBlindBox(int blindBoxId, MultipartFile image, boolean setPrimary);
    
    boolean setPrimaryImage(int blindBoxId, int imageId);
    
    boolean deleteImage(int blindBoxId, int imageId);
}
