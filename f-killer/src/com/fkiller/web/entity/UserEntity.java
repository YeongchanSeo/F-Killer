package com.fkiller.web.entity;

import java.sql.Date;

public class UserEntity {
	private int userNo;
	private String userName;
	private String userEmail;
	private String userPwd;
	private String userProfile;
	private String joinMethod;
	private Date regDate;
	private Date delDate;
	private boolean delFlg;
	
	public UserEntity(){
		
	}
	
	public UserEntity(int userNo,String userName,String userEmail,String userPwd,String userProfile,String joinMethod,Date regDate,Date delDate, boolean delFlg){
		this.userNo = userNo;
		this.userName = userName;
		this.userEmail = userEmail;
		this.userPwd = userPwd;
		this.userProfile = userProfile;
		this.joinMethod = joinMethod;
		this.regDate = regDate;
		this.delDate = delDate;
		this.delFlg = delFlg;
	}
	
	public UserEntity(int userNo,String userName,String userEmail,String userPwd,String userProfile,String joinMethod,Date regDate, boolean delFlg){
		this.userNo = userNo;
		this.userName = userName;
		this.userEmail = userEmail;
		this.userPwd = userPwd;
		this.userProfile = userProfile;
		this.joinMethod = joinMethod;
		this.regDate = regDate;
		this.delFlg = delFlg;
	}
	
	public UserEntity(String userName,String userEmail,String userPwd,String userProfile,String joinMethod,Date regDate,Date delDate, boolean delFlg){
		this.userName = userName;
		this.userEmail = userEmail;
		this.userPwd = userPwd;
		this.userProfile = userProfile;
		this.joinMethod = joinMethod;
		this.regDate = regDate;
		this.delDate = delDate;
		this.delFlg = delFlg;
	}
	
	public UserEntity(String userName,String userEmail,String userPwd,String userProfile,String joinMethod, boolean delFlg){
		this.userName = userName;
		this.userEmail = userEmail;
		this.userPwd = userPwd;
		this.userProfile = userProfile;
		this.joinMethod = joinMethod;
		this.delFlg = delFlg;
	}
	
	public UserEntity(String userName,String userEmail,String userPwd,String joinMethod, boolean delFlg){
		this.userName = userName;
		this.userEmail = userEmail;
		this.userPwd = userPwd;
		this.joinMethod = joinMethod;
		this.delFlg = delFlg;
	}
	
	public UserEntity(String userName,String userEmail,String userPwd,String joinMethod){
		this.userName = userName;
		this.userEmail = userEmail;
		this.userPwd = userPwd;
		this.joinMethod = joinMethod;
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

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserProfile() {
		return userProfile;
	}

	public void setUserProfile(String userProfile) {
		this.userProfile = userProfile;
	}

	public String getJoinMethod() {
		return joinMethod;
	}

	public void setJoinMethod(String joinMethod) {
		this.joinMethod = joinMethod;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public Date getDelDate() {
		return delDate;
	}

	public void setDelDate(Date delDate) {
		this.delDate = delDate;
	}

	public boolean isDelFlg() {
		return delFlg;
	}

	public void setDelFlg(boolean delFlg) {
		this.delFlg = delFlg;
	}
	
	public String toString(){
		return "userNo:"+userNo+"/userName:"+userName+"/userEmail:"+userEmail+"/userPwd:"+userPwd+"/userProfile:"+userProfile+"/joinMethod:"+joinMethod+"/regDate:"+regDate+"/delDate"+delDate+"/delFlg"+delFlg;
	}
}
