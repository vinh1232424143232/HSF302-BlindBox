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

    //Relationship with brand
    @ManyToOne(fetch = FetchType.LAZY)
    @JsonBackReference
    Brand brand;

    //Many to many with cart by Cart detail
    @OneToMany(mappedBy = "blindbox")
    @JsonManagedReference
    List<CartDetails> cartDetailsList;

    //Relationship with Order details

}
