package com.cloud.app.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.cloud.app.model.Messages;
import com.cloud.app.model.User;
import com.cloud.app.service.IMessageService;

@Controller
public class MessageController {
	
	@Autowired
	IMessageService messageService;
	
	@RequestMapping("getAllMessages")
	public void getAllMessages(HttpServletRequest request,HttpServletResponse response) throws IOException{
		User currentUser = (User) request.getSession().getAttribute("currentUser");
		List<Messages> allMessages = new ArrayList<Messages>();
		if(null!=currentUser){
 		 allMessages = messageService.getAllMessages(currentUser.getUserId());
		}
		response.setContentType("text/javascript;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(JSON.toJSONString(allMessages,SerializerFeature.DisableCircularReferenceDetect));	
	}
	
	@RequestMapping("/accept")
	public void accept(@RequestParam("messageId") String messageId,HttpServletRequest request,HttpServletResponse response) throws IOException{
		
		response.setContentType("text/javascript;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(JSON.toJSONString(messageService.acceptMessage(messageId)));	
	}
	
	@RequestMapping("/reject")
	public void reject(@RequestParam("messageId") String messageId,HttpServletRequest request,HttpServletResponse response) throws IOException{
		response.setContentType("text/javascript;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(JSON.toJSONString(messageService.rejectMessage(messageId)));	
	}
	
}
