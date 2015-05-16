package com.cloud.app.service.impl;

import java.util.ArrayList;
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
	User user;
	
	@Autowired  
    private UserMapper userDao;
	
	@Autowired
	private FriendMapper friendDao;
	
	@Autowired
	Message message;
	
	@Autowired
	MessageMapper messageDao;
	
	

	@Override
	public List<User> Showfriend(int userId) {
		// TODO Auto-generated method stub
		List<User> Allfriends = friendDao.selectAllFriends(userId);
		return Allfriends;
	}



	@Override
	public int deleteFriend(String friendIds,Integer userId) {
		// TODO Auto-generated method stub
		String [] vals = friendIds.split(",");
		for(String uploadId:vals){
	    	friendDao.deleteByUserId(Integer.parseInt(uploadId), userId);
		}
		return 1;
	}



	@Override
	public List<String> inviteFriend(String userIds, Integer currentuserId) {
			List<String> inviteFriendResult = new ArrayList<String>();
			String [] vals = userIds.split(",");
			for(String userId:vals){
				user = userDao.selectByPrimaryKey(Integer.parseInt(userId));
				//当用户就是自己时
				if(Integer.parseInt(userId)==currentuserId||currentuserId.equals(Integer.parseInt(userId))){
					inviteFriendResult.add(" "+user.getUserNickname()+" ，你不能添加自己为好友！");
				}
				//当用户已经是好友时
				else if(friendDao.selectByFriendIdAndUserId(Integer.parseInt(userId),currentuserId)!=null&&!friendDao.selectByFriendIdAndUserId(Integer.parseInt(userId),currentuserId).equals(null)){
					inviteFriendResult.add("用户 "+user.getUserNickname()+" 已经是你好友！");
				}
				//当用户不是好友时
				else{
					message.setMessageId(null);
					message.setFromId(currentuserId);
					message.setMessageType(1);
					message.setToId(Integer.parseInt(userId));
					messageDao.Addmessage(message);
					inviteFriendResult.add("已向 "+user.getUserNickname()+" 发送邀请！");
					
				}
				
			}
			return inviteFriendResult;
		
	}

	


}
