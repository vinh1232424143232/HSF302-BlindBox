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
public class Item {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int id;
    String url;
    String name;
    boolean active;

    @ManyToOne(fetch = FetchType.LAZY)
    @JsonBackReference
    Blindbox blindbox;
}
