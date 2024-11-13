package com.VendoraX.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.VendoraX.dto.ChatUserDTO;
import com.VendoraX.dto.MessageDTO;
import com.VendoraX.dto.NotificationDTO;
import com.VendoraX.entity.ChatMessage;
import com.VendoraX.entity.VendorEntity;
import com.VendoraX.repository.MessageRepository;
import com.VendoraX.repository.VendorRepo;
import com.VendoraX.service.ChatService;
import com.VendoraX.service.NotificationService;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.logging.Logger;

@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	private MessageRepository messageRepository;

	@Autowired
	private VendorRepo vendorRepo;

	@Autowired
	private NotificationService notificationService;

	private static final Logger logger = Logger.getLogger(ChatService.class.getName());

	@Override
	public MessageDTO sendMessage(MessageDTO messageDto) {
		// Create a new chat message entity
		ChatMessage message = new ChatMessage();
		message.setFromUser(messageDto.getFromUser());
		message.setToUser(messageDto.getToUser());
		message.setMessage(messageDto.getMessage());
		message.setTimestamp(LocalDateTime.now());

		// Save the chat message
		ChatMessage savedMessage = this.messageRepository.save(message);

		if (savedMessage != null) {
			logger.info("Message saved successfully");

			// Return the saved message details
			messageDto.setId(savedMessage.getId()); // Assuming there is an ID field in the DTO
			messageDto.setTimestamp(savedMessage.getTimestamp());

			// Create a notification for the recipient
			NotificationDTO notification = new NotificationDTO();
			notification.setSenderId(String.valueOf(savedMessage.getFromUser())); // The sender is the user who sent the
																					// message
			notification.setReceiverId(String.valueOf(savedMessage.getToUser())); // The receiver is the user who should
																					// be notified
			notification.setMessage("new message from : " + savedMessage.getFromUser());
			notification.setType("MESSAGE"); // Setting the notification type as 'MESSAGE'
			notification.setTimestamp(LocalDateTime.now());

			// Save the notification
			this.notificationService.createNotification(notification.getReceiverId(), notification);

			return messageDto;
		}
		return null;
	}

	public List<MessageDTO> getChatHistoryBYUserId(String userId) {
		// Retrieve messages sent by or received by the user
		List<ChatMessage> messages = messageRepository.findByFromUserOrToUser(userId, userId);

		// Convert entities to DTOs
		return messages.stream().map(entity -> new MessageDTO(entity.getId(), entity.getFromUser(), entity.getToUser(),
				entity.getMessage(), entity.getTimestamp())).collect(Collectors.toList());
	}

	@Override
	public List<ChatUserDTO> getAllChatUser() {

		// Fetch all users excluding 'admin'
		logger.info("Fetching all users excluding 'admin'");
		List<VendorEntity> users = this.vendorRepo.findAll().stream()
				.filter(user -> !user.getOwnerName().equalsIgnoreCase("admin")) // Exclude admin user
				.collect(Collectors.toList());

		// Fetch all messages (admin messages included)
		logger.info("Fetching all chat messages");
		List<ChatMessage> chatMessages = this.messageRepository.findAll();

		// Create a list to store ChatUserDTOs
		List<ChatUserDTO> chatUserDTOs = new ArrayList<>();

		// Map users to their last message
		for (VendorEntity user : users) {
			// Filter messages where the user is either the sender ('fromUser') or the
			// receiver ('toUser')
			Optional<ChatMessage> lastMessage = chatMessages.stream()
					.filter(message -> message.getFromUser().equals(String.valueOf(user.getId()))
							|| message.getToUser().equals(String.valueOf(user.getId()))) // Match messages for this user
																							// (sender or receiver)
					.sorted((m1, m2) -> m2.getTimestamp().compareTo(m1.getTimestamp())) // Sort by timestamp (most
																						// recent first)
					.findFirst(); // Get the most recent message

			// Create DTO object
			ChatUserDTO chatUserDTO = new ChatUserDTO();
			chatUserDTO.setUserID(String.valueOf(user.getId()));
			chatUserDTO.setUserName(user.getOwnerName());
			chatUserDTO.setUserProfileImagePath(user.getImagePath());

			// Set the last message content if present, otherwise default message
			if (lastMessage.isPresent()) {
				chatUserDTO.setLastMessage(lastMessage.get().getMessage());
				logger.info("User ID " + user.getId() + ": Last message found: " + lastMessage.get().getMessage());
			} else {
				chatUserDTO.setLastMessage("No messages yet");
				logger.info("User ID " + user.getId() + ": No messages found");
			}

			// Add DTO to the list
			chatUserDTOs.add(chatUserDTO);
		}

		// Sort chat users based on the timestamp of the last message (if any)
		logger.info("Sorting users by the timestamp of their last message");
		chatUserDTOs.sort((u1, u2) -> {
			Optional<ChatMessage> msg1 = chatMessages.stream()
					.filter(message -> message.getFromUser().equals(u1.getUserID())
							|| message.getToUser().equals(u1.getUserID()))
					.sorted((m1, m2) -> m2.getTimestamp().compareTo(m1.getTimestamp())).findFirst();

			Optional<ChatMessage> msg2 = chatMessages.stream()
					.filter(message -> message.getFromUser().equals(u2.getUserID())
							|| message.getToUser().equals(u2.getUserID()))
					.sorted((m1, m2) -> m2.getTimestamp().compareTo(m1.getTimestamp())).findFirst();

			return msg2.map(ChatMessage::getTimestamp).orElse(LocalDateTime.MIN)
					.compareTo(msg1.map(ChatMessage::getTimestamp).orElse(LocalDateTime.MIN));
		});

		// Return the sorted list of ChatUserDTOs
		logger.info("Returning sorted list of users based on last message");
		return chatUserDTOs;
	}

}
