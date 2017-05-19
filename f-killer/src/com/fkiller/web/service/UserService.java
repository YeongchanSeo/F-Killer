package com.fkiller.web.service;

import java.util.List;

import com.fkiller.web.entity.UserEntity;
import com.fkiller.web.vo.JobVo;
import com.fkiller.web.vo.TeamVo;

public interface UserService {
	boolean insertUser(UserEntity entity);
	boolean updateUser(UserEntity entity);
	boolean deleteUser(int userNo);
	UserEntity oneUser(String email);
	UserEntity oneUser(int userNo);
	boolean login(String email,String pwd);
	List<TeamVo> teamList(int userNo);
	List<JobVo> personalJobList(int userNo);
	public boolean secessionTeam(int userNo,int teamNo);
	public int changeFavorites(boolean favor, int teamNo, int userNo);
	public List<UserEntity> getUserList();
}	
