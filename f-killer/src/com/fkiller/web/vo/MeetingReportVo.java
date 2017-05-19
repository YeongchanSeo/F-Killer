package com.fkiller.web.vo;

public class MeetingReportVo {
	private int userNo;
	private String userName;
	private int totalMeeting;
	private int partInMeeting;
	
	public MeetingReportVo(){
		
	}
	
	public MeetingReportVo(int userNo,String userName,int totalMeeting){
		this.userNo = userNo;
		this.userName = userName;
		this.totalMeeting = totalMeeting;
	}
	
	public MeetingReportVo(int userNo,String userName,int totalMeeting,int partInMeeting){
		this.userNo = userNo;
		this.userName = userName;
		this.totalMeeting = totalMeeting;
		this.partInMeeting = partInMeeting;
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

	public int getTotalMeeting() {
		return totalMeeting;
	}

	public void setTotalMeeting(int totalMeeting) {
		this.totalMeeting = totalMeeting;
	}

	public int getPartInMeeting() {
		return partInMeeting;
	}

	public void setPartInMeeting(int partInMeeting) {
		this.partInMeeting = partInMeeting;
	}
	
	public String toString(){
		return "userNo:"+userNo+"/userName:"+userName+"/totalMeeting:"+totalMeeting+"/partInMeeting:"+partInMeeting;
	}
}
