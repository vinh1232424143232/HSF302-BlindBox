package hsf.project.mapper;

import hsf.project.pojo.CartDetails;
import hsf.project.pojo.OrderDetails;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.NullValuePropertyMappingStrategy;

import java.util.List;

@Mapper(componentModel = "spring", nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface OrderDetailMapper {
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "order", ignore = true)
    @Mapping(target = "quantity", source = "quantity")
    @Mapping(target = "price", source = "blindbox.price")
    @Mapping(target = "blindbox", source = "blindbox")
    OrderDetails toOrderDetails(CartDetails cartDetails);

    List<OrderDetails> toOrderDetailsList(List<CartDetails> cartDetailsList);
}
