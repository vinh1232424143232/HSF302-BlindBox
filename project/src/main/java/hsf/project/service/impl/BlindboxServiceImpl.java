package hsf.project.service.impl;

import hsf.project.pojo.*;
import hsf.project.repository.BlindboxRepository;
import hsf.project.repository.BrandRepository;
import hsf.project.repository.OrderRepository;
import hsf.project.service.BlindboxService;
import hsf.project.service.ItemService;
import hsf.project.service.SupabaseService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class BlindboxServiceImpl implements BlindboxService {

    BlindboxRepository blindboxRepository;
    BrandRepository brandRepository;
    SupabaseService supabaseService;
    ItemService itemService;
    OrderRepository orderRepository;

    @Override
    public List<Blindbox> getAllBlindBoxes() {
        return blindboxRepository.findAll();
    }

    @Override
    public List<Blindbox> getActiveBlindBoxes() {
        return blindboxRepository.findByActiveTrue();
    }

    @Override
    public List<Blindbox> getBlindBoxesByBrand(int brandId) {
        return blindboxRepository.findByBrandId(brandId);
    }

    @Override
    public List<Blindbox> findBlindboxByPriceBetween(int low, int high) {
        return blindboxRepository.findByPriceBetweenAndActiveTrue(low, high);
    }

    @Override
    public List<Blindbox> getAllBySearch(String text) {
        List<Blindbox> all = getActiveBlindBoxes();
        List<Blindbox> result = new ArrayList<>();
        for (Blindbox blindbox : all) {
            if (blindbox.getName().contains(text)) {
                result.add(blindbox);
            }
        }
        return result;
    }

    @Override
    public List<Blindbox> ascendListBlindbox() {
        List<Blindbox> blindboxes = getActiveBlindBoxes();
        Collections.sort(blindboxes, Comparator.comparingInt(Blindbox::getPrice));
        return blindboxes;
    }

    @Override
    public List<Blindbox> descendListBlindbox() {
        List<Blindbox> blindboxes = getActiveBlindBoxes();
        Collections.sort(blindboxes, Comparator.comparingInt(Blindbox::getPrice).reversed());
        return blindboxes;
    }



    @Override
    public Blindbox getBlindBoxById(int id) {
        return blindboxRepository.findById(id).orElse(null);
    }


    @Override
    @Transactional
    public Blindbox createBlindBox(String name, int price, int stock, int brandId, MultipartFile image, String description) {
        try {
            Blindbox blindbox = Blindbox.builder()
                    .name(name)
                    .price(price)
                    .stock(stock)
                    .description(description)
                    .active(true)
                    .build();
            Brand brand = brandRepository.findById(brandId).orElse(null);
            if (brand != null) {
                blindbox.setBrand(brand);
            }
            blindboxRepository.save(blindbox);
            if (image != null) {
                supabaseService.upload(image,"Blindbox_"+blindbox.getId());
                String url = supabaseService.getImage("Blindbox_"+blindbox.getId());
                blindbox.setUrl(url);
            }
            blindboxRepository.save(blindbox);
        } catch (IOException e) {
            System.err.println("Failed to save image: " + e.getMessage());
        }
        return null;
    }

    @Override
    @Transactional
    public Blindbox updateBlindBox(int id, String name, int price, int stock, boolean status, int brandId, MultipartFile image, String description) {
        //Update name, price, stock, status, brandId
        try {
            Blindbox blindbox = blindboxRepository.findById(id).orElse(null);
            Brand brand = brandRepository.findById(brandId).orElse(null);
            if (blindbox != null) {
                blindbox.setName(name);
                blindbox.setPrice(price);
                blindbox.setStock(stock);
                blindbox.setDescription(description);
                blindbox.setActive(status);
                if (brand != null) {
                    blindbox.setBrand(brand);
                }
                if (image != null) {
                    supabaseService.delete("Blindbox_"+id);
                    supabaseService.upload(image,"Blindbox_"+id);
                    String url = supabaseService.getImage("Blindbox_"+id);
                    blindbox.setUrl(url);
                }
                blindboxRepository.save(blindbox);
            }
        } catch (IOException e) {
            System.err.println("Failed to update: " + e.getMessage());
        }

        return null;
    }

    @Override
    @Transactional
    public boolean deleteBlindBox(int id) {
        try {
            Blindbox blindbox = blindboxRepository.findById(id).orElse(null);
            if (blindbox != null) {
                supabaseService.delete("Blindbox_"+id);
                blindboxRepository.delete(blindbox);
            }
        } catch (IOException e) {
            System.err.println("Failed to delete: " + e.getMessage());
        }
        return false;
    }

    @Override
    @Transactional
    public void updateStock(int id, int stock) {
        Blindbox blindbox = blindboxRepository.findById(id).orElse(null);
        if (blindbox != null) {
            blindbox.setStock(stock);
            blindboxRepository.save(blindbox);
        }
    }

    @Override
    public int countTotalBlindBoxes() {
        return blindboxRepository.findAll().size();
    }

    @Override
    public int countActiveBlindBoxes() {
        return blindboxRepository.findByActiveTrue().size();
    }

    @Override
    public List<Item> openBlindbox(int orderId) {
        Orders orders = orderRepository.findById(orderId).orElse(null);
        List<OrderDetails> orderDetailsList = orders.getOrderDetailsList();
        List<Item> itemsList = new ArrayList<>();
        if (!orderDetailsList.isEmpty()) {
            for (OrderDetails orderDetails : orderDetailsList) {
                for (int i=0; i<orderDetails.getQuantity(); i++) {
                    Item item = itemService.getRandomItem(orderDetails.getBlindbox().getId());
                    itemsList.add(item);
                }
            }
        }
        return itemsList;
    }
}
