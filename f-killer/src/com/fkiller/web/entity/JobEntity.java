package com.fkiller.web.entity;

import java.sql.Date;

import com.fkiller.web.contants.JobState;

public class JobEntity {
	private int jobNo;
	private int workInNo;
	private String jobTitle;
	private int prop;
	private Date dueDate;
	private Date regDate;
	private Date updDate;
	private String jobDesc;
	private JobState state;
	
	public JobEntity(){
		
	}
	
	public JobEntity(int jobNo,int workInNo,String jobTitle,int prop,Date dueDate,Date regDate, Date updDate,String jobDesc,JobState state){
		this.jobNo = jobNo;
		this.workInNo = workInNo;
		this.jobTitle = jobTitle;
		this.prop = prop;
		this.dueDate = dueDate;
		this.regDate = regDate;
		this.updDate = updDate;
		this.jobDesc = jobDesc;
		this.state = state;
	}
	
	public JobEntity(int workInNo,String jobTitle,int prop,Date dueDate,Date regDate, Date updDate,String jobDesc,JobState state){
		this.workInNo = workInNo;
		this.jobTitle = jobTitle;
		this.prop = prop;
		this.dueDate = dueDate;
		this.regDate = regDate;
		this.updDate = updDate;
		this.jobDesc = jobDesc;
		this.state = state;
	}
	
	public JobEntity(int workInNo,String jobTitle,int prop,Date dueDate, Date updDate,String jobDesc,JobState state){
		this.workInNo = workInNo;
		this.jobTitle = jobTitle;
		this.prop = prop;
		this.dueDate = dueDate;
		this.updDate = updDate;
		this.jobDesc = jobDesc;
		this.state = state;
	}
	
	public JobEntity(int workInNo,String jobTitle,int prop,Date dueDate,String jobDesc,JobState state){
		this.workInNo = workInNo;
		this.jobTitle = jobTitle;
		this.prop = prop;
		this.dueDate = dueDate;
		this.jobDesc = jobDesc;
		this.state = state;
	}

	public int getJobNo() {
		return jobNo;
	}

	public void setJobNo(int jobNo) {
		this.jobNo = jobNo;
	}

	public int getWorkInNo() {
		return workInNo;
	}

	public void setWorkInNo(int workInNo) {
		this.workInNo = workInNo;
	}

	public String getJobTitle() {
		return jobTitle;
	}

	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}

	public int getProp() {
		return prop;
	}

	public void setProp(int prop) {
		this.prop = prop;
	}

	public Date getDueDate() {
		return dueDate;
	}

	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
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

	public String getJobDesc() {
		return jobDesc;
	}

	public void setJobDesc(String jobDesc) {
		this.jobDesc = jobDesc;
	}

	public JobState getState() {
		return state;
	}

	public void setState(JobState state) {
		this.state = state;
	}
	
	public String toString(){
		return "jobNo:"+jobNo+"/workInNo:"+workInNo+"/jobTitle:"+jobTitle+"/prop:"+"/dueDate:"+dueDate+"/regDate:"+regDate+"/updDate:"+updDate+"/state:"+state;
	}
}
