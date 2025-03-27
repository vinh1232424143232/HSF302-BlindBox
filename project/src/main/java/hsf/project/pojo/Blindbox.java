package hsf.project.pojo;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Entity
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Blindbox {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int id;
    String name;
    int price;
    int stock;
    boolean active;

    //Relationship with brand
    @ManyToOne(fetch = FetchType.EAGER)
    @JsonBackReference
    Brand brand;

    String description;

    //Many to many with cart by Cart detail
    @OneToMany(mappedBy = "blindbox")
    @JsonManagedReference
    List<CartDetails> cartDetailsList;

    String url;

    //Relationship with Order details
    @OneToMany(mappedBy = "blindbox")
    @JsonManagedReference
    List<OrderDetails> orderDetailsList;

    //One to many with item
    @OneToMany(mappedBy = "blindbox")
    @JsonManagedReference
    List<Item> itemList;

}
