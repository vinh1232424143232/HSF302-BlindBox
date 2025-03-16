package hsf.project.repository;

import hsf.project.pojo.CartDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartDetailsRepository extends JpaRepository<CartDetails, Integer> {
}
