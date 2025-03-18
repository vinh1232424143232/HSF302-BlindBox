package hsf.project.service;

import hsf.project.pojo.Users;
import hsf.project.repository.RoleRepository;
import hsf.project.repository.UserRepository;
import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService implements IUserService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    public Users login(String email) {
        return userRepository.findByEmail(email);
    }

    @Transactional
    @Override
    public void create(Users user) {
        userRepository.save(user);
    }

    @Override
    public List<Users> getAllUsers() {
        return userRepository.findAll();
    }

    @Override
    public Users getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Transactional
    @Override
    public boolean updateUser(String email, String fullName, String currentPassword, String newPassword, String phone) {
        Users user = userRepository.findByEmail(email);
        if (user != null && user.getPassword().equals(currentPassword)) {
            user.setFullName(fullName);
            user.setPassword(newPassword);
            user.setPhone(phone);
            userRepository.save(user);
            return true;
        }
        return false;
    }

    @Transactional
    @Override
    public boolean deleteUser(String email) {
        Users user = userRepository.findByEmail(email);
        if (user != null) {
            userRepository.delete(user);
            return true;
        }
        return false;
    }
}
