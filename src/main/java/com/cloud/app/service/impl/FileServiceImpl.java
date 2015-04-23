package com.cloud.app.service.impl;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cloud.app.model.UserFile;
import com.cloud.app.service.IFileService;
import com.cloud.framwork.dao.UserFileMapper;
import com.cloud.framwork.dao.UserMapper;
import com.cloud.util.HashValue;
@Service("fileService")
public class FileServiceImpl implements IFileService{
	@Resource
	UserFile userFile;
	@Resource
	HashValue hashValue;
	@Resource  
    private UserFileMapper userFileDao; 
	public void saveFile(MultipartFile file,HttpServletRequest request,Integer userId){
		try {  
			String hash = hashValue.getHashValue(file, 32);
			
			//get the root path of webapp 
		    String rootPath = request.getSession().getServletContext()  
		        .getRealPath(""); 
            //set the file path 
            String path =rootPath+hash;  
            System.out.println(path);
            //save file
            File localFile = new File(path);  
            file.transferTo(localFile);  
            
            userFile.setUserId(userId);
			userFile.setFileName(file.getOriginalFilename());
            userFile.setFileMd5(hash);
            userFileDao.myinsert(userFile);
        } catch (Exception e) {  
            e.printStackTrace();  
            System.out.println("上传出错");  
        }  
		
		
	}
	
	 public  void getFile(HttpServletRequest request,  
		      HttpServletResponse response, String fileName, String fileContentType
		       ) throws Exception {  
		    
		    request.setCharacterEncoding("UTF-8");  
		    BufferedInputStream bis = null;  
		    BufferedOutputStream bos = null;  
		  
		    //get the root path of webapp 
		    String rootPath = request.getSession().getServletContext()  
		        .getRealPath("");  
		    
		    //get the  path of targetfile
		    String downLoadPath = rootPath+"/uploadFile/"+ fileName;  
		  
		    //get the  length of file
		    long fileLength = new File(downLoadPath).length();  

		    //set the response type
		    response.setContentType(fileContentType);  
		    response.setHeader("Content-disposition", "attachment; filename="  
		        + new String(fileName.getBytes("utf-8"), "ISO8859-1")); 
		    response.setHeader("Content-Length", String.valueOf(fileLength));  
		   
		    //get the BufferedInputStream
		    bis = new BufferedInputStream(new FileInputStream(downLoadPath));  
		   
		    //get the BufferedOutputStream
		    bos = new BufferedOutputStream(response.getOutputStream());  
		    
		 	//write file
		 	byte[] buff = new byte[2048];  
		    int bytesRead;  
		    while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
		      bos.write(buff, 0, bytesRead);  
		    }  
		 
		    //close the IO stream
		    bis.close();  
		    bos.close();  
		 
		 
	 }

	

	
}
