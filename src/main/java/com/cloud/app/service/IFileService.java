package com.cloud.app.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

public interface IFileService {
	//save File
	 void saveFile(MultipartFile file,HttpServletRequest request,Integer userId);
	//get File
	 void getFile (HttpServletRequest request,  
		      HttpServletResponse response, String fileName, String fileContentType
		       ) throws Exception;

}