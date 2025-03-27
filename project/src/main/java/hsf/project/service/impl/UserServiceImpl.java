package hsf.project.service.impl;

import hsf.project.pojo.Users;
import hsf.project.repository.RoleRepository;
import hsf.project.repository.UserRepository;
import hsf.project.service.CartService;
import hsf.project.service.UserService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;

import lombok.experimental.FieldDefaults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserServiceImpl implements UserService {
    UserRepository userRepository;
    RoleRepository roleRepository;
    CartService cartService;

    public Users login(String email) {
        return userRepository.findByEmail(email);
    }

    @Transactional
    @Override
    public void create(Users user) {
        userRepository.save(user);
        cartService.createCart(user);
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

        if (fullName != null) {
            user.setFullName(fullName);
        }
        if (phone != null) {
            user.setPhone(phone);
        }
        if (!currentPassword.isEmpty() && !newPassword.isEmpty()) {
            if (user != null && user.getPassword().equals(currentPassword)) {
                user.setPassword(newPassword);
            } else {
                return false;
            }
        }
        userRepository.save(user);
        return true;
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

    @Transactional
    @Override
    public void deleteById(int id) {
        userRepository.deleteById(id);
    }

    @Transactional
    @Override
    public void adminUpdate(String email, String fullName, String phone, int roleId, boolean status) {
        Users user = userRepository.findByEmail(email);
        if (user != null) {
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setRole(roleRepository.findById(roleId));
            user.setActive(status);
            userRepository.save(user);
        }
    }
}
