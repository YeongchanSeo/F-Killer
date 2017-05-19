package com.fkiller.web.entity;

import java.sql.Date;

public class InviteAlarmEntity {
	private int inviteNo;
	private int userNo;
	private int teamNo;
	private Date sendDate;
	
	public InviteAlarmEntity(){
		
	}
	
	public InviteAlarmEntity(int inviteNo,int userNo,int teamNo,Date sendDate){
		this.inviteNo = inviteNo;
		this.userNo = userNo;
		this.teamNo = teamNo;
		this.sendDate = sendDate;
	}
	
	public InviteAlarmEntity(int userNo,int teamNo,Date sendDate){
		this.userNo = userNo;
		this.teamNo = teamNo;
	}
	
	public InviteAlarmEntity(int userNo,int teamNo){
		this.userNo = userNo;
		this.teamNo = teamNo;
	}

	public int getInviteNo() {
		return inviteNo;
	}

	public void setInviteNo(int inviteNo) {
		this.inviteNo = inviteNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getTeamNo() {
		return teamNo;
	}

	public void setTeamNo(int teamNo) {
		this.teamNo = teamNo;
	}

	public Date getSendDate() {
		return sendDate;
	}

	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}
	
	public String toString(){
		return "inviteNo:"+inviteNo+"/userNo:"+userNo+"/teamNo:"+teamNo+"/sendDate:"+sendDate;
	}
}
