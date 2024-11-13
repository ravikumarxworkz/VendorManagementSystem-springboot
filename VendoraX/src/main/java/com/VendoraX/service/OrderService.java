package com.VendoraX.service;

import org.springframework.web.multipart.MultipartFile;

import com.VendoraX.dto.OrderDTO;
import com.VendoraX.response.OrderResponse;

public interface OrderService {

	OrderDTO getOrderById(int orderId);

	OrderResponse getAllOrdersByVendorId(int vendorId, int page, int size, String query);

	OrderResponse getAllOrderHistoryByVendorId(int vendorId, int page, int size, String query);

	OrderResponse getAllOrdersByAdmin(int page, int size, String query);

	OrderResponse getAllOrderStatusByAdmin(int page, int size, String query);

	OrderResponse getAllOrderHistoryByAdmin(int page, int size, String query);

	boolean saveOrder(OrderDTO orderDTO);

	boolean updateOrder(OrderDTO orderDTO) throws Exception;

	boolean cancelOrderByAdmin(int orderId);

	boolean updateOrderStatus(int orderId, String orderStatus, MultipartFile file);

	boolean updateOrderStatusByAdmin(int orderId, String orderStatus, String paymentStatus, MultipartFile file);
}