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
import com.cloud.framwork.dao.UserMapper;

@Service
public class GroupServiceImpl implements IGroupService {
	@Autowired
	User user;
	
	@Autowired
	UserMapper userDao;
	
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

	@Override
	public List<String> inviteGroup(String userIds, Integer currentuserId,
			String groupId) {
		List<String> inviteGroupResult = new ArrayList<String>();
		String [] vals = userIds.split(",");
		for(String userId:vals){
			user = userDao.selectByPrimaryKey(Integer.parseInt(userId));
			//当用户在群里时
			if(memberDao.selectByMemberIdAndGroupId(Integer.parseInt(groupId), Integer.parseInt(userId))!=null&&!memberDao.selectByMemberIdAndGroupId(Integer.parseInt(groupId), Integer.parseInt(userId)).equals(null)){
				inviteGroupResult.add("用户 "+user.getUserNickname()+" 已在组内！");
			}
			//当用户不在群里时
			else{
				message.setMessageId(null);
				message.setFromId(currentuserId);
				message.setMessageType(3);
				message.setMessageContent(Integer.parseInt(groupId));
				message.setToId(Integer.parseInt(userId));
				messageDao.Addmessage(message);
				
				inviteGroupResult.add("已向 "+user.getUserNickname()+" 发送邀请！");
				
			}
			
		}
		return inviteGroupResult;
	}

	@Override
	public List<String> deleteMember(String userIds, Integer currentuserId,
			String groupId) {
		List<String> deleteMemberResult = new ArrayList<String>();
		group = groupDao.selectByPrimaryKey(Integer.parseInt(groupId));
		String [] vals = userIds.split(",");
		for(String userId:vals){
			Integer userid = Integer.parseInt(userId);
			user = userDao.selectByPrimaryKey(userid);
			//当成员为自己时
			if(currentuserId.equals(Integer.parseInt(userId))){
				deleteMemberResult.add(" "+user.getUserNickname()+" ，你不能删除你自己！");
			}
			//当成员是群主时
			else if(userid.equals(group.getGroupLeaderId())){
			
				deleteMemberResult.add("你无权删除 "+user.getUserNickname()+" ");
			}
			//当成员是管理员时
			else if(userid.equals(group.getGroupDeputy1Id())||userid.equals(group.getGroupDeputy2Id())||userid.equals(group.getGroupDeputy3Id())){
				//当成员是管理员时，且当前用户不是群主
				if(!group.getGroupLeaderId().equals(currentuserId)){
					deleteMemberResult.add("你无权删除 "+user.getUserNickname()+" ");
				}
				//当成员是管理员时，当前用户是群主
				else {
					//删除member表记录
					memberDao.deleteByGroupIdAndUserId(Integer.parseInt(groupId), Integer.parseInt(userId));
					//置空Group表管理员字段
					if(userid.equals(group.getGroupDeputy1Id())){
						group.setGroupDeputy1Id(null);
					}else if(userid.equals(group.getGroupDeputy2Id())){
						group.setGroupDeputy2Id(null);
					}else if(userid.equals(group.getGroupDeputy3Id())){
						group.setGroupDeputy3Id(null);
					}
					deleteMemberResult.add("已成功删除 "+user.getUserNickname()+" ");
				}
			}
			else{
				//删除member表记录
				memberDao.deleteByGroupIdAndUserId(Integer.parseInt(groupId), Integer.parseInt(userId));
				deleteMemberResult.add("已成功删除 "+user.getUserNickname()+" ");
			}
			
		}
		//使更正后的Group表更新
		groupDao.updateByPrimaryKey(group);
		return deleteMemberResult;
	}

	@Override
	public List<String> downToCommon(String userIds, Integer currentuserId,
			String groupId) {
		List<String> downToCommonResult = new ArrayList<String>();
		group = groupDao.selectByPrimaryKey(Integer.parseInt(groupId));
		String [] vals = userIds.split(",");
		for(String userId:vals){
			Integer userid = Integer.parseInt(userId);
			user = userDao.selectByPrimaryKey(userid);
			//当成员为自己时
			if(currentuserId.equals(Integer.parseInt(userId))){
				downToCommonResult.add(" "+user.getUserNickname()+" ，你无法将自己变为普通成员！");
			}
			//当成员是管理员时
			else if(userid.equals(group.getGroupDeputy1Id())||userid.equals(group.getGroupDeputy2Id())||userid.equals(group.getGroupDeputy3Id())){
					//置空Group表管理员字段
					if(userid.equals(group.getGroupDeputy1Id())){
						group.setGroupDeputy1Id(null);
					}else if(userid.equals(group.getGroupDeputy2Id())){
						group.setGroupDeputy2Id(null);
					}else if(userid.equals(group.getGroupDeputy3Id())){
						group.setGroupDeputy3Id(null);
					}
					downToCommonResult.add("已成功取消 "+user.getUserNickname()+" 的管理员权限");
			}
			else{
				downToCommonResult.add(" "+user.getUserNickname()+" 已经是普通用户！");
			}
			
		}
		//使更正后的Group表更新
		groupDao.updateByPrimaryKey(group);
		return downToCommonResult;
	}

	@Override
	public List<String> upToAdmin(String userIds, Integer currentuserId,
			String groupId) {
		List<String> upToAdminResult = new ArrayList<String>();
		group = groupDao.selectByPrimaryKey(Integer.parseInt(groupId));
		String [] vals = userIds.split(",");
		for(String userId:vals){
			Integer userid = Integer.parseInt(userId);
			user = userDao.selectByPrimaryKey(userid);
			//当成员为自己时
			if(currentuserId.equals(Integer.parseInt(userId))){
				upToAdminResult.add(" "+user.getUserNickname()+" ，你已经是群主，无需提升为管理员！");
			}
			//当成员是管理员时
			else if(userid.equals(group.getGroupDeputy1Id())||userid.equals(group.getGroupDeputy2Id())||userid.equals(group.getGroupDeputy3Id())){
				upToAdminResult.add(" "+user.getUserNickname()+" 已经是管理员！");
			}
			else{
				if(group.getGroupDeputy1Id()==null||group.getGroupDeputy1Id().equals(null)){
					group.setGroupDeputy1Id(userid);
					upToAdminResult.add("已成功将 "+user.getUserNickname()+" 提升为管理员");
				}else if(group.getGroupDeputy2Id()==null||group.getGroupDeputy2Id().equals(null)){
					group.setGroupDeputy2Id(userid);
					upToAdminResult.add("已成功将 "+user.getUserNickname()+" 提升为管理员");
				}else if(group.getGroupDeputy3Id()==null||group.getGroupDeputy3Id().equals(null)){
					group.setGroupDeputy3Id(userid);
					upToAdminResult.add("已成功将 "+user.getUserNickname()+" 提升为管理员");
				}else{
					upToAdminResult.add("管理员人数已满！");
				}
			}
			
		}
		//使更正后的Group表更新
		groupDao.updateByPrimaryKey(group);
		return upToAdminResult;
	}

	@Override
	public List<String> upToLeader(String userIds, Integer currentuserId,
			String groupId) {
		List<String> upToLeaderResult = new ArrayList<String>();
		group = groupDao.selectByPrimaryKey(Integer.parseInt(groupId));
		String [] vals = userIds.split(",");
		for(String userId:vals){
			Integer userid = Integer.parseInt(userId);
			user = userDao.selectByPrimaryKey(userid);
			//当成员为自己时
			if(currentuserId.equals(Integer.parseInt(userId))){
				upToLeaderResult.add(" "+user.getUserNickname()+" ，你已经是群主！");
			}
			//当成员是管理员时
			else if(userid.equals(group.getGroupDeputy1Id())||userid.equals(group.getGroupDeputy2Id())||userid.equals(group.getGroupDeputy3Id())){
				//将成员设为群主
				group.setGroupLeaderId(userid);
				//将当前用户设为管理员
				if(userid.equals(group.getGroupDeputy1Id())){
					group.setGroupDeputy1Id(currentuserId);
				}else if(userid.equals(group.getGroupDeputy2Id())){
					group.setGroupDeputy2Id(currentuserId);
				}else if(userid.equals(group.getGroupDeputy3Id())){
					group.setGroupDeputy3Id(currentuserId);
				}
				upToLeaderResult.add("已成功将 "+user.getUserNickname()+" 提升为群主！");
			}
			//当成员是普通成员时
			else{
					upToLeaderResult.add(" "+user.getUserNickname()+" 是普通成员，你只能将管理员提升为群主！");
				}
			
			
		}
		//使更正后的Group表更新
		groupDao.updateByPrimaryKey(group);
		return upToLeaderResult;
	}
	

}
