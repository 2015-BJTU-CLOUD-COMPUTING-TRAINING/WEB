package com.cloud.app.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloud.app.model.Message;
import com.cloud.app.model.User;
import com.cloud.app.service.IUserService;
import com.cloud.framwork.dao.MessageMapper;
import com.cloud.framwork.dao.UserMapper;

@Service("userSerivice")
public class UserServiceImpl implements IUserService{
	@Autowired  
    private UserMapper userDao; 
	
	@Autowired
	private MessageMapper messageDao;
	
	@Override
	public User getUserById(Integer userId) {
		// TODO Auto-generated method stub
		return this.userDao.selectByPrimaryKey(userId);
	}
	@Override
	public int save(User user) {
		// TODO Auto-generated method stub
		return this.userDao.myinsert(user);
		
		
		
	}
	@Override
	public User getUserByNameAndPassword(User user) {
		// TODO Auto-generated method stub
		return this.userDao.selectByNameAndPassword(user);
	}
	@Override
	public List<Message> getAllMessages(Integer userId) {
		// TODO Auto-generated method stub
		List<Message> messages = messageDao.getAllMessages(userId);
		return messages;
	}

}
