package com.fkiller.web.vo;

import java.sql.Date;
import java.sql.Time;
import java.util.List;

public class MeetingVo {
	private int meetingNo;
	private Date meetingDate;
	private Time meetingTime;
	private String meetingTitle;
	private String meetingTopic;
	private String meetingDesc;
	private String meetingLoc;
	private boolean state;
	private List<PartVo> participants;
	
	public MeetingVo(int meetingNo, Date meetingDate,
			Time meetingTime, String meetingTitle, String meetingTopic,
			String meetingDesc, String meetingLoc, boolean state,
			List<PartVo> participants) {
		super();
		this.meetingNo = meetingNo;
		this.meetingDate = meetingDate;
		this.meetingTime = meetingTime;
		this.meetingTitle = meetingTitle;
		this.meetingTopic = meetingTopic;
		this.meetingDesc = meetingDesc;
		this.meetingLoc = meetingLoc;
		this.state = state;
		this.participants = participants;
	}
	public MeetingVo() {
		super();
	}
	
	public int getMeetingNo() {
		return meetingNo;
	}
	public void setMeetingNo(int meetingNo) {
		this.meetingNo = meetingNo;
	}
	public Date getMeetingDate() {
		return meetingDate;
	}
	public void setMeetingDate(Date meetingDate) {
		this.meetingDate = meetingDate;
	}
	public Time getMeetingTime() {
		return meetingTime;
	}
	public void setMeetingTime(Time meetingTime) {
		this.meetingTime = meetingTime;
	}
	public String getMeetingTitle() {
		return meetingTitle;
	}
	public void setMeetingTitle(String meetingTitle) {
		this.meetingTitle = meetingTitle;
	}
	public String getMeetingTopic() {
		return meetingTopic;
	}
	public void setMeetingTopic(String meetingTopic) {
		this.meetingTopic = meetingTopic;
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
	public List<PartVo> getParticipants() {
		return participants;
	}
	public void setParticipants(List<PartVo> participants) {
		this.participants = participants;
	}
	
	@Override
	public String toString() {
		String value="meetingNo:" + meetingNo + "/ meetingDate:"
				+ meetingDate + "/ meetingTime:" + meetingTime
				+ "/ meetingTitle:" + meetingTitle + "/ meetingTopic:"
				+ meetingTopic + "/ meetingDesc:" + meetingDesc
				+ "/ meetingLoc:" + meetingLoc + "/ state:" + state + "\nparticipants:\n";
		
		for(PartVo temp:participants){
			value+=temp+"\n";
		}
		
		return value;
	}
	
	
}
