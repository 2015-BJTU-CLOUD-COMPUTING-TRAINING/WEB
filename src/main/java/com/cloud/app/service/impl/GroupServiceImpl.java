package com.cloud.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloud.app.model.Group;
import com.cloud.app.model.Member;
import com.cloud.app.model.User;
import com.cloud.app.service.IGroupService;
import com.cloud.framwork.dao.GroupMapper;
import com.cloud.framwork.dao.MemberMapper;

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

	@Override
	public List<Group> ShowGroup(int userId) {
		// TODO Auto-generated method stub
		List<Group> AllGroups = groupDao.selectAllGroups(userId);
		return AllGroups;
	}

	@Override
	public int exitGroup(String groupIds, Integer userId) {
		// TODO Auto-generated method stub
		String [] vals = groupIds.split(",");
		for(String groupId:vals){
			memberDao.deleteByGroupIdAndUserId(Integer.parseInt(groupId), userId);
			group = groupDao.selectByPrimaryKey(Integer.parseInt(groupId));
			
			//只有非群主可以退群，若是管理员，则置空管理员字段
			if(group.getGroupDeputy1Id()==userId){
				group.setGroupDeputy1Id(null);
			}else if(group.getGroupDeputy2Id()==userId){
				group.setGroupDeputy2Id(null);
			}else if(group.getGroupDeputy3Id()==userId){
				group.setGroupDeputy3Id(null);
			}
			groupDao.updateByPrimaryKey(group);
		}
		return 1;
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
	

}
