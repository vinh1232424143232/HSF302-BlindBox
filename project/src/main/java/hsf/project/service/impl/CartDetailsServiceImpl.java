package hsf.project.service.impl;

import hsf.project.pojo.Blindbox;
import hsf.project.pojo.Cart;
import hsf.project.pojo.CartDetails;
import hsf.project.repository.BlindboxRepository;
import hsf.project.repository.CartDetailsRepository;
import hsf.project.repository.CartRepository;
import hsf.project.service.CartDetailService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CartDetailsServiceImpl implements CartDetailService {
    CartDetailsRepository cartDetailsRepository;
    CartRepository cartRepository;
    BlindboxRepository blindboxRepository;

    @Override
    @Transactional
    public CartDetails createCartDetail(int blindboxId, int quantity, Cart cart) {
        Blindbox blindbox = blindboxRepository.findById(blindboxId).orElse(null);
        if (blindbox != null && cart != null) {
            CartDetails cartDetails = CartDetails.builder()
                    .cart(cart)
                    .blindbox(blindbox)
                    .quantity(quantity)
                    .build();
            return cartDetailsRepository.save(cartDetails);
        }
        return null;
    }

    @Override
    public CartDetails getCartDetail(int id) {
        return cartDetailsRepository.findById(id).orElse(null);
    }

    @Override
    public List<CartDetails> getCartDetailsByCart(Cart cart) {
        return cartDetailsRepository.findByCart(cart);
    }

    @Override
    @Transactional
    public CartDetails updateCartDetail(int id, int quantity) {
        CartDetails cartDetails = cartDetailsRepository.findById(id).orElse(null);
        if (cartDetails != null) {
            if (quantity == 0) {
                deleteCartDetail(id);
                return null;
            }
            cartDetails.setQuantity(quantity);
            return cartDetailsRepository.save(cartDetails);
        }
        return null;
    }

    @Override
    @Transactional
    public void deleteCartDetail(int id) {
        cartDetailsRepository.deleteById(id);
    }
}
