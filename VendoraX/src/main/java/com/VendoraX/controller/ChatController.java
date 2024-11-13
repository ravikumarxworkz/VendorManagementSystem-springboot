package com.VendoraX.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;

import com.VendoraX.dto.ChatUserDTO;
import com.VendoraX.dto.MessageDTO;
import com.VendoraX.service.ChatService;


import java.util.Collections;
import java.util.List;

@Controller
@RequestMapping("/")
public class ChatController {

	@Autowired
	private ChatService chatService;

	@MessageMapping("/sendMessage") // Will be matched with "/chat/send" from client
	@SendTo("/topic/messages") // Subscribers will receive messages from this destination
	public MessageDTO sendMessage(@Payload MessageDTO messageDTO, SimpMessageHeaderAccessor headerAccessor) {

		try {
			MessageDTO savedMessage = chatService.sendMessage(messageDTO);
			if (savedMessage != null) {
				return savedMessage; // Send the saved message to subscribers
			} else {
				throw new RuntimeException("Failed to send the message.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("Error while sending the message: " + e.getMessage());
		}
	}

	@GetMapping("/messageHistory/{userId}")
	@ResponseBody
	public ResponseEntity<List<MessageDTO>> getChatHistoryByUserId(@PathVariable String userId) {
		List<MessageDTO> chatHistory = chatService.getChatHistoryBYUserId(userId);
		if (chatHistory != null && !chatHistory.isEmpty()) {
			return ResponseEntity.ok(chatHistory); // Return 200 OK with the chat history
		} else {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Collections.emptyList()); // Return 404 if no
																								// history found
		}
	}

	@GetMapping("getAllChatUsers")
	@ResponseBody
	public ResponseEntity<List<ChatUserDTO>> getChatUsers() {
		List<ChatUserDTO> users = this.chatService.getAllChatUser();
		return ResponseEntity.ok(users);
	}

}
