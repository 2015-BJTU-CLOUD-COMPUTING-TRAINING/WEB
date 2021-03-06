package com.cloud.app.model;

import java.util.Date;

import org.springframework.stereotype.Repository;
@Repository
public class UserFile {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column USER_FILE.UPLOAD_ID
     *
     * @mbggenerated
     */
    private Integer uploadId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column USER_FILE.USER_ID
     *
     * @mbggenerated
     */
    private Integer userId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column USER_FILE.FILE_NAME
     *
     * @mbggenerated
     */
    private String fileName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column USER_FILE.FILE_ID
     *
     * @mbggenerated
     */
    private Integer fileId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column USER_FILE.UPLOAD_TIME
     *
     * @mbggenerated
     */
    private Date uploadTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column USER_FILE.FILE_LASTMODIFIED
     *
     * @mbggenerated
     */
    private Date fileLastmodified;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column USER_FILE.STATE
     *
     * @mbggenerated
     */
    private Integer state;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column USER_FILE.DELETE_TIME
     *
     * @mbggenerated
     */
    private Date deleteTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column USER_FILE.COMMENT
     *
     * @mbggenerated
     */
    private String comment;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column USER_FILE.UPLOAD_ID
     *
     * @return the value of USER_FILE.UPLOAD_ID
     *
     * @mbggenerated
     */
    public Integer getUploadId() {
        return uploadId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column USER_FILE.UPLOAD_ID
     *
     * @param uploadId the value for USER_FILE.UPLOAD_ID
     *
     * @mbggenerated
     */
    public void setUploadId(Integer uploadId) {
        this.uploadId = uploadId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column USER_FILE.USER_ID
     *
     * @return the value of USER_FILE.USER_ID
     *
     * @mbggenerated
     */
    public Integer getUserId() {
        return userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column USER_FILE.USER_ID
     *
     * @param userId the value for USER_FILE.USER_ID
     *
     * @mbggenerated
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column USER_FILE.FILE_NAME
     *
     * @return the value of USER_FILE.FILE_NAME
     *
     * @mbggenerated
     */
    public String getFileName() {
        return fileName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column USER_FILE.FILE_NAME
     *
     * @param fileName the value for USER_FILE.FILE_NAME
     *
     * @mbggenerated
     */
    public void setFileName(String fileName) {
        this.fileName = fileName == null ? null : fileName.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column USER_FILE.FILE_ID
     *
     * @return the value of USER_FILE.FILE_ID
     *
     * @mbggenerated
     */
    public Integer getFileId() {
        return fileId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column USER_FILE.FILE_ID
     *
     * @param fileId the value for USER_FILE.FILE_ID
     *
     * @mbggenerated
     */
    public void setFileId(Integer fileId) {
        this.fileId = fileId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column USER_FILE.UPLOAD_TIME
     *
     * @return the value of USER_FILE.UPLOAD_TIME
     *
     * @mbggenerated
     */
    public Date getUploadTime() {
        return uploadTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column USER_FILE.UPLOAD_TIME
     *
     * @param uploadTime the value for USER_FILE.UPLOAD_TIME
     *
     * @mbggenerated
     */
    public void setUploadTime(Date uploadTime) {
        this.uploadTime = uploadTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column USER_FILE.FILE_LASTMODIFIED
     *
     * @return the value of USER_FILE.FILE_LASTMODIFIED
     *
     * @mbggenerated
     */
    public Date getFileLastmodified() {
        return fileLastmodified;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column USER_FILE.FILE_LASTMODIFIED
     *
     * @param fileLastmodified the value for USER_FILE.FILE_LASTMODIFIED
     *
     * @mbggenerated
     */
    public void setFileLastmodified(Date fileLastmodified) {
        this.fileLastmodified = fileLastmodified;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column USER_FILE.STATE
     *
     * @return the value of USER_FILE.STATE
     *
     * @mbggenerated
     */
    public Integer getState() {
        return state;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column USER_FILE.STATE
     *
     * @param state the value for USER_FILE.STATE
     *
     * @mbggenerated
     */
    public void setState(Integer state) {
        this.state = state;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column USER_FILE.DELETE_TIME
     *
     * @return the value of USER_FILE.DELETE_TIME
     *
     * @mbggenerated
     */
    public Date getDeleteTime() {
        return deleteTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column USER_FILE.DELETE_TIME
     *
     * @param deleteTime the value for USER_FILE.DELETE_TIME
     *
     * @mbggenerated
     */
    public void setDeleteTime(Date deleteTime) {
        this.deleteTime = deleteTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column USER_FILE.COMMENT
     *
     * @return the value of USER_FILE.COMMENT
     *
     * @mbggenerated
     */
    public String getComment() {
        return comment;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column USER_FILE.COMMENT
     *
     * @param comment the value for USER_FILE.COMMENT
     *
     * @mbggenerated
     */
    public void setComment(String comment) {
        this.comment = comment == null ? null : comment.trim();
    }
}