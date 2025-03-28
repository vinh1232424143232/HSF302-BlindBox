package hsf.project.service;

import hsf.project.enums.PaymentStatus;
import hsf.project.pojo.OrderDetails;
import hsf.project.pojo.Orders;
import hsf.project.pojo.Users;

import java.util.List;

public interface OrderService {
    Orders findById(int id);
    List<Orders> getAll();
    List<Orders> getOrdersByUser(Users user);
    Orders createOrder(Users user, int addressId, int amount);
    void updateOrder(int id, int addressId);
    void adminUpdateOrder(int id, String status, String paymentStatus);
    void updatePaymentStatus(int id, PaymentStatus paymentStatus);
    void cancelOrder(int id);
    void deleteOrder(int id);
}
