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
import com.fkiller.web.contants.ReportCycle;
import com.fkiller.web.entity.ProfessorEntity;
import com.fkiller.web.entity.TeamEntity;
import com.fkiller.web.entity.WorkInEntity;
import com.fkiller.web.service.TeamService;
import com.fkiller.web.vo.JobReportVo;
import com.fkiller.web.vo.MeetingReportVo;
import com.fkiller.web.vo.TeamMemberVo;
import com.fkiller.web.vo.TeamVo;

public class TeamDAO implements TeamService{
	private static ResourceBundle bundle;
	private static TeamDAO instance;
	
	static{
		bundle = ResourceBundle.getBundle("config/jdbc");
	}
	
	public static synchronized TeamDAO getInstance(){
		if(instance==null)
			instance = new TeamDAO();
		
		return instance;
	}
	
	private TeamDAO(){
		try{
			Class.forName(bundle.getString("driver"));
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	private Connection getConnection(){
		try{
			Connection conn = DriverManager.getConnection(bundle.getString("url"), bundle.getString("user_id"), bundle.getString("user_pwd"));
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
	
	public int createTeam(TeamEntity team,ProfessorEntity professor,WorkInEntity work){
		int teamNo = insertTeam(team);
		
		professor.setTeamNo(teamNo);
		
		if(!insertProfessor(professor))
			return -1;
		
		work.setTeamNo(teamNo);
		
		if(!insertMemeber(work))
			return -1;
		
		return teamNo;
	}
	
	private int insertTeam(TeamEntity entity){
		Connection conn = getConnection();
		
		String insertSQL="insert into team(team_name,team_topic,start_date,end_date"
						+ ",oper,reg_date,upd_date,leader_no) "
						+ "values(?,?,?,?,?,now(),now(),?)";
		PreparedStatement pstmt = null;
		
		try{
			int cnt=0;
			pstmt = conn.prepareStatement(insertSQL);
			pstmt.setString(++cnt, entity.getTeamName());
			pstmt.setString(++cnt, entity.getTeamTopic());
			pstmt.setDate(++cnt, entity.getStartDate());
			pstmt.setDate(++cnt, entity.getEndDate());
			pstmt.setBoolean(++cnt, entity.isOper());
			pstmt.setInt(++cnt, entity.getLeaderNo());
			
			int result = pstmt.executeUpdate();
			
			if(result>0)
				return getTeamNo(conn);
			else
				return -1;
		}catch(SQLException e){
			e.printStackTrace();
			return -1;
		}finally{
			closeConnection(conn);
		}
	}
	
	private int getTeamNo(Connection conn){
		String selectSQL = "select max(team_no) from team";
		
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			int teamNo=-1; 
			if(rs.next())
				teamNo = rs.getInt(1);
			
			return teamNo;
		}catch(SQLException e){
			e.printStackTrace();
			return -1;
		}
	}
	
	private boolean insertProfessor(ProfessorEntity entity){
		Connection conn = getConnection();
		
		String insertSQL = "insert into professor(team_no,email,cycle,auto,reg_date,upd_date,report_date) "
							+ "values(?,?,?,?,now(),now(),?)";
		PreparedStatement pstmt = null;
		
		try{
			int cnt=0;
			pstmt = conn.prepareStatement(insertSQL);
			pstmt.setInt(++cnt, entity.getTeamNo());
			pstmt.setString(++cnt, entity.getEmail());
			pstmt.setString(++cnt, entity.getCycle().toString());
			pstmt.setBoolean(++cnt, entity.isAuto());
			pstmt.setDate(++cnt, entity.getReportDate());
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
	
	public boolean insertMemeber(WorkInEntity entity){
		Connection conn = getConnection();
		
		String insertSQL = "insert into work_in(team_no,user_no,member_color,"
							+ "team_color,favorites,penaltycnt,reg_date)"
							+ "values(?,?,?,?,?,?,now())";
		PreparedStatement pstmt = null;
		
		try{
			int cnt=0;
			pstmt = conn.prepareStatement(insertSQL);
			pstmt.setInt(++cnt, entity.getTeamNo());
			pstmt.setInt(++cnt, entity.getUserNo());
			pstmt.setString(++cnt, entity.getMemberColor().toString());
			pstmt.setString(++cnt, entity.getTeamColor().toString());
			pstmt.setBoolean(++cnt, entity.isFavorites());
			pstmt.setInt(++cnt, entity.getPaneltyCnt());
			
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
	
	public boolean updateTeam(TeamEntity team,ProfessorEntity professor,WorkInEntity work){
		if(!updateTeam(team)){
			return false;
		}
		if(!updateProfessor(professor)) {
			return false;
		}
			
		return true;
	}
	
	private boolean updateTeam(TeamEntity entity){
		Connection conn = getConnection();
		
		String insertSQL="update team set team_name=?,team_topic=?,start_date=?,end_date=?,leader_no=? where team_no=?";
		PreparedStatement pstmt = null;
		
		try{
			int cnt=0;
			pstmt = conn.prepareStatement(insertSQL);
			pstmt.setString(++cnt, entity.getTeamName());
			pstmt.setString(++cnt, entity.getTeamTopic());
			pstmt.setDate(++cnt, entity.getStartDate());
			pstmt.setDate(++cnt, entity.getEndDate());
			pstmt.setInt(++cnt, entity.getLeaderNo());
			pstmt.setInt(++cnt, entity.getTeamNo());
			
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
	
	private boolean updateProfessor(ProfessorEntity entity){
		Connection conn = getConnection();
		
		String insertSQL = "update professor set email=?,cycle=?,auto=?,upd_date=now() where prof_no=?";
			
		PreparedStatement pstmt = null;
		
		try{
			int cnt=0;
			pstmt = conn.prepareStatement(insertSQL);
			pstmt.setString(++cnt, entity.getEmail());
			
			if(entity.getCycle() != null)
				pstmt.setString(++cnt, entity.getCycle().toString());
			else
				pstmt.setString(++cnt, null);
			pstmt.setBoolean(++cnt, entity.isAuto());
			pstmt.setInt(++cnt, entity.getProfNo());
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
	
	public List<TeamVo> getTeamList(){
		Connection conn = getConnection();
		String selectSQL = "select * from team_vo group by team_no order by team_no";
		PreparedStatement pstmt = null;
		List<TeamVo> teamList = new ArrayList<TeamVo>();
		try{
			pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				TeamVo vo = new TeamVo(rs.getInt("team_no"),rs.getString("team_name"),rs.getString("team_topic")
						,rs.getDate("start_date"),rs.getDate("end_date"),rs.getBoolean("oper"), rs.getInt("leader_no")
						,rs.getString("user_name"),Colors.valueOf(rs.getString("team_color").toUpperCase()).value(),rs.getBoolean("favorites"));
				
				teamList.add(vo);
			}
			
			return teamList;
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			closeConnection(conn);
		}
	}
	
	
	public TeamVo oneTeam(int teamNo, int userNo){
		Connection conn = getConnection();
		
		String selectSQL = "select team_name,team_topic,start_date,end_date,oper,leader_no,user_name, team_color,favorites "
						+ "from team_vo where team_no = "+teamNo+" and user_no = "+userNo;

		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(selectSQL);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()){
				int cnt=0;
				TeamVo vo = new TeamVo(teamNo, rs.getString(++cnt), rs.getString(++cnt), 
						rs.getDate(++cnt), rs.getDate(++cnt), rs.getBoolean(++cnt), rs.getInt(++cnt),rs.getString(++cnt),Colors.valueOf(rs.getString(++cnt).toUpperCase()).value(),rs.getBoolean(++cnt));
				return vo;
			}
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			closeConnection(conn);
		}
		return null;
	}
	
	public List<JobReportVo> getJobReport(int teamNo){
		Connection conn = getConnection();
		
		String selectSQL = "select distinct job.job_no,user.user_no, "
				+ "user_name,penaltyCnt from job join work_in on work_in.work_in_no = job.work_in_no "
				+ "join user on work_in.user_no = user.user_no where work_in.team_no = 1 order by user.user_no;";
		PreparedStatement pstmt = null;
		List<JobReportVo> list = new ArrayList<JobReportVo>();
		
		int userNo=0;
		String userName="";
		int paneltyCnt=0;
		List<JobState> jobStateList = new ArrayList<JobState>();
		
		try{
			pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()){
				userNo = rs.getInt("user_no");
				userName = rs.getString("user_name");
				paneltyCnt = rs.getInt("penaltycnt");
				jobStateList.add(JobState.valueOf(rs.getString("state")));
			}else
				return null;
				
			while(rs.next()){
				if(rs.getInt("user_no")!=userNo){
					JobReportVo vo = new JobReportVo(userNo,userName,paneltyCnt);
					jobStateList.clear();
					list.add(vo);
					userNo = rs.getInt("user_no");
					userName = rs.getString("user_name");
					paneltyCnt = rs.getInt("penaltyCnt");
					jobStateList.add(JobState.valueOf(rs.getString("state")));
				}else{
					jobStateList.add(JobState.valueOf(rs.getString("state")));
				}
			}
			
			return list;
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			closeConnection(conn);
		}
	}
	
	public List<MeetingReportVo> getMeetingReport(int teamNo){
		Connection conn = getConnection();
		List<MeetingReportVo> list = new ArrayList<MeetingReportVo>();
		
		if(!getTatolMeeting(conn, teamNo, list))
			return null;
		
		if(!getPartInMeeting(conn, teamNo, list))
			return null;
		
		return list;
	}
	
	private boolean getTatolMeeting(Connection conn,int teamNo,List<MeetingReportVo> list){
		String selectSQL = "select user_no,user_name,count(meeting_no) from part_in_view where team_no = "+teamNo 
				+ " group by user_no order by user_no";
		try {
			PreparedStatement pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				int cnt=0;
				MeetingReportVo vo = new MeetingReportVo(rs.getInt(++cnt), rs.getString(++cnt), rs.getInt(++cnt));
				list.add(vo);
			}
			
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	
	private boolean getPartInMeeting(Connection conn,int teamNo,List<MeetingReportVo> list){
		String selectSQL = "select user_no,count(meeting_no) from part_in_view "
				+ "where team_no = "+teamNo +" and state = true"
				+ " group by user_no order by user_no";
		try {
			PreparedStatement pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			
			for(int i=0;i<list.size();i++){
				if(rs.next()){
					list.get(i).setPartInMeeting(rs.getInt(2));
				}else
					break;
			}
			
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	
	public List<TeamMemberVo> teamMemberList(int teamNo){
		Connection conn = getConnection();
		
		String selectSQL = "select distinct user.user_no, user_email,user_name,user_profile ,member_color	"
				+ "from team join work_in on team.team_no = work_in.team_no join user on user.user_no = work_in.user_no where team.team_no = "+teamNo; 
		PreparedStatement pstmt = null;
		List<TeamMemberVo> list = new ArrayList<TeamMemberVo>();
		try{
			pstmt = conn.prepareStatement(selectSQL);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				TeamMemberVo vo = new TeamMemberVo(rs.getInt("user_no"),rs.getString("user_email"),rs.getString("user_name")
						,rs.getString("user_profile"),teamNo,Colors.valueOf(rs.getString("member_color").toUpperCase()).value());
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
	
	public boolean isLeader(int teamNo,int userNo){
		Connection conn = getConnection();
		
		String selectSQL = "select count(*) from team join user on "
							+ "user.user_no = team.leader_no "
							+ "where team.team_no = "+teamNo+" and user. user_no = "+userNo;
		
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			
			int result=0;
			if(rs.next())
				result = rs.getInt(1);
			
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
	
	public boolean changeTeamLeader(int teamNo,int userNo){
		Connection conn = getConnection();
		
		String updateSQL = "update team set leader_no = "+userNo+" where team_no = "+teamNo;
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(updateSQL);
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
	
	public ProfessorEntity getProfessorInfo(int teamNo){
		Connection conn = getConnection();
		
		String selectSQL = "select team.TEAM_NO, professor.prof_no, PROFESSOR.EMAIL, PROFESSOR.AUTO, PROFESSOR.CYCLE"+
				" from team join PROFESSOR on team.TEAM_NO=professor.TEAM_NO where team.team_no="+teamNo;
		
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			
			ProfessorEntity entity = null;
			while(rs.next()){
				if(rs.getString("cycle") != null) {
					entity = new ProfessorEntity( rs.getString("email"),rs.getInt("team_no"),
							ReportCycle.valueOf(rs.getString("cycle")),rs.getBoolean("auto"), rs.getInt("prof_no"));	
				} else{
					entity = new ProfessorEntity( rs.getString("email"),rs.getInt("team_no"),
							null,rs.getBoolean("auto"), rs.getInt("prof_no"));
				}
					
			}
			return entity;
			
		} catch(SQLException sqe){
			sqe.printStackTrace();
			return null;
		} finally{
			closeConnection(conn);
		}
	}
	
	public int getMaxTeamNo(){
		Connection conn = getConnection();
		String selectSQL = "select max(TEAM_NO) from TEAM"; 

		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();

			int result=0;
			if(rs.next())
				result = rs.getInt(1);
			
			if(result>0)
				return result;
			else
				return -1;
		} catch (SQLException sqe) {
			sqe.printStackTrace();
			return -1;
		} finally {
			closeConnection(conn);
		}
	}
}
