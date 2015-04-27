package com.cloud.app.service;

import java.util.List;

import com.cloud.app.model.Message;
import com.cloud.app.model.User;

public interface IMessageService {
	
	
	int Addfriendmessage(Integer userid,Integer friendid);
	
	 List<Message> getAllMessages(Integer userId);
}
