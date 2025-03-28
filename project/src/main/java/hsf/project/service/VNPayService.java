package hsf.project.service;

import hsf.project.config.VNPayConfig;
import hsf.project.enums.OrderStatus;
import hsf.project.enums.PaymentStatus;
import hsf.project.pojo.Orders;
import hsf.project.repository.OrderRepository;
import hsf.project.utils.VNPayHashUtils;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
@Slf4j
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class VNPayService {
    VNPayConfig vnPayConfig;
    OrderRepository orderRepository;

    public String createPaymentUrl(int id, @NonNull String ipAddress) throws Exception {
        validateCreatePaymentRequest(id, ipAddress);

        try {
            Map<String, String> vnp_Params = buildPaymentParams(id, ipAddress);
            String queryUrl = VNPayHashUtils.createQueryUrl(vnp_Params, vnPayConfig.getHashSecret());
            String fullUrl = vnPayConfig.getPayUrl() + "?" + queryUrl;

            log.info("Created payment URL for TxnRef: {}", vnp_Params.get("vnp_TxnRef"));
            return fullUrl;
        } catch (Exception e) {
            log.error("Error creating payment URL: {}", e.getMessage());
            throw new RuntimeException("Error creating payment URL" + e.getMessage());
        }
    }

    public String processPaymentResponse(@NonNull Map<String, String> response) {
        Assert.notEmpty(response, "Payment response cannot be empty");

        try {
            if (response.isEmpty()) {
                throw new Exception("VNPAY_MISSING_PARAMS");
            }

            validatePaymentResponse(response);
            return buildPaymentResult(response);
        } catch (Exception e) {
            log.error("Error creating payment URL: {}", e.getMessage());
            throw new RuntimeException("Error creating payment URL" + e.getMessage());
        }
    }


    public Map<String, String> processIPNResponse(@NonNull Map<String, String> response) {
        Assert.notEmpty(response, "IPN response cannot be empty");

        try {
            if (response.isEmpty()) {
                return createIPNResponse("99", "Invalid Request");
            }

            validatePaymentResponse(response);
            return processIPNResult(response);
        } catch (Exception e) {
            log.error("Error processing IPN response: {}", e.getMessage());
            return createIPNResponse("99", e.getMessage());
        }
    }

    private void validateCreatePaymentRequest(Integer id, String ipAddress) throws Exception {
        Assert.notNull(id, "Payment request cannot be null");
        Assert.hasText(ipAddress, "IP address cannot be empty");

        if (!StringUtils.hasText(ipAddress)) {
            throw new Exception("VNPAY_INVALID_IP_ADDRESS");
        }

    }

    private Map<String, String> buildPaymentParams(int id, String ipAddress) throws Exception {
        // Lấy thông tin order
        Orders orders = orderRepository.findById(id).orElse(null);


        // Kiểm tra trạng thái thanh toán
        if (orders.getPaymentStatus() == PaymentStatus.PAID) {
            throw new Exception("VNPAY_PAYMENT_ERROR");
        }

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", VNPayConfig.VERSION);
        vnp_Params.put("vnp_Command", VNPayConfig.COMMAND);
        vnp_Params.put("vnp_TmnCode", vnPayConfig.getTmnCode());
        vnp_Params.put("vnp_Amount", String.valueOf(orders.getAmount() * 100));
        vnp_Params.put("vnp_CurrCode", VNPayConfig.CURR_CODE);

        String vnp_TxnRef = generateTxnRef();
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);

        String orderInfo = String.format("Payment for Order #%s", id);
        vnp_Params.put("vnp_OrderInfo", orderInfo);

        vnp_Params.put("vnp_OrderType", "billpayment");
        vnp_Params.put("vnp_Locale", "vn");
        vnp_Params.put("vnp_ReturnUrl", vnPayConfig.getReturnUrl());
        vnp_Params.put("vnp_IpAddr", ipAddress);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);
        vnp_Params.put("vnp_BankCode", "ncb");

        return vnp_Params;
    }

    private void validatePaymentResponse(@NonNull Map<String, String> response) throws Exception {
        if (!response.containsKey("vnp_SecureHash")) {
            log.warn("Missing secure hash in response");
            throw new Exception("VNPAY_INVALID_CHECKSUM");
        }

        String vnp_SecureHash = response.get("vnp_SecureHash");
        if (vnp_SecureHash == null || vnp_SecureHash.isEmpty()) {
            log.warn("Empty secure hash in response");
            throw new Exception("VNPAY_INVALID_CHECKSUM");
        }

        // Create a new map to avoid modifying the input
        Map<String, String> fields = new HashMap<>(response);
        fields.remove("vnp_SecureHash");
        fields.remove("vnp_SecureHashType");

        String checkSum = VNPayHashUtils.hashAllFields(fields, vnPayConfig.getHashSecret());
        if (!checkSum.equals(vnp_SecureHash)) {
            log.warn("Invalid secure hash. Expected: {}, Got: {}", checkSum, vnp_SecureHash);
            throw new Exception("ErrorCode.VNPAY_INVALID_CHECKSUM");
        }
    }

    private String buildPaymentResult(Map<String, String> response) throws Exception {
        String responseCode = response.getOrDefault("vnp_ResponseCode", "99");
        String transactionStatus = response.getOrDefault("vnp_TransactionStatus", "99");

        if (!response.containsKey("vnp_Amount")) {
            throw new Exception("VNPAY_MISSING_PARAMS");
        }

        boolean isSuccess = "00".equals(responseCode) && "00".equals(transactionStatus);

        String url = "";

        if (isSuccess) {
            try {
                // Lấy order ID từ orderInfo
                String orderInfo = response.get("vnp_OrderInfo");
                int orderId = extractOrderId(orderInfo);

                Orders orders = orderRepository.findById(orderId).orElse(null);

                orders.setPaymentStatus(PaymentStatus.PAID);
                orders.setStatus(OrderStatus.SHIPPING);

                orderRepository.save(orders);

                //URL khi payment thành công
                url = "http://localhost:8181/hsf/payment/success";
            } catch (Exception e) {
            }
        } else {
            try {
                String orderInfo = response.get("vnp_OrderInfo");
                int orderId = extractOrderId(orderInfo);

                Orders orders = orderRepository.findById(orderId).orElse(null);

                orders.setPaymentStatus(PaymentStatus.CANCELLED);
                orders.setStatus(OrderStatus.CANCELLED);

                orderRepository.save(orders);

                ///URL khi payment thất bại
                url = "http://localhost:8181/hsf/payment/failed";
            } catch (Exception e) {
            }
        }

        return url;
    }

    private int extractOrderId(String orderInfo) throws Exception {
        try {
            // Giả sử orderInfo có format: "Payment for Booking #123"
            String[] parts = orderInfo.split("#");
            return Integer.parseInt(parts[1].trim());
        } catch (Exception e) {
            log.error("Error extracting booking ID from orderInfo: {}", orderInfo);
            throw new Exception("VNPAY_INVALID_ORDER_INFO");
        }
    }

    private Map<String, String> processIPNResult(Map<String, String> response) {
        String responseCode = response.get("vnp_ResponseCode");
        String transactionStatus = response.get("vnp_TransactionStatus");
        String transactionRef = response.get("vnp_TxnRef");

        if (!response.containsKey("vnp_Amount")) {
            return createIPNResponse("99", "Missing Amount");
        }

        long amount = Long.parseLong(response.get("vnp_Amount")) / 100;

        log.info("IPN Notification - TxnRef: {}, Amount: {}, Status: {}",
                transactionRef, amount, transactionStatus);

        if ("00".equals(responseCode) && "00".equals(transactionStatus)) {
            // TODO: Cập nhật trạng thái đơn hàng
            // orderService.updateOrderStatus(transactionRef, "PAID");
            return createIPNResponse("00", "Confirm Success");
        }

        log.warn("IPN notification failed - ResponseCode: {}, TransactionStatus: {}",
                responseCode, transactionStatus);
        return createIPNResponse("99", "Transaction Failed");
    }

    private String generateTxnRef() {
        return String.format("%s%d", vnPayConfig.getTmnCode(), System.currentTimeMillis());
    }

    private Map<String, String> createIPNResponse(@NonNull String rspCode, @NonNull String message) {
        Assert.hasText(rspCode, "Response code cannot be empty");
        Assert.hasText(message, "Message cannot be empty");

        return Map.of(
                "RspCode", rspCode,
                "Message", message
        );
    }

    private String getResponseMessage(String responseCode) {
        return switch (responseCode) {
            case "00" -> "Giao dịch thành công";
            case "07" -> "Trừ tiền thành công. Giao dịch bị nghi ngờ (liên quan tới lừa đảo, giao dịch bất thường)";
            case "09" -> "Giao dịch không thành công do: Thẻ/Tài khoản của khách hàng chưa đăng ký dịch vụ InternetBanking tại ngân hàng";
            case "10" -> "Giao dịch không thành công do: Khách hàng xác thực thông tin thẻ/tài khoản không đúng quá 3 lần";
            case "11" -> "Giao dịch không thành công do: Đã hết hạn chờ thanh toán";
            case "12" -> "Giao dịch không thành công do: Thẻ/Tài khoản của khách hàng bị khóa";
            case "13" -> "Giao dịch không thành công do Quý khách nhập sai mật khẩu xác thực giao dịch (OTP)";
            case "24" -> "Giao dịch không thành công do: Khách hàng hủy giao dịch";
            case "51" -> "Giao dịch không thành công do: Tài khoản của quý khách không đủ số dư để thực hiện giao dịch";
            case "65" -> "Giao dịch không thành công do: Tài khoản của Quý khách đã vượt quá hạn mức giao dịch trong ngày";
            case "75" -> "Ngân hàng thanh toán đang bảo trì";
            case "79" -> "Giao dịch không thành công do: KH nhập sai mật khẩu thanh toán quá số lần quy định";
            case "99" -> "Các lỗi khác";
            default -> "Giao dịch thất bại";
        };
    }
}
