package com.cloud.app.model;


import java.util.Date;

import org.springframework.stereotype.Repository;
@Repository
public class Messages {
    private User fromUser;
    private Group group;

    private Integer messageId;
    private Integer fromId;
    private Integer toId;
    private Integer messageType;
    private Integer messageContent;
    private Integer stateOp;
    private Date timeBuild;
    private String comment;
	public User getFromUser() {
		return fromUser;
	}
	public void setFromUser(User fromUser) {
		this.fromUser = fromUser;
	}
	public Group getGroup() {
		return group;
	}
	public void setGroup(Group group) {
		this.group = group;
	}
	public Integer getMessageId() {
		return messageId;
	}
	public void setMessageId(Integer messageId) {
		this.messageId = messageId;
	}
	public Integer getFromId() {
		return fromId;
	}
	public void setFromId(Integer fromId) {
		this.fromId = fromId;
	}
	public Integer getToId() {
		return toId;
	}
	public void setToId(Integer toId) {
		this.toId = toId;
	}
	public Integer getMessageType() {
		return messageType;
	}
	public void setMessageType(Integer messageType) {
		this.messageType = messageType;
	}
	public Integer getMessageContent() {
		return messageContent;
	}
	public void setMessageContent(Integer messageContent) {
		this.messageContent = messageContent;
	}
	public Integer getStateOp() {
		return stateOp;
	}
	public void setStateOp(Integer stateOp) {
		this.stateOp = stateOp;
	}
	public Date getTimeBuild() {
		return timeBuild;
	}
	public void setTimeBuild(Date timeBuild) {
		this.timeBuild = timeBuild;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	@Override
	public String toString() {
		return "Messages [fromUser=" + fromUser + ", group=" + group
				+ ", messageId=" + messageId + ", fromId=" + fromId + ", toId="
				+ toId + ", messageType=" + messageType + ", messageContent="
				+ messageContent + ", stateOp=" + stateOp + ", timeBuild="
				+ timeBuild + ", comment=" + comment + "]";
	}
    
}