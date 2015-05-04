package com.cloud.app.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cloud.app.model.Messages;
import com.cloud.app.service.IMessageService;

@Controller
public class MessageController {
	
	@Autowired
	IMessageService messageService;
	
	@RequestMapping("/accept")
	public String accept(@RequestParam("messageId") Integer messageId,HttpServletRequest request){
		
		List<Messages> messages = (List<Messages>)request.getSession().getAttribute("messages");
		for(Messages message:messages){
			if(message.getMessageId()==messageId){
				messageService.acceptMessage(message);
			}
		}
		return null;
	}
	
	@RequestMapping("/reject")
	public String reject(@RequestParam("messageId") Integer messageId,HttpServletRequest request){
		
		List<Messages> messages = (List<Messages>)request.getSession().getAttribute("messages");
		for(Messages message:messages){
			if(message.getMessageId()==messageId){
				messageService.rejectMessage(message);
			}
		}
		
		return null;
	}
	
}
