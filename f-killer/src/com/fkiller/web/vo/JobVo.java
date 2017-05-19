package com.fkiller.web.vo;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import com.fkiller.web.contants.JobState;

public class JobVo {
	private int jobNo;
	private String jobTitle;
	private int prop;
	private Date dueDate;
	private String jobDesc;
	private JobState jobState;
	private int teamNo;
	private String teamName;
	private int leaderNo;
	private String userName;
	private int userNo;
	private List<CommentVo> comments;
	private List<FileVo> files;
	
	public JobVo(){
		
	}
	
	public JobVo(int jobNo, String jobTitle, int prop, Date dueDate, String jobDesc, JobState jobState,int teamNo, String teamName,int leaderNo,String userName, List<CommentVo> comments, List<FileVo> files) {
		super();
		this.jobNo = jobNo;
		this.jobTitle = jobTitle;
		this.prop = prop;
		this.dueDate = dueDate;
		this.jobDesc = jobDesc;
		this.jobState = jobState;
		this.teamNo = teamNo;
		this.teamName = teamName;
		this.leaderNo = leaderNo;
		this.userName = userName;
		this.comments = comments;
		this.files = files;
	}
	public JobVo(int jobNo, String jobTitle, int prop, Date dueDate, String jobDesc, JobState jobState, int teamNo, String teamName,int leaderNo,String userName){
		this.jobNo = jobNo;
		this.jobTitle = jobTitle;
		this.prop = prop;
		this.dueDate = dueDate;
		this.jobDesc = jobDesc;
		this.jobState = jobState;
		this.teamNo = teamNo;
		this.teamName = teamName;
		this.leaderNo = leaderNo;
		this.userName = userName;
		
	}
	public JobVo(int jobNo, String jobTitle, int prop, Date dueDate, String jobDesc, JobState jobState, int teamNo, String teamName,int leaderNo,String userName,int userNo){
		this.jobNo = jobNo;
		this.jobTitle = jobTitle;
		this.prop = prop;
		this.dueDate = dueDate;
		this.jobDesc = jobDesc;
		this.jobState = jobState;
		this.teamNo = teamNo;
		this.teamName = teamName;
		this.leaderNo = leaderNo;
		this.userName = userName;
		this.userNo = userNo;
	}

	public JobVo(int jobNo, String jobTitle, int prop, Date dueDate, String jobDesc, JobState jobState,String userName){
		this.jobNo = jobNo;
		this.jobTitle = jobTitle;
		this.prop = prop;
		this.dueDate = dueDate;
		this.jobDesc = jobDesc;
		this.jobState = jobState;
		this.userName = userName;
		
	}
	public JobVo(int jobNo, String jobTitle, int prop, Date dueDate, String jobDesc, JobState jobState,String userName,int userNo){
		this.jobNo = jobNo;
		this.jobTitle = jobTitle;
		this.prop = prop;
		this.dueDate = dueDate;
		this.jobDesc = jobDesc;
		this.jobState = jobState;
		this.userName = userName;
		this.userNo = userNo;
	}
	
	public JobVo(int jobNo, String jobTitle, int prop, Date dueDate, String jobDesc){
		this.jobNo = jobNo;
		this.jobTitle = jobTitle;
		this.prop = prop;
		this.dueDate = dueDate;
		this.jobDesc = jobDesc;
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

	public String getJobDesc() {
		return jobDesc;
	}

	public void setJobDesc(String jobDesc) {
		this.jobDesc = jobDesc;
	}

	public JobState getJobState() {
		return jobState;
	}

	public void setJobState(JobState jobState) {
		this.jobState = jobState;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public List<CommentVo> getComments() {
		return comments;
	}

	public void setComments(List<CommentVo> comments) {
		this.comments = comments;
	}

	public List<FileVo> getFiles() {
		return files;
	}

	public void setFiles(List<FileVo> files) {
		this.files = files;
	}
	
	public int getTeamNo() {
		return teamNo;
	}

	public void setTeamNo(int teamNo) {
		this.teamNo = teamNo;
	}

	public int getLeaderNo() {
		return leaderNo;
	}

	public void setLeaderNo(int leaderNo) {
		this.leaderNo = leaderNo;
	}

	public String toString(){
		return "jobNo:"+jobNo+"/jobTitle:"+jobTitle+"/prop:"+prop+"/dueDate:"+dueDate+"/jobDesc:"+jobDesc+"/jobState:"+jobState+"/teamNo:"+teamNo+"/teamName:"+teamName+"/leaderNo:"+leaderNo+"/userName:"+userName+"/comments:"+comments+"/files:"+files;
	}
	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
}
