package com.fkiller.web.entity;

import java.sql.Date;

import jdk.nashorn.internal.runtime.regexp.joni.constants.RegexState;

public class TeamEntity {
	private int teamNo;
	private String teamName;
	private String teamTopic;
	private Date startDate;
	private Date endDate;
	private Date regDate;
	private Date updDate;
	private boolean oper;
	private int leaderNo;
	
	public TeamEntity(){
		
	}
	
	public TeamEntity(int teamNo,String teamName,String teamTopic,Date startDate,Date endDate,Date regDate,Date updDate, boolean oper,int leaderNo){
		this.teamNo = teamNo;
		this.teamName = teamName;
		this.teamTopic = teamTopic;
		this.startDate = startDate;
		this.endDate = endDate;
		this.regDate = regDate;
		this.updDate = updDate;
		this.oper = oper;
		this.leaderNo = leaderNo;
	}
	
	public TeamEntity(String teamName,String teamTopic,Date startDate,Date endDate,boolean oper,int leaderNo){
		this.teamName = teamName;
		this.teamTopic = teamTopic;
		this.startDate = startDate;
		this.endDate = endDate;
		this.oper = oper;
		this.leaderNo = leaderNo;
	}
	
	public TeamEntity(String teamName,String teamTopic,Date startDate,Date endDate,int leaderNo,int teamNo){
		this.teamName = teamName;
		this.teamTopic = teamTopic;
		this.startDate = startDate;
		this.endDate = endDate;
		this.leaderNo = leaderNo;
		this.teamNo = teamNo;
	}

	public TeamEntity(String teamName,String teamTopic,Date startDate,Date endDate,Date regDate, Date updDate, boolean oper,int leaderNo){
		this.teamName = teamName;
		this.teamTopic = teamTopic;
		this.startDate = startDate;
		this.endDate = endDate;
		this.regDate = regDate;
		this.updDate = updDate;
		this.oper = oper;
		this.leaderNo = leaderNo;
	}

	public int getTeamNo() {
		return teamNo;
	}

	public void setTeamNo(int teamNo) {
		this.teamNo = teamNo;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	public String getTeamTopic() {
		return teamTopic;
	}

	public void setTeamTopic(String teamTopic) {
		this.teamTopic = teamTopic;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public boolean isOper() {
		return oper;
	}

	public void setOper(boolean oper) {
		this.oper = oper;
	}

	public int getLeaderNo() {
		return leaderNo;
	}

	public void setLeaderNo(int leaderNo) {
		this.leaderNo = leaderNo;
	}

	public String toString(){
		return "teamNo:"+teamNo+"/teamName:"+teamName+"/temapTopic"+teamTopic+"/startDate:"+startDate+"/endDate:"+endDate+"/regDate:"+regDate+"/updDate:"+updDate+"/leaderNo:"+leaderNo;
	}
}
