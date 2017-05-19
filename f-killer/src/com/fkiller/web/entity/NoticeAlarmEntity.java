package com.fkiller.web.entity;

import java.sql.Date;

public class NoticeAlarmEntity {
	private int noticeAlarmNo;
	private int userNo;
	private int noticeNo;
	private Date sendDate;
	
	public NoticeAlarmEntity(int noticeAlarmNo, int userNo, int noticeNo,
			Date sendDate) {
		super();
		this.noticeAlarmNo = noticeAlarmNo;
		this.userNo = userNo;
		this.noticeNo = noticeNo;
		this.sendDate = sendDate;
	}
	public NoticeAlarmEntity(int userNo, int noticeNo, Date sendDate) {
		super();
		this.userNo = userNo;
		this.noticeNo = noticeNo;
		this.sendDate = sendDate;
	}
	public NoticeAlarmEntity(int userNo, int noticeNo) {
		super();
		this.userNo = userNo;
		this.noticeNo = noticeNo;
	}
	public NoticeAlarmEntity() {
		super();
	}
	
	public int getNoticeAlarmNo() {
		return noticeAlarmNo;
	}
	public void setNoticeAlarmNo(int noticeAlarmNo) {
		this.noticeAlarmNo = noticeAlarmNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public int getNoticeNo() {
		return noticeNo;
	}
	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}
	public Date getSendDate() {
		return sendDate;
	}
	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}
	
	@Override
	public String toString() {
		return "noticeAlarmNo:" + noticeAlarmNo
				+ "/ userNo:" + userNo + "/ noticeNo:" + noticeNo
				+ "/ sendDate:" + sendDate;
	}
	
	
}
