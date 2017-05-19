package com.fkiller.web.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.ResourceBundle;

import com.fkiller.web.contants.AlarmType;
import com.fkiller.web.contants.JobState;
import com.fkiller.web.entity.AlarmEntity;
import com.fkiller.web.service.AlarmService;
import com.fkiller.web.vo.AlarmVo;

public class AlarmDAO implements AlarmService{
	private static ResourceBundle bundle;
	private static AlarmDAO instance;
	
	static{
		bundle = ResourceBundle.getBundle("config/jdbc");
	}
	
	public static synchronized AlarmDAO getInstance(){
		if(instance==null)
			instance = new AlarmDAO();
		
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
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public List<AlarmVo> teamAlarmList(int userNo,int teamNo){
		Connection conn = getConnection();
		
		List<AlarmVo> list = new ArrayList<AlarmVo>();
		
		if(!meetingAlarmList(conn, userNo, teamNo, list))
			return null;
		
		if(!noticeAlarmList(conn, userNo, teamNo, list))
			return null;

		Collections.sort(list, new Comparator<AlarmVo>() {
			  public int compare(AlarmVo o1, AlarmVo o2) {
			      return o1.getSendDate().compareTo(o2.getSendDate());
			  }
		});
		
		closeConnection(conn);
		
		return list;
	}
	
	private boolean meetingAlarmList(Connection conn, int userNo, int teamNo,List<AlarmVo> list){
		
		String selectSQL = "select meeting_alarm_no, meeting.meeting_no, meeting_alarm.send_date "
							+ " from meeting_alarm join meeting "
							+ " on meeting_alarm.meeting_no = meeting.meeting_no where user_no = "+userNo+" and team_no = "+teamNo
							+ " order by meeting_alarm.send_date";
		
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(selectSQL);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				AlarmVo vo = new AlarmVo(rs.getInt(1), AlarmType.MEETING, "새로운 회의가 등록되었습니다.", rs.getInt(2), rs.getDate(3));
				list.add(vo);
			}
			
			return true;
		}catch(SQLException e){
			e.printStackTrace();
			return false;
		}
	}
	
	private boolean noticeAlarmList(Connection conn,int userNo,int teamNo,List<AlarmVo> list){
		
		String selectSQL = "select notice_alarm_no, notice.notice_no, notice_alarm.send_date"
							+ " from notice_alarm join notice "
							+ " on notice_alarm.notice_no = notice.notice_no where notice_alarm.user_no = "+userNo+" and team_no = "+teamNo
							+ " order by notice_alarm.send_date desc";
		
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(selectSQL);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				AlarmVo vo = new AlarmVo(rs.getInt(1), AlarmType.NOTICE, "새로운 공지가 등록되었습니다.", rs.getInt(2), rs.getDate(3));
				list.add(vo);
			}
			
			return true;
		}catch(SQLException e){
			e.printStackTrace();
			return false;
		}
	}
	
	public List<AlarmVo> personalAlarmList(int userNo){
		Connection conn = getConnection();
		
		List<AlarmVo> list = new ArrayList<AlarmVo>();
		
		if(!jobAlarmList(conn, userNo, list))
			return null;
		
		if(!inviteAlarmList(conn, userNo, list))
			return null;
		
		closeConnection(conn);
		return list;
	}
	
	private boolean jobAlarmList(Connection conn,int userNo,List<AlarmVo> list){
		String selectSQL = "SELECT job_alarm.job_alarm_no,j.job_no,j.job_title, j.team_no, j.state "+
				    	   "FROM (SELECT job_no, job_title, team_no, state "+
				    	   		 "FROM job JOIN work_in "+
				    	   		 "ON job.work_in_no = work_in.work_in_no) j JOIN job_alarm "+ 
				    	   		 										 "ON j.job_no = job_alarm.job_no where user_no = "+ userNo;
		
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				JobState state = JobState.valueOf(rs.getString("state"));
				String message = "";
				if(state == JobState.PERMISSION)
					message = "업무 "+rs.getString(3)+"가(이) 결재 대기 중 입니다.";
				else if(state == JobState.DONE)
					message = "업무 "+rs.getString(3)+"가(이) 결재 승인 되었습니다.";
				else
					message = "새 업무  "+rs.getString(3)+"가(이) 등록되었습니다.";
				
				AlarmVo vo = new AlarmVo(rs.getInt(1), AlarmType.JOB,message,rs.getInt(2), rs.getInt(4));
				list.add(vo);
			}
			return true;
		}catch(SQLException e){
			e.printStackTrace();
			return false;
		}
		
	}

	
	private boolean inviteAlarmList(Connection conn,int userNo,List<AlarmVo> list){
		String selectSQL = "select invite_alarm_no,team.team_no,team.team_name "
				+ "from team join invite_alarm on team.team_no = invite_alarm.team_no where user_no = "+userNo;
		
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				AlarmVo vo = new AlarmVo(rs.getInt(1), AlarmType.INVITE, rs.getString(3)+"팀에서 초대 메시지가 도착하였습니다.", -1,rs.getInt(2));
				list.add(vo);
			}
				
			return true;
		}catch(SQLException e){
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean insertAlarm(AlarmType type,AlarmEntity entity){
		Connection conn = getConnection();
		String detailNo="";
		if(type==AlarmType.JOB)
			detailNo = "JOB_NO";
		else if(type==AlarmType.INVITE)
			detailNo = "TEAM_NO";
		else if(type==AlarmType.MEETING)
			detailNo = "MEETING_NO";
		else if(type==AlarmType.NOTICE)
			detailNo = "NOTICE_NO";
		
		String insertSQL = "insert into "+type+"_ALARM("+detailNo+",user_no,send_date) values(?,?,now())";
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(insertSQL);
			pstmt.setInt(1, entity.getDetailNo());
			pstmt.setInt(2, entity.getUserNo());
			int result = pstmt.executeUpdate();
			
			if(result>0)
				return true;
			else
				return false;
		}catch(SQLException e){
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean deleteAlarm(AlarmType type,int alarmNo){
		Connection conn = getConnection();
		String deleteSQL = "delete from "+type+"_ALARM where "+type+"_ALARM_NO = "+alarmNo;
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
		}
	}
	
}
