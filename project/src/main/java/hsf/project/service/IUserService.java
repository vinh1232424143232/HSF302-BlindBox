package hsf.project.service;

import hsf.project.pojo.Users;

public interface IUserService {
    Users create(Users user);
    Users getUserByEmail(String email);
    Users updateUser(Users user);
    void deleteUser(Users user);
}
