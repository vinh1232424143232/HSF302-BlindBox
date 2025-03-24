package hsf.project.service;

import hsf.project.pojo.Blindbox;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface BlindboxService {
    // BlindBox operations
    List<Blindbox> getAllBlindBoxes();

    List<Blindbox> getBlindBoxesByBrand(int brandId);

    List<Blindbox> getActiveBlindBoxes();

    List<Blindbox> getAllBySearch(String text);

    Blindbox getBlindBoxById(int id);

    Blindbox createBlindBox(String name, int price, int stock, int brandId, MultipartFile image);

    Blindbox updateBlindBox(int id, String name, int price, int stock, boolean active, int brandId, MultipartFile image);

    boolean deleteBlindBox(int id);

    int countTotalBlindBoxes();

    int countActiveBlindBoxes();

    List<Blindbox> ascendListBlindbox();
    List<Blindbox> descendListBlindbox();
}
