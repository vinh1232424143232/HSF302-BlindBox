package hsf.project.service;

import hsf.project.pojo.Blindbox;
import hsf.project.pojo.Cart;
import hsf.project.pojo.CartDetails;
import hsf.project.pojo.Users;
import hsf.project.repository.CartRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CartService implements ICartService {

    @Autowired
    private CartRepository cartRepo;


    @Override
    public Cart getCart(Users user) {
        return cartRepo.findByUser(user);
    }

    @Override
    public void addBlindboxToCart(Users user, Blindbox blindbox) {
        Cart cart = user.getCart();
        for (CartDetails cartDetails : cart.getCartDetailsList()) {
            if (cartDetails.getBlindbox().getId() == blindbox.getId()) {
                cartDetails.setQuantity(cartDetails.getQuantity() + 1);
                return;
            }
        }
        CartDetails cartDetails = new CartDetails();
        cartDetails.setBlindbox(blindbox);
        cartDetails.setQuantity(1);
        cartDetails.setCart(cart);
        cart.getCartDetailsList().add(cartDetails);
        cartRepo.save(cart);
    }

    @Override
    public void changeBlinboxQuantity(Users user, Blindbox blindbox, int quantity) {
        Cart cart = user.getCart();
        for (CartDetails cartDetails : cart.getCartDetailsList()) {
            if (cartDetails.getBlindbox().getId() == blindbox.getId()) {
                cartDetails.setQuantity(quantity);
                cartRepo.save(cart);
                return;
            }
        }
    }

    @Override
    public void removeBlindboxFromCart(Users user, Blindbox blindbox) {
        Cart cart = user.getCart();
        for (CartDetails cartDetails : cart.getCartDetailsList()) {
            if (cartDetails.getBlindbox().getId() == blindbox.getId()) {
                cart.getCartDetailsList().remove(cartDetails);
                cartRepo.save(cart);
                return;
            }
        }
    }

    @Override
    public void clearCart(Users user) {
        Cart cart = user.getCart();
        cart.getCartDetailsList().clear();
        cartRepo.save(cart);
    }
}
