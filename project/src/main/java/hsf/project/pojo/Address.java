package hsf.project.pojo;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Address {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int id;
    String number;
    String street;
    String city;

    //Relationship with User
    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.REMOVE)
    @JsonBackReference
    Users user;

    //Relationship with Order
    @OneToMany(mappedBy = "address", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    List<Orders> orders;

    boolean isActive;

}
