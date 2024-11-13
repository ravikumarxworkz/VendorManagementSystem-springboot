package com.VendoraX.dto;

import lombok.Data;

@Data
public class VendorDashboardDTO {

    private OrderStatisticsDTO orderStatistics;  // Order statistics for the vendor
    private PaymentSummaryDTO paymentSummary;    // Payment summary for the vendor

}

