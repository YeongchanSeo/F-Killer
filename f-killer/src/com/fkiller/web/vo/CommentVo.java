package com.fkiller.web.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class CommentVo {
	private int commentNo;
	private String name;
	private String desc;
	private Date date;
	
	public CommentVo(){
		
	}
	
	public CommentVo(int commentNo,String name,String desc,Date date){
		this.commentNo = commentNo;
		this.name = name;
		this.desc = desc;
		this.date = date;
	}

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}
	
	public String toString(){
		return "commentNo:"+commentNo+"/name:"+name+"/desc:"+desc+"/date:"+date;
	}
	
}
