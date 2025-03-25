package hsf.project.service;

import hsf.project.pojo.Blindbox;
import hsf.project.pojo.Cart;
import hsf.project.pojo.Users;

public interface ICartService {
    public Cart getCart(Users user);
    public void addBlindboxToCart(Users user, Blindbox blindbox);
    public void changeBlinboxQuantity(Users user, Blindbox blindbox, int quantity);
    public void removeBlindboxFromCart(Users user, Blindbox blindbox);
    public void clearCart(Users user);
}
