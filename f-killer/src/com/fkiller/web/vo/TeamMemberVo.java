package com.fkiller.web.vo;

import com.fkiller.web.contants.Colors;

public class TeamMemberVo {
	private int userNo;
	private String email;
	private String name;
	private String profile;
	private String memberColor;
	private int teamNo;
	
	public TeamMemberVo(){
		
	}

	public TeamMemberVo(int userNo,String email,String name,String profile,int teamNo,String memberColor){
		this.userNo = userNo;
		this.email = email;
		this.name = name;
		this.profile = profile;
		this.teamNo = teamNo;
		this.memberColor = memberColor;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public int getTeamNo() {
		return teamNo;
	}

	public void setTeamNo(int teamNo) {
		this.teamNo = teamNo;
	}

	public String getMemberColor() {
		return memberColor;
	}

	public void setMemberColor(String memberColor) {
		this.memberColor = memberColor;
	}

	public String toString(){
		return "userNo:"+userNo+"/email:"+email+"/name:"+name+"/profile:"+profile+"/teamNo:"+teamNo+"/memberColor:"+memberColor;
	}

}
