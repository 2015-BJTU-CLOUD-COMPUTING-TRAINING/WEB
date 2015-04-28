package com.cloud.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloud.app.model.Message;
import com.cloud.app.model.Messages;
import com.cloud.app.service.IMessageService;
import com.cloud.framwork.dao.MessageMapper;
@Service("messageService")
public class MessageServiceImpl implements IMessageService {
	
	@Autowired
	private MessageMapper messageDao;
	
	@Autowired
	private Message message;

	

	@Override
	public int Addfriendmessage(Integer userid, Integer friendid) {
		// TODO Auto-generated method stub
		message.setFromId(userid);
		message.setToId(friendid);
		message.setMessageType(1);
		message.setMessageContent(null);
		return messageDao.Addmessage(message);
	} 
	@Override
	public List<Messages> getAllMessages(Integer userId) {
		// TODO Auto-generated method stub
		List<Messages> messages = messageDao.getAllMessages(userId);
		return messages;
	}

}
