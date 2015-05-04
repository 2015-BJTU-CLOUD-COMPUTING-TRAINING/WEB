package com.cloud.app.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloud.app.model.Group;
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
	public int update(User user) {
		// TODO Auto-generated method stub
		return userDao.updateByPrimaryKey(user);
	}
	@Override
	public List<User> searchUser(String userIdOrName) {
		List<User> searchUserResults=new ArrayList<User>();
		if(userIdOrName==null||"".equals(userIdOrName)){
			searchUserResults.add(null);
		}else{
		Pattern pattern = Pattern.compile("[0-9]*");
		Matcher isNum = pattern.matcher(userIdOrName);
		//如果是数字
		if(isNum.matches()){
			searchUserResults.add(userDao.selectByPrimaryKey(Integer.parseInt(userIdOrName)));
			
		}
		searchUserResults.addAll(userDao.selectByUserNickName(userIdOrName));
		
		}
		return searchUserResults;
	}
	
	
	

}
