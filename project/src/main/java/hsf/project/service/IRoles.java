package hsf.project.service;

import hsf.project.pojo.Roles;

import java.util.List;

public interface IRoles {
    Roles getRolesById(int id);
    List<Roles> getAllRoles();
}
