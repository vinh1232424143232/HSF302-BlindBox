package hsf.project.service;

import hsf.project.pojo.Cart;
import hsf.project.pojo.Users;

public interface CartService {
    Cart createCart(Users user);
    Cart getCartByUser(Users user);
    void deleteCart(int cartId);
    void addToCart(Cart cart,int blindboxId, int quantity);
    int totalCart(Cart cart);
}
