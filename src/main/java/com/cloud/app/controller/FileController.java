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

@Controller
public class FileController {

	@Autowired
	IFileService fileService;
	
	@Autowired
	IShareService shareService;
	
	@Autowired
	IMessageService messageService;

	@RequestMapping("/index")
	public String getAllFile(HttpSession session, Model model) {
		System.out
				.println("--------------------------index--------------------------");
	
		User user = (User) session.getAttribute("currentUser");
		if(user==null){
			return "redirect:/login";
		}
		List<UserAllFile> userAllFile = fileService.getAllFileByUserID(user
				.getUserId());
		model.addAttribute("userAllFile", userAllFile);
		session.setAttribute("messages", messageService.getAllMessages(user.getUserId()));
		return "index";
	}

	@RequestMapping("/upload")
	public String upload(@RequestParam("file") MultipartFile[] files,
			HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("currentUser");
		if(user==null){
			return "redirect:/login";
		}
		for (MultipartFile file : files) {

			System.out.println("文件类型：" + file.getContentType());
			System.out.println("文件名称：" + file.getOriginalFilename());
			System.out.println("文件大小:" + file.getSize());
			System.out
					.println(".................................................");
			if (!file.isEmpty()) {
				// save file
				fileService.saveFile(file, request, user.getUserId());
			}
		}
		return "redirect:/index";
	}

	@RequestMapping("/download")
	public String download(String uploadIds, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out
				.println("--------------------------download--------------------------");
		System.out.println(uploadIds);
		fileService.getFile(request, response, uploadIds);
		return null;
	}

	@RequestMapping("/deleteFile")
	public String deleteFile(String uploadIds, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out
				.println("--------------------------delete--------------------------");
		User user = (User) request.getSession().getAttribute("currentUser");
		if(user==null){
			return "redirect:/login";
		}
		System.out.println(uploadIds);
		fileService.deleteFile(uploadIds);
		return "redirect:/index";
	}

	@RequestMapping("/share")
	public String share(String uploadIds, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out
				.println("--------------------------share--------------------------");
		User user = (User) request.getSession().getAttribute("currentUser");
		if(user==null){
			return "redirect:/login";
		}
		System.out.println(uploadIds);
		System.out.println(request.getSession().getAttribute("currentUser"));
		shareService.shareFiles(uploadIds);
		return "redirect:/shareRecord";
	}

}
