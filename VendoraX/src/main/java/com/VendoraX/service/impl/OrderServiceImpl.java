package com.VendoraX.service.impl;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.VendoraX.dto.NotificationDTO;
import com.VendoraX.dto.OrderDTO;
import com.VendoraX.dto.OrderTrackDTO;
import com.VendoraX.dto.PaymentDTO;
import com.VendoraX.entity.OrderEntity;
import com.VendoraX.entity.ProductEntity;
import com.VendoraX.entity.VendorEntity;
import com.VendoraX.mailSending.MailSending;
import com.VendoraX.repository.OrderRepository;
import com.VendoraX.repository.ProductRepository;
import com.VendoraX.repository.VendorRepo;
import com.VendoraX.response.OrderResponse;
import com.VendoraX.service.NotificationService;
import com.VendoraX.service.OrderService;
import com.VendoraX.service.OrderTrackService;
import com.VendoraX.service.PaymentService;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private VendorRepo vendorRepo;

	@Autowired
	private OrderRepository orderRepository;

	@Autowired
	private ProductRepository productRepository;

	@Autowired
	private PaymentService paymentService;

	@Autowired
	private NotificationService notificationService;

	@Autowired
	private OrderTrackService orderTrackService;

	@Autowired
	MailSending mailSending;

	/*----------------------------------SAVE ADMIN  ORDERED PRODUCT METHOD------------------------------------ */
	@Override
	public boolean saveOrder(OrderDTO orderDTO) {
		ProductEntity productEntity = this.productRepository.findById(orderDTO.getProductId()).orElse(null);
		OrderEntity orderEntity = new OrderEntity();
		BeanUtils.copyProperties(orderDTO, orderEntity);
		orderEntity.setVendor(productEntity.getVendor());
		orderEntity.setProduct(productEntity);
		orderEntity.setProductName(productEntity.getProductName());
		orderEntity.setProductPrice(productEntity.getProductPrice());
		orderEntity.setDescriptionAboutProduct(productEntity.getDescriptionAboutProduct());
		orderEntity.setDeliveryCharge(productEntity.getDeliveryCharge());
		orderEntity.setDeliveryDate(orderDTO.getDeliveryDate());
		orderEntity.setOrderDate(LocalDateTime.now());
		orderEntity.setOrderStatus("Order");

		OrderEntity saveOrder = this.orderRepository.save(orderEntity);
		if (saveOrder != null) {
			NotificationDTO notification = new NotificationDTO();
			notification.setSenderId("admin");
			notification.setReceiverId(String.valueOf(productEntity.getVendor().getId()));
			notification
					.setMessage("You have received a new order for your product: " + productEntity.getProductName());
			notification.setType("ORDER"); // Setting the notification type as 'ORDER'
			notification.setTimestamp(LocalDateTime.now());
			// Save the notification
			this.notificationService.createNotification(notification.getReceiverId(), notification);
			OrderTrackDTO orderTrackDTO = new OrderTrackDTO();
			orderTrackDTO.setOrderId(saveOrder.getOrderId());
			this.orderTrackService.createOrderTrack(orderTrackDTO);
			return true;
		}
		return false;
	}

	@Override
	public boolean updateOrder(OrderDTO orderDTO) throws Exception {
		if (!orderRepository.existsById(orderDTO.getOrderId())) {
			throw new Exception("Order not found.");
		}
		OrderEntity orderEntity = orderRepository.findById(orderDTO.getOrderId()).get();
		orderEntity.setDeliveryDate(orderDTO.getDeliveryDate());
		orderEntity.setOrderQuantity(orderDTO.getOrderQuantity());
		orderEntity.setDeliveryAddress(orderDTO.getDeliveryAddress());
		orderEntity.setMessage(orderDTO.getMessage());
		OrderEntity saveOrder = this.orderRepository.save(orderEntity);
		if (saveOrder != null) {

			return true;
		}
		return false;
	}

	@Override
	public boolean cancelOrderByAdmin(int orderId) {
		OrderEntity entity = this.orderRepository.findById(orderId).orElse(null);
		if (entity == null) {
			return false;
		}
		entity.setOrderStatus("order cancelled");
		entity = this.orderRepository.save(entity);
		OrderTrackDTO orderTrackDTO = new OrderTrackDTO();
		orderTrackDTO.setOrderId(entity.getOrderId());
		this.orderTrackService.createOrderTrack(orderTrackDTO);
		return entity != null;
	}

//================================	NEW CODES START FROM HERE============= //

	@Override
	public OrderResponse getAllOrdersByVendorId(int vendorId, int page, int size, String query) {
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.DESC, "orderDate"));
		Page<OrderEntity> orderPage;
		VendorEntity vendorEntity = this.vendorRepo.findById(vendorId).orElse(null);

		// Define the statuses you want to filter
		List<String> orderStatuses = Arrays.asList("Confirmed", "Order");

		if (query != null && !query.isEmpty()) {
			// Fetch orders with specific statuses and query (filter by product name or
			// other attributes)
			orderPage = this.orderRepository.findByVendorAndOrderStatusInAndProductNameContainingIgnoreCase(
					vendorEntity, orderStatuses, query, pageable);
		} else {
			// Fetch orders with specific statuses without a query
			orderPage = this.orderRepository.findByVendorAndOrderStatusIn(vendorEntity, orderStatuses, pageable);
		}

		// Map to response DTO
		OrderResponse response = new OrderResponse();
		response.setOrders(orderPage.getContent().stream().map(this::mapToOrderDto).collect(Collectors.toList()));
		response.setTotalPages(orderPage.getTotalPages());

		return response;
	}

	@Override
	public OrderDTO getOrderById(int orderId) {
		OrderEntity orderEntity = this.orderRepository.findById(orderId).orElse(null);
		return mapToOrderDto(orderEntity);
	}

	public OrderDTO mapToOrderDto(OrderEntity orderEntity) {
		OrderDTO orderDto = new OrderDTO();

		orderDto.setOrderId(orderEntity.getOrderId());
		orderDto.setProductId(orderEntity.getProduct().getId()); // Assuming you have a `ProductEntity`
		orderDto.setVendorId(orderEntity.getVendor().getId()); // Assuming you have a `VendorEntity`
		orderDto.setProductName(orderEntity.getProduct().getProductName());
		orderDto.setProductPrice(orderEntity.getProduct().getProductPrice());
		orderDto.setDeliveryCharge(orderEntity.getProduct().getDeliveryCharge());
		orderDto.setDescriptionAboutProduct(orderEntity.getProduct().getDescriptionAboutProduct());
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

	@Override
	public boolean updateOrderStatus(int orderId, String orderStatus, MultipartFile file) {
		// Initialize variables for payment status and order amount
		String paymentStatus = "unpaid";
		double orderAmount = 0.0d;

		// Retrieve the order entity by ID
		Optional<OrderEntity> orderOptional = orderRepository.findById(orderId);
		if (!orderOptional.isPresent()) {
			return false; // Return false if the order does not exist
		}

		OrderEntity order = orderOptional.get();

		// Handle cases where the status is "can't_delivered" or "Confirmed"
		if (orderStatus.equalsIgnoreCase("can't_delivered") || orderStatus.equalsIgnoreCase("Confirmed")) {
			order.setOrderStatus(orderStatus);
			order.setPaymentStatus(paymentStatus);
		}
		// Handle the case where the status is "delivered"
		else if (orderStatus.equalsIgnoreCase("delivered")) {
			// Calculate the total order amount (Product Price * Quantity + Delivery Charge)
			orderAmount = order.getProductPrice() * order.getOrderQuantity() + order.getDeliveryCharge();
			order.setOrderAmount(orderAmount);
			order.setOrderStatus(orderStatus);
			order.setPaymentStatus(paymentStatus);

			// Send the order invoice to the admin
//	        boolean orderInvoiceSent = mailSending.sendOrderInvoiceToAdmin(
//	            order.getVendor().getEmailId(), orderStatus, order.getProductName(), file);

			// Check if the file is present and not empty
			if (file != null && !file.isEmpty()) {
				try {
					// Save the file with the order ID and set the order invoice path
					String fileName = saveFileWithOrderId(orderId, file);
					order.setOrderInvoicePath(fileName);
				} catch (IOException e) {
					e.printStackTrace();
					return false; // Return false in case of an exception while saving the file
				}
			}
		} else {
			return false; // Return false if the order status does not match any valid options
		}

		order = orderRepository.save(order);

		// Create a notification for the order status update
		if (order != null) {
			NotificationDTO notification = new NotificationDTO();
			notification.setSenderId(String.valueOf(order.getVendor().getId())); // The sender is the vendor
			notification.setReceiverId("admin"); // The receiver is 'admin'
			notification.setMessage("Order ID: " + orderId + " has been updated to status: " + orderStatus);
			notification.setType("ORDER_STATUS_UPDATE"); // Setting the notification type as 'ORDER_STATUS_UPDATE'
			notification.setTimestamp(LocalDateTime.now());

			// Save the notification
			this.notificationService.createNotification(notification.getReceiverId(), notification);
		}

		OrderTrackDTO orderTrackDTO = new OrderTrackDTO();
		orderTrackDTO.setOrderId(orderId);
		this.orderTrackService.createOrderTrack(orderTrackDTO);

		// Return true if the order was successfully saved
		return order != null;
	}

	private String saveFileWithOrderId(int orderId, MultipartFile file) throws IOException {
		// Get the original file name and append the orderId to make it unique
		String originalFileName = file.getOriginalFilename();
		String fileName = "order_invoice_" + orderId + "_" + originalFileName;

		// Define where to store the file (adjust the path as necessary)
		String filePath = "E:\\OrderInvoiceFiles\\" + fileName;

		// Save the file locally
		Path path = Paths.get(filePath);
		Files.write(path, file.getBytes());

		// Return the file name to store it in the database
		return fileName;
	}

	/*---------------------------------- ADMIN UPDATINNG  ALL ORDER & PAYMENT STATUS AND SEND BILL TO VEDNOR  ------------------------------------ */
	@Override
	public boolean updateOrderStatusByAdmin(int orderId, String orderStatus, String paymentStatus, MultipartFile file) {
		// Retrieve the order entity by ID
		OrderEntity order = orderRepository.findById(orderId).orElse(null);
		if (order == null) {
			return false; // Return false if the order does not exist
		}

		// Check payment status and handle file accordingly
		if ("Paid".equalsIgnoreCase(paymentStatus)) {
			// If payment status is "Paid", the file is compulsory
			if (file == null || file.isEmpty()) {
				return false; // Return false if the file is not provided
			}

			// Try to save the invoice file
			try {
				String fileName = saveOrderPaymentFileWithOrderId(orderId, file);
				order.setPaymentInovicePath(fileName);

				// Create a new Payment entity
				PaymentDTO payment = new PaymentDTO();
				payment.setPaymentInvoicePath(fileName);
				payment.setPaymentStatus(paymentStatus);
				payment.setOrderAmount(order.getOrderAmount());
				payment.setOrderId(orderId);
				payment.setVendorId(order.getVendor().getId());

				// Save the payment details
				boolean save = this.paymentService.createPayment(payment);
				if (!save) {
					return false; // Return false if payment saving fails
				}

			} catch (IOException e) {
				e.printStackTrace();
				return false; // Return false if file saving fails
			}
		} else if ("Unpaid".equalsIgnoreCase(paymentStatus)) {
			// Clear the payment invoice path if the status is "Unpaid"
			order.setPaymentInovicePath(null);
		} else {
			// Handle any other payment statuses if needed
			// Add more conditions here if there are additional statuses
		}

		// Update order status and payment status
		order.setPaymentStatus(paymentStatus);
		order.setOrderStatus(orderStatus);

		// Save the updated order entity
		try {
			orderRepository.save(order);
			NotificationDTO notification = new NotificationDTO();
			notification.setSenderId("admin"); // Admin is the sender
			notification.setReceiverId(String.valueOf(order.getVendor().getId())); // Vendor is the receiver
			notification.setMessage("Your order with ID: " + orderId + " has been updated to status: " + orderStatus
					+ " with payment status: " + paymentStatus);
			notification.setType("ORDER_UPDATE"); // Setting the notification type as 'ORDER_UPDATE'
			notification.setTimestamp(LocalDateTime.now());
			this.notificationService.createNotification(notification.getReceiverId(), notification);
			OrderTrackDTO orderTrackDTO = new OrderTrackDTO();
			orderTrackDTO.setOrderId(orderId);
			this.orderTrackService.createOrderTrack(orderTrackDTO);
		} catch (Exception e) {
			e.printStackTrace();
			return false; // Return false if order saving fails
		}

		return true; // Return true if the entire process is successful
	}

	private String saveOrderPaymentFileWithOrderId(int orderId, MultipartFile file) throws IOException {
		// Get the original file name and append the orderId to make it unique
		String originalFileName = file.getOriginalFilename();
		String fileName = "invoice_" + orderId + "_" + originalFileName;

		// Define where to store the file (adjust the path as necessary)
		String filePath = "E:\\OrderInvoiceFiles\\" + fileName;

		// Save the file locally
		Path path = Paths.get(filePath);
		Files.write(path, file.getBytes());

		// Return the file name to store it in the database
		return fileName;
	}

	@Override
	public OrderResponse getAllOrderHistoryByVendorId(int vendorId, int page, int size, String query) {
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.DESC, "orderDate"));
		Page<OrderEntity> orderPage;
		VendorEntity vendorEntity = this.vendorRepo.findById(vendorId).orElse(null);

		// Define the statuses to exclude
		List<String> excludedStatuses = Arrays.asList("Confirmed", "Order");

		if (query != null && !query.isEmpty()) {
			// Fetch orders with specific statuses and query (filter by product name or
			// other attributes)
			orderPage = this.orderRepository.findByVendorAndProductNameContainingIgnoreCaseAndOrderStatusNotIn(
					vendorEntity, query, excludedStatuses, pageable);
		} else {
			// Fetch orders with specific statuses without a query
			orderPage = this.orderRepository.findByVendorAndOrderStatusNotIn(vendorEntity, excludedStatuses, pageable);
		}

		// Map to response DTO
		OrderResponse response = new OrderResponse();
		response.setOrders(orderPage.getContent().stream().map(this::mapToOrderDto).collect(Collectors.toList()));
		response.setTotalPages(orderPage.getTotalPages());

		return response;
	}

	@Override
	public OrderResponse getAllOrdersByAdmin(int page, int size, String query) {
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.DESC, "orderDate"));
		Page<OrderEntity> orderPage;

		// Define the specific status you want to filter by (e.g., "Order")
		List<String> orderStatuses = Collections.singletonList("Order");

		if (query != null && !query.isEmpty()) {
			// Fetch orders with the "Order" status and filter by product name or other
			// attributes (ignores vendorEntity)
			orderPage = this.orderRepository.findByOrderStatusInAndProductNameContainingIgnoreCase(orderStatuses, query,
					pageable);
		} else {
			// Fetch orders with the "Order" status only (ignores vendorEntity)
			orderPage = this.orderRepository.findByOrderStatusIn(orderStatuses, pageable);
		}

		// Map the orders to DTOs and return the response
		OrderResponse response = new OrderResponse();
		response.setOrders(orderPage.getContent().stream().map(this::mapToOrderDto).collect(Collectors.toList()));
		response.setTotalPages(orderPage.getTotalPages());

		return response;
	}

	@Override
	public OrderResponse getAllOrderStatusByAdmin(int page, int size, String query) {
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.DESC, "orderDate"));
		Page<OrderEntity> orderPage;

		// Define the specific status you want to filter by (e.g., "Order")
		List<String> orderStatuses = Arrays.asList("Confirmed", "received", "delivered");
		String paymentStatus = "unpaid";

		if (query != null && !query.isEmpty()) {
			// Fetch orders with the "Order" status and filter by product name or other
			// attributes (ignores vendorEntity)
			orderPage = this.orderRepository.findByOrderStatusInAndPaymentStatusAndProductNameContainingIgnoreCase(
					orderStatuses, paymentStatus, paymentStatus, pageable);
		} else {
			// Fetch orders with the "Order" status only (ignores vendorEntity)
			orderPage = this.orderRepository.findByOrderStatusInAndPaymentStatus(orderStatuses, paymentStatus,
					pageable);
		}

		// Map the orders to DTOs and return the response
		OrderResponse response = new OrderResponse();
		response.setOrders(orderPage.getContent().stream().map(this::mapToOrderDto).collect(Collectors.toList()));
		response.setTotalPages(orderPage.getTotalPages());

		return response;

	}

	@Override
	public OrderResponse getAllOrderHistoryByAdmin(int page, int size, String query) {
		// Create a Pageable object with sorting by order date in descending order
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.DESC, "orderDate"));
		Page<OrderEntity> orderPage;

		// Define the specific statuses you want to filter by
		List<String> orderStatuses = Arrays.asList("notReceived", "order cancelled", "can't_delivered", "received");

		if (query != null && !query.isEmpty()) {
			// Fetch orders with the specified statuses and filter by product name or other
			// attributes
			orderPage = this.orderRepository.findByOrderStatusInAndProductNameContainingIgnoreCase(orderStatuses, query,
					pageable);
		} else {
			// Fetch orders with the specified statuses without filtering by product name
			orderPage = this.orderRepository.findByOrderStatusIn(orderStatuses, pageable);
		}

		// Map the orders to DTOs and return the response
		OrderResponse response = new OrderResponse();
		response.setOrders(orderPage.getContent().stream().map(this::mapToOrderDto).collect(Collectors.toList()));
		response.setTotalPages(orderPage.getTotalPages());

		return response;
	}

}
