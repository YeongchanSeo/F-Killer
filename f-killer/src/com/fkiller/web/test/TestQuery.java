package com.fkiller.web.test;

import java.util.List;

import com.fkiller.web.dao.UserDAO;
import com.fkiller.web.vo.TeamVo;

public class TestQuery {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		UserDAO dao = UserDAO.getInstance();
		
		List<TeamVo> list = dao.teamList(1);
		
		System.out.println(list);
			
	}

}
