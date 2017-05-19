package com.fkiller.web.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class TeamJobListVo {
	private int jobNo;
	private int userNo;
	private String userName;
	private String jobTitle;
	private String memberColor;
	private Date dueDate;
	
	public TeamJobListVo(){
		
	}

	public TeamJobListVo(int jobNo, int userNo, String userName, String jobTitle, String memberColor,
			Date dueDate) {
		this.jobNo = jobNo;
		this.userNo = userNo;
		this.userName = userName;
		this.jobTitle = jobTitle;
		this.memberColor = memberColor;
		this.dueDate = dueDate;
	}

	public int getJobNo() {
		return jobNo;
	}

	public void setJobNo(int jobNo) {
		this.jobNo = jobNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getJobTitle() {
		return jobTitle;
	}

	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}

	public String getMemberColor() {
		return memberColor;
	}

	public void setMemberColor(String memberColor) {
		this.memberColor = memberColor;
	}

	public Date getDueDate() {
		return dueDate;
	}

	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}
	
	public String toString(){
		return "jobNo:"+jobNo+"/jobTitle:"+jobTitle+"/userNo:"+userNo+
				"/userName:"+userName+"/jobTitle:"+jobTitle+"/memberColor:"+memberColor+"/dueDate:"+dueDate;
	}
	
}
