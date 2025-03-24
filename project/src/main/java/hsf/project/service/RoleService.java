package hsf.project.service;

import java.util.List;

public interface RoleService {
    hsf.project.pojo.Roles getRolesById(int id);
    List<hsf.project.pojo.Roles> getAllRoles();
}
