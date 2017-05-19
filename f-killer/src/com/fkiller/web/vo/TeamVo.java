package com.fkiller.web.vo;

import java.sql.Date;

public class TeamVo {
	private int teamNo;
	private String teamName;
	private String teamTopic;
	private Date startDate;
	private Date endDate;
	private boolean oper;
	private String teamColor;
	private int leaderNo;
	private String leaderName;
	private boolean favorites;
	
	public TeamVo(){
		
	}
	
	public TeamVo(int teamNo,String teamName,String teamTopic,Date startDate,Date endDate,boolean oper,int leaderNo,String leadername,String teamColor,boolean favorites){
		this.teamNo = teamNo;
		this.teamName = teamName;
		this.teamTopic = teamTopic;
		this.startDate = startDate;
		this.endDate = endDate;
		this.oper = oper;
		this.leaderNo = leaderNo;
		this.leaderName = leadername;
		this.teamColor = teamColor;
		this.favorites = favorites;
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

	public boolean isOper() {
		return oper;
	}

	public void setOper(boolean oper) {
		this.oper = oper;
	}

	public String getLeaderName() {
		return leaderName;
	}

	public void setLeaderName(String leaderName) {
		this.leaderName = leaderName;
	}
	
	public String getTeamColor() {
		return teamColor;
	}

	public void setTeamColor(String teamColor) {
		this.teamColor = teamColor;
	}
	
	public boolean isFavorites() {
		return favorites;
	}

	public void setFavorites(boolean favorites) {
		this.favorites = favorites;
	}

	public int getLeaderNo() {
		return leaderNo;
	}

	public void setLeaderNo(int leaderNo) {
		this.leaderNo = leaderNo;
	}

	public String toString(){
		return "teamNo:"+teamNo+"/teamName:"+teamName+"/teamTopic:"+teamTopic+"/startDate:"+startDate+"/endDate:"+endDate+"/oper:"+oper+"/leaderNo"+leaderNo+"/leaderName:"+leaderName+"/teamColor:"+teamColor+"/favorites:"+favorites;
	}
}
