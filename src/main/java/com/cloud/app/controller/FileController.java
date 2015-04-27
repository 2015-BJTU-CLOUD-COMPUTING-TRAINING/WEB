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

@Controller
public class FileController {

	@Resource
	IFileService fileService;

	@RequestMapping("/index")
	public String getAllFile(HttpSession session, Model model) {
		System.out
				.println("--------------------------index--------------------------");
		// 打印session
		Enumeration<String> e = session.getAttributeNames();
		while (e.hasMoreElements()) {
			String s = e.nextElement();
			System.out.println("index session:" + s + " == "
					+ session.getAttribute(s));
		}
		// 打印model
		Map<String, Object> modelMap = model.asMap();
		for (Object modelKey : modelMap.keySet()) {
			Object modelValue = modelMap.get(modelKey);
			System.out.println("index model:" + modelKey + " -- " + modelValue);
		}
		User user = (User) session.getAttribute("currentUser");
		List<UserAllFile> userAllFile = fileService.getAllFileByUserID(user
				.getUserId());
		model.addAttribute("userAllFile", userAllFile);
		return "index";
	}

	@RequestMapping("/upload")
	public String upload(@RequestParam("file") MultipartFile[] files,
			HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("currentUser");
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
	public String download(String fileIds, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out
				.println("--------------------------download--------------------------");
		System.out.println(fileIds);
		System.out.println(request.getSession().getAttribute("currentUser"));
		fileService.getFile(request, response, fileIds);
		return null;
	}

	@RequestMapping("/delete")
	public String delete(String fileIds, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out
				.println("--------------------------delete--------------------------");
		System.out.println(fileIds);
		System.out.println(request.getSession().getAttribute("currentUser"));
		// String storeName="demoUpload2班-14126101-胡志伟-外文库-MeTeL-49.key";
		// String contentType = "application/octet-stream";
		// fileService.getFile(request, response, storeName, contentType);
		return "redirect:/index";
	}

	@RequestMapping("/share")
	public String share(String fileIds, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out
				.println("--------------------------share--------------------------");
		System.out.println(fileIds);
		System.out.println(request.getSession().getAttribute("currentUser"));
		// String storeName="demoUpload2班-14126101-胡志伟-外文库-MeTeL-49.key";
		// String contentType = "application/octet-stream";
		// fileService.getFile(request, response, storeName, contentType);
		return "redirect:/index";
	}

}
