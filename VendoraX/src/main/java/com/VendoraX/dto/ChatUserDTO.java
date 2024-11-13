package com.VendoraX.dto;

import lombok.Data;

@Data
public class ChatUserDTO {

	private String userID;
	private String userName;
	private String userProfileImagePath;
	private String lastMessage;

}
