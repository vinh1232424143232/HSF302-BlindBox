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


    @Override
    public Users login(String email, String password) {
        return userRepository.findByEmailAndPassword(email, password);
    }
}
