package com.VendoraX.service.impl;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.VendoraX.dto.OrderDTO;
import com.VendoraX.dto.OrderTrackDTO;
import com.VendoraX.entity.OrderEntity;
import com.VendoraX.entity.OrderTrackEntity;
import com.VendoraX.repository.OrderRepository;
import com.VendoraX.repository.OrderTrackRepository;
import com.VendoraX.service.OrderTrackService;

@Service
public class OrderTrackServiceImpl implements OrderTrackService {

	@Autowired
	private OrderTrackRepository orderTrackRepository;

	@Autowired
	private OrderRepository orderRepository;

	@Override
	public boolean createOrderTrack(OrderTrackDTO orderTrackDTO) {
		try {

			OrderTrackEntity orderTrackEntity = new OrderTrackEntity();

			OrderEntity orderEntity = this.orderRepository.findById(orderTrackDTO.getOrderId())
					.orElseThrow(() -> new RuntimeException("Order not found for ID: " + orderTrackDTO.getOrderId()));

			orderTrackEntity.setOrder(orderEntity);
			orderTrackEntity.setOrderId(orderTrackDTO.getOrderId());
			orderTrackEntity.setUpDateStatus(LocalDate.now());
			orderTrackEntity.setOrderStatus(orderEntity.getOrderStatus());

			// Save the order track entity to the repository
			this.orderTrackRepository.save(orderTrackEntity);

			return true; // Return true if the operation is successful
		} catch (Exception e) {
			// Handle any exception and return false if the operation fails
			e.printStackTrace(); // Log the error message (you can use proper logging instead of printStackTrace)
			return false;
		}
	}

	@Override
	public List<OrderTrackDTO> getOrderTrackingDetails(int orderId) {
	    // Fetch the list of OrderTrackEntity based on the order ID
	    List<OrderTrackEntity> orderTrackEntities = orderTrackRepository.findByOrderId(orderId);

	    // Map OrderTrackEntity to OrderTrackDTO
	    return orderTrackEntities.stream()
	        .map(orderTrackEntity -> {
	            // Create a new OrderTrackDTO instance
	            OrderTrackDTO dto = new OrderTrackDTO();
	            dto.setId(orderTrackEntity.getId());
	            dto.setOrderId(orderTrackEntity.getOrderId());
	            dto.setUpDateStatus(orderTrackEntity.getUpDateStatus());
	            dto.setOrderStatus(orderTrackEntity.getOrderStatus());

	            // Map OrderEntity to OrderDTO
	            OrderDTO orderDTO = mapToOrderDto(orderTrackEntity.getOrder());
	            dto.setOrderDTO(orderDTO);

	            return dto;
	        })
	        .collect(Collectors.toList());
	}

	// Helper method to map OrderEntity to OrderDTO
	public OrderDTO mapToOrderDto(OrderEntity orderEntity) {
	    if (orderEntity == null) {
	        return null; // Handle potential null orderEntity
	    }
	    
	    OrderDTO orderDto = new OrderDTO();
	    System.out.println("mapToOrderDto");
	    System.out.println(orderEntity);

	    // Assuming ProductEntity and VendorEntity are properly set and not null
	    orderDto.setOrderId(orderEntity.getOrderId());
	    orderDto.setProductId(orderEntity.getProduct() != null ? orderEntity.getProduct().getId() : null);
	    orderDto.setVendorId(orderEntity.getVendor() != null ? orderEntity.getVendor().getId() : null);
	    orderDto.setProductName(orderEntity.getProduct() != null ? orderEntity.getProduct().getProductName() : null);
	    orderDto.setProductPrice(orderEntity.getProduct() != null ? orderEntity.getProduct().getProductPrice() : null);
	    orderDto.setDeliveryCharge(orderEntity.getProduct() != null ? orderEntity.getProduct().getDeliveryCharge() : null);
	    orderDto.setDescriptionAboutProduct(orderEntity.getProduct() != null ? orderEntity.getProduct().getDescriptionAboutProduct() : null);
	    orderDto.setOrderQuantity(orderEntity.getOrderQuantity());
	    orderDto.setOrderDate(orderEntity.getOrderDate());
	    orderDto.setDeliveryDate(orderEntity.getDeliveryDate());
	    orderDto.setDeliveryAddress(orderEntity.getDeliveryAddress());
	    orderDto.setMessage(orderEntity.getMessage());
	    orderDto.setOrderStatus(orderEntity.getOrderStatus());
	    orderDto.setOrderAmount(orderEntity.getOrderAmount());
	    orderDto.setPaymentStatus(orderEntity.getPaymentStatus());
	    orderDto.setOrderInvoicePath(orderEntity.getOrderInvoicePath());
	    orderDto.setPaymentInvoicePath(orderEntity.getPaymentInovicePath());

	    return orderDto;
	}

}
