package hsf.project.dto;

import hsf.project.pojo.Blindbox;
import lombok.Data;

@Data
public class CartDetailsDTO {
    private int quantity;
    private Blindbox blindbox;
}
