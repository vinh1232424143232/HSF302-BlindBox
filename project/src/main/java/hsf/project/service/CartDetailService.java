package hsf.project.service;

import hsf.project.pojo.Cart;
import hsf.project.pojo.CartDetails;

import java.util.List;

public interface CartDetailService {
    CartDetails createCartDetail(int blindboxId, int quantity, Cart cart);
    CartDetails updateCartDetail(int id, int quantity);
    void deleteCartDetail(int id);
    CartDetails getCartDetail(int id);
    List<CartDetails> getCartDetailsByCart(Cart cart);
}
