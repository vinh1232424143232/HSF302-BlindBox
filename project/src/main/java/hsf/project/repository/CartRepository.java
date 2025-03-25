package hsf.project.repository;

import hsf.project.pojo.Cart;
import hsf.project.pojo.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartRepository extends JpaRepository<Cart, Integer> {
    Cart findByUser(Users user);
}
