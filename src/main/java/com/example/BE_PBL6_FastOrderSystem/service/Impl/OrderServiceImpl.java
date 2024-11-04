package com.example.BE_PBL6_FastOrderSystem.service.Impl;

import com.example.BE_PBL6_FastOrderSystem.entity.*;
import com.example.BE_PBL6_FastOrderSystem.repository.*;
import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import com.example.BE_PBL6_FastOrderSystem.response.OrderResponse;
import com.example.BE_PBL6_FastOrderSystem.response.UserResponse;
import com.example.BE_PBL6_FastOrderSystem.service.IOrderService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements IOrderService {
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final CartItemRepository cartItemRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final StoreRepository storeRepository;
    private final PaymentMethodRepository paymentMethodRepository;
    private final ComboRepository comboRepository;
    private final ProductStoreRepository productStoreRepository;
    private final SizeRepository sizeRepository;
    private final StatusOrderRepository statusOrderRepository;
    private final ShippingFeeRepository shippingFeeRepository;
    private final ShipperRepository shipperRepository;
    private final VoucherRepository discountCodeRepository;
    private  final AnnounceRepository announceRepository;
    private final UserVoucherRepository userVoucherRepository;

    public String generateUniqueOrderCode() {
        Random random = new Random();
        String orderCode;
        do {
            orderCode = String.format("%06d", random.nextInt(900000) + 100000);
        } while (orderRepository.existsByOrderCode(orderCode));
        return orderCode;
    }
    @Override
    public Double getPriceBasedProductOnSize(Product product, Size size) {
        Double basePrice = (product.getDiscountedPrice() != 0.0) ? product.getDiscountedPrice() : product.getPrice();

        return switch (size.getName()) {
            case "L" -> basePrice + 10000;
            case "XL" -> basePrice + 20000;
            default -> basePrice;
        };
    }
    @Override
    public Double getPriceBasedComboOnSize(Combo combo, Size size) {
        Double basePrice = combo.getComboPrice();
        return switch (size.getName()) {
            case "L" -> basePrice + 10000;
            case "XL" -> basePrice + 20000;
            default -> basePrice;
        };
    }
    @Override
    public ResponseEntity<APIRespone> findNearestShipper(Double latitude, Double longitude, int limit) {
        List<User> nearestShippers = shipperRepository.findNearestShippers(latitude, longitude, limit);
        if (nearestShippers.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "No shippers found nearby", ""));
        }
        List<UserResponse> userResponses = nearestShippers.stream()
                .map(UserResponse::new)
                .collect(Collectors.toList());
        return ResponseEntity.ok(new APIRespone(true, "Success", userResponses));
    }

    @Transactional
    @Override
    public ResponseEntity<APIRespone> processOrder(Long userId, String paymentMethod, List<Long> cartIds, String deliveryAddress, Double longitude, Double latitude, String orderCode, String discountCode) {
        List<Cart> cartItems = cartIds.stream()
                .flatMap(cartId -> cartItemRepository.findByCartId(cartId).stream())
                .filter(cartItem -> cartItem.getUser().getId().equals(userId))
                .collect(Collectors.toList());

        if (cartItems.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Carts are empty", ""));
        }

        if (cartItems.stream().anyMatch(cartItem -> !cartItem.getUser().getId().equals(userId))) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Carts does not belong to the specified user!", ""));
        }

        List<Store> stores = cartItems.stream()
                .map(Cart::getStoreId)
                .map(storeRepository::findById)
                .filter(Optional::isPresent)
                .map(Optional::get)
                .toList();

        if (stores.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "No stores found in the cart", ""));
        }
        PaymentMethod paymentMethodEntity = paymentMethodRepository.findByName(paymentMethod);
        if (paymentMethodEntity == null) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Payment method not found", ""));
        }
        Optional<User> userOptional = userRepository.findById(userId);
        if (userOptional.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "User not found", ""));
        }
        User user = userOptional.get();
        Order order = new Order();
        order.setOrderDate(LocalDateTime.now());
        StatusOrder statusOrder = statusOrderRepository.findByStatusName("Đơn hàng mới");
        System.out.println(statusOrder);
        order.setStatus(statusOrder);
        order.setOrderCode(orderCode);
        order.setCreatedAt(LocalDateTime.now());
        order.setUpdatedAt(LocalDateTime.now());
        order.setUser(user);
        order.setFeedBack(false);
        //order.setCarts(cartItems);
        order.setDeliveryAddress(deliveryAddress);
        if (deliveryAddress.equalsIgnoreCase("Mua tại cửa hàng")) {
            order.setDeliveryAddress("Mua tại cửa hàng");
        } else {
            order.setDeliveryAddress(deliveryAddress);
            order.setLongitude(longitude);
            order.setLatitude(latitude);
        }

        List<OrderDetail> orderDetails = cartItems.stream().map(cartItem -> {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrder(order);
            if (cartItem.getProduct() != null) {
                orderDetail.setProduct(cartItem.getProduct());
            } else if (cartItem.getCombo() != null) {
                orderDetail.setCombo(cartItem.getCombo());
            }
            orderDetail.setQuantity(Integer.valueOf(cartItem.getQuantity()));
            orderDetail.setUnitPrice(Double.valueOf(cartItem.getUnitPrice()));
            orderDetail.setTotalPrice(Double.valueOf(cartItem.getTotalPrice()));
            orderDetail.setSize(cartItem.getSize());
            Store store = storeRepository.findById(cartItem.getStoreId()).orElseThrow(() -> new EntityNotFoundException("Store not found"));
            orderDetail.setStore(store);
            orderDetail.setStatus(statusOrder);
            // lay ra danh sach cac san pham uong kem tu cart
            if (cartItem.getDrinkProducts() != null) {
                List<Product> drinkProducts = new ArrayList<>(cartItem.getDrinkProducts());
                orderDetail.setDrinkProducts(drinkProducts);
            }
            return orderDetail;
        }).collect(Collectors.toList());
        // Calculate total amount
        Long totalAmount = calculateOrderAmount(cartIds, latitude, longitude, discountCode);
        order.setTotalAmount(Double.valueOf(totalAmount));
        // Nhóm các order detail theo cửa hàng
        if (!deliveryAddress.equalsIgnoreCase("Mua tại cửa hàng")) {
            // Group OrderDetail objects by their store
            Map<Store, List<OrderDetail>> groupedOrderDetails = orderDetails.stream()
                    .collect(Collectors.groupingBy(OrderDetail::getStore));
            for (Map.Entry<Store, List<OrderDetail>> entry : groupedOrderDetails.entrySet()) {
                Store store = entry.getKey();
                List<OrderDetail> storeOrderDetails = entry.getValue();
                // Calculate the shipping fee for the store
                Double shippingFee = calculateShippingFee(order, store);
                // Assign the shipping fee to each OrderDetail in the group
                ShippingFee fee = new ShippingFee();
                fee.setFee(shippingFee);
                shippingFeeRepository.save(fee);
                for (OrderDetail orderDetail : storeOrderDetails) {
                    orderDetail.setShippingFee(fee);
                }
            }
        }
        order.setOrderDetails(orderDetails);
        orderRepository.save(order);
        if (discountCode != null) {
            UserVoucher userVoucher = userVoucherRepository.findByCode(discountCode);
            if (userVoucher != null) {
                userVoucher.setIsUsed(true);
                userVoucherRepository.save(userVoucher);
            }
        }
        AnnounceUser announceUser  = new AnnounceUser(userId,"Thông báo đơn hàng ","Bạn đặt hàng "+orderCode +" thành công . Tổng giá trị " + totalAmount);
        announceRepository.save(announceUser);
        return ResponseEntity.ok(new APIRespone(true, "Order placed successfully", ""));
    }


    @Transactional
    @Override
    public ResponseEntity<APIRespone> processOrderNow(Long userId, String paymentMethod, Long productId, Long comboId, List<Long> drinkId, Long storeId, Integer quantity, String size, String deliveryAddress, Double longitude, Double latitude,String orderCode, String discountCode) {
        Product product = null;
        Combo combo = null;

        if (productId != null) {
            Optional<Product> productOptional = productRepository.findByProductId(productId);
            if (productOptional.isEmpty()) {
                return ResponseEntity.badRequest().body(new APIRespone(false, "Product not found", ""));
            }
            product = productOptional.get();
        }

        if (comboId != null) {
            Optional<Combo> comboOptional = comboRepository.findById(comboId);
            if (comboOptional.isEmpty()) {
                return ResponseEntity.badRequest().body(new APIRespone(false, "Combo not found", ""));
            }
            combo = comboOptional.get();
        }

        if (product == null && combo == null) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Neither product nor combo found", ""));
        }

        Optional<Store> storeOptional = storeRepository.findById(storeId);
        if (storeOptional.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Store not found", ""));
        }

        PaymentMethod paymentMethodEntity = paymentMethodRepository.findByName(paymentMethod);
        if (paymentMethodEntity == null) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Payment method not found", ""));
        }

        Optional<User> userOptional = userRepository.findById(userId);
        if (userOptional.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "User not found", ""));
        }
        User user = userOptional.get();
        Order order = new Order();
        order.setOrderDate(LocalDateTime.now());
        StatusOrder statusOrder = statusOrderRepository.findByStatusName("Đơn hàng mới");
        order.setStatus(statusOrder);
        order.setOrderCode(orderCode);
        order.setCreatedAt(LocalDateTime.now());
        order.setUpdatedAt(LocalDateTime.now());
        order.setUser(user);
        order.setFeedBack(false);
        order.setDeliveryAddress(deliveryAddress);
        if (deliveryAddress.equalsIgnoreCase("Mua tại cửa hàng")) {
            order.setDeliveryAddress("Mua tại cửa hàng");
        } else {
            order.setDeliveryAddress(deliveryAddress);
            order.setLongitude(longitude);
            order.setLatitude(latitude);
        }
        Size s = sizeRepository.findByName(size);
        OrderDetail orderDetail = new OrderDetail();
        orderDetail.setOrder(order);
        orderDetail.setProduct(product);
        orderDetail.setCombo(combo);
        orderDetail.setQuantity(quantity);

        if (product != null) {
          Double unitPrice = getPriceBasedProductOnSize(product, s);
            orderDetail.setUnitPrice(unitPrice);
            orderDetail.setTotalPrice(unitPrice * quantity);
        } else {
            Double unitPrice = getPriceBasedComboOnSize(combo, s);
            orderDetail.setUnitPrice(unitPrice);
            orderDetail.setTotalPrice(unitPrice * quantity);
        }
        // Thiết lập thông tin nước uống nếu có
        if (drinkId != null && !drinkId.isEmpty()) {
            List<Product> drinkProducts = new ArrayList<>();
            for (int i = 0; i < drinkId.size(); i++) {
                Optional<Product> drinkProductOptional = productRepository.findByProductId(drinkId.get(i));
                if (drinkProductOptional.isEmpty()) {
                    return ResponseEntity.badRequest().body(new APIRespone(false, "Drink product not found", ""));
                }
                drinkProducts.add(drinkProductOptional.get());

            }
            orderDetail.setDrinkProducts(drinkProducts);
        }
        orderDetail.setSize(s);
        orderDetail.setStore(storeOptional.get());
        orderDetail.setStatus(statusOrder);
        List<OrderDetail> orderDetails = new ArrayList<>();
        orderDetails.add(orderDetail);
        // Calculate total amount
        Long totalAmount = calculateOrderNowAmount(productId, comboId, quantity, storeId, latitude, longitude, discountCode, size);
        if (totalAmount == null) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Failed to calculate total amount", ""));
        }

        order.setTotalAmount(Double.valueOf(totalAmount));
        order.setOrderDetails(orderDetails);
        // Nhóm các order detail theo cửa hàng
        if (!deliveryAddress.equalsIgnoreCase("Mua tại cửa hàng")) {
            // Group OrderDetail objects by their store
            Map<Store, List<OrderDetail>> groupedOrderDetails = orderDetails.stream()
                    .collect(Collectors.groupingBy(OrderDetail::getStore));
            for (Map.Entry<Store, List<OrderDetail>> entry : groupedOrderDetails.entrySet()) {
                Store store = entry.getKey();
                List<OrderDetail> storeOrderDetails = entry.getValue();
                // Calculate the shipping fee for the store
                Double shippingFee = calculateShippingFee(order, store);
                // Assign the shipping fee to each OrderDetail in the group
                ShippingFee fee = new ShippingFee();
                fee.setFee(shippingFee);
                shippingFeeRepository.save(fee);
                for (OrderDetail orderDetail1 : storeOrderDetails) {
                    orderDetail1.setShippingFee(fee);
                }
            }
        }
        order.setOrderDetails(orderDetails);
        orderRepository.save(order);
        if (discountCode != null) {
            UserVoucher userVoucher = userVoucherRepository.findByCode(discountCode);
            if (userVoucher != null) {
                userVoucher.setIsUsed(true);
                userVoucherRepository.save(userVoucher);
            }

        }
        AnnounceUser announceUser  = new AnnounceUser(userId,"Thông báo đơn hàng ","Bạn đặt hàng "+orderCode +" thành công . Tổng giá trị " + totalAmount);
        announceRepository.save(announceUser);
        return ResponseEntity.ok(new APIRespone(true, "Order placed successfully", ""));
    }
    @Override
    public Double calculateShippingFee(Order order, Store store) {
        double storeLatitude = store.getLatitude();
        double storeLongitude = store.getLongitude();
        double deliveryLatitude = order.getLatitude();
        double deliveryLongitude = order.getLongitude();
        final int EARTH_RADIUS = 6371;
        double latDistance = Math.toRadians(deliveryLatitude - storeLatitude);
        double lonDistance = Math.toRadians(deliveryLongitude - storeLongitude);
        double a = Math.sin(latDistance / 2) * Math.sin(latDistance / 2)
                + Math.cos(Math.toRadians(storeLatitude)) * Math.cos(Math.toRadians(deliveryLatitude))
                * Math.sin(lonDistance / 2) * Math.sin(lonDistance / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        double distance = EARTH_RADIUS * c;
        double shippingFeePerKm = 10000;
        if (distance <= 1.1) {
            return 0.0;
        }
        double shippingFee = distance * shippingFeePerKm;
        return Math.floor(shippingFee / 1000) * 1000;
    }

    @Override
    public Long calculateOrderNowAmount(Long productId, Long comboId, int quantity, Long storeId, Double latitude, Double longitude, String discountCode, String size) {
        long totalAmount = 0;
        // Tính tổng số tiền từ sản phẩm
        if (productId != null) {
            Optional<Product> productOptional = productRepository.findByProductId(productId);
            if (productOptional.isEmpty()) {
                return null;
            }
            Product product = productOptional.get();
            Size s = sizeRepository.findByName(size);
            Double unitPrice = getPriceBasedProductOnSize(product, s);
            totalAmount += Math.round(unitPrice * quantity);
        }

        // Tính tổng số tiền từ combo
        if (comboId != null) {
            Optional<Combo> comboOptional = comboRepository.findById(comboId);
            if (comboOptional.isEmpty()) {
                return null;
            }
            Combo combo = comboOptional.get();
            Size s = sizeRepository.findByName(size);
            Double unitPrice = getPriceBasedComboOnSize(combo, s);
            totalAmount += Math.round(unitPrice * quantity);
        }

        // Kiểm tra mã giảm giá
        if (discountCode != null) {
            LocalDateTime now = LocalDateTime.now();
            List<Voucher> voucherOptional = discountCodeRepository.findByStartDateBeforeAndEndDateAfter(now);
            if (voucherOptional.isEmpty()) {
                return null;
            }
            Voucher voucher1 = voucherOptional.get(0);
            totalAmount -= Math.round(totalAmount * voucher1.getDiscountPercent() / 100);
            Voucher voucher = discountCodeRepository.findByCode(discountCode).orElseThrow();
            totalAmount -= Math.round(totalAmount * voucher.getDiscountPercent() / 100);
        }

        // Tính phí giao hàng
        Optional<Store> storeOptional = storeRepository.findById(storeId);
        if (storeOptional.isPresent()) {
            Store store = storeOptional.get();
            Order dummyOrder = new Order();
            dummyOrder.setLatitude(latitude);
            dummyOrder.setLongitude(longitude);

            Double shippingFee = calculateShippingFee(dummyOrder, store);
            totalAmount += Math.round(shippingFee);
        } else {
            return null;
        }
        return totalAmount;
    }
@Override
public Long calculateOrderAmount(List<Long> cartIds, Double latitude, Double longitude, String discountCode) {
    List<Cart> cartItems = cartIds.stream()
            .flatMap(cartId -> getCartItemsByCartId(cartId).stream())
            .toList();

    long totalAmount = 0;
    for (Cart item : cartItems) {
        totalAmount += Math.round(item.getTotalPrice());
    }
    
    // Kiểm tra mã giảm giá
    if (discountCode != null) {

        LocalDateTime now = LocalDateTime.now();
        List<Voucher> voucherOptional = discountCodeRepository.findByStartDateBeforeAndEndDateAfter(now);

        if (!voucherOptional.isEmpty()) {
            Voucher voucher1 = voucherOptional.get(0);
            totalAmount -= Math.round(totalAmount * voucher1.getDiscountPercent() / 100);
        } else {
            System.out.println("Discount code not found or expired");
        }

        Voucher voucher = discountCodeRepository.findByCode(discountCode).orElseThrow();
        totalAmount -= Math.round(totalAmount * voucher.getDiscountPercent() / 100);
    }

    // Group cart items by store
    Map<Long, List<Cart>> itemsByStore = cartItems.stream()
            .collect(Collectors.groupingBy(Cart::getStoreId));

    // Calculate shipping fee for each store
    double totalShippingFee = 0;
    for (Map.Entry<Long, List<Cart>> entry : itemsByStore.entrySet()) {
        Long storeId = entry.getKey();
        Optional<Store> storeOptional = storeRepository.findById(storeId);
        if (storeOptional.isPresent()) {
            Store store = storeOptional.get();
            Order dummyOrder = new Order();
            dummyOrder.setLatitude(latitude);
            dummyOrder.setLongitude(longitude);
            Double shippingFee = calculateShippingFee(dummyOrder, store);
            totalShippingFee += Math.round(shippingFee);
        } else {
            System.out.println("Store not found for storeId: " + storeId);
            return 0L;
        }
    }

    totalAmount += totalShippingFee;

    System.out.println("Total amount sau khi tính toán: " + totalAmount);
    return totalAmount;
}


    @Transactional
    @Override
    public ResponseEntity<APIRespone> updateQuantityProduct(Long productId, Long comboId, Long storeId, int quantity) {
        if (productId != null) {
            Optional<ProductStore> productStoreOptional = productStoreRepository.findByProductIdAndStoreId(productId, storeId);
            if (productStoreOptional.isEmpty()) {
                return ResponseEntity.badRequest().body(new APIRespone(false, "Product not found", ""));
            }
            ProductStore productStore = productStoreOptional.get();
            if (productStore.getStockQuantity() < quantity) {
                return ResponseEntity.badRequest().body(new APIRespone(false, "Product not enough", ""));
            }
            if (productStore.getStockQuantity() == 0) {
                return ResponseEntity.badRequest().body(new APIRespone(false, "Product out of stock", ""));
            }
            productStore.setStockQuantity(productStore.getStockQuantity() - quantity);
            productStoreRepository.save(productStore);
            return ResponseEntity.ok(new APIRespone(true, "Product quantity updated successfully", ""));

        }
        if (comboId != null) {
            Optional<Combo> comboOptional = comboRepository.findById(comboId);
            if (comboOptional.isEmpty()) {
                return ResponseEntity.badRequest().body(new APIRespone(false, "Combo not found", ""));
            }
            Combo combo = comboOptional.get();
            List<ProductStore> productStores = combo.getProducts().stream()
                    .map(product -> productStoreRepository.findByProductIdAndStoreId(product.getProductId(), storeId))
                    .filter(Optional::isPresent)
                    .map(Optional::get)
                    .collect(Collectors.toList());
            if (productStores.isEmpty()) {
                return ResponseEntity.badRequest().body(new APIRespone(false, "Product not found", ""));
            }
            if (productStores.stream().anyMatch(productStore -> productStore.getStockQuantity() < quantity)) {
                return ResponseEntity.badRequest().body(new APIRespone(false, "Product not enough", ""));
            }
            if (productStores.stream().anyMatch(productStore -> productStore.getStockQuantity() == 0)) {
                return ResponseEntity.badRequest().body(new APIRespone(false, "Product out of stock", ""));
            }
            productStores.forEach(productStore -> productStore.setStockQuantity(productStore.getStockQuantity() - quantity));
            productStoreRepository.saveAll(productStores);
            return ResponseEntity.ok(new APIRespone(true, "Product quantity updated successfully", ""));
        }
        return ResponseEntity.badRequest().body(new APIRespone(false, "Neither product nor combo found", ""));
    }
    @Transactional
    @Override
    public ResponseEntity<APIRespone> updateOrderStatus(String orderCode,String status) {
        Optional<Order> orderOptional = orderRepository.findByOrderCode(orderCode);
        if (orderOptional.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Order code not found", ""));
        }
        StatusOrder statusOrder = statusOrderRepository.findByStatusName(status);
        if (statusOrder == null) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Status not found", ""));
        }
        Order order = orderOptional.get();
        order.setStatus(statusOrder);
        orderRepository.save(order);
        return ResponseEntity.ok(new APIRespone(true, "Order status updated successfully",""));
    }
    @Override
    public ResponseEntity<APIRespone> updateOrderDetailStatus(String orderCode, Long storeId, String status) {
        Optional<Order> orderOptional = orderRepository.findByOrderCode(orderCode);
        if (orderOptional.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Order code not found", ""));
        }
        Order order = orderOptional.get();
        List<OrderDetail> orderDetails = orderDetailRepository.findByOrder_OrderCode_AndStoreId(orderCode, storeId);
        if (orderDetails.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Order detail not found", ""));
        }
        StatusOrder statusOrder = statusOrderRepository.findByStatusName(status);
        if (statusOrder == null) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Status not found", ""));
        }
        orderDetails.forEach(orderDetail -> orderDetail.setStatus(statusOrder));
        orderDetailRepository.saveAll(orderDetails);

        // Check if all order details have the status "Đơn hàng đã hoàn thành"
        StatusOrder completedStatus = statusOrderRepository.findByStatusName("Đơn hàng đã hoàn thành");
        boolean allCompleted = orderDetails.stream()
                .allMatch(orderDetail -> orderDetail.getStatus().equals(completedStatus));

        if (allCompleted) {
            order.setStatus(completedStatus);
            orderRepository.save(order);
        }

        return ResponseEntity.ok(new APIRespone(true, "Order detail status updated successfully", ""));

    }

    @Override
    public ResponseEntity<APIRespone> getAllOrderDetailOfStore(Long ownerId) {
        List<Order> orders = orderRepository.findAll();
        if (orders.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "No order found", ""));
        }
        List<Store> stores = storeRepository.findAllByManagerId(ownerId);
        if (stores.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Store not found", ""));
        }

        // Kiểm tra xem có đơn hàng nào có chi tiết hợp lệ không
        List<Order> orders1 = orders.stream()
                .filter(order -> {
                    if (order.getOrderDetails() != null && !order.getOrderDetails().isEmpty()) {
                        return order.getOrderDetails().stream()
                                .anyMatch(orderDetail -> orderDetail.getStore() != null && stores.contains(orderDetail.getStore()));
                    }
                    // Không in ra order nếu không có OrderDetail
                    return false;
                })
                .toList();

        if (orders1.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "No order found", ""));
        }

        // Chuyển đổi các đơn hàng thành OrderResponse
        List<OrderResponse> orderResponses = orders1.stream()
                .map(OrderResponse::new)
                .collect(Collectors.toList());

        return ResponseEntity.ok(new APIRespone(true, "Success", orderResponses));
    }

    @Override
    public ResponseEntity<APIRespone> getOrderDetailOfStore(Long ownerId, String orderCode) {
        Optional<Order> orderOptional = orderRepository.findByOrderCode(orderCode);
        if (orderOptional.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Order code not found", ""));
        }
        Order order = orderOptional.get();
        List<Store> stores = storeRepository.findAllByManagerId(ownerId);
        if (stores.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Store not found", ""));
        }
        if (order.getOrderDetails().stream().noneMatch(orderDetail -> stores.contains(orderDetail.getStore()))) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Order does not belong to the specified store", ""));
        }
        return ResponseEntity.ok(new APIRespone(true, "Success", new OrderResponse(order)));
    }


@Override
public ResponseEntity<APIRespone> cancelOrder(String orderCode, Long userId) {
    Optional<Order> orderOptional = orderRepository.findByOrderCode(orderCode);
    if (orderOptional.isEmpty()) {
        return ResponseEntity.badRequest().body(new APIRespone(false, "Order not found", ""));
    }
    Order order = orderOptional.get();
    if (!order.getUser().getId().equals(userId)) {
        return ResponseEntity.badRequest().body(new APIRespone(false, "Order does not belong to the specified user", ""));
    }
    if (order.getStatus().equals("Đơn hàng đã được xác nhận")) {
        return ResponseEntity.badRequest().body(new APIRespone(false, "Order cannot be canceled", ""));
    }
    order.setStatus(statusOrderRepository.findByStatusName("Đơn hàng đã bị hủy"));
    orderRepository.save(order);

    // Retrieve and update the cart status
//    List<Cart> carts = cartItemRepository.findByOrderId(order.getOrderId());
//    for (Cart cart : carts) {
//        cart.setStatus("Đã bị hủy");
//        cartItemRepository.save(cart);
//    }

    return ResponseEntity.ok(new APIRespone(true, "Order and associated cart canceled successfully", ""));
}

    @Override
    public ResponseEntity<APIRespone> getOrdersByStatusAndUserId(String statusName, Long userId) {
        StatusOrder statusOrder = statusOrderRepository.findByStatusName(statusName);
        if (statusOrder == null) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Status not found", ""));
        }
        List<Order> orders = orderRepository.findAllByStatusAndUserId(statusOrder, userId);
        if (orders.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "No orders found for the specified status and user", ""));
        }
        List<OrderResponse> orderResponses = orders.stream()
                .map(OrderResponse::new)
                .collect(Collectors.toList());
        return ResponseEntity.ok(new APIRespone(true, "Success", orderResponses));
    }
    @Override
    public ResponseEntity<APIRespone> findOrderByOrderCodeAndUserId(String orderCode, Long userId) {
        Optional<Order> orderOptional = orderRepository.findByOrderCode(orderCode);
        if (orderOptional.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Order not found", ""));
        }
        Order order = orderOptional.get();
        if (!order.getUser().getId().equals(userId)) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Order does not belong to the specified user", ""));
        }
        return ResponseEntity.ok(new APIRespone(true, "Success", new OrderResponse(order)));
    }

    @Override
    public ResponseEntity<APIRespone> getOrderByStatus(Long ownerId, String status) {
        StatusOrder statusOrder = statusOrderRepository.findByStatusName(status);
        if (statusOrder == null) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Status not found", ""));
        }
        List<Order> orders = orderRepository.findAllByStatus(statusOrder);
        if (orders.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "No order found", ""));
        }
        List<Store> stores = storeRepository.findAllByManagerId(ownerId);
        if (stores.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Store not found", ""));
        }
        List<Order> orders1 = orders.stream()
                .filter(order -> order.getOrderDetails().stream().anyMatch(orderDetail -> stores.contains(orderDetail.getStore())))
                .toList();
        if (orders1.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "No order found", ""));
        }
        List<OrderResponse> orderResponses = orders1.stream()
                .map(OrderResponse::new)
                .collect(Collectors.toList());
        return ResponseEntity.ok(new APIRespone(true, "Success", orderResponses));
    }


    @Override
    public List<Cart> getCartItemsByCartId(Long cartId) {
        return cartItemRepository.findByCartId(cartId);
    }
    @Transactional
    @Override
    public ResponseEntity<APIRespone> findOrderByOrderCode(String orderCode) {
        Optional<Order> orderOptional = orderRepository.findByOrderCode(orderCode);
        if (orderOptional.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Order not found", ""));
        }
        Order order = orderOptional.get();
        OrderResponse orderResponse = new OrderResponse(order);
        return ResponseEntity.ok(new APIRespone(true, "Success", orderResponse));
    }


    @Override
    public ResponseEntity<APIRespone> getAllOrderDetailsByUser(Long userId) {
        List<Order> orders = orderRepository.findAllByUserId(userId);
        if (orders.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "No order found", ""));
        }
        List<OrderResponse> orderResponses = orders.stream().map(OrderResponse::new).collect(Collectors.toList());
        return ResponseEntity.ok(new APIRespone(true, "Success", orderResponses));
    }

    @Override
    public ResponseEntity<APIRespone> getOrderDetailByUserId(Long userId, String orderCode) {
        Optional<Order> orderOptional = orderRepository.findByOrderCode(orderCode);
        if (orderOptional.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Order code not found", ""));
        }
        Order order = orderOptional.get();
        if (!order.getUser().getId().equals(userId)) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Order does not belong to the specified user", ""));
        }
        if (order.getOrderDetails().stream().noneMatch(orderDetail -> order.getUser().getId().equals(userId))) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Order does not belong to the specified user", ""));
        }
        return ResponseEntity.ok(new APIRespone(true, "Success", new OrderResponse(order)));
    }
    @Override
    public ResponseEntity<APIRespone> updateStatusFeedBack(Long orderid){
        Order order = orderRepository.findById(orderid).get();
        order.setFeedBack(true);
        orderRepository.save(order);
        return ResponseEntity.ok(new APIRespone(true, "Success", ""));
    }
    @Override
    public ResponseEntity<APIRespone> getAllOrderByStatusOfStore(String statusName, Long OwnerId) {
        StatusOrder statusOrder = statusOrderRepository.findByStatusName(statusName);
        List<Store> stores = storeRepository.findAllByManagerId(OwnerId);

        if (stores.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Store not found", ""));
        }
        return ResponseEntity.badRequest().body(new APIRespone(false, "Store not found", ""));

    }
}