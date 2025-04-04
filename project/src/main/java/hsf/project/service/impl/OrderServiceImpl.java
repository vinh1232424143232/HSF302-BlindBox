package hsf.project.service.impl;

import hsf.project.enums.OrderStatus;
import hsf.project.enums.PaymentStatus;
import hsf.project.mapper.OrderDetailMapper;
import hsf.project.pojo.*;
import hsf.project.repository.*;
import hsf.project.service.OrderService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OrderServiceImpl implements OrderService {
    OrderRepository orderRepository;
    AddressRepository addressRepository;
    OrderDetailMapper orderDetailMapper;
    OrderDetailsRepository orderDetailsRepository;
    CartRepository cartRepository;
    CartDetailsRepository cartDetailsRepository;
    BlindboxRepository blindboxRepository;

    public Orders findById(int id) {
        return orderRepository.findById(id).orElse(null);
    }

    public List<Orders> getAll() {
        return orderRepository.findAll();
    }

    public List<Orders> getOrdersByUser(Users user) {
        return orderRepository.getOrderByUser(user);
    }

    @Transactional
    public Orders createOrder(Users user, int addressId, int amount) {
        Address address = addressRepository.findById(addressId).orElse(null);
        Cart cart = cartRepository.findByUser(user);
        Orders order = Orders.builder()
                .status(OrderStatus.WAITING)
                .user(user)
                .address(address)
                .amount(amount)
                .paymentStatus(PaymentStatus.PENDING)
                .build();
        orderRepository.save(order);

        List<CartDetails> cartDetails = cart.getCartDetailsList();
        if (!cartDetails.isEmpty()) {
            for (CartDetails cartDetail : cartDetails) {
                OrderDetails orderDetails = orderDetailMapper.toOrderDetails(cartDetail);
                orderDetails.setOrder(order);
                orderDetailsRepository.save(orderDetails);
            }
        }
        if (!cartDetails.isEmpty()) {
            for (CartDetails cartDetail : cartDetails) {
                cartDetail.getBlindbox().setStock(cartDetail.getBlindbox().getStock() - cartDetail.getQuantity());
                blindboxRepository.save(cartDetail.getBlindbox());
                cartDetailsRepository.delete(cartDetail);
            }
            cart.getCartDetailsList().clear();
        }
        cartRepository.save(cart);
        return orderRepository.save(order);
    }

    @Transactional
    public void updateOrder(int id, int addressId) {
        Orders order = findById(id);
        Address address = addressRepository.findById(addressId).orElse(null);
        if (address != null) {
            order.setAddress(address);
        }
        orderRepository.save(order);
    }

    @Transactional
    public void adminUpdateOrder(int id, String status, String paymentStatus) {
        Orders order = findById(id);
        PaymentStatus paymentStatusUpdate = PaymentStatus.valueOf(paymentStatus);
        OrderStatus orderStatusUpdate = OrderStatus.valueOf(status);
        order.setPaymentStatus(paymentStatusUpdate);
        order.setStatus(orderStatusUpdate);
        orderRepository.save(order);
    }

    @Transactional
    public void updatePaymentStatus(int id, PaymentStatus paymentStatus) {
        Orders order = findById(id);
        order.setPaymentStatus(paymentStatus);
        orderRepository.save(order);
    }

    @Transactional
    public void cancelOrder(int id) {
        Orders order = findById(id);
        order.setStatus(OrderStatus.CANCELLED);
        order.setPaymentStatus(PaymentStatus.CANCELLED);
    }

    @Transactional
    public void deleteOrder(int id) {
        Orders order = findById(id);
        orderRepository.delete(order);
    }







}
