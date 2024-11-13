package com.VendoraX.service;

import java.util.List;

import com.VendoraX.dto.OrderTrackDTO;

public interface OrderTrackService {

	boolean createOrderTrack(OrderTrackDTO  orderTrackDTO);

	 List<OrderTrackDTO> getOrderTrackingDetails(int orderId);

}
