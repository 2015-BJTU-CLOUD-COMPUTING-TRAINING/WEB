package com.cloud.app.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cloud.app.model.User;
import com.cloud.app.model.UserAllFile;
import com.cloud.app.service.IFileService;
import com.cloud.app.service.IMessageService;
import com.cloud.app.service.IShareService;

@Controller
public class RecycleController {

	@Autowired
	IFileService fileService;
	
	@Autowired
	IShareService shareService;
	
	@Autowired
	IMessageService messageService;

	@RequestMapping("/recycle")
	public String getAllRecycleFile(HttpSession session, Model model) {
		User user = (User) session.getAttribute("currentUser");
		//获得当前用户所有回收站内文件
		List<UserAllFile> userAllRecycleFile = fileService.getAllRecycleFileByUserID(user
				.getUserId());
		model.addAttribute("userAllRecycleFile", userAllRecycleFile);
		return "recycle";
	}
	
	@RequestMapping("/restore")
	public String restore(String uploadIds, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		//恢复回收站内文件
		fileService.restore(uploadIds);
		return "redirect:/index";
	}
	
	

	@RequestMapping("/deleteRecycleFile")
	public String deleteRecycleFile(String uploadIds, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		//彻底删除
		fileService.deleteRecycleFile(uploadIds);
		return "redirect:/recycle";
	}

}
