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
public class CartDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int id;
    int quantity;

    //Relationship with blind box
    @ManyToOne(fetch = FetchType.LAZY)
    @JsonBackReference
    Blindbox blindbox;

    //Relationship with cart
    @ManyToOne(fetch = FetchType.LAZY)
    @JsonBackReference
    Cart cart;
}
