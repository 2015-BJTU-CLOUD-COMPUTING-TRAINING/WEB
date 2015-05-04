package com.cloud.app.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.cloud.app.model.GroupAllFile;
import com.cloud.app.model.UserAllFile;
import com.cloud.app.model.UserFile;

public interface IFileService {
	//save File
	 void saveFile(MultipartFile file,HttpServletRequest request,Integer userId);
	//get File
	 void getFile (HttpServletRequest request,  
		      HttpServletResponse response, String uploadIds) throws Exception;
	 
	 void getGroupFile (HttpServletRequest request,  
		      HttpServletResponse response, String uploadIds) throws Exception;
	 List<UserAllFile> getAllFileByUserID(Integer userId);
	 
	 List<UserAllFile> getAllRecycleFileByUserID(Integer userId);
	 
	 int deleteFile(String uploadIds);
	 List<String> deleteGroupFile(String uploadIds,Integer userId);
	 int  deleteRecycleFile(String uploadIds);
	 int  restore(String uploadIds);
	 
	 List<GroupAllFile> getAllFileByGroupID(Integer groupId);
	 
	 List<String> shareToGroup(String uploadIds,String groupIds);
	
}