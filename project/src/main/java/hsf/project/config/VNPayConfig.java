package hsf.project.config;

import lombok.Getter;
import org.springframework.stereotype.Component;

@Component
@Getter
public class VNPayConfig {
    public static final String VERSION = "2.1.0";
    public static final String COMMAND = "pay";
    public static final String CURR_CODE = "VND";
    public static final String COUNTRY_CODE = "VN";
    public static final String LOCALE = "vn";


}
