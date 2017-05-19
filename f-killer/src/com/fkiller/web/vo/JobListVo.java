package com.fkiller.web.vo;

import java.sql.Date;

import com.fkiller.web.contants.JobState;

public class JobListVo {
	private int jobNo;
	private String jobTitle;
	private Date dueDate;
	private int prop;
	private String name;
	private JobState jobState;
	
	public JobListVo(){
		
	}
	
	public JobListVo(int jobNo,String jobTitle, Date dueDate){
		this.jobNo = jobNo;
		this.jobTitle = jobTitle;
		this.dueDate = dueDate;
	}

	
	public JobListVo(int jobNo,String jobTitle, Date dueDate,int prop,String name,JobState jobState){
		this.jobNo = jobNo;
		this.jobTitle = jobTitle;
		this.dueDate = dueDate;
		this.prop = prop;
		this.name = name;
		this.jobState = jobState;
	}

	public int getJobNo() {
		return jobNo;
	}

	public void setJobNo(int jobNo) {
		this.jobNo = jobNo;
	}

	public String getJobTitle() {
		return jobTitle;
	}

	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}

	public Date getDueDate() {
		return dueDate;
	}

	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}
	
	public int getProp() {
		return prop;
	}

	public void setProp(int prop) {
		this.prop = prop;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public JobState getJobState() {
		return jobState;
	}

	public void setJobState(JobState jobState) {
		this.jobState = jobState;
	}

	public String toString(){
		return "jobNo:"+jobNo+"/jobTitle:"+jobTitle+"/dueDate:"+dueDate+"/prop:"+prop+"/name:"+name+"/jobState:"+jobState;
	}
}
