package com.fkiller.web.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

import com.fkiller.web.contants.Colors;
import com.fkiller.web.contants.JobState;
import com.fkiller.web.entity.UserEntity;
import com.fkiller.web.service.UserService;
import com.fkiller.web.vo.JobVo;
import com.fkiller.web.vo.TeamVo;

public class UserDAO implements UserService{
	private static ResourceBundle bundle;
	private static UserDAO instance;
	
	static{
		bundle = ResourceBundle.getBundle("config/jdbc");
	}
	
	public static synchronized UserDAO getInstance(){
		if(instance==null)
			instance = new UserDAO();
		
		return instance;
	}
	
	private UserDAO(){
		try{
			Class.forName(bundle.getString("driver"));
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	private Connection getConnection(){
		try{
			Connection conn = DriverManager.getConnection(bundle.getString("url"),bundle.getString("user_id"), bundle.getString("user_pwd"));
			System.out.println("conn 성공");
			return conn;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	private void closeConnection(Connection conn){
		try{
			if(conn!=null)
				conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
	
	public boolean insertUser(UserEntity entity){
		Connection conn = getConnection();
		String insertSQL = "insert into user(user_name,user_email,user_pwd,user_profile,join_method,reg_date,del_flg,del_date) " + 
							"values(?,?,?,?,?,now(),false,'0001-01-01')";
		PreparedStatement pstmt = null;
		
		try{
			int cnt = 0;
			pstmt = conn.prepareStatement(insertSQL);
			pstmt.setString(++cnt, entity.getUserName());
			pstmt.setString(++cnt, entity.getUserEmail());
			pstmt.setString(++cnt, entity.getUserPwd());
			pstmt.setString(++cnt, entity.getUserProfile());
			pstmt.setString(++cnt, entity.getJoinMethod());
			int result = pstmt.executeUpdate();
			if(result>0)
				return true;
			else
				return false;
		
		}catch(SQLException e){
			e.printStackTrace();
			return false;
		}finally{
			closeConnection(conn);
		}
	}
	
	public boolean updateUser(UserEntity entity){
		Connection conn = getConnection();
		
		String updateSQL = "update user set user_name=?,user_pwd=?,user_profile=? where user_no=?";
		PreparedStatement pstmt = null;
		
		System.out.println("updateUser들어옴"+entity);
		try{
			int cnt = 0;
			pstmt = conn.prepareStatement(updateSQL);
			pstmt.setString(++cnt, entity.getUserName());
			pstmt.setString(++cnt, entity.getUserPwd());
			pstmt.setString(++cnt, entity.getUserProfile());
			pstmt.setInt(++cnt, entity.getUserNo());
			
			int result = pstmt.executeUpdate();
			if(result>0)
				return true;
			else
				return false;
		
		}catch(SQLException e){
			e.printStackTrace();
			return false;
		}finally{
			closeConnection(conn);
		}
	}
	
	public boolean deleteUser(int userNo){
	Connection conn = getConnection();
		
		String deleteSQL = "delete from user where user_no = "+userNo;
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(deleteSQL);
			
			int result = pstmt.executeUpdate();
			
			if(result>0)
				return true;
			else
				return false;
		
		}catch(SQLException e){
			e.printStackTrace();
			return false;
		}finally{
			closeConnection(conn);
		}
	}
	
	public UserEntity oneUser(String email){
		Connection conn = getConnection();
		
		String selectSQL = "select * from user where user_email='"+email+"'";
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(selectSQL);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()){
				int cnt=0;
				UserEntity entity = new UserEntity(rs.getInt(++cnt),rs.getString(++cnt)
									,rs.getString(++cnt),rs.getString(++cnt),rs.getString(++cnt)
									,rs.getString(++cnt),rs.getDate(++cnt),rs.getBoolean("del_flg"));
				
				return entity;
			}
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			closeConnection(conn);
		}
		
		return null;
	}
	
	public UserEntity oneUser(int userNo){
		Connection conn = getConnection();
		
		String selectSQL = "select * from user where user_no='"+userNo+"'";
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(selectSQL);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()){
				int cnt=0;
				UserEntity entity = new UserEntity(rs.getInt(++cnt),rs.getString(++cnt)
									,rs.getString(++cnt),rs.getString(++cnt),rs.getString(++cnt)
									,rs.getString(++cnt),rs.getDate(++cnt),rs.getBoolean("del_flg"));
				
				return entity;
			}
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			closeConnection(conn);
		}
		
		return null;
	}
	
	
	public List<UserEntity> getUserList(){
		Connection conn = getConnection();
		String selectSQL = "select * from user";
		PreparedStatement pstmt = null;
		List<UserEntity> userList = new ArrayList<UserEntity>();
		try{
			pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			
			
			while(rs.next()){
				UserEntity entity = new UserEntity(rs.getInt("user_no"),rs.getString("user_name"),rs.getString("user_email")
						,rs.getString("user_pwd"),rs.getString("user_profile"),rs.getString("join_method")
						,rs.getDate("reg_date"),rs.getBoolean("del_flg"));
				if(entity.isDelFlg())
					entity.setDelDate(rs.getDate("del_date"));
				else
					entity.setDelDate(null);
				
				userList.add(entity);
			}
			
			return userList;
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			closeConnection(conn);
		}
	}
	
	public boolean login(String email,String pwd){
		Connection conn = getConnection();
		
		String loginSQL = "select count(*) from user where user_email='"+email+"' and user_pwd='"+pwd+"'";
		
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(loginSQL);
			ResultSet rs = pstmt.executeQuery();
			
			int cnt=0;
			if(rs.next())
				cnt = rs.getInt(1);
			
			if(cnt==1)
				return true;
			else
				return false;
			
		}catch(SQLException e){
			e.printStackTrace();
			return false;
		}finally{
			closeConnection(conn);
		}
	}
	
	public List<TeamVo> teamList(int userNo){
		Connection conn = getConnection();
		String selectSQL = "select * from team_vo where user_no="+userNo;
		
		PreparedStatement pstmt = null;
		
		List<TeamVo> list = null;
		try{
			pstmt = conn.prepareStatement(selectSQL);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs==null)
				return null;
			
			list = new ArrayList<TeamVo>();
			
			while(rs.next()){
				TeamVo vo = new TeamVo(rs.getInt("team_no"),rs.getString("team_name"),
							rs.getString("team_topic"),rs.getDate("start_date"),
							rs.getDate("end_date"),rs.getBoolean("oper"),rs.getInt("leader_no"),rs.getString("user_name"),Colors.valueOf(rs.getString("team_color").toUpperCase()).value(),rs.getBoolean("favorites"));
				list.add(vo);
			}
			return list;
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			closeConnection(conn);
		}
	}
	
	public List<JobVo> personalJobList(int userNo){
		Connection conn = getConnection();
		
		String selectSQL = "select * from job_vo where user_no = "+userNo;
		
		PreparedStatement pstmt = null;
		
		List<JobVo> list = null;
		try{
			pstmt = conn.prepareStatement(selectSQL);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs==null)
				return null;
			
			list = new ArrayList<JobVo>();
			
			while(rs.next()){
				JobVo vo = new JobVo(rs.getInt("job_no"),rs.getString("job_title"),rs.getInt("prop"),rs.getDate("due_date"),rs.getString("job_desc")
						,JobState.valueOf(rs.getString("state")),rs.getInt("team_no"),rs.getString("team_name"),rs.getInt("leader_no"),rs.getString("user_name"));
				list.add(vo);
			}
			
			return list;
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			closeConnection(conn);
		}
	}
	
	public boolean secessionTeam(int userNo,int teamNo){
		Connection conn = getConnection();
		
		String deleteSQL = "delete from work_in where team_no = "+teamNo+" and user_no = "+userNo;
		
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(deleteSQL);
			int result = pstmt.executeUpdate();
			
			if(result>0)
				return true;
			else
				return false;
		}catch(SQLException e){
			e.printStackTrace();
			return false;
		}finally{
			closeConnection(conn);
		}
		
	}
	
	public int changeFavorites(boolean favor, int teamNo, int userNo){
		Connection conn = getConnection();
		
		int changeFavor = 0;
		if(favor == true)
			changeFavor = 0;
		else
			changeFavor = 1;
		
		String updateSQL = "update work_in set FAVORITES="+changeFavor+" where team_no="+teamNo+ " and user_no="+userNo;
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(updateSQL);		
			
			int result = pstmt.executeUpdate();
			
			if(result > 0){				
				return changeFavor;				
			} else
				return -1;

		}catch(SQLException e){
			e.printStackTrace();
			return -1;
		}finally{
			closeConnection(conn);
		}
	}
	
	
}
