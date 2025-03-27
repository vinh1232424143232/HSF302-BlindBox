package hsf.project.service.impl;

import hsf.project.pojo.Address;
import hsf.project.pojo.Users;
import hsf.project.repository.AddressRepository;
import hsf.project.repository.UserRepository;
import hsf.project.service.AddressService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AddressServiceImpl implements AddressService {
    AddressRepository addressRepository;
    UserRepository userRepository;

    @Transactional
    @Override
    public Address create(String number, String street, String city, String email) {
        Users user = userRepository.findByEmail(email);
        Address address = Address.builder()
                .number(number)
                .street(street)
                .city(city)
                .isActive(true)
                .build();
        address.setUser(user);
        return addressRepository.save(address);
    }

    @Override
    public Address findById(int id) {
        return addressRepository.findById(id).orElse(null);
    }

    @Override
    public List<Address> getAll(Users user) {
        List<Address> addresses = addressRepository.findAllByUser(user);
        List<Address> active = new ArrayList<>();
        for (Address address : addresses) {
            if (address.isActive()) {
                active.add(address);
            }
        }
        return active;
    }

    @Transactional
    @Override
    public boolean update(int id, String street, String city, String number) {
        Address address = findById(id);
        if (address != null) {
            address.setStreet(street);
            address.setCity(city);
            address.setNumber(number);
            addressRepository.save(address);
            return true;
        }
        return false;
    }

    @Transactional
    @Override
    public boolean deleteById(int id) {
        Address address = addressRepository.findById(id).orElse(null);
        if (address != null) {
            address.setActive(false);
            addressRepository.save(address);
            return true;
        }
        return false;
    }
}
