package hsf.project.service;

import hsf.project.pojo.Users;

import java.util.List;

public interface IUserService {
    void create(Users user);
    Users getUserByEmail(String email);
    boolean updateUser(String email, String fullName, String currentPassword, String newPassword, String phone);
    boolean deleteUser(String email);
    List<Users> getAllUsers();
}
