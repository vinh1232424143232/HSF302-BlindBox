package hsf.project.repository;

import hsf.project.pojo.Blindbox;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BlindboxRepository extends JpaRepository<Blindbox, Integer> {
    /**
     * Find all blind boxes for a specific brand
     */
    List<Blindbox> findByBrandId(int brandId);

    /**
     * Find all active blind boxes
     */
    List<Blindbox> findByActiveTrue();

    List<Blindbox> findByPriceBetweenAndActiveTrue(int low, int high);
}
