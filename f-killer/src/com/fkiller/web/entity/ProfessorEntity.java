package com.fkiller.web.entity;

import java.sql.Date;

import com.fkiller.web.contants.ReportCycle;

public class ProfessorEntity {
	private int profNo;
	private String email;
	private int teamNo;
	private ReportCycle cycle;
	private boolean auto;
	private Date updDate;
	private Date reportDate;
	
	public ProfessorEntity(){
		
	}
	
	public ProfessorEntity(int profNo,String email,int teamNo,ReportCycle cycle,boolean auto,Date updDate,Date reportDate){
		this.profNo = profNo;
		this.email = email;
		this.teamNo = teamNo;
		this.cycle = cycle;
		this.auto = auto;
		this.updDate = updDate;
		this.reportDate = reportDate;
	}
	
	public ProfessorEntity(String email,int teamNo,ReportCycle cycle,boolean auto,Date updDate,Date reportDate){
		this.email = email;
		this.teamNo = teamNo;
		this.cycle = cycle;
		this.auto = auto;
		this.updDate = updDate;
		this.reportDate = reportDate;
	}

	public ProfessorEntity(String email,int teamNo,ReportCycle cycle,boolean auto){
		this.email = email;
		this.teamNo = teamNo;
		this.cycle = cycle;
		this.auto = auto;		
	}
	
	public ProfessorEntity(String email,int teamNo,ReportCycle cycle,boolean auto, int profNo){
		this.email = email;
		this.teamNo = teamNo;
		this.cycle = cycle;
		this.auto = auto;
		this.profNo = profNo;
	}

	public ProfessorEntity(String email,ReportCycle cycle,boolean auto, int profNo){
		this.email = email;
		this.cycle = cycle;
		this.auto = auto;
		this.profNo = profNo;
	}
	
	public ProfessorEntity(String email,ReportCycle cycle,boolean auto){
		this.email = email;
		this.cycle = cycle;
		this.auto = auto;
	}

	
	public int getProfNo() {
		return profNo;
	}

	public void setProfNo(int profNo) {
		this.profNo = profNo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getTeamNo() {
		return teamNo;
	}

	public void setTeamNo(int teamNo) {
		this.teamNo = teamNo;
	}

	public ReportCycle getCycle() {
		return cycle;
	}

	public void setCycle(ReportCycle cycle) {
		this.cycle = cycle;
	}

	public boolean isAuto() {
		return auto;
	}

	public void setAuto(boolean auto) {
		this.auto = auto;
	}

	public Date getUpdDate() {
		return updDate;
	}

	public void setUpdDate(Date updDate) {
		this.updDate = updDate;
	}
	
	public Date getReportDate() {
		return reportDate;
	}

	public void setReportDate(Date reportDate) {
		this.reportDate = reportDate;
	}

	public String toString(){
		return "profNo:"+profNo+"/email:"+email+"/teamNo:"+teamNo+"/cycle:"+cycle+"/auto:"+auto+"/updDate:"+updDate+"/reportDate:"+reportDate;
	}
}
