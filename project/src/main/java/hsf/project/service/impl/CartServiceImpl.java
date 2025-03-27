package hsf.project.service.impl;

import hsf.project.pojo.Blindbox;
import hsf.project.pojo.Cart;
import hsf.project.pojo.CartDetails;
import hsf.project.pojo.Users;
import hsf.project.repository.BlindboxRepository;
import hsf.project.repository.CartDetailsRepository;
import hsf.project.repository.CartRepository;
import hsf.project.repository.UserRepository;
import hsf.project.service.CartDetailService;
import hsf.project.service.CartService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CartServiceImpl implements CartService {
    CartRepository cartRepository;
    UserRepository userRepository;
    BlindboxRepository blindboxRepository;
    CartDetailService cartDetailService;
    private final CartDetailsRepository cartDetailsRepository;

    @Override
    @Transactional
    public Cart createCart(Users user) {
        if (user != null) {
            Cart cart = new Cart();
            cart.setUser(user);
            return cartRepository.save(cart);
        }
        return null;
    }

    @Override
    public Cart getCartByUser(Users users) {
        return cartRepository.findByUser(users);
    }

    @Override
    @Transactional
    public void deleteCart(int cartId) {
        cartRepository.deleteById(cartId);
    }

    @Override
    @Transactional
    public void addToCart(Cart cart,int blindboxId, int quantity) {
        Blindbox blindbox = blindboxRepository.findById(blindboxId).orElse(null);
        if (blindbox != null) {
            if (quantity > blindbox.getStock()) {
                quantity = blindbox.getStock();
            }
        }
        List<CartDetails> cartDetailsList = cart.getCartDetailsList();
        int count = 0;
        if (cartDetailsList.isEmpty()) {
            cartDetailService.createCartDetail(blindboxId, quantity, cart);
        } else {
            for (CartDetails cartDetails : cartDetailsList) {
                if (cartDetails.getBlindbox().getId() == blindboxId) {
                    cartDetails.setQuantity(cartDetails.getQuantity() + quantity);
                } else {
                    count++;
                }
                if (count == cartDetailsList.size()) {
                    cartDetailService.createCartDetail(blindboxId, quantity, cart);
                }
            }
        }
    }

    @Override
    public int totalCart(Cart cart) {
        List<CartDetails> cartDetailsList = cartDetailsRepository.findByCart(cart);
        int total = 0;
        if (cartDetailsList != null && !cartDetailsList.isEmpty()) {
            for (CartDetails cartDetails : cartDetailsList) {
                total += cartDetails.getQuantity()*cartDetails.getBlindbox().getPrice();
            }
        }
        return total;
    }
}
