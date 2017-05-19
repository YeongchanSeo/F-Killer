package com.fkiller.web.entity;

import java.sql.Date;

import com.fkiller.web.contants.AlarmType;

public class JobAlarmEntity {
	private int jobAlarmNo;
	private int jobNo;
	private AlarmType alarmType;
	private Date sendDate;
	
	public JobAlarmEntity(){
		
	}
	
	public JobAlarmEntity(int jobAlarmNo,int jobNo,AlarmType alarmType,Date sendDate){
		this.jobAlarmNo = jobAlarmNo;
		this.jobNo = jobNo;
		this.alarmType = alarmType;
		this.sendDate = sendDate;
	}
	
	public JobAlarmEntity(int jobNo,AlarmType alarmType,Date sendDate){
		this.jobNo = jobNo;
		this.alarmType = alarmType;
		this.sendDate = sendDate;
	}
	
	public JobAlarmEntity(int jobNo,AlarmType alarmType){
		this.jobNo = jobNo;
		this.alarmType = alarmType;
	}

	public int getJobAlarmNo() {
		return jobAlarmNo;
	}

	public void setJobAlarmNo(int jobAlarmNo) {
		this.jobAlarmNo = jobAlarmNo;
	}

	public int getJobNo() {
		return jobNo;
	}

	public void setJobNo(int jobNo) {
		this.jobNo = jobNo;
	}

	public AlarmType getAlarmType() {
		return alarmType;
	}

	public void setAlarmType(AlarmType alarmType) {
		this.alarmType = alarmType;
	}

	public Date getSendDate() {
		return sendDate;
	}

	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}
	
	public String toString(){
		return "jobAlarmNo:"+jobAlarmNo+"/jobNo:"+jobNo+"/alarmType:"+alarmType+"/sendDate:"+sendDate;
	}
}
