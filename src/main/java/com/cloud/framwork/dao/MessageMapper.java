package com.cloud.framwork.dao;

import com.cloud.app.model.Message;
import com.cloud.app.model.Messages;

import java.util.List;

public interface MessageMapper {
	
	int Addmessage(Message message);
	
	List<Messages> getAllMessages(Integer userId);
	
	int updateMessageState(Integer messageId,Integer State_OP);
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table MESSAGE_TABLE
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer messageId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table MESSAGE_TABLE
     *
     * @mbggenerated
     */
    int insert(Message record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table MESSAGE_TABLE
     *
     * @mbggenerated
     */
    Message selectByPrimaryKey(Integer messageId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table MESSAGE_TABLE
     *
     * @mbggenerated
     */
    List<Message> selectAll();

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table MESSAGE_TABLE
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(Message record);
}