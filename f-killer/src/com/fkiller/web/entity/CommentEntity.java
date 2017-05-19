package com.fkiller.web.entity;

import java.sql.Date;

public class CommentEntity {
	private int commentNo;
	private int userNo;
	private int jobNo;
	private String commentDesc;
	private Date regDate;
	
	public CommentEntity(){
		
	}
	
	public CommentEntity(int commentNo,int userNo,int jobNo,String commentDesc,Date regDate){
		this.commentNo = commentNo;
		this.userNo = userNo;
		this.jobNo = jobNo;
		this.commentDesc = commentDesc;
		this.regDate = regDate;
	}
	
	public CommentEntity(int userNo,int jobNo,String commentDesc,Date regDate){
		this.userNo = userNo;
		this.jobNo = jobNo;
		this.commentDesc = commentDesc;
		this.regDate = regDate;
	}
	
	public CommentEntity(int userNo,int jobNo,String commentDesc){
		this.userNo = userNo;
		this.jobNo = jobNo;
		this.commentDesc = commentDesc;
	}

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getJobNo() {
		return jobNo;
	}

	public void setJobNo(int jobNo) {
		this.jobNo = jobNo;
	}

	public String getCommentDesc() {
		return commentDesc;
	}

	public void setCommentDesc(String commentDesc) {
		this.commentDesc = commentDesc;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	public String toString(){
		return "commentNo:"+commentNo+"/userNo:"+userNo+"/jobNo:"+jobNo+"/commentDesc:"+commentDesc+"/regDate:"+regDate;
	}
}
