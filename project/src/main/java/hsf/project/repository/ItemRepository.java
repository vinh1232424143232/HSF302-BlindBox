package hsf.project.repository;

import hsf.project.pojo.Blindbox;
import hsf.project.pojo.Item;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ItemRepository extends JpaRepository<Item, Integer> {
    List<Item> findByBlindbox(Blindbox blindbox);
    List<Item> findByActiveTrue();
}
