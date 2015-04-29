package com.cloud.app.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloud.app.model.Share;
import com.cloud.app.model.ShareDetail;
import com.cloud.app.model.UserFile;
import com.cloud.app.service.IShareService;
import com.cloud.framwork.dao.ShareMapper;
import com.cloud.framwork.dao.UserFileMapper;
import com.cloud.util.GetRandomString;
@Service
public class ShareServiceImpl implements IShareService {
	
	@Autowired
	private UserFile userFile;
	
	@Autowired
	private UserFileMapper userFileDao;
	
	@Autowired
	private Share share;
	
	@Autowired
	private ShareMapper shareDao;
	
	@Autowired
	private GetRandomString getRandomString;

	@Override
	public List<Share> getAllShareRecordByUserID(Integer userId) {
		// TODO Auto-generated method stub
		List<Share> AllShareRecords = shareDao.selectByUserId(userId);
		List<Share> showAllShareRecords=new ArrayList<Share>();
		List<String> marks = new ArrayList<String>();
		for(Share record:AllShareRecords){
			if(!marks.contains(record.getMark())){
				marks.add(record.getMark());
				showAllShareRecords.add(record);
			}
			
		}
		return showAllShareRecords;
	}

	@Override
	public int shareFiles(String uploadIds) {
		String [] vals = uploadIds.split(",");
		String mark = getRandomString.getRandomString(6);
		while(!shareDao.selectByMark(mark).isEmpty()){
			mark = getRandomString.getRandomString(6);
		}
		
		for(String uploudId:vals){
			userFile = userFileDao.selectByPrimaryKey(Integer.parseInt(uploudId));
			share.setFileId(userFile.getFileId());
			share.setFileName(userFile.getFileName());
			share.setUserId(userFile.getUserId());
			share.setMark(mark);
			shareDao.myinsert(share);
		}
		return 1;
	}

	@Override
	public int deleteShare(String uploadIds) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ShareDetail> getAllShareDetailByMark(String mark) {
		// TODO Auto-generated method stub
		return shareDao.selectShareDetailByMark(mark);
	}

	@Override
	public int saveFile(String uploadIds,Integer userId) {
		// TODO Auto-generated method stub
		String [] vals = uploadIds.split(",");
		for(String uploudId:vals){
			UserFile olduserFile = userFileDao.selectByPrimaryKey(Integer.parseInt(uploudId));
			userFile.setFileId(olduserFile.getFileId());
			userFile.setFileName(olduserFile.getFileName());
			userFile.setUserId(userId);
			userFileDao.myinsert(userFile);
		}
		return 1;
	}

}
