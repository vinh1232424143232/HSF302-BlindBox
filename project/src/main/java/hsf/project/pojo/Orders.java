package hsf.project.pojo;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import hsf.project.enums.PaymentStatus;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Orders {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int id;

    PaymentStatus paymentStatus;

    int amount;

    boolean status;

    @CreationTimestamp
    LocalDateTime createdAt;

    //Relationship with User
    @ManyToOne(fetch = FetchType.LAZY)
    @JsonBackReference
    Users user;

    //Relationship with Address
    @ManyToOne(fetch = FetchType.LAZY)
    @JsonBackReference
    Address address;

    //Relationship with Order details
    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    List<OrderDetails> orderDetailsList;

}
