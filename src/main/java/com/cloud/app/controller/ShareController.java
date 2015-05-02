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
		//根据当前用户id获得所有已分享文件
		User user = (User) session.getAttribute("currentUser");
		model.addAttribute("shareRecord", shareService.getAllShareRecordByUserID(user.getUserId()));
		return "share";
	}
	
	@RequestMapping("/deleteShare")
	public String deleteShare(String shareMarks,HttpSession session, Model model){
		//根据分享Mark取消分享
		shareService.deleteShare(shareMarks);
		return "redirect:/shareRecord";
	}
	
	@RequestMapping("/s/{mark}")
	public String showShareDetail(@PathVariable String mark,HttpSession session, Model model){
		//根据Mark获得分享详情
		List<ShareDetail> shareRecordDetail =  shareService.getAllShareDetailByMark(mark);
		model.addAttribute("shareRecordDetail", shareRecordDetail);
		return "shareDetail";
	}
	
	@RequestMapping("/saveFile")
	public String saveFile(HttpSession session ,String uploadIds){
		//根据当前用户id和分享文件的uploadId保存至当前用户空间中
		User user = (User) session.getAttribute("currentUser");
		shareService.saveFile(uploadIds,user.getUserId());
		return "redirect:/index";
	}
	

}
