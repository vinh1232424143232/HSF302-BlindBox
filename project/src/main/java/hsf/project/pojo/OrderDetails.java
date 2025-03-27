package hsf.project.pojo;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Entity
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class OrderDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int id;

    int price;

    int quantity;

    //Relationship with Blind box
    @ManyToOne(fetch = FetchType.EAGER)
    @JsonBackReference
    Blindbox blindbox;

    //Relationship with Order
    @ManyToOne(fetch = FetchType.EAGER)
    @JsonBackReference
    Orders order;
}
