package hsf.project.service.impl;

import hsf.project.repository.RoleRepository;
import hsf.project.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleRepository roleRepository;

    @Override
    public hsf.project.pojo.Roles getRolesById(int id) {
        return roleRepository.findById(id);
    }

    @Override
    public List<hsf.project.pojo.Roles> getAllRoles() {
        return roleRepository.findAll();
    }
}
