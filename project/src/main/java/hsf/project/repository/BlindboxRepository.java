package hsf.project.repository;

import hsf.project.pojo.Blindbox;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BlindboxRepository extends JpaRepository<Blindbox, Integer> {
}
