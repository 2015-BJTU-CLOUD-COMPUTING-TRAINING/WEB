package com.cloud.app.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloud.app.model.User;
import com.cloud.app.service.IUserService;
import com.cloud.framwork.dao.UserMapper;

@Service("userSerivice")
public class UserServiceImpl implements IUserService{
	@Resource  
    private UserMapper userDao; 
	@Override
	public User getUserById(int userId) {
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

}
