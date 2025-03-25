package hsf.project.repository;

import hsf.project.enums.RoleType;
import hsf.project.pojo.Roles;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface RoleRepository extends JpaRepository<Roles, Integer> {
    Roles findById(int id);

    Roles findByRole(RoleType role);
}
