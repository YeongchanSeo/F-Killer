package com.fkiller.web.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

import com.fkiller.web.contants.Colors;
import com.fkiller.web.entity.MeetingEntity;
import com.fkiller.web.entity.PartInEntity;
import com.fkiller.web.service.MeetingService;
import com.fkiller.web.vo.MeetingVo;
import com.fkiller.web.vo.PartVo;

public class MeetingDAO implements MeetingService{
	private static ResourceBundle bundle;
	private static MeetingDAO instance;
		
	static{
		bundle=ResourceBundle.getBundle("config/jdbc");	
	}
	
	public static synchronized MeetingDAO getInistance(){
		if(instance==null){	
			instance=new MeetingDAO();
		}
		return instance;
	}
	
	private MeetingDAO(){
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
	
	public List<MeetingVo> teamMeetingList(int teamNo, int done, int num){ //[done]-1:예정만, 0:모두, 1:완료만   //[num]0:전부, 나머지:원하는 개수만큼
		Connection conn=getConnection();
		
		List<MeetingVo> list=new ArrayList<MeetingVo>();
		
		String selectSQL = "SELECT A.* FROM (SELECT @ROWNUM := @ROWNUM + 1 AS ROWNUM, n.* "
					+"FROM (SELECT * FROM meeting WHERE team_no=? ";
		
		switch(done){
		case -1:
			selectSQL  += "AND state=false ";
			break;
		case 0: break;
		case 1:
			selectSQL += "AND state=true ";
			break;
		}
		
		if(num<=0){
			selectSQL += " ORDER BY meeting_date ASC) n, (SELECT @ROWNUM := 0) R ) A";
		}else{
			selectSQL += "AND meeting_date >= DATE(NOW()) ORDER BY meeting_date ASC) n, (SELECT @ROWNUM := 0) R ) A "
				  +"WHERE A.ROWNUM <= ?";
		}
		
		PreparedStatement pstmt=null;
		try{			
			pstmt=conn.prepareStatement(selectSQL);
			pstmt.setInt(1, teamNo);
			if(num>0){
				pstmt.setInt(2, num);
			}
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()){
				MeetingVo entity=new MeetingVo();
				
				entity.setMeetingNo(rs.getInt("meeting_no"));
				entity.setMeetingDate(rs.getDate("meeting_date"));
				entity.setMeetingTime(rs.getTime("meeting_time"));
				entity.setMeetingTitle(rs.getString("meeting_title"));
				entity.setMeetingTopic(rs.getString("meeting_topic"));
				entity.setMeetingDesc(rs.getString("meeting_desc"));
				entity.setMeetingLoc(rs.getString("meeting_loc"));
				entity.setState(rs.getBoolean("state"));
				
				List<PartVo> partInList=getParticipations(conn, entity.getMeetingNo(),teamNo);
				entity.setParticipants(partInList);
				
				list.add(entity);
			}
		}catch(SQLException sqle){
			System.out.println("MeetingDAO-teamMeetingList메소드에러");
			sqle.printStackTrace();
		}finally{
			closeConnection(conn);
		}
		
		return list;
		
	}
	
	private List<PartVo> getParticipations(Connection conn, int meetingNo,int teamNo){
		List<PartVo> list=new ArrayList<PartVo>();
		
		String selectSQL="SELECT u.user_no, u.user_name, p.state, p.part_in_no, w.member_color "
						+"FROM part_in p join user u "
						+"ON p.user_no=u.user_no JOIN work_in w "
						+"ON u.user_no=w.user_no "
						+"WHERE p.meeting_no=? and w.team_no = ?";
		
		PreparedStatement pstmt=null;
		try {
			pstmt=conn.prepareStatement(selectSQL);
			pstmt.setInt(1, meetingNo);
			pstmt.setInt(2, teamNo);
			
			ResultSet rs=pstmt.executeQuery();
			
			while(rs.next()){
				PartVo entity=new PartVo();
				
				entity.setUserNo(rs.getInt("user_no"));
				entity.setUserName(rs.getString("user_name"));
				entity.setState(rs.getBoolean("state"));
				entity.setPartInNo(rs.getInt("part_in_no"));
				entity.setMemberColor(Colors.valueOf(rs.getString("member_color").toUpperCase()).value());
				
				list.add(entity);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("MeetingDAO-getParticipations메소드에러");
			e.printStackTrace();
		}
		
		return list;
	}
	
	public MeetingVo oneMeeting(int meetingNo,int teamNo){
		Connection conn=getConnection();
		
		String selectSQL="SELECT * FROM meeting WHERE meeting_no=?";
		
		PreparedStatement pstmt=null;
		try {
			pstmt=conn.prepareStatement(selectSQL);
			pstmt.setInt(1, meetingNo);
			ResultSet rs=pstmt.executeQuery();
			
			if(rs.next()){
				MeetingVo entity=new MeetingVo();
				
				entity.setMeetingNo(rs.getInt("meeting_no"));
				entity.setMeetingDate(rs.getDate("meeting_date"));
				entity.setMeetingTime(rs.getTime("meeting_time"));
				entity.setMeetingTitle(rs.getString("meeting_title"));
				entity.setMeetingTopic(rs.getString("meeting_topic"));
				entity.setMeetingDesc(rs.getString("meeting_desc"));
				entity.setMeetingLoc(rs.getString("meeting_loc"));
				entity.setState(rs.getBoolean("state"));
				
				List<PartVo> partInList=getParticipations(conn, entity.getMeetingNo(),teamNo);
				entity.setParticipants(partInList);
				
				return entity;
			}
			else
				return null;
			
		} catch (SQLException e) {
			System.out.println("MeetingDAO-oneMeeting메소드에러");
			e.printStackTrace();
			return null;
		}finally{
			closeConnection(conn);
		}
		
	}
	
	public int insertMeeting(MeetingEntity entity, List<PartInEntity>partInList){ //성공시 추가한 회의 번호 리턴. 실패시 -1 리턴.
		Connection conn=getConnection();
		
		String insertSQL="INSERT INTO meeting(team_no,meeting_date,meeting_time,meeting_topic,"
						+"meeting_title,meeting_loc,reg_date,upd_date,state) "
						+"VALUES(?,?,?,?,?,?,NOW(),NOW(),false)";
		
		PreparedStatement pstmt=null;
		try{
			conn.setAutoCommit(false);
			
			pstmt=conn.prepareStatement(insertSQL);
			pstmt.setInt(1, entity.getTeamNo());
			pstmt.setDate(2, entity.getmeetingDate());
			pstmt.setTime(3, entity.getMeetingTime());
			pstmt.setString(4, entity.getMeetingTopic());
			pstmt.setString(5, entity.getMeetingTitle());
			pstmt.setString(6, entity.getMeetingLoc());
			
			int result=pstmt.executeUpdate();
			if(result>0){
				String selectSQL="SELECT max(meeting_no) FROM meeting";
				PreparedStatement pstmt2=conn.prepareStatement(selectSQL);
				
				ResultSet rs=pstmt2.executeQuery();
				if(rs.next()){
					int meetingNo=rs.getInt(1);
					
					boolean partResult=false;
					for(PartInEntity partEntity:partInList){
						partEntity.setMeetingNo(meetingNo);
						partResult=insertPartIn(conn, partEntity);
						if(!partResult){
							conn.rollback();
							return -1;
						}
					}
					conn.commit();
					return meetingNo;
				}else{
					conn.rollback();
					return -1;
				}
			}else{
				conn.rollback();
				return -1;
			}
		}catch(SQLException sqle){
			System.out.println("MeetingDAO-insertMeeting메소드에러");
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
	
	/**
	 * 회의 업데이트 함수 - partInList를 보낼 때 PartInEntity에 partInNo도 정확히 넣어서 보내야함. 신규는 0으로
	 * @param entity
	 * @param partInList
	 * @return
	 */
	public boolean updateMeeting(MeetingEntity entity, List<PartInEntity>partInList,int teamNo){
		Connection conn=getConnection();
		
		String updateSQL="UPDATE meeting "
						+"SET meeting_date=?,meeting_time=?,meeting_topic=?,"
						+"meeting_title=?,meeting_loc=?,upd_date=NOW() "
						+"WHERE meeting_no=?";
		
		PreparedStatement pstmt=null;
		try{
			conn.setAutoCommit(false);
			
			pstmt=conn.prepareStatement(updateSQL);
			pstmt.setDate(1, entity.getmeetingDate());
			pstmt.setTime(2, entity.getMeetingTime());
			pstmt.setString(3, entity.getMeetingTopic());
			pstmt.setString(4, entity.getMeetingTitle());
			pstmt.setString(5, entity.getMeetingLoc());
			pstmt.setInt(6, entity.getMeetingNo());
			
			int result=pstmt.executeUpdate();
			if(result>0){
				List<PartVo> savedPartInList=getParticipations(conn, entity.getMeetingNo(),teamNo);
				boolean isThereChage=checkInsertOrDeletePartIn(savedPartInList, partInList);
				if(isThereChage){
					for(PartVo pVo:savedPartInList){
						if(!deletePartIn(conn, pVo.getPartInNo())){
							conn.rollback();
							return false;
						}
					}
					for(PartInEntity pEntity:partInList){
						if(!insertPartIn(conn, pEntity)){
							conn.rollback();
							return false;
						}
					}
				}
				conn.commit();
				return true;
			}else{
				conn.rollback();
				return false;
			}
		}catch(SQLException sqle){
			sqle.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("MeetingDAO-updateMeeting메소드에러");
				e.printStackTrace();
			}
			return false;
		}finally{
			closeConnection(conn);
		}
	}
	
	private boolean checkInsertOrDeletePartIn(List<PartVo> savedList, List<PartInEntity> newList){
		boolean usage=false;
		
		List<PartVo> tempVoList=new ArrayList<PartVo>();
		List<PartInEntity> tempEntityList=new ArrayList<PartInEntity>();
		
		for(PartVo vo:savedList){
			for(PartInEntity entity:newList){
				if(vo.getPartInNo()==entity.getPartInNo())
					tempVoList.add(vo);
			}
		}
		for(PartInEntity entity:newList){
			for(PartVo vo:savedList){
				if(entity.getPartInNo()==vo.getPartInNo())
					tempEntityList.add(entity);
			}
		}
		
		if(tempVoList.size()>0)
			savedList.removeAll(tempVoList);
		
		if(tempEntityList.size()>0)
			newList.removeAll(tempEntityList);
		
		if(savedList.size()>0 || newList.size()>0)
			usage=true;
		
		return usage;
	}
	
	public boolean deleteMeeting(int meetingNo){
		Connection conn=getConnection();
		
		String deleteSQL="DELETE FROM meeting WHERE meeting_no=?";
		
		PreparedStatement pstmt=null;
		try{
			conn.setAutoCommit(false);
			
			pstmt=conn.prepareStatement(deleteSQL);
			pstmt.setInt(1, meetingNo);
			
			int result=pstmt.executeUpdate();
			if(result>0){
				conn.commit();
				return true;
			}else{
				conn.rollback();
				return false;
			}
		}catch(SQLException sqle){
			System.out.println("MeetingDAO-deleteMeeting메소드에러");
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
	
	private boolean insertPartIn(Connection conn, PartInEntity entity){
		String insertSQL="INSERT INTO part_in(user_no,meeting_no,state) "
						+"VALUES(?,?,false)";

		PreparedStatement pstmt=null;
		try{
			pstmt=conn.prepareStatement(insertSQL);
			pstmt.setInt(1, entity.getUserNo());
			pstmt.setInt(2, entity.getMeetingNo());
			
			int result=pstmt.executeUpdate();
			if(result>0){
				return true;
			}else{
				return false;
			}
		}catch(SQLException sqle){
			System.out.println("MeetingDAO-insertPartIn메소드에러");
			sqle.printStackTrace();
			return false;
		}
	}
	
	private boolean deletePartIn(Connection conn, int partInNo){
		String deleteSQL="DELETE FROM part_in WHERE part_in_no=?";
		
		PreparedStatement pstmt=null;
		try{
			pstmt=conn.prepareStatement(deleteSQL);
			pstmt.setInt(1, partInNo);
			
			int result=pstmt.executeUpdate();
			if(result>0){
				return true;
			}else{
				return false;
			}
		}catch(SQLException sqle){
			System.out.println("MeetingDAO-deletePartIn메소드에러");
			sqle.printStackTrace();
			return false;
		}		
	}
	
	private boolean updatePartIn(Connection conn, PartInEntity entity){
		String deleteSQL="UPDATE part_in "
						+"SET state=? "
						+"WHERE part_in_no=?";
		
		PreparedStatement pstmt=null;
		try{
			pstmt=conn.prepareStatement(deleteSQL);
			pstmt.setBoolean(1, entity.isState());
			pstmt.setInt(2, entity.getPartInNo());
			
			int result=pstmt.executeUpdate();
			if(result>0){
				return true;
			}else{
				return false;
			}
		}catch(SQLException sqle){
			System.out.println("MeetingDAO-updatePartIn메소드에러");
			sqle.printStackTrace();
			return false;
		}	
	}
	
	public boolean writeMeetingLog(MeetingEntity entity, List<PartInEntity>partInList){
		Connection conn=getConnection();
		
		try{
			conn.setAutoCommit(false);
			boolean result=updateMeetingLog(conn, entity);
			if(result){
				for(PartInEntity pEntity:partInList){
					if(!updatePartIn(conn, pEntity)){
						conn.commit();
						return false;
					}
				}
				conn.commit();
				return true;
			}else{
				conn.rollback();
				return false;
			}
		}catch(SQLException sqle){
			System.out.println("MeetingDAO-insertMeetingLog메소드에러");
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

	private boolean updateMeetingLog(Connection conn, MeetingEntity entity){
		String updateSQL="UPDATE meeting "
						+"SET meeting_desc=?,state=true,upd_date=NOW() "
						+"WHERE meeting_no=?";
		
		PreparedStatement pstmt=null;
		try{
			pstmt=conn.prepareStatement(updateSQL);
			pstmt.setString(1, entity.getMeetingDesc());
			pstmt.setInt(2, entity.getMeetingNo());
			
			int result=pstmt.executeUpdate();
			if(result>0){
				return true;
			}else{
				return false;
			}
		}catch(SQLException sqle){
			System.out.println("MeetingDAO-updateMeetingLog메소드에러");
			sqle.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean hasMeeting(int teamNo, Date date) {
		Connection conn=getConnection();
		String selectSQL="SELECT * FROM meeting WHERE team_no=? and meeting_date=?";
		
		PreparedStatement pstmt=null;
		try{
			pstmt=conn.prepareStatement(selectSQL);
			pstmt.setInt(1, teamNo);
			pstmt.setDate(2, date);
			
			ResultSet rs=pstmt.executeQuery();
			
			if(rs.next()){
				return true;
			}else{
				return false;
			}
		}catch(SQLException sqle){
			System.out.println("MeetingDAO-hasMeeting메소드에러");
			sqle.printStackTrace();
			return false;
		}finally{
			closeConnection(conn);
		}
	}
	
}
