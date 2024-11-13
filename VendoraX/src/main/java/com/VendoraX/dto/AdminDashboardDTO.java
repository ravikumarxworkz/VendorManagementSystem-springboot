package com.VendoraX.dto;

import lombok.Data;

@Data
public class AdminDashboardDTO {

	private long totalVendorCount;
	private OrderStatisticsDTO orderStatistics; // Order statistics for the vendor
	private PaymentSummaryDTO paymentSummary; // Payment summary for the vendor

}
