package com.cloud.app.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.cloud.app.model.UserAllFile;
import com.cloud.app.model.UserFile;

public interface IFileService {
	//save File
	 void saveFile(MultipartFile file,HttpServletRequest request,Integer userId);
	//get File
	 void getFile (HttpServletRequest request,  
		      HttpServletResponse response, String fileIds) throws Exception;
	 List<UserAllFile> getAllFileByUserID(Integer userId);
	 
}