package com.VendoraX.dto;

import lombok.Data;

@Data
public class PaymentSummaryDTO {

    private double totalAmountToPay;  
    private double amountPaid;        
    private double remainingBalance;  

}
