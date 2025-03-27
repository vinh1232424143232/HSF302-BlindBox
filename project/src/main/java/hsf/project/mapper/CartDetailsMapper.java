package hsf.project.mapper;

import hsf.project.dto.CartDetailsDTO;
import hsf.project.pojo.CartDetails;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface CartDetailsMapper {
    CartDetailsDTO toDTO(CartDetails cartDetails);
    List<CartDetailsDTO> toDTOList(List<CartDetails> cartDetailsList);
}