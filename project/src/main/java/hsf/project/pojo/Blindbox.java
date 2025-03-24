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
public class Blindbox {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int id;
    String name;
    String description;
    String size;
    String material;
    int quantity;
    double price;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    BlindboxStatus status;
    
    boolean active;

    // Transient field for primary image path (not stored in database)
    @Transient
    String primaryImagePath;
    
    // Relationship with brand
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "brand_id")
    @JsonBackReference
    Brand brand;

    // Relationship with images
    @OneToMany(mappedBy = "blindbox", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    List<BlindBoxImage> images = new ArrayList<>();

    // Many to many with cart by Cart detail
    @OneToMany(mappedBy = "blindbox")
    @JsonManagedReference
    List<CartDetails> cartDetailsList;

    // Helper method to add image
    public void addImage(BlindBoxImage image) {
        images.add(image);
        image.setBlindbox(this);
    }
    
    // Helper method to remove image
    public void removeImage(BlindBoxImage image) {
        images.remove(image);
        image.setBlindbox(null);
    }
}

enum BlindboxStatus {
    AVAILABLE, OUT_OF_STOCK, COMING_SOON
}
