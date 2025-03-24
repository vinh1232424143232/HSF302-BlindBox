package hsf.project.repository;

import hsf.project.pojo.BlindBoxImage;
import hsf.project.pojo.Blindbox;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BlindBoxImageRepository extends JpaRepository<BlindBoxImage, Integer> {
    
    /**
     * Find all images for a blind box ordered by ID
     */
    List<BlindBoxImage> findByBlindboxOrderById(Blindbox blindbox);
    
    /**
     * Find the primary image for a blind box
     */
    Optional<BlindBoxImage> findByBlindboxAndPrimaryTrue(Blindbox blindbox);
    
    /**
     * Delete all images associated with a blind box
     */
    void deleteByBlindbox(Blindbox blindbox);
    
    /**
     * Reset all primary flags for a blind box's images
     */
    @Modifying
    @Query("UPDATE BlindBoxImage i SET i.primary = false WHERE i.blindbox = :blindbox")
    void resetPrimaryImagesForBlindbox(@Param("blindbox") Blindbox blindbox);
    
    /**
     * Set an image as primary
     */
    @Modifying
    @Query("UPDATE BlindBoxImage i SET i.primary = true WHERE i.id = :imageId")
    void setPrimaryImage(@Param("imageId") int imageId);
} 