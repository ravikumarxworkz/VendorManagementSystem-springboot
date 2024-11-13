package com.VendoraX.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.VendoraX.dto.OrderDTO;
import com.VendoraX.response.OrderResponse;
import com.VendoraX.service.OrderService;

import jakarta.persistence.EntityNotFoundException;
import jakarta.validation.Valid;


@Controller
@RequestMapping("/")
public class OrderController {

	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);

	@Autowired
	private OrderService orderService;

	// Save a new order (POST)
	@PostMapping("/saveOrder")
	public ResponseEntity<String> saveOrder(@Valid @RequestBody OrderDTO orderDTO) {
		try {
			System.out.println("ordet Dto recvied from client:"+orderDTO);
			boolean save = orderService.saveOrder(orderDTO);
			if (save) {
				logger.info("Order saved successfully.");
				return ResponseEntity.ok("Order saved successfully.");
			} else {
				return ResponseEntity.ok("Order not saved successfully.");
			}

		} catch (Exception e) {
			return ResponseEntity.status(500).body("Error saving order: " + e.getMessage());
		}
	}

	// Update an existing order (PUT)
	@PutMapping("/updateOrder")
	public ResponseEntity<String> updateOrder(@Valid @RequestBody OrderDTO orderDTO) {
		try {
			orderService.updateOrder(orderDTO);
			return ResponseEntity.ok("Order updated successfully.");
		} catch (Exception e) {
			return ResponseEntity.status(500).body("Error updating order: " + e.getMessage());
		}
	}

	@GetMapping("/getAllOrdersByVendorId")
	public ResponseEntity<?> getAllOrdersByVendorId(@RequestParam int page, @RequestParam int size,
			@RequestParam(required = false) String query, @RequestParam int vendorId) {

		try {
			OrderResponse orderResponse = orderService.getAllOrdersByVendorId(vendorId, page, size, query);
			return ResponseEntity.ok(orderResponse); // Success response
		} catch (EntityNotFoundException e) {
			// Handle specific error if vendor or order is not found
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Vendor or Order not found: " + e.getMessage());
		} catch (Exception e) {
			// General error handling for other unexpected exceptions
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("An error occurred while fetching the orders: " + e.getMessage());
		}
	}

	@GetMapping("/getOrderById")
	public ResponseEntity<?> getOrderById(@RequestParam int orderId) {
		try {
			OrderDTO order = orderService.getOrderById(orderId);
			return ResponseEntity.ok(order); // Success response
		} catch (EntityNotFoundException e) {
			// Handle specific error if the order is not found
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Order not found: " + e.getMessage());
		} catch (Exception e) {
			// General error handling for other unexpected exceptions
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("An error occurred while fetching the order: " + e.getMessage());
		}
	}

	@PostMapping("/submitOrderStatus")
	public ResponseEntity<String> submitOrderStatus(@RequestParam("orderStatus") String orderStatus,
			@RequestParam("orderId") int orderId, @RequestParam(value = "file", required = false) MultipartFile file) {

		// Call the service to handle business logic
		orderService.updateOrderStatus(orderId, orderStatus, file);

		return ResponseEntity.ok("Order status and invoice submitted successfully");
	}
	
	@PostMapping("/submitOrderStatusByAdmin")
	public ResponseEntity<String> submitOrderStatusByAdmin(@RequestParam("orderStatus") String orderStatus,
			@RequestParam("paymentStatus") String paymentStatus,
			@RequestParam("orderId") int orderId, @RequestParam(value = "file", required = false) MultipartFile file) {
         
		// Call the service to handle business logic
		orderService.updateOrderStatusByAdmin(orderId, orderStatus,paymentStatus, file);

		return ResponseEntity.ok("Order status and invoice submitted successfully");
	}
	
	@PostMapping("/cancelOrder")
	public ResponseEntity<String> cancelOrder(@RequestParam int orderId) {
	    boolean isOrderCancelled = orderService.cancelOrderByAdmin(orderId);
	    
	    if (isOrderCancelled) {
	        return ResponseEntity.status(HttpStatus.OK).body("Order cancelled successfully");
	    } else {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Order not cancelled successfully");
	    }
	}


//  

	@GetMapping("/getAllOrderHistoryByVendorId")
	public ResponseEntity<?> getAllOrderHistoryByVendorId(@RequestParam int page, @RequestParam int size,
			@RequestParam(required = false) String query, @RequestParam int vendorId) {

		try {
			OrderResponse orderResponse = orderService.getAllOrderHistoryByVendorId(vendorId, page, size, query);
			return ResponseEntity.ok(orderResponse); // Success response
		} catch (EntityNotFoundException e) {
			// Handle specific error if vendor or order is not found
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Vendor or Order not found: " + e.getMessage());
		} catch (Exception e) {
			// General error handling for other unexpected exceptions
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("An error occurred while fetching the orders: " + e.getMessage());
		}
	}

	// admin by orders
	@GetMapping("/getAllOrdersByAdmin")
	public ResponseEntity<?> getAllOrdersByAdmin(@RequestParam int page, @RequestParam int size,
			@RequestParam(required = false) String query) {

		try {
			OrderResponse orderResponse = orderService.getAllOrdersByAdmin(page, size, query);
			return ResponseEntity.ok(orderResponse); // Success response
		} catch (EntityNotFoundException e) {
			// Handle specific error if vendor or order is not found
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Vendor or Order not found: " + e.getMessage());
		} catch (Exception e) {
			// General error handling for other unexpected exceptions
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("An error occurred while fetching the orders: " + e.getMessage());
		}
	}
	
	@GetMapping("/getAllOrdersStatusByAdmin")
	public ResponseEntity<?> getAllOrdersStatusByAdmin(@RequestParam int page, @RequestParam int size,
	        @RequestParam(required = false) String query) {

	    try {
	        OrderResponse orderResponse = orderService.getAllOrderStatusByAdmin(page, size, query);
	        return ResponseEntity.ok(orderResponse); // Success response
	    } catch (EntityNotFoundException e) {
	        return ResponseEntity.status(HttpStatus.NOT_FOUND)
	                .body("Vendor or Order not found: " + e.getMessage());
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                .body("An error occurred while fetching the orders: " + e.getMessage());
	    }
	}

	@GetMapping("/getAllOrderHistoryByAdmin")
	public ResponseEntity<?> getAllOrderHistoryByAdmin(@RequestParam int page, @RequestParam int size,
			@RequestParam(required = false) String query) {

		try {
			OrderResponse orderResponse = orderService.getAllOrderHistoryByAdmin(page, size, query);
			return ResponseEntity.ok(orderResponse); // Success response
		} catch (EntityNotFoundException e) {
			// Handle specific error if vendor or order is not found
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Vendor or Order not found: " + e.getMessage());
		} catch (Exception e) {
			// General error handling for other unexpected exceptions
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("An error occurred while fetching the orders: " + e.getMessage());
		}
	}
	
	/*----------------------------------UPDATE ORDER AND PAYMENT STATUS METHOD------------------------------------ */
	@PostMapping("/updateOrderStatusByAdmin")
	@ResponseBody
	public ResponseEntity<Object> updateOrderStatusByAdmin(@RequestParam("orderId") String orderId,
			@RequestParam("paymentStatus") String paymentStatus, @RequestParam("orderStatus") String orderStatus,
			@RequestParam(value = "file", required = false) MultipartFile file) {
		try {
			int orderID = Integer.parseInt(orderId);
			boolean updateOrderStatus = orderService.updateOrderStatusByAdmin(orderID, paymentStatus, orderStatus,
					file);
			if (updateOrderStatus) {
				return ResponseEntity.ok().body("updateOrderStatusSuccessfully");
			} else {

				return ResponseEntity.ok().body("!updateOrderStatusSuccessfully");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.ok().body("!Failed to upload invoice and send email.");
		}
	}

}
