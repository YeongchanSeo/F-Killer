package com.fkiller.web.entity;

import java.sql.Date;

public class AlarmEntity {
	private int detailNo;
	private int userNo;
	private int teamNo;
	private Date sendDate;
	
	public AlarmEntity(){
		
	}
	
	public AlarmEntity(int detailNo,int userNo){
		this.detailNo = detailNo;
		this.userNo = userNo;
	}
	
	public AlarmEntity(int detailNo,int userNo, Date sendDate){
		this.detailNo = detailNo;
		this.userNo = userNo;
		this.sendDate = sendDate;
	}

	public int getDetailNo() {
		return detailNo;
	}

	public void setDetailNo(int detailNo) {
		this.detailNo = detailNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public Date getSendDate() {
		return sendDate;
	}

	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}
	
	public void setTeamNo(int teamNo){
		this.teamNo = teamNo;
	}
	
	public int getTeamNo(){
		return teamNo;
	}
	
	public String toString(){
		return "detailNo:"+detailNo+"/userNo:"+userNo+"/teamNo:"+teamNo+"/sendDate:"+sendDate;
	}
}
