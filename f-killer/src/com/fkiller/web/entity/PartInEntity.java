package com.fkiller.web.entity;

public class PartInEntity {
	private int partInNo;
	private int userNo;
	private int meetingNo;
	private boolean state;
	
	
	public PartInEntity(int partInNo, int userNo, int meetingNo, boolean state) {
		super();
		this.partInNo = partInNo;
		this.userNo = userNo;
		this.meetingNo = meetingNo;
		this.state = state;
	}


	public PartInEntity(int userNo, int meetingNo, boolean state) {
		super();
		this.userNo = userNo;
		this.meetingNo = meetingNo;
		this.state = state;
	}
	
	public PartInEntity(int userNo) {
		this.userNo = userNo;
	}
	
	public PartInEntity(int partInNo, int userNo, int meetingNo) {
		this.partInNo=partInNo;
		this.userNo = userNo;
		this.meetingNo=meetingNo;
	}


	public PartInEntity() {
		super();
	}


	public int getPartInNo() {
		return partInNo;
	}


	public void setPartInNo(int partInNo) {
		this.partInNo = partInNo;
	}


	public int getUserNo() {
		return userNo;
	}


	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}


	public int getMeetingNo() {
		return meetingNo;
	}


	public void setMeetingNo(int meetingNo) {
		this.meetingNo = meetingNo;
	}


	public boolean isState() {
		return state;
	}


	public void setState(boolean state) {
		this.state = state;
	}


	@Override
	public String toString() {
		return "partInNo:" + partInNo + "/ userNo:" + userNo
				+ "/ meetingNo:" + meetingNo + "/ state:" + state;
	}
	
	
	
}
