package com.fkiller.web.entity;

import java.sql.Date;

public class FileEntity {
	private int fileNo;
	private int jobNo;
	private int userNo;
	private String fileName;
	private String fileSize;
	private String fileExtension;
	private Date regDate;
	private Date udpDate;
	
	
	public FileEntity(int fileNo, int jobNo, int userNo, String fileName,
			String fileSize,String fileExtension, Date udpDate) {
		super();
		this.fileNo = fileNo;
		this.jobNo = jobNo;
		this.userNo = userNo;
		this.fileName = fileName;
		this.fileSize = fileSize;
		this.udpDate = udpDate;
	}
	public FileEntity(int fileNo, int jobNo, int userNo, String fileName,
			String fileSize, Date regDate, Date udpDate) {
		super();
		this.fileNo = fileNo;
		this.jobNo = jobNo;
		this.userNo = userNo;
		this.fileName = fileName;
		this.fileSize = fileSize;
		this.regDate = regDate;
		this.udpDate = udpDate;
	}
	
	public FileEntity(String fileName,String fileSize, String fileExtension) {
		super();
		this.fileName = fileName;
		this.fileSize = fileSize;
		this.fileExtension = fileExtension;
	}
	
	public FileEntity(int jobNo, int userNo, String fileName, String fileSize,
			Date regDate, Date udpDate) {
		super();
		this.jobNo = jobNo;
		this.userNo = userNo;
		this.fileName = fileName;
		this.fileSize = fileSize;
		this.regDate = regDate;
		this.udpDate = udpDate;
	}
	public FileEntity(int jobNo, int userNo, String fileName, String fileSize) {
		super();
		this.jobNo = jobNo;
		this.userNo = userNo;
		this.fileName = fileName;
		this.fileSize = fileSize;
	}
	public FileEntity() {
		super();
	}
	
	public int getFileNo() {
		return fileNo;
	}
	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}
	public int getJobNo() {
		return jobNo;
	}
	public void setJobNo(int jobNo) {
		this.jobNo = jobNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
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
	public Date getUdpDate() {
		return udpDate;
	}
	public void setUdpDate(Date udpDate) {
		this.udpDate = udpDate;
	}

	
	
	public String getFileExtension() {
		return fileExtension;
	}
	public void setFileExtension(String fileExtension) {
		this.fileExtension = fileExtension;
	}
	@Override
	public String toString() {
		return "fileNo:" + fileNo + "/ jobNo:" + jobNo
				+ "/ userNo:" + userNo + "/ fileName:" + fileName
				+ "/ fileSize:" + fileSize + "/fileExtension:"+fileExtension+"/ regDate:" + regDate
				+ "/ udpDate:" + udpDate;
	}
	
	
}
