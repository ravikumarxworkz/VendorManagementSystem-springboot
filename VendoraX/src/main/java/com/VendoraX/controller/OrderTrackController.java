package com.VendoraX.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.VendoraX.dto.OrderTrackDTO;
import com.VendoraX.service.OrderTrackService;

@RestController
public class OrderTrackController {

    @Autowired
    private OrderTrackService orderTrackService;
   
    @GetMapping("/ordertrack")
    public List<OrderTrackDTO> getOrderTrackingByOrderId(@RequestParam("orderId") int orderId) {
        return orderTrackService.getOrderTrackingDetails(orderId);
    }
}
