package com.cloud.app.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloud.app.model.Group;
import com.cloud.app.model.Member;
import com.cloud.app.model.Message;
import com.cloud.app.model.User;
import com.cloud.app.service.IGroupService;
import com.cloud.framwork.dao.GroupMapper;
import com.cloud.framwork.dao.MemberMapper;
import com.cloud.framwork.dao.MessageMapper;

@Service
public class GroupServiceImpl implements IGroupService {
	
	@Autowired
	private GroupMapper groupDao;
	
	@Autowired
	private Group group;
	
	@Autowired
	private MemberMapper memberDao;
	
	@Autowired
	private Member member;
	
	@Autowired
	Message message;
	
	@Autowired
	MessageMapper messageDao;

	@Override
	public List<Group> ShowGroup(int userId) {
		// TODO Auto-generated method stub
		List<Group> AllGroups = groupDao.selectAllGroups(userId);
		return AllGroups;
	}

	@Override
	public List<String> exitGroup(String groupIds, Integer userId) {
		// TODO Auto-generated method stub
		List<String> exitGroupResult = new ArrayList<String>();
		String [] vals = groupIds.split(",");
		for(String groupId:vals){
			group = groupDao.selectByPrimaryKey(Integer.parseInt(groupId));
			//群主不可退群
			if(group.getGroupLeaderId()==userId){
				exitGroupResult.add("退出 "+group.getGroupName()+" 失败，请转移群主身份后再尝试");
			}
			else{
			memberDao.deleteByGroupIdAndUserId(Integer.parseInt(groupId), userId);
			//只有非群主可以退群，若是管理员，则置空管理员字段
			if(group.getGroupDeputy1Id()==userId){
				group.setGroupDeputy1Id(null);
			}else if(group.getGroupDeputy2Id()==userId){
				group.setGroupDeputy2Id(null);
			}else if(group.getGroupDeputy3Id()==userId){
				group.setGroupDeputy3Id(null);
			}
			groupDao.updateByPrimaryKey(group);
			exitGroupResult.add("退出 "+group.getGroupName()+" 成功");
			}
			
		}
		return exitGroupResult;
	}

	@Override
	public int creatGroup(Group group, Integer userId) {
		// TODO Auto-generated method stub
		group.setGroupBuilderId(userId);
		group.setGroupLeaderId(userId);
		groupDao.myinsert(group);
		member.setMemberId(userId);
		member.setGroupId(group.getGroupId());
		memberDao.insert(member);
		return 1;
	}

	@Override
	public List<User> ShowMembers(Integer groupId) {
		// TODO Auto-generated method stub
		List<User> AllMembers = memberDao.selectAllMembers(groupId);
		group = groupDao.selectByPrimaryKey(groupId);
		for(User member:AllMembers){
			if(member.getUserId()==group.getGroupBuilderId()){
				if(member.getComment()==null){
					member.setComment("创建者");
				}else
				member.setComment(member.getComment()+",创建者");
			}
			if(member.getUserId()==group.getGroupLeaderId()){
				if(member.getComment()==null){
					member.setComment("群主");
				}else
				member.setComment(member.getComment()+",群主");
			}
			if(member.getUserId()==group.getGroupDeputy1Id()||member.getUserId()==group.getGroupDeputy2Id()||member.getUserId()==group.getGroupDeputy3Id()){
				if(member.getComment()==null){
					member.setComment("管理员");
				}else
				member.setComment(member.getComment()+",管理员");
			}
			if(member.getComment()==null){
				member.setComment("普通成员");
			}
			
		}
		return AllMembers;
	}

	@Override
	public List<Group> searchGroup(String groupIdOrName) {
		// TODO Auto-generated method stub
		List<Group> searchGroupResults=new ArrayList<Group>();
		if(groupIdOrName==null||"".equals(groupIdOrName)){
			searchGroupResults.add(null);
		}else{
		Pattern pattern = Pattern.compile("[0-9]*");
		Matcher isNum = pattern.matcher(groupIdOrName);
		//如果是数字
		if(isNum.matches()){
			searchGroupResults.add(groupDao.selectByPrimaryKey(Integer.parseInt(groupIdOrName)));
		}
			searchGroupResults.addAll(groupDao.selectByGroupName(groupIdOrName));
		
		}
		return searchGroupResults;
		
	}

	@Override
	public List<String> joinGroup(String groupIds, Integer userId) {
		List<String> joinGroupResult = new ArrayList<String>();
		String [] vals = groupIds.split(",");
		for(String groupId:vals){
			group = groupDao.selectByPrimaryKey(Integer.parseInt(groupId));
			//当用户在群里时
			if(memberDao.selectByMemberIdAndGroupId(Integer.parseInt(groupId), userId)!=null&&!memberDao.selectByMemberIdAndGroupId(Integer.parseInt(groupId), userId).equals(null)){
				joinGroupResult.add("你已在 "+group.getGroupName()+" 组内！");
			}
			//当用户不在群里时
			else{
				message.setMessageId(null);
				message.setFromId(userId);
				message.setMessageType(5);
				message.setMessageContent(Integer.parseInt(groupId));
				message.setToId(group.getGroupLeaderId());
				messageDao.Addmessage(message);
				if(group.getGroupDeputy1Id()!=null){
				message.setMessageId(null);
				message.setToId(group.getGroupDeputy1Id());
				messageDao.Addmessage(message);
				}
				if(group.getGroupDeputy2Id()!=null){
				message.setMessageId(null);
				message.setToId(group.getGroupDeputy2Id());
				messageDao.Addmessage(message);
				}
				if(group.getGroupDeputy3Id()!=null){
				message.setMessageId(null);
				message.setToId(group.getGroupDeputy3Id());
				messageDao.Addmessage(message);
				}
				joinGroupResult.add("申请加入 "+group.getGroupName()+" 成功！");
				
			}
			
		}
		return joinGroupResult;
	}
	

}
