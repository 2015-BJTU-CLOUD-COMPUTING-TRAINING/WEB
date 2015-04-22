package com.cloud.app.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.Iterator;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import com.cloud.util.operateFile;

@Controller
@RequestMapping("/file")
public class FileController {
	
	@Resource
	operateFile operateFile;
	
	@RequestMapping("/upload")
	public String addUsers(@RequestParam("file") MultipartFile[] files,
			HttpServletRequest request) {

		for (MultipartFile file : files) {
			
			System.out.println("文件类型："+file.getContentType());
		      System.out.println("文件名称："+file.getOriginalFilename());
		      System.out.println("文件大小:"+file.getSize());
		      System.out.println(".................................................");
			if (!file.isEmpty()) {
				operateFile.saveFile(file);
			}
		}
		return "upload";
	}
	
	@RequestMapping(value = "/download")  
	  public ModelAndView download(HttpServletRequest request,  
	      HttpServletResponse response) throws Exception {  
	  
//			String storeName = "Spring3.xAPI_zh.chm";  
	    String storeName="demoUpload2班-14126101-胡志伟-外文库-MeTeL-49.key";
	    String contentType = "application/octet-stream";  
	    operateFile.getFile(request, response, storeName, contentType);  
	    return null;  
	  }  
}
