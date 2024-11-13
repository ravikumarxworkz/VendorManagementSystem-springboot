package com.VendoraX.dto;

import lombok.Data;

@Data
public class OrderStatisticsDTO {

    private long totalProducts;   
    private long totalOrders;       
    private long deliveredCount;
    private long pendingOrders;
    private long canceledOrders; 
    private long receivedOrders;

}
