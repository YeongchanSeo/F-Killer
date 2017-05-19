package com.fkiller.web.entity;

import java.sql.Date;
import java.sql.Time;

public class MeetingEntity {
	private int meetingNo;
	private int teamNo;
	private Date meetingDate;
	private Time meetingTime;
	private String meetingTopic;
	private String meetingTitle;
	private String meetingDesc;
	private String meetingLoc;
	private boolean state;
	private Date regDate;
	private Date updDate;
	public MeetingEntity(int meetingNo, int teamNo, Date meetingDate,
			Time meetingTime, String meetingTopic, String meetingTitle,
			String meetingDesc, String meetingLoc, boolean state,
			Date regDate, Date updDate) {
		super();
		this.meetingNo = meetingNo;
		this.teamNo = teamNo;
		this.meetingDate = meetingDate;
		this.meetingTime = meetingTime;
		this.meetingTopic = meetingTopic;
		this.meetingTitle = meetingTitle;
		this.meetingDesc = meetingDesc;
		this.meetingLoc = meetingLoc;
		this.state = state;
		this.regDate = regDate;
		this.updDate = updDate;
	}
	public MeetingEntity(int teamNo, Date meetingDate,
			Time meetingTime, String meetingTopic, String meetingTitle,
			String meetingLoc, boolean state) {
		this.teamNo = teamNo;
		this.meetingDate = meetingDate;
		this.meetingTime = meetingTime;
		this.meetingTopic = meetingTopic;
		this.meetingTitle = meetingTitle;
		this.meetingLoc = meetingLoc;
		this.state = state;
	}
	public MeetingEntity(int meetingNo, int teamNo, Date meetingDate,
			Time meetingTime, String meetingTopic, String meetingTitle,
			String meetingLoc, boolean state) {
		this.meetingNo=meetingNo;
		this.teamNo = teamNo;
		this.meetingDate = meetingDate;
		this.meetingTime = meetingTime;
		this.meetingTopic = meetingTopic;
		this.meetingTitle = meetingTitle;
		this.meetingLoc = meetingLoc;
		this.state = state;
	}
	public MeetingEntity(int teamNo, Date meetingDate,
			Time meetingTime, String meetingTopic, String meetingTitle,
			String meetingDesc, String meetingLoc, boolean state,
			Date regDate, Date updDate) {
		super();
		this.teamNo = teamNo;
		this.meetingDate = meetingDate;
		this.meetingTime = meetingTime;
		this.meetingTopic = meetingTopic;
		this.meetingTitle = meetingTitle;
		this.meetingDesc = meetingDesc;
		this.meetingLoc = meetingLoc;
		this.state = state;
		this.regDate = regDate;
		this.updDate = updDate;
	}
	public MeetingEntity(int teamNo, Date meetingDate,
			Time meetingTime, String meetingTopic, String meetingTitle,
			String meetingDesc, String meetingLoc, boolean state) {
		super();
		this.teamNo = teamNo;
		this.meetingDate = meetingDate;
		this.meetingTime = meetingTime;
		this.meetingTopic = meetingTopic;
		this.meetingTitle = meetingTitle;
		this.meetingDesc = meetingDesc;
		this.meetingLoc = meetingLoc;
		this.state = state;
	}
	public MeetingEntity(int teamNo, Date meetingDate,
			Time meetingTime, String meetingTopic, String meetingTitle,
			String meetingDesc, String meetingLoc) {
		super();
		this.teamNo = teamNo;
		this.meetingDate = meetingDate;
		this.meetingTime = meetingTime;
		this.meetingTopic = meetingTopic;
		this.meetingTitle = meetingTitle;
		this.meetingDesc = meetingDesc;
		this.meetingLoc = meetingLoc;
	}
	public MeetingEntity() {
		super();
	}
	
	
	public int getMeetingNo() {
		return meetingNo;
	}
	public void setMeetingNo(int meetingNo) {
		this.meetingNo = meetingNo;
	}
	public int getTeamNo() {
		return teamNo;
	}
	public void setTeamNo(int teamNo) {
		this.teamNo = teamNo;
	}
	public Date getmeetingDate() {
		return meetingDate;
	}
	public void setmeetingDate(Date meetingDate) {
		this.meetingDate = meetingDate;
	}
	public Time getMeetingTime() {
		return meetingTime;
	}
	public void setMeetingTime(Time meetingTime) {
		this.meetingTime = meetingTime;
	}
	public String getMeetingTopic() {
		return meetingTopic;
	}
	public void setMeetingTopic(String meetingTopic) {
		this.meetingTopic = meetingTopic;
	}
	public String getMeetingTitle() {
		return meetingTitle;
	}
	public void setMeetingTitle(String meetingTitle) {
		this.meetingTitle = meetingTitle;
	}
	public String getMeetingDesc() {
		return meetingDesc;
	}
	public void setMeetingDesc(String meetingDesc) {
		this.meetingDesc = meetingDesc;
	}
	public String getMeetingLoc() {
		return meetingLoc;
	}
	public void setMeetingLoc(String meetingLoc) {
		this.meetingLoc = meetingLoc;
	}
	public boolean isState() {
		return state;
	}
	public void setState(boolean state) {
		this.state = state;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public Date getUpdDate() {
		return updDate;
	}
	public void setUpdDate(Date updDate) {
		this.updDate = updDate;
	}
	
	
	@Override
	public String toString() {
		return "meetingNo:" + meetingNo + "/ teamNo:" + teamNo
				+ "/ meetingDate:" + meetingDate + "/ meetingTime:"
				+ meetingTime + "/ meetingTopic:" + meetingTopic
				+ "/ meetingTitle:" + meetingTitle + "/ meetingDesc:"
				+ meetingDesc + "/ meetingLoc:" + meetingLoc + " state:"
				+ state + "/ regDate:" + regDate + "/ updDate:" + updDate;
	}
	
	
}
