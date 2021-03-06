package com.cloud.framwork.dao;

import com.cloud.app.model.Friend;
import com.cloud.app.model.User;

import java.util.List;

public interface FriendMapper {
	List<User> selectAllFriends(Integer userId);
	Friend selectByFriendIdAndUserId(Integer friendId,Integer userId);
	int deleteByUserId(Integer friendAId,Integer friendBId);
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table FRIEND_TABLE
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer friendsId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table FRIEND_TABLE
     *
     * @mbggenerated
     */
    int insert(Friend record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table FRIEND_TABLE
     *
     * @mbggenerated
     */
    Friend selectByPrimaryKey(Integer friendsId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table FRIEND_TABLE
     *
     * @mbggenerated
     */
    List<Friend> selectAll();

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table FRIEND_TABLE
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(Friend record);
}