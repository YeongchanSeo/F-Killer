package com.fkiller.web.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class FileVo {
	private int fileNo;
	private int jobNo;
	private String jobTitle;
	private String fileName;
	private String fileSize;
	private String fileExtension;
	private Date regDate;
	
	public FileVo(int fileNo, int jobNo,String jobTitle,String fileName,
			String fileSize, String fileExtension,Date regDate) {
		this.fileNo = fileNo;
		this.jobNo = jobNo;
		this.jobTitle = jobTitle;
		this.fileName = fileName;
		this.fileSize = fileSize;
		this.fileExtension = fileExtension;
		this.regDate = regDate;
	}
	
	
	public FileVo() {
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
	
	public String getJobTitle() {
		return jobTitle;
	}

	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}

	public String getFileExtension() {
		return fileExtension;
	}


	public void setFileExtension(String fileExtension) {
		this.fileExtension = fileExtension;
	}


	@Override
	public String toString() {
		return "fileNo:" + fileNo + "/ jobNo:" + jobNo +" / jobTitle:"+jobTitle
				 + "/ fileName:" + fileName
				+ "/ fileSize:" + fileSize + "/ fileExtension:" + fileExtension + "/ regDate:" + regDate;
	}
}
