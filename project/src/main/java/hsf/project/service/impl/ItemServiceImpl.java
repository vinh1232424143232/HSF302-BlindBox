package hsf.project.service.impl;

import hsf.project.pojo.Blindbox;
import hsf.project.pojo.Item;
import hsf.project.repository.BlindboxRepository;
import hsf.project.repository.ItemRepository;
import hsf.project.service.ItemService;
import hsf.project.service.SupabaseService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Random;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ItemServiceImpl implements ItemService {
    ItemRepository itemRepository;
    BlindboxRepository blindboxRepository;
    SupabaseService supabaseService;

    @Override
    public List<Item> getAllItems() {
        return itemRepository.findAll();
    }

    @Override
    public List<Item> getAllByActive() {
        return itemRepository.findByActiveTrue();
    }

    @Override
    public List<Item> getAllByBlindbox(int id) {
        Blindbox blindbox = blindboxRepository.findById(id).orElse(null);
        if (blindbox != null) {
            return itemRepository.findByBlindbox(blindbox);
        }
        return List.of();
    }

    @Override
    public Item getItemById(int id) {
        return itemRepository.findById(id).orElse(null);
    }

    @Override
    public Item getRandomItem(int id) {
        Blindbox blindbox = blindboxRepository.findById(id).orElse(null);
        if (blindbox != null) {
            List<Item> items = itemRepository.findByBlindbox(blindbox);
            int number = getRandomNumber(0, items.size() - 1);
            return items.get(number);
        }
        return null;
    }

    @Override
    @Transactional
    public Item saveItem(String name, int blindboxId, MultipartFile image) {
        try {
            Item item = Item.builder()
                    .name(name)
                    .active(true)
                    .build();
            Blindbox blindbox = blindboxRepository.findById(blindboxId).orElse(null);
            if (blindbox != null) {
                item.setBlindbox(blindbox);
            }
            itemRepository.save(item);
            if (image != null) {
                supabaseService.upload(image,"Item_"+item.getId());
                String url = supabaseService.getImage("Item_"+item.getId());
                item.setUrl(url);
            }
            itemRepository.save(item);
        } catch (IOException e) {
            System.err.println("Failed to save item: " + e.getMessage());
        }
        return null;
    }

    @Override
    @Transactional
    public Item updateItem(int id, String name, int blindboxId, boolean status, MultipartFile image) {
        try {
            Item item = itemRepository.findById(id).orElse(null);
            if (item != null) {
                item.setName(name);
                item.setBlindbox(blindboxRepository.findById(blindboxId).orElse(null));
                item.setActive(status);
                itemRepository.save(item);
                if (image != null) {
                    supabaseService.delete("Item_"+item.getId());
                    supabaseService.upload(image,"Item_"+item.getId());
                    String url = supabaseService.getImage("Item_"+item.getId());
                    item.setUrl(url);
                }
                itemRepository.save(item);
            }
        } catch (IOException e) {
            System.err.println("Failed to update item: " + e.getMessage());
        }
        return null;
    }

    @Override
    @Transactional
    public void deleteItem(int id) {
        itemRepository.deleteById(id);
    }

    @Override
    public int countItems() {
        return itemRepository.findAll().size();
    }

    @Override
    public int countItemsActive() {
        return itemRepository.findByActiveTrue().size();
    }

    public static int getRandomNumber(int min, int max) {
        Random random = new Random();
        return random.nextInt(max - min + 1) + min; // Đảm bảo số nằm trong khoảng [min, max]
    }
}
