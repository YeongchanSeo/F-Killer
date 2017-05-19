package com.fkiller.web.vo;

import com.fkiller.web.contants.Colors;

public class PartVo {
	private int userNo;
	private String userName;
	private boolean state;
	private int partInNo;
	private String memberColor;
	
	public PartVo(int userNo, String userName, boolean state, int partInNo,
			String memberColor) {
		super();
		this.userNo=userNo;
		this.userName = userName;
		this.state = state;
		this.partInNo = partInNo;
		this.memberColor = memberColor;
	}
	
	public PartVo() {
		super();
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public boolean isState() {
		return state;
	}

	public void setState(boolean state) {
		this.state = state;
	}

	public int getPartInNo() {
		return partInNo;
	}

	public void setPartInNo(int partInNo) {
		this.partInNo = partInNo;
	}

	public String getMemberColor() {
		return memberColor;
	}

	public void setMemberColor(String memberColor) {
		this.memberColor = memberColor;
	}

	@Override
	public String toString() {
		return "userNo:" + userNo + "/ userName:" + userName + "/ state:" + state
				+ "/ partInNo:" + partInNo;
	}
	
	
	
}
