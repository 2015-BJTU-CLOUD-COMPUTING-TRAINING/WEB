package com.cloud.app.service.impl;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cloud.app.model.HDFS;
import com.cloud.app.model.UserAllFile;
import com.cloud.app.model.UserFile;
import com.cloud.app.service.IFileService;
import com.cloud.framwork.dao.HDFSMapper;
import com.cloud.framwork.dao.UserFileMapper;
import com.cloud.framwork.dao.UserMapper;
import com.cloud.util.HashValue;
@Service("fileService")
public class FileServiceImpl implements IFileService{
	@Autowired
	HashValue hashValue;
	
	@Autowired
	HDFS hdfs;
	
	@Autowired
	HDFSMapper hdfsDao;
	
	@Autowired
	UserFile userFile;
	
	@Autowired
    private UserFileMapper userFileDao; 
	
	public void saveFile(MultipartFile file,HttpServletRequest request,Integer userId){
		try {  
			String hash = hashValue.getHashValue(file, 32);
			
			//get the root path of webapp 
		    String rootPath = request.getSession().getServletContext()  
		        .getRealPath(""); 
            //set the file path 
            String path ="/Users/cJack1913/Downloads/test/"+hash+file.getOriginalFilename();  
            //save file
            File localFile = new File(path);  
            file.transferTo(localFile);  
            System.out.println("filepath"+path);
            System.out.println(new Date(localFile.lastModified()));
            hdfs.setFileMd5(hash);
            hdfs.setFileSize(file.getSize());
            hdfs.setFileType(file.getContentType());
            hdfs.setFileUrl(path);
            hdfsDao.insert(hdfs);
            
            userFile.setFileId(hdfs.getFileId());
            userFile.setUserId(userId);
			userFile.setFileName(file.getOriginalFilename());
            userFileDao.myinsert(userFile);
           /*
            * 此处还查hash
            * 回滚
            * 
            */
            
            
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

	@Override
	public List<UserAllFile> getAllFileByUserID(Integer userId) {
		// TODO Auto-generated method stub
		
		List<UserAllFile> userAllFile=userFileDao.selectAllByUserId(userId);
		return userAllFile;
	}

	

	
}
