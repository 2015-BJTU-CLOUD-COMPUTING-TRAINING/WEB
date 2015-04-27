package com.cloud.app.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloud.app.model.Message;
import com.cloud.app.model.User;
import com.cloud.app.service.IFriendService;
import com.cloud.app.service.IUserService;
import com.cloud.framwork.dao.FriendMapper;
import com.cloud.framwork.dao.MessageMapper;
import com.cloud.framwork.dao.UserMapper;

@Service("friendService")
public class FriendServiceImpl implements IFriendService{
	@Autowired  
    private UserMapper userDao;
	
	@Autowired
	private FriendMapper friendDao;
	
	

	@Override
	public List<User> Showfriend(int userId) {
		// TODO Auto-generated method stub
		List<User> Allfriends = friendDao.selectAllFriends(userId);
		return Allfriends;
	}

	


}
