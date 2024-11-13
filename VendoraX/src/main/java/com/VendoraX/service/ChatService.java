package com.VendoraX.service;

import java.util.List;

import com.VendoraX.dto.ChatUserDTO;
import com.VendoraX.dto.MessageDTO;

public interface ChatService {

	MessageDTO sendMessage(MessageDTO chatMessageDto);

	List<MessageDTO> getChatHistoryBYUserId(String userId);

	List<ChatUserDTO> getAllChatUser();

}
