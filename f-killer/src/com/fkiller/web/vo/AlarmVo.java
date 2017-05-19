package com.fkiller.web.vo;

import java.sql.Date;
import java.sql.Timestamp;

import com.fkiller.web.contants.AlarmType;


public class AlarmVo {
	private int alarmNo;
	private AlarmType alarmType;
	private String message;
	private int detailNo;
	private int teamNo;
	private Date sendDate;
	
	public AlarmVo(){
		
	}
	
	public AlarmVo(int alarmNo,AlarmType alarmType,String message,int detailNo, Date sendDate){
		this.alarmNo = alarmNo;
		this.alarmType = alarmType;
		this.message = message;
		this.detailNo = detailNo;
		this.sendDate = sendDate;
	}
	
	public AlarmVo(int alarmNo,AlarmType alarmType,String message,int detailNo){
		this.alarmNo = alarmNo;
		this.alarmType = alarmType;
		this.message = message;
		this.detailNo = detailNo;
	}
	
	public AlarmVo(int alarmNo,AlarmType alarmType,String message,int detailNo,int teamNo){
		this.alarmNo = alarmNo;
		this.alarmType = alarmType;
		this.message = message;
		this.detailNo = detailNo;
		this.teamNo = teamNo;
	}
	
	public AlarmVo(int alarmNo,AlarmType alarmType,int detailNo,int teamNo){
		this.alarmNo = alarmNo;
		this.alarmType = alarmType;
		this.detailNo = detailNo;
		this.teamNo = teamNo;
	}

	public int getAlarmNo() {
		return alarmNo;
	}

	public void setAlarmNo(int alarmNo) {
		this.alarmNo = alarmNo;
	}

	public AlarmType getAlarmType() {
		return alarmType;
	}

	public void setAlarmType(AlarmType alarmType) {
		this.alarmType = alarmType;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getDetailNo() {
		return detailNo;
	}

	public void setDetailNo(int detailNo) {
		this.detailNo = detailNo;
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
		return "alarmNo:"+alarmNo+"/alarmType:"+alarmType+"/message:"+message+"/detailNo:"+detailNo+"/teamNo:"+teamNo;
	}
}
