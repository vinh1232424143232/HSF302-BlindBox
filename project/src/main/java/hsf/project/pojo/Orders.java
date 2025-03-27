package hsf.project.pojo;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import hsf.project.enums.OrderStatus;
import hsf.project.enums.PaymentStatus;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.Date;
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

    OrderStatus status;

    @CreationTimestamp
    Date createdAt;

    //Relationship with User
    @ManyToOne(fetch = FetchType.EAGER)
    @JsonBackReference
    Users user;

    //Relationship with Address
    @ManyToOne(fetch = FetchType.EAGER)
    @JsonBackReference
    Address address;

    //Relationship with Order details
    @OneToMany(mappedBy = "order", cascade = CascadeType.PERSIST)
    @JsonManagedReference
    List<OrderDetails> orderDetailsList;

}
