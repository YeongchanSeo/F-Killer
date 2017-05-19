package com.fkiller.web.vo;

import com.fkiller.web.contants.JobState;

public class ReportVo {
	private int 	   userNo;
	private String     userName;
	private int[] 	   jobState;
	private int 	   totalMeeting;
	private int 	   partInMeeting;
	private int 	   completion;
	private int 	   closed;
	private int		   jobs;
	
	public ReportVo(){
		
	}
	
	public ReportVo(int userNo,String userName){
		this.userNo 		= userNo;
		this.userName 		= userName;
	}
	
	public ReportVo(int userNo,String userName,int[] jobState,int totalMeeting,int partInMeeting,int completion, int closed){
		this.userNo 		= userNo;
		this.userName 		= userName;
		this.jobState 		= jobState;
		this.totalMeeting 	= totalMeeting;
		this.partInMeeting 	= partInMeeting;
		this.completion		= completion;
		this.closed			= closed;
	}
	
	public ReportVo(int userNo,String userName,int totalMeeting,int partInMeeting,int completion, int closed){
		this.userNo 		= userNo;
		this.userName 		= userName;
		this.totalMeeting 	= totalMeeting;
		this.partInMeeting 	= partInMeeting;
		this.completion		= completion;
		this.closed			= closed;
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

	public int getCompletion() {
		return completion;
	}

	public void setCompletion(int completion) {
		this.completion = completion;
	}

	public int getClosed() {
		return closed;
	}

	public void setClosed(int closed) {
		this.closed = closed;
	}

	public int[] getJobState() {
		return jobState;
	}

	public void setJobState(int[] jobState) {
		this.jobState = jobState;
	}

	public String toString(){
		return "userNo:"+userNo+"/userName:"+userName+"/jobState:"+jobState
				+"/totalMeeting:"+totalMeeting+"/partInMeeting:"+partInMeeting+"/completion:"+completion +"/closed"+closed;
	}

	public int getJobs() {
		return jobs;
	}

	public void setJobs(int jobs) {
		this.jobs = jobs;
	}
	
	
	
}
