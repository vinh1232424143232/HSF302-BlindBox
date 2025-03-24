package hsf.project.service;

import hsf.project.pojo.Address;
import hsf.project.pojo.Users;

import java.util.List;

public interface AddressService {
    Address create(String street, String city, String number, String email);
    Address findById(int id);
    List<Address> getAll(Users user);
    boolean update(int id, String street, String city, String number);
    boolean deleteById(int id);
}
