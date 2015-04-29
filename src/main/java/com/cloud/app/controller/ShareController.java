package com.cloud.app.controller;



import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cloud.app.model.ShareDetail;
import com.cloud.app.model.User;
import com.cloud.app.service.IMessageService;
import com.cloud.app.service.IShareService;

@Controller
public class ShareController {
	
	@Autowired
	private IShareService shareService;
	
	@Autowired
	private IMessageService messageService;
	
	@RequestMapping("/shareRecord")
	public String showShareRecord(HttpSession session, Model model){
		System.out
		.println("--------------------------showShareRecord--------------------------");
		User user = (User) session.getAttribute("currentUser");
		if(user==null){
			return "redirect:/login";
		}
		model.addAttribute("shareRecord", shareService.getAllShareRecordByUserID(user.getUserId()));
		session.setAttribute("messages", messageService.getAllMessages(user.getUserId()));
		return "share";
	}
	
	@RequestMapping("/s/{mark}")
	public String showShareDetail(@PathVariable String mark,HttpSession session, Model model){
		System.out
		.println("--------------------------showShareDetail--------------------------");
		List<ShareDetail> shareRecordDetail =  shareService.getAllShareDetailByMark(mark);
		model.addAttribute("shareUser", shareRecordDetail.get(0).getUser());
		model.addAttribute("shareRecordDetail", shareRecordDetail);
		return "shareDetail";
	}

}
