package hsf.project.service;

import hsf.project.pojo.Users;
import hsf.project.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService implements IUserService {
    @Autowired
    private UserRepository userRepository;

    public Users login(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public Users create(Users user) {
        return userRepository.save(user);
    }

    @Override
    public Users getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public Users updateUser(Users user) {
        return null;
    }

    @Override
    public void deleteUser(Users user) {

    }
}
