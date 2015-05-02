package com.cloud.app.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import com.cloud.app.model.User;
import com.cloud.app.model.UserAllFile;
import com.cloud.app.model.UserFile;
import com.cloud.app.service.IFileService;
import com.cloud.app.service.IMessageService;
import com.cloud.app.service.IShareService;
import com.cloud.app.service.IUserService;

@Controller
public class FileController {

	@Autowired
	IFileService fileService;
	
	@Autowired
	IShareService shareService;
	
	@Autowired
	IMessageService messageService;
	
	@Autowired
	IUserService userService;

	@RequestMapping("/index")
	public String getAllFile(HttpSession session, Model model) {
		User user = (User) session.getAttribute("currentUser");
		//根据当前用户id获得所有该用户文件
		List<UserAllFile> userAllFile = fileService.getAllFileByUserID(user
				.getUserId());
		model.addAttribute("userAllFile", userAllFile);
		return "index";
	}
	
	@RequestMapping("/uploadview")
	public String upload(HttpServletRequest request) {
		return "upload";
	}

	@RequestMapping("/upload")
	public String upload(@RequestParam("file") MultipartFile[] files,
			HttpServletRequest request,Model model) {
		User user = (User) request.getSession().getAttribute("currentUser");
		//上传文件总大小
		long fileSize = 0;
		//用户已用空间
		user = userService.getUserById(user.getUserId());
		long existedV = user.getExistedVolume();
		for (MultipartFile file : files) {
			if (!file.isEmpty()) {
				fileSize += file.getSize();
				// save file
				fileService.saveFile(file, request, user.getUserId());
			}
		}
		//更新用户已用空间
		user.setExistedVolume(existedV+fileSize);
		userService.update(user);
		return "redirect:/index";
	}

	@RequestMapping("/download")
	public String download(String uploadIds, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		fileService.getFile(request, response, uploadIds);
		return null;
	}

	@RequestMapping("/deleteFile")
	public String deleteFile(String uploadIds, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		fileService.deleteFile(uploadIds);
		return "redirect:/index";
	}

	@RequestMapping("/share")
	public String share(String uploadIds, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		shareService.shareFiles(uploadIds);
		return "redirect:/shareRecord";
	}
	
	

}
