package com.cloud.testmybatis;



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
import com.cloud.app.model.User;
import com.cloud.app.model.UserAllFile;
import com.cloud.app.service.IFileService;
import com.cloud.app.service.IUserService;


@RunWith(SpringJUnit4ClassRunner.class) //表示继承了SpringJUnit4ClassRunner类
@ContextConfiguration(locations = {"classpath:spring-mybatis.xml"}) //加载spring的配置文件
public class TestMybatis {
	
	private static Logger logger = Logger.getLogger(TestMybatis.class);
	
	@Resource
	private IUserService userService = null;
	
	@Resource
	private IFileService fileService=null;
	
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

}
