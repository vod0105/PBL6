package com.example.BE_PBL6_FastOrderSystem.service.Impl;

import com.example.BE_PBL6_FastOrderSystem.entity.*;
import com.example.BE_PBL6_FastOrderSystem.repository.*;
import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import com.example.BE_PBL6_FastOrderSystem.response.OrderDetailResponse;
import com.example.BE_PBL6_FastOrderSystem.response.ShipperOrderResponse;
import com.example.BE_PBL6_FastOrderSystem.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class ShipperOrderImpl implements IShipperOrderService {
    private final ShipperOrderRepository shipperOrderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final OrderRepository orderRepository;
    private final ShipperRepository shipperRepository;
    private final StatusOrderRepository statusOrderRepository;
    private final StatusDeliveryRepository statusDeliveryRepository;
    private final IStatusDeliveryService statusDeliveryService;
    private final IOrderService orderService;
    private final IAnnouceService annouceService;

    @Override
    public ResponseEntity<APIRespone> getAll() {
        List<ShipperOrder> shipperOrders = shipperOrderRepository.findAll();
        List<ShipperOrderResponse> shipperOrderResponses = shipperOrders.stream()
                .map(ShipperOrderResponse::new)
                .collect(Collectors.toList());
        return ResponseEntity.ok(new APIRespone(true, "Success", shipperOrderResponses));
    }
    @Override
    public ResponseEntity<APIRespone> getAllOrderDetailOfShipper(Long shipperId) {
        List<ShipperOrder> shipperOrders = shipperOrderRepository.findAllByShipperId(shipperId);
        List<ShipperOrderResponse> orderDetailResponses = shipperOrders.stream()
                .map(ShipperOrderResponse::new)
                .collect(Collectors.toList());
        return ResponseEntity.ok(new APIRespone(true, "Success", orderDetailResponses));
    }

    @Override
    public ResponseEntity<APIRespone> getShipperOrderbyId(Long shipperId, Long shipperOrderId) {
        List<ShipperOrder> shipperOrders = shipperOrderRepository.findByIdAndShipperId(shipperOrderId, shipperId);
        List<ShipperOrderResponse> orderDetailResponses = shipperOrders.stream()
                .map(ShipperOrderResponse::new)
                .collect(Collectors.toList());
        return ResponseEntity.ok(new APIRespone(true, "Success", orderDetailResponses));
    }

    @Override
    public ResponseEntity<APIRespone> getAllShipperOrderByStatus(Long shipperId, String status) {
        List<ShipperOrder> shipperOrders = shipperOrderRepository.findAllByShipperIdAndStatus(shipperId, status);
        if (shipperOrders.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Orders not found", ""));
        }
        List<ShipperOrderResponse> orderDetailResponses = shipperOrders.stream()
                .map(ShipperOrderResponse::new)
                .collect(Collectors.toList());
        return ResponseEntity.ok(new APIRespone(true, "Success", orderDetailResponses));
    }

    @Override
    public ResponseEntity<APIRespone> updateShipperLocation(Long shipperId, Double newLatitude, Double newLongitude) {
        User shipper = shipperRepository.findById(shipperId).orElse(null);
        if (shipper == null) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "No shipper found with the specified ID", ""));
        }
        shipper.setLatitude(newLatitude);
        shipper.setLongitude(newLongitude);
        shipperRepository.save(shipper);
        return ResponseEntity.ok(new APIRespone(true, "Shipper location updated successfully", ""));
    }

    @Override
    public ResponseEntity<APIRespone> getOrdersSortedByDistance(Long shipperId, int page, int size) {
        User shipper = shipperRepository.findById(shipperId).orElse(null);
        if (shipper == null) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "No shipper found with the specified ID", ""));
        }

        List<OrderDetail> orderDetails = orderDetailRepository.findAllByStatus("Đơn hàng mới");
        if (orderDetails.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "No orders found", ""));
        }
        List<OrderDetailResponse> sortedOrderDetails = orderDetails.stream()
                .sorted(Comparator.comparingDouble(orderDetail -> calculateDistance(
                        shipper.getLatitude(), shipper.getLongitude(),
                        orderDetail.getStore().getLatitude(),
                        orderDetail.getStore().getLongitude())))
                .skip(page * size)
                .limit(size)
                .map(OrderDetailResponse::new)
                .collect(Collectors.toList());

        return ResponseEntity.ok(new APIRespone(true, "Success", sortedOrderDetails));
    }

    private double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        final int R = 6371; // Radius of the earth in km
        double latDistance = Math.toRadians(lat2 - lat1);
        double lonDistance = Math.toRadians(lon2 - lon1);
        double a = Math.sin(latDistance / 2) * Math.sin(latDistance / 2)
                + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                * Math.sin(lonDistance / 2) * Math.sin(lonDistance / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return R * c; // Distance in km
    }
    @Scheduled(fixedRate = 30000) // 30 giây
    public ResponseEntity<APIRespone> autoAssignShipper() {
        List<OrderDetail> orderDetails = orderDetailRepository.findAllByStatus("Đơn hàng đã được xác nhận");
        Map<Store, Map<Long, List<OrderDetail>>> groupedOrderDetails = orderDetails.stream()
                .collect(Collectors.groupingBy(OrderDetail::getStore,
                        Collectors.groupingBy(orderDetail -> orderDetail.getOrder().getOrderId())));

        for (Map.Entry<Store, Map<Long, List<OrderDetail>>> storeGroup : groupedOrderDetails.entrySet()) {
            Store store = storeGroup.getKey();
            Map<Long, List<OrderDetail>> orderIdGroups = storeGroup.getValue();

            for (Map.Entry<Long, List<OrderDetail>> orderGroup : orderIdGroups.entrySet()) {
                List<OrderDetail> storeOrderDetails = orderGroup.getValue();
                Optional<User> newShipperOptional = shipperRepository.findNearestShippers(store.getLatitude(), store.getLongitude(), 1)
                        .stream()
                        .findFirst();
                if (newShipperOptional.isPresent()) {
                    System.out.println("Tìm thấy shipper");
                    User newShipper = newShipperOptional.get();
                    newShipper.setIsActive(false);
                    shipperRepository.save(newShipper);

                    // Create a single ShipperOrder for the store and order group
                    ShipperOrder shipperOrder = new ShipperOrder();
                    shipperOrder.setShipper(newShipper);
                    shipperOrder.setStore(store);
                    shipperOrder.setCreatedAt(LocalDateTime.now());
                    StatusDelivery statusDelivery = statusDeliveryRepository.findByStatusName("Chưa nhận");
                    System.out.println(statusDelivery);
                    shipperOrder.setStatus(statusDelivery);
                    shipperOrderRepository.save(shipperOrder);

                    for (OrderDetail orderDetail : storeOrderDetails) {
                        orderDetail.setShipperOrder(shipperOrder);
                        orderDetailRepository.save(orderDetail);
                        // cập nhật trạng thái của orderDetail
                        StatusOrder statusOrder = statusOrderRepository.findByStatusName("Đơn hàng đã chọn được người giao");
                        orderDetail.setStatus(statusOrder);
                        orderDetailRepository.save(orderDetail);
                    }
                } else {
                    System.out.println("Không tìm thấy shipper");
                    return ResponseEntity.badRequest().body(new APIRespone(false, "Không tìm thấy shipper", ""));
                }
            }
        }
        return ResponseEntity.ok(new APIRespone(true, "Shipper đã được gán", ""));
    }

    @Scheduled(fixedRate = 100000) // 100 giây
    public void autoAssignShipperOrder() {
        List<ShipperOrder> ListShipperOrders = shipperOrderRepository.findAllByStatusIn(List.of("Chưa nhận", "Đã từ chối"));
        for (ShipperOrder shipperOrder : ListShipperOrders) {
            if (shipperOrder.getCreatedAt().plusMinutes(10).isBefore(LocalDateTime.now())) {
                // 10 phút chưa nhận đơn hàng thì tự động gán shipper khác
                User currentShipper = shipperOrder.getShipper();
                if (currentShipper != null) {
                    currentShipper.setIsActive(true);
                    currentShipper.setIsBusy(true);
                    shipperRepository.save(currentShipper);
                }
                Store store = shipperOrder.getStore();
                Optional<User> newShipperOptional = shipperRepository.findNearestShippers(store.getLatitude(), store.getLongitude(), 1)
                        .stream()
                        .findFirst();
                if (newShipperOptional.isPresent()) {
                    // tìm thấy shipper khác
                    User newShipper = newShipperOptional.get();
                    newShipper.setIsActive(false);
                    shipperRepository.save(newShipper);
                    shipperOrder.setShipper(newShipper);
                    shipperOrder.setCreatedAt(LocalDateTime.now());
                    StatusDelivery statusDelivery = statusDeliveryRepository.findByStatusName("Đã nhận lại từ shipper khác nhưng chưa chấp nhận");
                    shipperOrder.setStatus(statusDelivery);
                    shipperOrderRepository.save(shipperOrder);
                }
            }
        }
    }
    @Transactional
    @Override
    public ResponseEntity<APIRespone> approveShipperOrder(Long shipperId, Long shipperOrderId, Boolean isAccepted) {
        ShipperOrder shipperOrder = shipperOrderRepository.findByIdandShipperId(shipperOrderId, shipperId);
        if (shipperOrder == null) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "No orders found for the specified shipper", ""));
        }

        StatusDelivery statusDelivery;
        User shipper = shipperOrder.getShipper();

        if (isAccepted) {
            // Shipper chấp nhận đơn hàng
            statusDelivery = statusDeliveryRepository.findByStatusName("Đã nhận");
            if (statusDelivery == null) {
                return ResponseEntity.badRequest().body(new APIRespone(false, "Status not found", ""));
            }

            shipperOrder.setStatus(statusDelivery);
            shipperOrder.setReceivedAt(LocalDateTime.now());
            shipper.setIsActive(true);
            shipperOrderRepository.save(shipperOrder);
            shipperRepository.save(shipper);

            // Log the status to verify
            System.out.println("Status after accepting: " + shipperOrder.getStatus().getStatusName());

            return ResponseEntity.ok(new APIRespone(true, "Shipper accepted the order", ""));

        } else {
            // Shipper từ chối đơn hàng
            statusDelivery = statusDeliveryRepository.findByStatusName("Đã từ chối");
            if (statusDelivery == null) {
                return ResponseEntity.badRequest().body(new APIRespone(false, "Status not found", ""));
            }

            shipperOrder.setStatus(statusDelivery);
            shipperOrderRepository.save(shipperOrder);

            // Log the status to verify
            System.out.println("Status after rejecting: " + shipperOrder.getStatus().getStatusName());

            // Tìm shipper khác gần nhất
            Store store = shipperOrder.getStore();
            Optional<User> newShipperOptional = shipperRepository.findNearestShippers(store.getLatitude(), store.getLongitude(), 1)
                    .stream()
                    .findFirst();

            if (newShipperOptional.isPresent()) {
                User newShipper = newShipperOptional.get();
                newShipper.setIsActive(false);
                shipperOrder.setShipper(newShipper);
                shipperOrderRepository.save(shipperOrder);
                shipperRepository.save(newShipper);

                return ResponseEntity.ok(new APIRespone(true, "Shipper đã từ chối, hệ thống đã tìm thấy shipper khác", ""));
            } else {
                return ResponseEntity.badRequest().body(new APIRespone(false, "Không tìm thấy shipper khác", ""));
            }
        }
    }

    @Override
    public ResponseEntity<APIRespone> updateStatusOrderDetail(Long shipperId, Long shipperOrderId, Long orderDetailId) {
        ShipperOrder shipperOrder = shipperOrderRepository.findByIdandShipperId(shipperOrderId, shipperId);
        if (shipperOrder == null) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "No orders found for the specified shipper", ""));
        }
        OrderDetail orderDetail = orderDetailRepository.findById(orderDetailId).orElse(null);
        if (orderDetail == null) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "No OrderDetail found with the specified ID", ""));
        }
        if (!orderDetail.getShipperOrder().getShipper().getId().equals(shipperId)) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "The OrderDetail is not being delivered by the specified shipper", ""));
        }
        StatusOrder statusOrder = statusOrderRepository.findByStatusName("Đơn hàng đang giao");
        if (statusOrder != null) {
            orderDetail.setStatus(statusOrder);
        } else {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Status not found", ""));
        }
        orderDetailRepository.save(orderDetail);
        String status = orderDetail.getStatus().getStatusName();
        System.out.println(status);;

        // Cập nhật statusOrder dựa trên status hiện tại
        if (status.equals("Đơn hàng đã được xác nhận")) {
            statusOrder = statusOrderRepository.findByStatusName("Đơn hàng đang giao");
        } else if (status.equals("Đơn hàng đang giao")) {
            statusOrder = statusOrderRepository.findByStatusName("Đơn hàng đã hoàn thành");
        }

        // Kiểm tra nếu không tìm thấy statusOrder mới, trả về lỗi
        if (statusOrder == null) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Status not found", ""));
        }

        // Cập nhật status của orderDetail
        orderDetail.setStatus(statusOrder);

        // Tìm tất cả các OrderDetail có cùng orderId
        List<OrderDetail> orderDetails = orderDetailRepository.findByOrderId(orderDetail.getOrder().getOrderId());

        // Kiểm tra nếu tất cả các orderDetail có cùng status
        boolean isUpdateOrderStatus = true;
        for (OrderDetail item : orderDetails) {
            if (!item.getStatus().getStatusName().equals(statusOrder.getStatusName())) {
                isUpdateOrderStatus = false;
                break;
            }
        }

        // Nếu tất cả các orderDetail có cùng status, cập nhật status của Order
        if (isUpdateOrderStatus) {

            Order order = orderRepository.findById(orderDetail.getOrder().getOrderId()).orElse(null);
            if (order != null) {
                order.setStatus(statusOrder);  // Cập nhật status của Order
                orderRepository.save(order);   // Lưu Order
                annouceService.addnewannounce(order.getUser().getId(), "Thông báo", "Đơn hàng mã số " + order.getOrderCode() + " : " + statusOrder.getStatusName());
            }
        }
        return ResponseEntity.ok(new APIRespone(true, "Order update successfully", ""));
    }

    @Override
    public ResponseEntity<APIRespone> finishDelivery(Long shipperId, Long shipperOrderId, Long orderDetailId) {
        ShipperOrder shipperOrder = shipperOrderRepository.findByIdandShipperId(shipperOrderId, shipperId);
        if (shipperOrder == null) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "No orders found for the specified shipper", ""));
        }
        OrderDetail orderDetail = orderDetailRepository.findById(orderDetailId).orElse(null);
        if (orderDetail == null) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "No OrderDetail found with the specified ID", ""));
        }
        if (!orderDetail.getShipperOrder().getShipper().getId().equals(shipperId)) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "The OrderDetail is not being delivered by the specified shipper", ""));
        }
        StatusOrder statusOrder = statusOrderRepository.findByStatusName("Đơn hàng đã hoàn thành");
        if (statusOrder != null) {
            orderDetail.setStatus(statusOrder);
        } else {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Status not found", ""));
        }

        orderDetailRepository.save(orderDetail);
        // kiểm tra xem tất cả các orderDetail cua shipperOrder khác đã hoàn thành chưa neu tat ca hoan thanh thi cap nhat trang thai cua Order la da hoan thanh
        List<OrderDetail> orderDetails = shipperOrder.getOrderDetails();
        boolean allFinished = orderDetails.stream().allMatch(o -> o.getStatus().getStatusName().equals("Đơn hàng đã hoàn thành"));
        if (allFinished) {
            Order order = orderDetails.get(0).getOrder();
            StatusOrder orderStatus = statusOrderRepository.findByStatusName("Đơn hàng đã hoàn thành");
            order.setStatus(orderStatus);
            orderRepository.save(order);
        }
        StatusDelivery statusDelivery = statusDeliveryRepository.findByStatusName("Đã giao hàng");
        System.out.println(statusDelivery);
        shipperOrder.setStatus(statusDelivery);
        shipperOrder.setDeliveredAt(LocalDateTime.now());
        // cập nhật trạng thái của shipper
        User shipper = shipperOrder.getShipper();
        shipper.setIsActive(true);
        shipperRepository.save(shipper);
        shipperOrderRepository.save(shipperOrder);
        return ResponseEntity.ok(new APIRespone(true, "Order delivered successfully", ""));
    }
@Override
public ResponseEntity<APIRespone> updateBusyStatus(Long shipperId) {
        User shipper = shipperRepository.findById(shipperId).orElse(null);
        if (shipper == null) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "No shipper found with the specified ID", ""));
        }
        shipper.setIsBusy(false);
        shipperRepository.save(shipper);
        return ResponseEntity.ok(new APIRespone(true, "Shipper is not busy", ""));

    }
}
