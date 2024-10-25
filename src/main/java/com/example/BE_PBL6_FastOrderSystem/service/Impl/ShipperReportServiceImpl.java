package com.example.BE_PBL6_FastOrderSystem.service.Impl;

import com.example.BE_PBL6_FastOrderSystem.entity.ShipperOrder;
import com.example.BE_PBL6_FastOrderSystem.repository.ShipperOrderRepository;
import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import com.example.BE_PBL6_FastOrderSystem.response.ShipperReportResponse;
import com.example.BE_PBL6_FastOrderSystem.service.IShipperReportService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ShipperReportServiceImpl implements IShipperReportService {
    final ShipperOrderRepository shipperOrderRepository;


    @Override
    public ResponseEntity<APIRespone> getAllShipperReport(Long shipperId) {
        String status = "Đã giao hàng";
        List<ShipperOrder> shipperOrders = shipperOrderRepository.findAllByShipperIdAndStatus(shipperId, status);
        if (shipperOrders.isEmpty()) {
            return ResponseEntity.ok(new APIRespone(false, "No shipper report found", null));
        }
        List<ShipperReportResponse> shipperReportResponses = shipperOrders.stream()
                .map(shipperOrder -> new ShipperReportResponse(
                        shipperOrder.getId(),
                        shipperOrder.getShipper().getId(),
                        shipperOrder.getShipper().getFullName(),
                        shipperOrder.getStatus() != null ? shipperOrder.getStatus().getStatusName() : "Unknown",
                        shipperOrder.getReceivedAt(),
                        shipperOrder.getDeliveredAt(),
                        shipperOrder.getOrderDetails().get(0).getOrder().getShippingFee(),
                        shipperOrder.getStore().getStoreName()
                ))
                .toList();
        return ResponseEntity.ok(new APIRespone(true, "Get all shipper report successfully", shipperReportResponses));
    }
}
