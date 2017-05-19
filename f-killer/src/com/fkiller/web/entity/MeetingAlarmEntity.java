package com.fkiller.web.entity;

import java.sql.Date;

public class MeetingAlarmEntity {
	private int meetingAlarmNo;
	private int meetingNo;
	private int userNo;
	private Date sendDate;
	
	public MeetingAlarmEntity(int meetingAlarmNo, int meetingNo, int userNo,
			Date sendDate) {
		super();
		this.meetingAlarmNo = meetingAlarmNo;
		this.meetingNo = meetingNo;
		this.userNo = userNo;
		this.sendDate = sendDate;
	}
	public MeetingAlarmEntity(int meetingNo, int userNo, Date sendDate) {
		super();
		this.meetingNo = meetingNo;
		this.userNo = userNo;
		this.sendDate = sendDate;
	}
	public MeetingAlarmEntity(int meetingNo, int userNo) {
		super();
		this.meetingNo = meetingNo;
		this.userNo = userNo;
	}
	public MeetingAlarmEntity() {
		super();
	}
	
	public int getMeetingAlarmNo() {
		return meetingAlarmNo;
	}
	public void setMeetingAlarmNo(int meetingAlarmNo) {
		this.meetingAlarmNo = meetingAlarmNo;
	}
	public int getMeetingNo() {
		return meetingNo;
	}
	public void setMeetingNo(int meetingNo) {
		this.meetingNo = meetingNo;
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
	
	@Override
	public String toString() {
		return "meetingAlarmNo:" + meetingAlarmNo
				+ "/ meetingNo:" + meetingNo + "/ userNo:" + userNo
				+ "/ sendDate:" + sendDate;
	}
	
}
