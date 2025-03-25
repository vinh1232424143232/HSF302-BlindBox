package hsf.project.repository;

import hsf.project.pojo.Cart;
import hsf.project.pojo.CartDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CartDetailsRepository extends JpaRepository<CartDetails, Integer> {
    List<CartDetails> findByCart(Cart cart);
}
