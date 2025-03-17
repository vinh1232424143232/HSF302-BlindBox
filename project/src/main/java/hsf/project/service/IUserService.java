package hsf.project.service;

import hsf.project.pojo.Users;

public interface IUserService {
    Users login(String username, String password);
}
