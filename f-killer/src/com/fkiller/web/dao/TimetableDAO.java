package com.fkiller.web.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

import com.fkiller.web.entity.TimetableEntity;
import com.fkiller.web.service.TimeTableService;

public class TimetableDAO implements TimeTableService {
	private static ResourceBundle bundle;
	private static TimetableDAO instance;

	static{
		bundle = ResourceBundle.getBundle("config/jdbc");
	}

	public static synchronized TimetableDAO getInstance(){
		if(instance==null)
			instance = new TimetableDAO();

		return instance;
	}

	private Connection getConnection(){
		try{
			Connection conn = DriverManager.getConnection(bundle.getString("url"),bundle.getString("user_id"),bundle.getString("user_pwd"));
			return conn;
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}
	}

	private void closeConnection(Connection conn){
		try{
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
	}

	public TimetableEntity recommendTimetable(List<Integer>userNoList){
		Connection conn = getConnection();
		
		String selectSQL = "select * from timetable where user_no=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<TimetableEntity> list = new ArrayList<TimetableEntity>();
		try{
			pstmt = conn.prepareStatement(selectSQL);
			for(Integer userNo : userNoList){
				int cnt=1;
				pstmt.setInt(1, userNo);
				rs = pstmt.executeQuery();
				if(rs.next()){
					TimetableEntity entity = new TimetableEntity(rs.getString(++cnt),rs.getString(++cnt),rs.getString(++cnt)
										,rs.getString(++cnt),rs.getString(++cnt),rs.getString(++cnt),rs.getString(++cnt));
					list.add(entity);
				}
			}
			return calTimetable(list);
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			closeConnection(conn);
		}
	}

	public boolean insertTimetable(TimetableEntity entity){
		Connection conn = getConnection();

		String insertSQL = "insert into timetable values(?,?,?,?,?,?,?,?)";
		PreparedStatement pstmt = null;

		try{
			int cnt=0;
			pstmt = conn.prepareStatement(insertSQL);
			pstmt.setInt(++cnt, entity.getUserNo());
			pstmt.setString(++cnt, entity.getMon());
			pstmt.setString(++cnt, entity.getTue());
			pstmt.setString(++cnt, entity.getWed());
			pstmt.setString(++cnt, entity.getThu());
			pstmt.setString(++cnt, entity.getFri());
			pstmt.setString(++cnt, entity.getSat());
			pstmt.setString(++cnt, entity.getSun());
			
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

	public boolean updateTimetable(TimetableEntity entity){
		Connection conn = getConnection();

		String updateSQL = "update timetable set mon=?,tue=?,wed=?,thu=?,fri=?,sat=?,sun=? where user_no=?";
		PreparedStatement pstmt = null;

		try{
			int cnt=0;
			pstmt = conn.prepareStatement(updateSQL);
			pstmt.setString(++cnt, entity.getMon());
			pstmt.setString(++cnt, entity.getTue());
			pstmt.setString(++cnt, entity.getWed());
			pstmt.setString(++cnt, entity.getThu());
			pstmt.setString(++cnt, entity.getFri());
			pstmt.setString(++cnt, entity.getSat());
			pstmt.setString(++cnt, entity.getSun());
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

	public boolean deleteTimetable(int userNo){
		Connection conn = getConnection();

		String deleteSQL = "delete from timetable where user_no="+userNo;
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

	public TimetableEntity oneTimetable(int userNo){
		Connection conn = getConnection();

		String selectSQL = "select * from timetable where user_no="+userNo;
		PreparedStatement pstmt = null;

		try{
			pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()){
				int cnt=0;
				TimetableEntity entity = new TimetableEntity(rs.getInt(++cnt), rs.getString(++cnt), rs.getString(++cnt)
						, rs.getString(++cnt), rs.getString(++cnt), rs.getString(++cnt)
						, rs.getString(++cnt), rs.getString(++cnt));
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

	private TimetableEntity calTimetable(List<TimetableEntity> timetableList){
		int mon=0,tue=0,wed=0,thu=0,fri=0,sat=0,sun=0;
		
		mon = Integer.valueOf(timetableList.get(0).getMon(), 2);
		tue = Integer.valueOf(timetableList.get(0).getTue(), 2);
		wed = Integer.valueOf(timetableList.get(0).getWed(), 2);
		thu = Integer.valueOf(timetableList.get(0).getThu(), 2);
		fri = Integer.valueOf(timetableList.get(0).getFri(), 2);
		sat = Integer.valueOf(timetableList.get(0).getSat(), 2);
		sun = Integer.valueOf(timetableList.get(0).getSun(), 2);
		
		for(int i=1;i<timetableList.size();i++){
			mon = mon&Integer.valueOf(timetableList.get(i).getMon(), 2);
			tue = tue&Integer.valueOf(timetableList.get(i).getTue(), 2);
			wed = wed&Integer.valueOf(timetableList.get(i).getWed(), 2);
			thu = thu&Integer.valueOf(timetableList.get(i).getThu(), 2);
			fri = fri&Integer.valueOf(timetableList.get(i).getFri(), 2);
			sat = sat&Integer.valueOf(timetableList.get(i).getSat(), 2);
			sun = sun&Integer.valueOf(timetableList.get(i).getSun(), 2);
		}
		
		TimetableEntity timetable = new TimetableEntity(Integer.toBinaryString(mon),Integer.toBinaryString(tue)
									,Integer.toBinaryString(wed),Integer.toBinaryString(thu),Integer.toBinaryString(fri)
									,Integer.toBinaryString(sat),Integer.toBinaryString(sun));
		
		if(timetable.getMon().length()<24){
			int cnt = 24-timetable.getMon().length();
			for(int i=0;i<cnt;i++){
				System.out.println("##"+i+"/"+timetable.getMon().length());
				timetable.setMon("0"+timetable.getMon());
			}
		}
		if(timetable.getTue().length()<24){
			int cnt = 24-timetable.getTue().length();
			for(int i=0;i<cnt;i++)
				timetable.setTue("0"+timetable.getTue());
		}
		if(timetable.getWed().length()<24){
			int cnt = 24-timetable.getWed().length();
			for(int i=0;i<cnt;i++)
				timetable.setWed("0"+timetable.getWed());
		}
		if(timetable.getThu().length()<24){
			int cnt = 24-timetable.getThu().length();
			for(int i=0;i<cnt;i++)
				timetable.setThu("0"+timetable.getThu());
		}
		if(timetable.getFri().length()<24){
			int cnt = 24-timetable.getFri().length();
			for(int i=0;i<cnt;i++)
				timetable.setFri("0"+timetable.getFri());
		}
		if(timetable.getSat().length()<24){
			int cnt = 24-timetable.getSat().length();
			for(int i=0;i<cnt;i++)
				timetable.setSat("0"+timetable.getSat());
		}
		if(timetable.getSun().length()<24){
			int cnt = 24-timetable.getSun().length();
			for(int i=0;i<cnt;i++)
				timetable.setSun("0"+timetable.getSun());
		}
		System.out.println("@@@@@@"+timetable+"@@@@@@");
		return timetable;
	}
}
