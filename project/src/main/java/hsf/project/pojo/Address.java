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
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Address {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int id;
    String number;
    String street;
    String city;

    //Relationship with User
    @ManyToOne(fetch = FetchType.LAZY)
    @JsonBackReference
    Users user;

    //Relationship with Order
    @OneToMany(mappedBy = "address", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    List<Orders> orders;
}
