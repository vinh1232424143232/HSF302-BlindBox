package hsf.project.repository;

import hsf.project.pojo.Orders;
import hsf.project.pojo.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Orders, Integer> {
    List<Orders> getOrderByUser(Users user);

}
