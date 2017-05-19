package com.fkiller.web.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

import com.fkiller.web.entity.NoticeEntity;
import com.fkiller.web.service.NoticeService;


public class NoticeDAO implements NoticeService{
	private static ResourceBundle bundle;
	private static NoticeDAO instance;
		
	static{
		bundle=ResourceBundle.getBundle("config/jdbc");	
	}
	
	public static synchronized NoticeDAO getInistance(){
		if(instance==null){
			instance=new NoticeDAO();
		}
		return instance;
	}
	
	private NoticeDAO(){
		try {
			Class.forName(bundle.getString("driver"));
		} catch (ClassNotFoundException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	private Connection getConnection(){
		try {
			Connection conn=DriverManager.getConnection(bundle.getString("url"),
							bundle.getString("user_id"),bundle.getString("user_pwd"));

			return conn;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}	
	}
	
	private void closeConnection(Connection conn){
		try{
			if(conn!=null/* || !conn.isClosed()*/)
				conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
	
	
	public List<NoticeEntity> teamNoticeList(int teamNo, int num){	//0:전부, 나머지:원하는 개수만큼
		Connection conn=getConnection();
		
		List<NoticeEntity> list=new ArrayList<NoticeEntity>();
		
		String selectSQL="SELECT * FROM notice WHERE team_no=?";
		if(num>0){
		/*	selectSQL = "SET @RNUM := 0; "+"SELECT * , @RNUM := @RNUM + 1 "
					  + "from (SELECT * FROM notice WHERE team_no=? ORDER BY reg_date DESC) a "
					  + "where @RNUM := @RNUM + 1<=?";
			*/
			
			selectSQL = "SELECT A.* FROM (SELECT @ROWNUM := @ROWNUM + 1 AS ROWNUM, n.* "
					   +"FROM (select * from notice where team_no=? order by reg_date desc) n, "
					   +"(SELECT @ROWNUM := 0) R ) A "
					   +"WHERE A.ROWNUM <= ?";
		}
		
		PreparedStatement pstmt=null;
		try{			
			pstmt=conn.prepareStatement(selectSQL);
			pstmt.setInt(1, teamNo);
			
			if(num>0){
				pstmt.setInt(2, num);
				/*PreparedStatement ppstmt=conn.prepareStatement(preSQL);
				int result=ppstmt.executeUpdate();
				if(result<=0){
					return list;
				}*/
			}
			
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()){
				NoticeEntity entity=new NoticeEntity();
				
				entity.setNoticeNo(rs.getInt("notice_no"));
				//entity.setUserNo(rs.getInt("user_no"));
				//entity.setTeamNo(rs.getInt("team_no"));
				entity.setNoticeTitle(rs.getString("notice_title"));
				entity.setNoticeDesc(rs.getString("notice_desc"));
				//entity.setRegDate(rs.getTimestamp("reg_date"));
				entity.setUpdDate(rs.getDate("upd_date"));
				
				list.add(entity);
			}
		}catch(SQLException sqle){
			System.out.println("NoticeDAO-teamNoticeList 메소드 오류");
			sqle.printStackTrace();
		}finally{
			closeConnection(conn);
		}
		
		return list;
	}
	
	public int insertNotice(NoticeEntity entity){  //성공시 추가한 공지 번호 리턴. 실패시 -1 리턴.
		Connection conn=getConnection();
		
		String insertSQL="INSERT INTO notice(user_no,team_no,notice_title,notice_desc,reg_date,upd_date) "
						+"VALUES(?,?,?,?,NOW(),NOW())";
		
		PreparedStatement pstmt=null;
		try{
			conn.setAutoCommit(false);
			
			pstmt=conn.prepareStatement(insertSQL);
			pstmt.setInt(1, entity.getUserNo());
			pstmt.setInt(2, entity.getTeamNo());
			pstmt.setString(3, entity.getNoticeTitle());
			pstmt.setString(4, entity.getNoticeDesc());
			
			
			int result=pstmt.executeUpdate();
			if(result>0){
				pstmt=conn.prepareStatement("SELECT max(notice_no) FROM notice");
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()){
					int noticeNo = rs.getInt(1);
					conn.commit();
					return noticeNo;
				}else{
					conn.rollback();
					return -1;
				}
			}else{
				conn.rollback();
				return -1;
			}
		}catch(SQLException sqle){
			System.out.println("NoticeDAO-insertNotice 메소드 오류");
			sqle.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return -1;
		}finally{
			closeConnection(conn);
		}
	}
	
	public boolean updateNotice(NoticeEntity entity){
		Connection conn=getConnection();
		
		String deleteSQL="UPDATE notice "
						+"SET user_no=?,team_no=?,notice_title=?,notice_desc=?,upd_date=NOW() "
						+"WHERE notice_no=?";
		
		PreparedStatement pstmt=null;
		try{
			conn.setAutoCommit(false);
			
			pstmt=conn.prepareStatement(deleteSQL);
			pstmt.setInt(1, entity.getUserNo());
			pstmt.setInt(2, entity.getTeamNo());
			pstmt.setString(3, entity.getNoticeTitle());
			pstmt.setString(4, entity.getNoticeDesc());
			pstmt.setInt(5, entity.getNoticeNo());

			int result=pstmt.executeUpdate();
			if(result>0){
				conn.commit();
				return true;
			}else{
				conn.rollback();
				return false;
			}
		}catch(SQLException sqle){
			System.out.println("NoticeDAO-updateNotice 메소드 오류");
			sqle.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return false;
		}finally{
			closeConnection(conn);
		}
	}
	
	public boolean deleteNotice(int noticeNo){
		
		Connection conn=getConnection();
		
		String deleteSQL="DELETE FROM notice WHERE notice_no=?";
		
		PreparedStatement pstmt=null;
		try{
			conn.setAutoCommit(false);
			
			pstmt=conn.prepareStatement(deleteSQL);
			pstmt.setInt(1, noticeNo);
			
			int result=pstmt.executeUpdate();
			if(result>0){
				conn.commit();
				return true;
			}else{
				conn.rollback();
				return false;
			}
		}catch(SQLException sqle){
			System.out.println("NoticeDAO-deleteNotice 메소드 오류");
			sqle.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return false;
		}finally{
			closeConnection(conn);
		}
	}
	
	public NoticeEntity oneNotice(int noticeNo){
		Connection conn=getConnection();
		
		String selectSQL="SELECT * FROM notice WHERE notice_no=?";
		
		PreparedStatement pstmt=null;
		try {
			pstmt=conn.prepareStatement(selectSQL);
			pstmt.setInt(1, noticeNo);
			ResultSet rs=pstmt.executeQuery();
			
			if(rs.next()){
				NoticeEntity entity=new NoticeEntity();
				entity.setNoticeNo(rs.getInt("notice_no"));
				//entity.setUserNo(rs.getInt("user_no"));
				//entity.setTeamNo(rs.getInt("team_no"));
				entity.setNoticeTitle(rs.getString("notice_title"));
				entity.setNoticeDesc(rs.getString("notice_desc"));
				//entity.setRegDate(rs.getTimestamp("reg_date"));
				entity.setUpdDate(rs.getDate("upd_date"));
				
				return entity;
			}
			else
				return null;
			
		} catch (SQLException e) {
			System.out.println("NoticeDAO-oneNotice 메소드 오류");
			e.printStackTrace();
			return null;
		}finally{
			closeConnection(conn);
		}
	}
	
	
}
