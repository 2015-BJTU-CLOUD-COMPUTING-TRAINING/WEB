package com.cloud.app.service.impl;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.cloud.app.model.Group;
import com.cloud.app.model.GroupAllFile;
import com.cloud.app.model.GroupFile;
import com.cloud.app.model.HDFS;
import com.cloud.app.model.User;
import com.cloud.app.model.UserAllFile;
import com.cloud.app.model.UserFile;
import com.cloud.app.service.IFileService;
import com.cloud.framwork.dao.GroupFileMapper;
import com.cloud.framwork.dao.GroupMapper;
import com.cloud.framwork.dao.HDFSMapper;
import com.cloud.framwork.dao.ShareMapper;
import com.cloud.framwork.dao.UserFileMapper;
import com.cloud.framwork.dao.UserMapper;
import com.cloud.testmybatis.TestMybatis;
import com.cloud.util.HashValue;
import com.cloud.util.ZipFile;
@Service("fileService")
public class FileServiceImpl implements IFileService{
	private static Logger logger = Logger.getLogger(FileServiceImpl.class);
	@Autowired
	ZipFile zipfile;
	
	@Autowired
	HashValue hashValue;
	
	@Autowired
	HDFS hdfs;
	
	@Autowired
	HDFSMapper hdfsDao;
	
	@Autowired
	UserFile userFile;
	
	@Autowired
    UserFileMapper userFileDao; 
	
	@Autowired
	ShareMapper shareDao;
	
	@Autowired
	User user;
	
	@Autowired
	UserMapper userDao;
	
	@Autowired
	GroupFileMapper groupFileDao;
	
	@Autowired
	GroupFile groupFile;
	
	@Autowired
	GroupMapper groupDao;
	
	@Autowired
	Group group;
	
	@Override
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
	
	@Override
	 public  void getFile(HttpServletRequest request,  
		      HttpServletResponse response, String uploadIds
		       ) throws Exception {  
		    //设置字符编码
		 	request.setCharacterEncoding("UTF-8");
		    //获得请求的fileId
		 	String [] vals = uploadIds.split(",");
		 	//下载文件路径
		 	String downloadUrl;
		 	//下载文件名称
		    String downloadName="";
		    
		    //当存在多个文件时
		    if(vals.length>1){
		    //获得所有需要下载的文件所在路径
		    String filesUrl[] = new String[vals.length];
		    String filesName[] = new String[vals.length];
		    int i=0;
		    for(String uploadId:vals){
		    	userFile=userFileDao.selectByPrimaryKey(Integer.parseInt(uploadId));
		    	hdfs=hdfsDao.selectByPrimaryKey(userFile.getFileId());
		    	logger.info(JSON.toJSONString(userFile));
		    	logger.info(JSON.toJSONString(hdfs));
		    	
		    	
		    	if(i==0){
		    		//设置打包文件名
		    		 downloadName="【批量下载】"+userFile.getFileName()+"等.zip";
		    	}
		    	//get the  path of targetfile
		    	filesUrl[i]=hdfs.getFileUrl();
		    	filesName[i]=userFile.getFileName();
		    	i++;
		    	
		    }
		    //设置打包文件路径
		    downloadUrl="/Users/cJack1913/Downloads/test/"+downloadName;
		    //打包文件
		    zipfile.zipFile(filesUrl,filesName, downloadUrl);
		    }else{
		    	userFile=userFileDao.selectByPrimaryKey(Integer.parseInt(vals[0]));
		    	hdfs=hdfsDao.selectByPrimaryKey(userFile.getFileId());
		    	logger.info(JSON.toJSONString(userFile));
		    	logger.info(JSON.toJSONString(hdfs));
		    	//设置文件路径和文件名
			    downloadUrl=hdfs.getFileUrl();
		    	downloadName=userFile.getFileName();
		    }
		    
		    logger.info(JSON.toJSONString(downloadUrl));
	    	logger.info(JSON.toJSONString(downloadName));
	    	
	    	// 清空response
            response.reset();
            // 设置response的Header
		    response.setHeader("Content-disposition", "attachment; filename="  
		        + new String(downloadName.getBytes("utf-8"), "ISO8859-1")); 
		    response.setHeader("Content-Length", String.valueOf(new File(downloadUrl).length()));
		    
		    //设置输出流  
		    BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());;
		    //设置输入流
		    BufferedInputStream bis = new BufferedInputStream(new FileInputStream(downloadUrl));
		    
		 	//写入文件
		 	byte[] buff = new byte[2048];  
		    int bytesRead;  
		    while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
		      bos.write(buff, 0, bytesRead);  
		    }  
		 
		    //close the IO stream
		    bis.close();
		    File zipfile = new File(downloadUrl);
		    zipfile.delete();
		    bos.close();  
		    
		    
		 
	 }

	@Override
	public List<UserAllFile> getAllFileByUserID(Integer userId) {
		// TODO Auto-generated method stub
		
		List<UserAllFile> userAllFile=userFileDao.selectAllByUserIdAndState(userId, 0);
		return userAllFile;
	}
	
	

	@Override
	public int deleteFile(String uploadIds) {
		// TODO Auto-generated method stub
		long existedVolume;
		String [] vals = uploadIds.split(",");
		for(String uploadId:vals){
			//将文件放入回收站
			userFile = userFileDao.selectByPrimaryKey(Integer.parseInt(uploadId));
			userFile.setDeleteTime(new Date());
			userFile.setState(1);
	    	userFileDao.updateByPrimaryKey(userFile);
	    	//update用户existedVolume
	    	hdfs = hdfsDao.selectByPrimaryKey(userFile.getFileId());
	    	user = userDao.selectByPrimaryKey(userFile.getUserId());
	    	existedVolume=user.getExistedVolume();
	    	existedVolume-=hdfs.getFileSize();
	    	user.setExistedVolume(existedVolume);
	    	userDao.updateByPrimaryKey(user);
	    	
		}
		return 1;
	}

	@Override
	public List<UserAllFile> getAllRecycleFileByUserID(Integer userId) {
		// TODO Auto-generated method stub
		List<UserAllFile> userAllFile=userFileDao.selectAllByUserIdAndState(userId, 1);
		return userAllFile;
	}

	@Override
	public int deleteRecycleFile(String uploadIds) {
		// TODO Auto-generated method stub
		String [] vals = uploadIds.split(",");
		for(String uploadId:vals){
			userFile=userFileDao.selectByPrimaryKey(Integer.parseInt(uploadId));
			shareDao.deleteByUserIdAndFileId(userFile.getUserId(), userFile.getFileId());
			userFileDao.deleteByPrimaryKey(Integer.parseInt(uploadId));
			
		}
		return 1;
	}

	@Override
	public int restore(String uploadIds) {
		String [] vals = uploadIds.split(",");
		long existedVolume;
		for(String uploadId:vals){
			//将文件从回收站取出
			userFile = userFileDao.selectByPrimaryKey(Integer.parseInt(uploadId));
			userFile.setDeleteTime(null);
			userFile.setState(0);
	    	userFileDao.updateByPrimaryKey(userFile);
	     	//update用户existedVolume
	    	hdfs = hdfsDao.selectByPrimaryKey(userFile.getFileId());
	    	user = userDao.selectByPrimaryKey(userFile.getUserId());
	    	existedVolume=user.getExistedVolume();
	    	existedVolume+=hdfs.getFileSize();
	    	user.setExistedVolume(existedVolume);
	    	userDao.updateByPrimaryKey(user);
		}
		return 1;
	}

	@Override
	public List<GroupAllFile> getAllFileByGroupID(Integer groupId) {

		List<GroupAllFile> GroupAllFile=groupFileDao.selectAllByGroupIdAndState(groupId, 0);
		return GroupAllFile;
	}

	@Override
	public List<String> shareToGroup(String uploadIds, String groupIds) {
		// TODO Auto-generated method stub
		List<String> shareToGroupMessage = new ArrayList<String>();
		String [] uploads = uploadIds.split(",");
		String [] groups = groupIds.split(",");
		//获得所有分享文件的大小
		long fileSize = 0;
		for(String uploadId:uploads){
			userFile = userFileDao.selectByPrimaryKey(Integer.parseInt(uploadId));
			fileSize+=hdfsDao.selectByPrimaryKey(userFile.getFileId()).getFileSize();
		}
		
		for(String groupId:groups){
			group = groupDao.selectByPrimaryKey(Integer.parseInt(groupId));
			
			//空间不足时
			if((group.getExistedVolume()+fileSize)>group.getTotalVolume()){
				shareToGroupMessage.add(group.getGroupName()+"   剩余空间不足，分享失败！");
			}
			//空间充足时
			else
			{
				for(String uploadId:uploads){
					//转存至组空间
					userFile = userFileDao.selectByPrimaryKey(Integer.parseInt(uploadId));
					groupFile.setUploadId(null);
					groupFile.setFileId(userFile.getFileId());
					groupFile.setFileName(userFile.getFileName());
					groupFile.setGroupId(Integer.parseInt(groupId));
					groupFile.setUploaderId(userFile.getUserId());
					groupFileDao.myinsert(groupFile);
					//更新组容量
					group.setExistedVolume(group.getExistedVolume()+hdfsDao.selectByPrimaryKey(userFile.getFileId()).getFileSize());
				}
				groupDao.updateByPrimaryKey(group);
				shareToGroupMessage.add(group.getGroupName()+"   分享成功！");
			}
			
		}
		return shareToGroupMessage;
	}

	

	
}
