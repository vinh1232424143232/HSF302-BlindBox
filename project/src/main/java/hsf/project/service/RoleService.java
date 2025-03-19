package hsf.project.service;

import hsf.project.pojo.Roles;
import hsf.project.repository.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleService implements IRoles {
    @Autowired
    private RoleRepository roleRepository;

    @Override
    public Roles getRolesById(int id) {
        return roleRepository.findById(id);
    }

    @Override
    public List<Roles> getAllRoles() {
        return roleRepository.findAll();
    }
}
