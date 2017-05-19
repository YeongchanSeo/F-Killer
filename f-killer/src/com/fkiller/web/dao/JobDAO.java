package com.fkiller.web.dao;

import java.io.File;
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
import com.fkiller.web.entity.CommentEntity;
import com.fkiller.web.entity.FileEntity;
import com.fkiller.web.entity.JobEntity;
import com.fkiller.web.service.JobService;
import com.fkiller.web.vo.CommentVo;
import com.fkiller.web.vo.FileAdminVo;
import com.fkiller.web.vo.FileVo;
import com.fkiller.web.vo.JobVo;
import com.fkiller.web.vo.JobVo;
import com.fkiller.web.vo.TeamJobListVo;

public class JobDAO implements JobService{
	private static ResourceBundle bundle;
	private static JobDAO instance;
	
	static{
		bundle = ResourceBundle.getBundle("config/jdbc");
	}
	
	public static synchronized JobDAO getInstance(){
		if(instance==null)
			instance = new JobDAO();
		
		return instance;
	}
	
	private JobDAO(){
		try{
			Class.forName(bundle.getString("driver"));
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	private Connection getConnection(){
		try{
			Connection conn = DriverManager.getConnection(bundle.getString("url"),bundle.getString("user_id"),bundle.getString("user_pwd"));
			return conn;
		}
		catch(SQLException e){
			e.printStackTrace();
			return null;
		}
	}
	
	private void closeConnection(Connection conn){
		try{
			if(conn!=null)
				conn.close();
		}
		catch(SQLException e){
			e.printStackTrace();
		}
	}
	
	public boolean insertFile(FileEntity entity){
		Connection conn = getConnection();
		
		String insertSQL = "insert into file(job_no,file_name,file_size,file_extension,reg_date,upd_date)  values(?,?,?,?,now(),now())";
		PreparedStatement pstmt = null;
		
		try{
			int cnt=0;
			pstmt = conn.prepareStatement(insertSQL);
			pstmt.setInt(++cnt,entity.getJobNo());
			pstmt.setString(++cnt,entity.getFileName());
			pstmt.setString(++cnt, entity.getFileSize());
			pstmt.setString(++cnt, entity.getFileExtension());
			
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
	
	private boolean insertFile(Connection conn,FileEntity entity){
		String insertSQL = "insert into file(job_no,file_name,file_size,file_extension,reg_date,upd_date)  values(?,?,?,?,now(),now())";
		PreparedStatement pstmt = null;
		try{
			int cnt=0;
			pstmt = conn.prepareStatement(insertSQL);
			pstmt.setInt(++cnt,entity.getJobNo());
			pstmt.setString(++cnt,entity.getFileName());
			pstmt.setString(++cnt, entity.getFileSize());
			pstmt.setString(++cnt, entity.getFileExtension());
			
			int result = pstmt.executeUpdate();
			
			if(result>0)
				return true;
			else
				return false;
			
		}catch(SQLException e){
			System.out.println("insertFile 에러");
			e.printStackTrace();
			return false;
		}
	}
	
	
	private boolean insertFileList(Connection conn,List<FileEntity> fileList){
		int jobNo = getJobNo(conn);
		for(FileEntity entity : fileList){
			entity.setJobNo(jobNo);
			if(!insertFile(conn,entity))
				return false;
		}
		
		return true;
	}
	
	//FileEntity 삽입 쿼리 작성해야함.
	private boolean insertJob(Connection conn,JobEntity entity){
		
		String insertSQL = "insert into job(work_in_no,job_title,prop,due_date,job_desc,state,upd_date,reg_date) values(?,?,?,?,?,?,now(),now())";
		PreparedStatement pstmt = null;
		try{
			int cnt=0;
			pstmt = conn.prepareStatement(insertSQL);
			pstmt.setInt(++cnt,entity.getWorkInNo());
			pstmt.setString(++cnt, entity.getJobTitle());
			pstmt.setInt(++cnt,entity.getProp());
			pstmt.setDate(++cnt,entity.getDueDate());
			
			pstmt.setString(++cnt,entity.getJobDesc());
			pstmt.setString(++cnt,entity.getState().toString());
			int result = pstmt.executeUpdate();
			if(result>0)
				return true;
			else
				return false;
		}catch(SQLException e){
			System.out.println("insertJob 에러!!");
			e.printStackTrace();
			return false;
		}
	}
	
	private int getJobNo(Connection conn){
		String selectSQL = "select max(job_no) from job";
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			
			int jobNo=-1;
			if(rs.next())
				jobNo = rs.getInt(1);
			
			return jobNo;
		}catch(SQLException e){
			e.printStackTrace();
			return -1;
		}
	}
	
	public int insertJob(JobEntity entity,List<FileEntity>fileList){ //성공시 추가한 업무 번호 리턴. 실패시 -1 리턴.
		Connection conn = getConnection();
		if(!insertJob(conn,entity))
			return -1;

		if(fileList!=null && fileList.size()>0){
			if(!insertFileList(conn,fileList))
				return -1;
		}
		
		int jobNo = getJobNo(conn);
		closeConnection(conn);
		
		return jobNo;
		
	}
	
	
	
	public boolean deleteJob(int jobNo){
		Connection conn = getConnection();
		
		if(!deleteJob(conn,jobNo))
			return false;
		
		if(!deleteFile(conn,jobNo))
			return false;
		
		if(!deleteComment(conn,jobNo))
			return false;
		
		return true;
	}
	
	private boolean deleteJob(Connection conn, int jobNo){
		String deleteSQL = "delete from job where job_no = "+jobNo;
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(deleteSQL);
			int result = pstmt.executeUpdate();
			
			if(result>0)
				return true;
			else
				return false;
		}catch(SQLException e){
			System.out.println("deleteJob 에러!!");
			return false;
		}
	}
	
	private boolean deleteComment(Connection conn,int jobNo){
		
		String deleteSQL = "delete from comment where job_no = "+jobNo;
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
	
	private boolean deleteFile(Connection conn, int jobNo){
		
		String deleteSQL = "delete from file where job_no = "+jobNo;
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(deleteSQL);
			int result = pstmt.executeUpdate();
			
			if(result>0)
				return true;
			else
				return false;
		}catch(SQLException e){
			System.out.println("deleteFile 에러!!");
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean deleteFile(int fileNo){
		Connection conn = getConnection();
		String deleteSQL = "delete from file where file_no = "+fileNo;
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(deleteSQL);
			int result = pstmt.executeUpdate();
			
			if(result>0)
				return true;
			else
				return false;
		}catch(SQLException e){
			System.out.println("deleteFile 에러!!");
			e.printStackTrace();
			return false;
		}finally{
			closeConnection(conn);
		}
	}
	
	public boolean updateJob(JobEntity entity){
		Connection conn = getConnection();
		
		String updateSQL = "update job set work_in_no=?,job_title=?,prop=?,due_date=?,job_desc=?,state=?,upd_date=now() where job_no=?";
		
		System.out.println("update Job : "+entity);
		PreparedStatement pstmt = null;
		try{
			int cnt=0;
			pstmt = conn.prepareStatement(updateSQL);
			pstmt.setInt(++cnt, entity.getWorkInNo());
			pstmt.setString(++cnt, entity.getJobTitle());
			pstmt.setInt(++cnt, entity.getProp());
			pstmt.setDate(++cnt, entity.getDueDate());
			pstmt.setString(++cnt, entity.getJobDesc());
			pstmt.setString(++cnt, entity.getState().toString());
			pstmt.setInt(++cnt, entity.getJobNo());
			
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
	
	public boolean insertComment(CommentEntity entity){
		Connection conn = getConnection();
		
		String insertSQL = "insert into comment(user_no,job_no,comment_desc,reg_date,upd_date) values(?,?,?,now(),now())";
		PreparedStatement pstmt = null;
		try{
			int cnt=0;
			pstmt = conn.prepareStatement(insertSQL);
			pstmt.setInt(++cnt,entity.getUserNo());
			pstmt.setInt(++cnt,entity.getJobNo());
			pstmt.setString(++cnt, entity.getCommentDesc());
			
			int result = pstmt.executeUpdate();
			
			if(result>0)
				return true;
			else
				return false;
		}catch(SQLException e){
			System.out.println("insertComment 에러");
			e.printStackTrace();
			return false;
		}finally{
			closeConnection(conn);
		}
	}
	
	public boolean updateComment(CommentEntity entity){
		Connection conn = getConnection();
		
		String updateSQL = "update comment set comment_desc=?,upd_date=now() where comment_no=?";
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(updateSQL);
			pstmt.setString(1, entity.getCommentDesc());
			pstmt.setInt(2, entity.getCommentNo());
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
	
	
	
	public JobVo oneJob(int jobNo){
		Connection conn = getConnection();
		String selectSQL = "select * from job_vo where job_no = "+jobNo;
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()){
				JobVo vo = new JobVo(rs.getInt("job_no"),rs.getString("job_title"),rs.getInt("prop"),rs.getDate("due_date"),rs.getString("job_desc")
						,JobState.valueOf(rs.getString("state")),rs.getInt("team_no"),rs.getString("team_name"),rs.getInt("leader_no"),rs.getString("user_name"),rs.getInt("user_no"));
				
				
				List<CommentVo> commentList = listComment(conn, jobNo);
				vo.setComments(commentList);
				List<FileVo> fileList = listFile(conn, jobNo);
				vo.setFiles(fileList);
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
	
//	public List<JobVo> teamJobList(int userNo,int teamNo){
//		Connection conn = getConnection();
//		
//		String selectSQL = "select job.job_no,job.job_title,job.prop, job.due_date,job.job_desc,job.state,team.team_name,user.user_name "
//				+ "from job join work_in on job.work_in_no = work_in.work_in_no "
//				+ "join user on user.USER_NO = WORK_IN.WORK_IN_NO join team on team.TEAM_NO = WORK_IN.TEAM_NO "
//				+ "where team.team_no = "+teamNo+" and user.user_no = "+userNo;
//		
//		PreparedStatement pstmt = null;
//		
//		List<JobVo> list = null;
//		try{
//			pstmt = conn.prepareStatement(selectSQL);
//			
//			ResultSet rs = pstmt.executeQuery();
//			
//			if(rs==null)
//				return null;
//			
//			list = new ArrayList<JobVo>();
//			
//			while(rs.next()){
//				JobVo vo = new JobVo(rs.getInt("job_no"),rs.getString("job_title"),rs.getInt("prop"),rs.getTimestamp("due_date"),rs.getString("job_desc")
//						,JobState.valueOf(rs.getString("state")),rs.getString("team_name"),rs.getString("user_name"));
//				
//				List<CommentVo> commentList = listComment(conn, vo.getJobNo());
//				vo.setComments(commentList);
//				List<FileVo> fileList = listFile(conn, vo.getJobNo());
//				vo.setFiles(fileList);
//				
//				list.add(vo);
//			}
//			
//			return list;
//			
//		}catch(SQLException e){
//			e.printStackTrace();
//			return null;
//		}finally{
//			closeConnection(conn);
//		}
//		
//	}
	
	public List<JobVo> teamJobList(int userNo,int teamNo){
		Connection conn = getConnection();
		
		String selectSQL = "select job_no,job_title,prop,due_date,job_desc,state,user_name,user_no "
				+ "from job_vo "
				+ "where team_no = "+teamNo +" and user_no = "+userNo;
		
		PreparedStatement pstmt = null;
		
		List<JobVo> list = null;
		try{
			
			pstmt = conn.prepareStatement(selectSQL);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs==null)
				return null;
			
			list = new ArrayList<JobVo>();
			
			while(rs.next()){
				int cnt=0;
				JobVo vo = new JobVo(rs.getInt(++cnt),rs.getString(++cnt),rs.getInt(++cnt),rs.getDate(++cnt),rs.getString(++cnt),JobState.valueOf(rs.getString(++cnt)),rs.getString(++cnt),rs.getInt("user_no"));
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
	
	public List<JobVo> teamJobList(int teamNo){
		Connection conn = getConnection();
		
		String selectSQL = "select job_no,job_title,prop,due_date,job_desc,state,user_name,user_no "
				+ "from job_vo "
				+ "where team_no="+teamNo;
		
		PreparedStatement pstmt = null;
		
		List<JobVo> list = null;
		try{
			
			pstmt = conn.prepareStatement(selectSQL);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs==null)
				return null;
			
			list = new ArrayList<JobVo>();
			
			while(rs.next()){
				int cnt=0;
				JobVo vo = new JobVo(rs.getInt(++cnt),rs.getString(++cnt),rs.getInt(++cnt),rs.getDate(++cnt),rs.getString(++cnt),JobState.valueOf(rs.getString(++cnt)),rs.getString(++cnt), rs.getInt(++cnt));		
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
	
	
	public List<TeamJobListVo> teamJobCalendar(int teamNo){
		Connection conn = getConnection();
		
		String selectSQL = "select job_no,work_in.user_no,user_name,job_title,member_color,due_date "
				+ "from job join work_in on job.work_in_no = work_in.work_in_no join user on work_in.user_no = user.user_no "
				+ "where work_in.team_no = "+teamNo+" order by due_date";
		
		PreparedStatement pstmt = null;
		
		List<TeamJobListVo> list = null;
		try{
			pstmt = conn.prepareStatement(selectSQL);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs==null)
				return null;
			
			list = new ArrayList<TeamJobListVo>();
			
			while(rs.next()){
				int cnt=0;
				TeamJobListVo vo = new TeamJobListVo(rs.getInt(++cnt),rs.getInt(++cnt),rs.getString(++cnt),
										rs.getString(++cnt),Colors.valueOf(rs.getString(++cnt).toUpperCase()).value(),rs.getDate(++cnt));
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
	
//	public List<JobVo> teamJobList(int teamNo){
//		Connection conn = getConnection();
//		
//		String selectSQL = "select job.job_no,job.job_title,job.prop, job.due_date,job.job_desc,job.state,team.team_name,user.user_name "
//				+ "from job join work_in on job.work_in_no = work_in.work_in_no "
//				+ "join user on user.USER_NO = WORK_IN.WORK_IN_NO join team on team.TEAM_NO = WORK_IN.TEAM_NO "
//				+ "where team.team_no = "+teamNo;
//		
//		List<JobVo> list = null;
//		PreparedStatement pstmt = null;
//		
//		try{
//			pstmt = conn.prepareStatement(selectSQL);
//			ResultSet rs = pstmt.executeQuery();
//			
//			if(rs==null)
//				return null;
//			
//			list = new ArrayList<JobVo>();
//			
//			while(rs.next()){
//				JobVo vo = new JobVo(rs.getInt("job_no"),rs.getString("job_title"),rs.getInt("prop"),rs.getTimestamp("due_date"),rs.getString("job_desc")
//						,JobState.valueOf(rs.getString("state")),rs.getString("team_name"),rs.getString("user_name"));
//				
//				List<CommentVo> commentList = listComment(conn, vo.getJobNo());
//				vo.setComments(commentList);
//				List<FileVo> fileList = listFile(conn, vo.getJobNo());
//				vo.setFiles(fileList);
//				
//				list.add(vo);
//			}
//			
//			return list;
//			
//		}catch(SQLException e){
//			e.printStackTrace();
//			return null;
//		}finally{
//			closeConnection(conn);
//		}
//		
//	}
	
	
	
	private List<CommentVo> listComment(Connection conn,int jobNo){
		
		String selectSQL = "select user.user_name, comment.comment_desc, comment.comment_no, comment.upd_date " +
							"from comment join user " +
							"on comment.user_no = user.user_no " +
							"where job_no="+jobNo;
		PreparedStatement pstmt = null;
		List<CommentVo> list = null;
		try{
			pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs==null)
				return null;
			
			list = new ArrayList<CommentVo>();
			
			while(rs.next()){
				CommentVo vo = new CommentVo(rs.getInt("comment_no"),rs.getString("user_name"),rs.getString("comment_desc"),rs.getDate("upd_date"));
				list.add(vo);
			}
			
			return list;
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}
	}
	
	private List<FileVo> listFile(Connection conn,int jobNo){
		
		String selectSQL = "select file_no,job_no, job_title, "+
							"file_name,file_size,file_extension,reg_date "+
							//"from file join job on file.job_no = job.job_no "+
							//"join work_in on work_in.WORK_IN_NO = job.WORK_IN_NO "+
							"from file_vo where job_no="+jobNo;
		
		PreparedStatement pstmt = null;
		List<FileVo> list = null;
		try{
			pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs==null)
				return null;
			
			list = new ArrayList<FileVo>();
			
			while(rs.next()){
				FileVo vo = new FileVo(rs.getInt("file_no"),rs.getInt("job_no"),rs.getString("job_title")
						,rs.getString("file_name"),rs.getString("file_size"),rs.getString("file_extension"),rs.getDate("reg_date"));
				list.add(vo);
			}
			
			return list;
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}
	}
	
	
	
	
	public FileVo oneFile(int fileNo){
		Connection conn = getConnection();
		String selectSQL = "select file.file_no,file.job_no, job_title,"+
							"file.file_name,file.file_size,file.file_extension,file.upd_date "+
							"from file join job on file.job_no = job.job_no "+
							"join work_in on work_in.WORK_IN_NO = job.WORK_IN_NO "+
							"where file.file_no="+fileNo;
		
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()){
				FileVo vo = new FileVo(rs.getInt("file_no"),rs.getInt("job_no"),rs.getString("job_title")
						,rs.getString("file_name"),rs.getString("file_size"),rs.getString("file_extension"),rs.getDate("upd_date"));
				return vo;
			}
			
			return null;
			
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			closeConnection(conn);
		}
	}
	
	public boolean updateFile(List<FileEntity> fileList){
		Connection conn = getConnection();
		
		for(FileEntity file : fileList){
			if(file.getFileNo()!=0){
				if(!updateFile(conn,file))
					return false;
			}else{
				if(!insertFile(conn,file))
					return false;
			}
		}
		
		closeConnection(conn);
		
		return true;
	}
	
	private boolean updateFile(Connection conn,FileEntity file){
		String updageSQL = "update file set file_name = ?, file_size = ?, file_extension = ? ,upd_date = now() where file_no = ?";
		
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(updageSQL);
			int cnt=0;
			pstmt.setString(++cnt,file.getFileName());
			pstmt.setString(++cnt, file.getFileSize());
			pstmt.setString(++cnt, file.getFileExtension());
			pstmt.setInt(++cnt, file.getFileNo());
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
	
	public int getWorkInNo(int userNo,int teamNo){
		Connection conn = getConnection();
		String selectSQL = "select work_in_no from work_in where user_no = "+userNo+" and team_no = "+teamNo;
		
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			int workInNo=0;
			if(rs.next()){
				workInNo = rs.getInt(1);
			}else
				return -1;
			
			return workInNo;
		}catch(SQLException e){
			e.printStackTrace();
			return -1;
		}finally{
			closeConnection(conn);
		}
	}
	
	public List<FileVo> teamFileList(int teamNo){
		Connection conn = getConnection();
		String selectSQL = "select file_no,job_no,job_title,file_name,file_size,file_extension,reg_date from file_vo where team_no ="+teamNo;
		PreparedStatement pstmt = null;
		List<FileVo> fileList = new ArrayList<FileVo>();
		
		try{
			pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				int cnt=0;
				FileVo vo = new FileVo(rs.getInt(++cnt), rs.getInt(++cnt), rs.getString(++cnt), rs.getString(++cnt), rs.getString(++cnt), rs.getString(++cnt), rs.getDate(++cnt));
				fileList.add(vo);
			}
			return fileList;
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			closeConnection(conn);
		}
	}
	
	
	public List<FileVo> getFileList(){
		Connection conn = getConnection();
		String selectSQL = "select * from file_vo";
		PreparedStatement pstmt = null;
		List<FileVo> fileList = new ArrayList<FileVo>();
		try{
			pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				int cnt=0;
				FileVo vo = new FileVo(rs.getInt(++cnt),rs.getInt(++cnt),rs.getString(++cnt)
						,rs.getString(++cnt),rs.getString(++cnt),rs.getString(++cnt),rs.getDate(++cnt));
				fileList.add(vo);
			}
			
			return fileList;
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			closeConnection(conn);
		}
	}
	
	public List<FileAdminVo> getAdminFileList(){
		Connection conn = getConnection();
		String selectSQL = "select file_no,file_name,team.team_no,team.team_name,file_size,file_vo.reg_date "
				+ "from file_vo join team on file_vo.team_no = team.team_no;";
		PreparedStatement pstmt = null;
		List<FileAdminVo> fileList = new ArrayList<FileAdminVo>();
		try{
			pstmt = conn.prepareStatement(selectSQL);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				int cnt=0;
				FileAdminVo vo = new FileAdminVo(rs.getInt(++cnt), rs.getString(++cnt), rs.getInt(++cnt), rs.getString(++cnt), rs.getString(++cnt), rs.getDate(++cnt));
				fileList.add(vo);
			}
			
			return fileList;
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			closeConnection(conn);
		}
	}

}


