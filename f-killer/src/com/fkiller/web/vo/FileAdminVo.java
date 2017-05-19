package com.fkiller.web.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class FileAdminVo {
	private int fileNo;
	private String fileName;
	private int teamNo;
	private String teamName;
	private String fileSize;
	private Date regDate;
	
	public FileAdminVo(){
		
	}

	public FileAdminVo(int fileNo, String fileName, int teamNo, String teamName, String fileSize, Date regDate) {
		this.fileNo = fileNo;
		this.fileName = fileName;
		this.teamNo = teamNo;
		this.teamName = teamName;
		this.fileSize = fileSize;
		this.regDate = regDate;
	}

	public int getFileNo() {
		return fileNo;
	}

	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
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

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String toString(){
		return "fileNo:"+fileNo+"/fileName:"+fileName+"/teamNo:"+teamNo+"/teamName:"+teamName+"/fileSize:"+fileSize+"/regDate:"+regDate;
	}
	
}
