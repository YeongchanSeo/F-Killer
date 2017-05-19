package com.fkiller.web.entity;

import java.sql.Date;

import com.fkiller.web.contants.Colors;
import com.sun.org.apache.xalan.internal.xsltc.compiler.Template;

public class WorkInEntity {
	private int workInNo;
	private int userNo;
	private int teamNo;
	private Colors memberColor;
	private Colors teamColor;
	private boolean favorites;
	private int paneltyCnt;
	private boolean delFlg;
	private Date regDate;
	
	public WorkInEntity(){
		
	}
	
	public WorkInEntity(int workInNo,int userNo,int teamNo, Colors memberColor,Colors teamColor,boolean favorites,int paneltyCnt,boolean delFlg,Date regDate){
		this.workInNo = workInNo;
		this.userNo = userNo;
		this.teamNo = teamNo;
		this.memberColor = memberColor;
		this.teamColor = teamColor;
		this.favorites = favorites;
		this.paneltyCnt = paneltyCnt;
		this.delFlg = delFlg;
		this.regDate = regDate;
	}
	
	public WorkInEntity(int userNo,int teamNo, Colors memberColor,Colors teamColor,boolean favorites,int paneltyCnt,boolean delFlg,Date regDate){
		this.userNo = userNo;
		this.teamNo = teamNo;
		this.memberColor = memberColor;
		this.teamColor = teamColor;
		this.favorites = favorites;
		this.paneltyCnt = paneltyCnt;
		this.delFlg = delFlg;
		this.regDate = regDate;
	}
	
	public WorkInEntity(int userNo,int teamNo, Colors memberColor,Colors teamColor,boolean favorites,int paneltyCnt,boolean delFlg){
		this.userNo = userNo;
		this.teamNo = teamNo;
		this.memberColor = memberColor;
		this.teamColor = teamColor;
		this.favorites = favorites;
		this.paneltyCnt = paneltyCnt;
		this.delFlg = delFlg;
	}
	
	public WorkInEntity(int userNo, Colors memberColor,Colors teamColor,boolean favorites,int paneltyCnt,boolean delFlg){
		this.userNo = userNo;
		this.memberColor = memberColor;
		this.teamColor = teamColor;
		this.favorites = favorites;
		this.paneltyCnt = paneltyCnt;
		this.delFlg = delFlg;
	}

	public int getWorkInNo() {
		return workInNo;
	}

	public void setWorkInNo(int workInNo) {
		this.workInNo = workInNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getTeamNo() {
		return teamNo;
	}

	public void setTeamNo(int teamNo) {
		this.teamNo = teamNo;
	}

	public Colors getMemberColor() {
		return memberColor;
	}

	public void setMemberColor(Colors memberColor) {
		this.memberColor = memberColor;
	}

	public Colors getTeamColor() {
		return teamColor;
	}

	public void setTeamColor(Colors teamColor) {
		this.teamColor = teamColor;
	}

	public boolean isFavorites() {
		return favorites;
	}

	public void setFavorites(boolean favorites) {
		this.favorites = favorites;
	}

	public int getPaneltyCnt() {
		return paneltyCnt;
	}

	public void setPaneltyCnt(int paneltyCnt) {
		this.paneltyCnt = paneltyCnt;
	}

	public boolean isDelFlg() {
		return delFlg;
	}

	public void setDelFlg(boolean delFlg) {
		this.delFlg = delFlg;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	public String toString(){
		return "workInNo:"+workInNo+"/userNo:"+userNo+"/teamNo:"+teamNo+"/memberColor:"+memberColor+"/teamColor:"+teamColor+"/paneltyCnt:"+paneltyCnt+"/delFlg:"+delFlg+"/regDate:"+regDate;
	}
}
