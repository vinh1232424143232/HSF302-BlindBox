package hsf.project.service;

import hsf.project.pojo.Item;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ItemService {
    List<Item> getAllItems();
    List<Item> getAllByActive();
    List<Item> getAllByBlindbox(int id);
    Item getItemById(int id);
    Item getRandomItem(int id);
    Item saveItem(String name, int blindboxId, MultipartFile image);
    Item updateItem(int id, String name, int blindboxId, boolean status, MultipartFile image);
    void deleteItem(int id);
    int countItems();
    int countItemsActive();
}
