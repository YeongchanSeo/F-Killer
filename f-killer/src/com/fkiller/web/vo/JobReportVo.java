package com.fkiller.web.vo;

import com.fkiller.web.contants.JobState;

public class JobReportVo {
	private int userNo;
	private String userName;
	private int[] jobStates;
	private int paneltyCnt;
	private int jobs;
	
	public JobReportVo(){
		
	}
	
	public JobReportVo(int userNo,String userName,int paneltyCnt){
		this.userNo = userNo;
		this.userName = userName;
		this.paneltyCnt = paneltyCnt;
	}
	
	public JobReportVo(int userNo,String userName,int[] jobState,int paneltyCnt){
		this.userNo = userNo;
		this.userName = userName;
		this.jobStates = jobState;
		this.paneltyCnt = paneltyCnt;
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

	public int[] getJobStates() {
		return jobStates;
	}

	public void setJobStates(int[] jobStates) {
		this.jobStates = jobStates;
	}

	public int getPaneltyCnt() {
		return paneltyCnt;
	}

	public void setPaneltyCnt(int paneltyCnt) {
		this.paneltyCnt = paneltyCnt;
	}
	
	public int getJobs() {
		return jobs;
	}

	public void setJobs(int jobs) {
		this.jobs = jobs;
	}

	public String toString(){
		return "userNo:"+userNo+"/userName:"+userName+"/jobState:"+jobStates+"/paneltyCnt:"+paneltyCnt;
	}
}
