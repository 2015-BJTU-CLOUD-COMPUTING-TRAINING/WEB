package com.cloud.testmybatis;



import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.alibaba.fastjson.JSON;
import com.cloud.app.model.Group;
import com.cloud.app.model.GroupAllFile;
import com.cloud.app.model.Message;
import com.cloud.app.model.Messages;
import com.cloud.app.model.Share;
import com.cloud.app.model.ShareDetail;
import com.cloud.app.model.User;
import com.cloud.app.model.UserAllFile;
import com.cloud.app.service.IFileService;
import com.cloud.app.service.IFriendService;
import com.cloud.app.service.IGroupService;
import com.cloud.app.service.IMessageService;
import com.cloud.app.service.IShareService;
import com.cloud.app.service.IUserService;
import com.cloud.util.GetRandomString;


@RunWith(SpringJUnit4ClassRunner.class) //表示继承了SpringJUnit4ClassRunner类
@ContextConfiguration(locations = {"classpath:spring-mybatis.xml"}) //加载spring的配置文件
public class TestMybatis {
	
	private static Logger logger = Logger.getLogger(TestMybatis.class);
	
	@Resource
	private IUserService userService ;
	
	@Resource
	private IFriendService friendService;
	
	@Resource
	private IMessageService messageService;
	
	@Resource
	private IFileService fileService;
	
	@Resource
	private GetRandomString getRandomString;
	
	@Resource
	private IShareService shareService;
	
	@Resource
	private IGroupService groupService;
	
	@Test
	public void test1(){
		User user = userService.getUserById(9);
		System.out.println(user);
		logger.info(JSON.toJSONString(user));
		System.out.println(user.getUserTimeBuild());
	}
	
	
	
	@Test
	public void test2(){
		List<UserAllFile> userAllFile = fileService.getAllFileByUserID(9);
		Iterator<UserAllFile> i = userAllFile.iterator(); 
		while(i.hasNext()){
			UserAllFile userfile=i.next();
			System.out.println(userfile);
			System.out.println(userfile.getHdfs());
		}
	}
	
	@Test
	public void test3(){
		List<User> userAllFriend = friendService.Showfriend(9);
		Iterator<User> i = userAllFriend.iterator(); 
		while(i.hasNext()){
			logger.info(JSON.toJSONString(i.next()));
		}
	}
	@Test
	public void test4(){
		System.out.println(messageService.Addfriendmessage(12, 9));
		System.out.println(messageService.Addfriendmessage(13, 9));
		System.out.println(messageService.Addfriendmessage(11, 9));
	}
	
	@Test
	public void test5(){
		List<Messages> messages = messageService.getAllMessages(9);
		for(Messages message:messages){
			logger.info(JSON.toJSONString(message.getFromUser()));
			logger.info(JSON.toJSONString(message.getGroup()));
		}
	}
	
	@Test
	public void test6(){
		List<Messages> messages = messageService.getAllMessages(9);
		for(Messages message:messages){
			if(message.getMessageId()==4){
				messageService.acceptMessage(message.getMessageId().toString());
			}
		}
	}
	
	@Test
	public void test7(){
		List<Messages> messages = messageService.getAllMessages(9);
		for(Messages message:messages){
			if(message.getMessageId()==3){
				messageService.rejectMessage(message.getMessageId().toString());
			}
		}
	}
	
	@Test
	public void test8(){
		System.out.println(getRandomString.getRandomString(10));
	}
	
	@Test
	public void test9(){
		String uploadIds="18,19,20,";
		shareService.shareFiles(uploadIds);
	}
	
	@Test
	public void test10(){
		
		List<Share> shareRecords = shareService.getAllShareRecordByUserID(9);
		for(Share shareRecord:shareRecords){
			logger.info(JSON.toJSONString(shareRecord));
		}
	}
	
	@Test
	public void test11(){
		
		List<ShareDetail> shareRecords = shareService.getAllShareDetailByMark("OJ0WVZ");
		for(ShareDetail shareRecord:shareRecords){
			logger.info(JSON.toJSONString(shareRecord));
		}
	}
	@Test
	public void test12(){
		System.out.println(new Date());
	}
	@Test
	public void test13(){
		List<Group> groups=groupService.ShowGroup(9);
		for(Group group:groups){
			logger.info(JSON.toJSONString(group));
		}
	}

	@Test
	public void test14(){
		List<GroupAllFile> groupAllFile = fileService.getAllFileByGroupID(1);
		logger.info(groupAllFile);
		for(GroupAllFile groupFile:groupAllFile){
			logger.info(JSON.toJSONString(groupFile));
		}
	}
	@Test
	public void test15(){
		List<User> groupAllMember = groupService.ShowMembers(1);
		logger.info(groupAllMember);
		for(User groupMember:groupAllMember){
			logger.info(JSON.toJSONString(groupMember));
		}
	}
	@Test
	public void test16(){
		List<String> shareToGroupMessages = fileService.shareToGroup("30,49,46", "1,2,3");
		logger.info(shareToGroupMessages);
		for(String groupMember:shareToGroupMessages){
			logger.info(JSON.toJSONString(groupMember));
		}
	}
	@Test
	public void test17(){
		List<Group> searchGroupResults = groupService.searchGroup("4");
		logger.info(searchGroupResults);
		for(Group searchGroupResult:searchGroupResults){
			logger.info(JSON.toJSONString(searchGroupResult));
		}
	}
	@Test
	public void test18(){
		List<String> joinGroupResults = groupService.joinGroup("1,2,3", 12);
		logger.info(joinGroupResults);
		for(String joinGroupResult:joinGroupResults){
			logger.info(JSON.toJSONString(joinGroupResult));
		}
	}
	@Test
	public void test19(){
		List<Messages> allMessages = null; 
		logger.info(JSON.toJSONString(allMessages));
		allMessages = new ArrayList<Messages>();
		logger.info(JSON.toJSONString(allMessages));
 		 allMessages = messageService.getAllMessages(9);
 		logger.info(JSON.toJSONString(allMessages));
	}
	
	
}
