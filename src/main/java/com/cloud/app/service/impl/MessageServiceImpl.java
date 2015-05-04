package com.cloud.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloud.app.model.Friend;
import com.cloud.app.model.Group;
import com.cloud.app.model.Member;
import com.cloud.app.model.Message;
import com.cloud.app.model.Messages;
import com.cloud.app.service.IMessageService;
import com.cloud.framwork.dao.FriendMapper;
import com.cloud.framwork.dao.MemberMapper;
import com.cloud.framwork.dao.MessageMapper;

@Service("messageService")
public class MessageServiceImpl implements IMessageService {

	@Autowired
	private MessageMapper messageDao;

	@Autowired
	private Message message;

	@Autowired
	private FriendMapper friendDao;

	@Autowired
	private Friend friend;

	@Autowired
	private MemberMapper memberDao;

	@Autowired
	private Member member;

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

	@Override
	public int acceptMessage(Messages messages) {
		// TODO Auto-generated method stub
		messageDao.updateMessageState(messages.getMessageId(), 1);

		// 请求加好友
		if (messages.getMessageType() == 1) {
			friend.setFriendA(messages.getFromId());
			friend.setFriendB(messages.getToId());
			friendDao.insert(friend);
		}
		// 邀请入组
		else if (messages.getMessageType() == 3) {
			member.setGroupId(messages.getMessageContent());
			member.setMemberId(messages.getToId());
			memberDao.insert(member);
		//申请入组
		} else if (messages.getMessageType() == 5) {
			//messageDao.deleteByFromIdAndContent(messageId)
			member.setGroupId(messages.getMessageContent());
			member.setMemberId(messages.getFromId());
			memberDao.insert(member);
		}

		return 1;
	}

	@Override
	public int rejectMessage(Messages messages) {
		messageDao.updateMessageState(messages.getMessageId(), 2);
		return 1;

	}

}
