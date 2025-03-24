package hsf.project.pojo;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Entity
@Table(name = "blindbox_image")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class BlindBoxImage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;
    
    String imagePath;
    String imageAlt;
    
    @Column(name = "is_primary")
    boolean primary;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "blindbox_id")
    @JsonBackReference
    Blindbox blindbox;
} 