package com.fkiller.web.entity;

import java.sql.Date;

public class NoticeEntity {
	private int noticeNo;
	private int userNo;
	private int teamNo;
	private String noticeTitle;
	private String noticeDesc;
	private Date regDate;
	private Date updDate;
	
	public NoticeEntity(int noticeNo, int userNo, int teamNo,
			String noticeTitle, String noticeDesc, Date regDate,
			Date updDate) {
		super();
		this.noticeNo = noticeNo;
		this.userNo = userNo;
		this.teamNo = teamNo;
		this.noticeTitle = noticeTitle;
		this.noticeDesc = noticeDesc;
		this.regDate = regDate;
		this.updDate = updDate;
	}
	public NoticeEntity(int userNo, int teamNo, String noticeTitle,
			String noticeDesc, Date regDate, Date updDate) {
		super();
		this.userNo = userNo;
		this.teamNo = teamNo;
		this.noticeTitle = noticeTitle;
		this.noticeDesc = noticeDesc;
		this.regDate = regDate;
		this.updDate = updDate;
	}
	public NoticeEntity(int userNo, int teamNo, String noticeTitle,
			String noticeDesc) {
		super();
		this.userNo = userNo;
		this.teamNo = teamNo;
		this.noticeTitle = noticeTitle;
		this.noticeDesc = noticeDesc;
	}
	public NoticeEntity() {
		super();
	}
	
	public int getNoticeNo() {
		return noticeNo;
	}
	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
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
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getNoticeDesc() {
		return noticeDesc;
	}
	public void setNoticeDesc(String noticeDesc) {
		this.noticeDesc = noticeDesc;
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
	
	@Override
	public String toString() {
		return "noticeNo:" + noticeNo + "/ userNo:" + userNo
				+ "/ teamNo:" + teamNo + "/ noticeTitle:" + noticeTitle
				+ "/ noticeDesc:" + noticeDesc + "/ regDate:" + regDate
				+ "/ updDate:" + updDate ;
	}
	
	
}
