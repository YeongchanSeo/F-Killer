package com.fkiller.web.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.fkiller.web.contants.AlarmType;
import com.fkiller.web.contants.JobState;
import com.fkiller.web.dao.AlarmDAO;
import com.fkiller.web.dao.JobDAO;
import com.fkiller.web.dao.MeetingDAO;
import com.fkiller.web.dao.NoticeDAO;
import com.fkiller.web.dao.TeamDAO;
import com.fkiller.web.dao.UserDAO;
import com.fkiller.web.entity.AlarmEntity;
import com.fkiller.web.entity.CommentEntity;
import com.fkiller.web.entity.FileEntity;
import com.fkiller.web.entity.JobEntity;
import com.fkiller.web.entity.NoticeEntity;
import com.fkiller.web.entity.TeamEntity;
import com.fkiller.web.entity.UserEntity;
import com.fkiller.web.service.AlarmService;
import com.fkiller.web.service.JobService;
import com.fkiller.web.service.MeetingService;
import com.fkiller.web.service.NoticeService;
import com.fkiller.web.service.TeamService;
import com.fkiller.web.service.UserService;
import com.fkiller.web.socket.FileDeleter;
import com.fkiller.web.socket.FileDownloader;
import com.fkiller.web.socket.FileUploader;
import com.fkiller.web.vo.JobVo;
import com.fkiller.web.vo.JobVo;
import com.fkiller.web.vo.MeetingVo;
import com.fkiller.web.vo.TeamMemberVo;
import com.fkiller.web.vo.TeamVo;

/**
 * Servlet implementation class JobController
 */
@WebServlet("/JobController.do")
public class JobController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public JobController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		String cmd = request.getParameter("cmd");
		RequestDispatcher rd = null;

		if(cmd.equals("job_list")){
			HttpSession session = request.getSession();

			String teamNo_s = request.getParameter("teamNo");
			TeamService teamService = TeamDAO.getInstance();

			int teamNo = -1;
			if(teamNo_s!=null && !teamNo_s.equals("")){
				teamNo = Integer.parseInt(teamNo_s);

				List<TeamMemberVo> list = teamService.teamMemberList(teamNo); 
				session.setAttribute("member_list", list);

				TeamVo team = teamService.oneTeam(teamNo, ((UserEntity)session.getAttribute("user")).getUserNo());
				session.setAttribute("team", team);
			}else{
				teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();
			}


			JobService service = JobDAO.getInstance();

			List<JobVo> list = service.teamJobList(teamNo);
			/*
			for(JobVo vo : list)
				System.out.println(vo);
			 */

			//알람으로 타고왔는지 검사
			String detailNo_s = request.getParameter("detailNo");
			if(detailNo_s!=null && !detailNo_s.equals("")){
				int alarmNo = Integer.parseInt(request.getParameter("alarmNo"));

				AlarmService alarmService = AlarmDAO.getInstance();
				alarmService.deleteAlarm(AlarmType.JOB, alarmNo);
				UserEntity user = (UserEntity) session.getAttribute("user");
				int userNo = user.getUserNo();
				int pListSize = alarmService.personalAlarmList(userNo).size();
				session.setAttribute("alarm_cnt", pListSize);
				int detailNo = Integer.parseInt(detailNo_s);
				request.setAttribute("detailNo", detailNo);
				String where = request.getParameter("where");
				if(where!=null){
					System.out.println("*************************"+where);
					request.setAttribute("where", where);
				}
				//int userNo = ((UserEntity) session.getAttribute("user")).getUserNo();
				if(!teamService.isLeader(teamNo,userNo)){
					rd = request.getRequestDispatcher("personalJobMain.jsp");
				}else{
					rd = request.getRequestDispatcher("jobManageMain.jsp");
				}

				//알람 삭제 후 개수 하나 감소
//				int alarm_cnt = (Integer)session.getAttribute("alarm_cnt");
//				session.setAttribute("alarm_cnt", alarm_cnt-1);				
				
			}else{
				rd = request.getRequestDispatcher("jobManageMain.jsp");
			}
			//request.setAttribute("where", request.getAttribute("where"));
			request.setAttribute("job_list", list);
		}else if(cmd.equals("one_job")){
			
			int jobNo = Integer.parseInt(request.getParameter("job_no"));
			String auth = request.getParameter("auth");
			System.out.println("!@#!@#!#!@#"+auth);
			String page = request.getParameter("page");
			String where = request.getParameter("where");
			String teamNo = request.getParameter("teamNo");
			JobService service = JobDAO.getInstance();
			JobVo vo = service.oneJob(jobNo);
			System.out.println("VO:"+vo);
			System.out.println("@#@#$@#$"+where);
			request.setAttribute("job", vo);
			request.setAttribute("auth", auth);
			request.setAttribute("page", page);
			request.setAttribute("team_no", teamNo);
			if(where!=null && where.length()>0){
				if(where.equals("fromAlarm")){
					HttpSession session = request.getSession();
					int leaderNo = ((TeamVo)session.getAttribute("team")).getLeaderNo();
					int userNo = ((UserEntity)session.getAttribute("user")).getUserNo();
					System.out.println("!@$@#$      "+leaderNo+" "+userNo);
					if(leaderNo == userNo){
						request.setAttribute("where", "jobManageMain");
						System.out.println("여기로 들어는 오니????");
					}else	
						request.setAttribute("where", "personalJobMain");
				}else
					request.setAttribute("where", where);
			}
			rd = request.getRequestDispatcher("jobDetailView.jsp");

		}else if(cmd.equals("job_manage_list")){
			HttpSession session = request.getSession();
			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();

			TeamService teamService = TeamDAO.getInstance();
			List<TeamMemberVo> memberList = teamService.teamMemberList(teamNo);
			session.setAttribute("member_list",memberList);////////////////////이 코드는 나중에 최종통합할때 지워야함

			JobService service = JobDAO.getInstance();
			List<JobVo> list = service.teamJobList(teamNo);

			request.setAttribute("job_list", list);

			rd = request.getRequestDispatcher("jobManageMain.jsp");
		} else if (cmd.equals("personal_job_list")){
			HttpSession session = request.getSession();
			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();

			TeamService teamService = TeamDAO.getInstance();
			List<TeamMemberVo> memberList = teamService.teamMemberList(teamNo);
			session.setAttribute("member_list",memberList);////////////////////이 코드는 나중에 최종통합할때 지워야함

			JobService service = JobDAO.getInstance();
			List<JobVo> list = service.teamJobList(teamNo);
			
			request.setAttribute("job_list", list);

			rd = request.getRequestDispatcher("personalJobMain.jsp");
		}else if(cmd.equals("personal_job_list2")){
			String userNo = request.getParameter("userNo");
			int user_no = Integer.parseInt(userNo);
			String teamNo = request.getParameter("teamNo");
			int team_no = Integer.parseInt(teamNo);

			JobService service = JobDAO.getInstance();
			List<JobVo> list = service.teamJobList(user_no, team_no);

			JSONArray array = new JSONArray();
			for(JobVo vo : list){
				System.out.println(vo);
				JSONObject json = new JSONObject();
				json.put("jobNo", (Integer)vo.getJobNo());
				json.put("jobTitle", vo.getJobTitle());
				json.put("dueDate", vo.getDueDate().toString());
				json.put("prop", (Integer)vo.getProp());
				json.put("name", vo.getUserName());
				json.put("jobState", vo.getJobState().toString());
				array.add(json);
			}

			PrintWriter out = response.getWriter();
			out.print(array);
			out.flush();
			out.close();
			return;

		}  else if(cmd.equals("searchJob")){
			HttpSession session = request.getSession();
			String searchText = request.getParameter("search_text");
			request.setAttribute("search_text", searchText);
			if(session.getAttribute("team")==null){
				UserService service = UserDAO.getInstance();
				UserEntity user = (UserEntity) session.getAttribute("user");
				List<TeamVo> teamList = service.teamList(user.getUserNo());
				List<TeamVo> searchTeamList = new LinkedList<TeamVo>();
				for(TeamVo vo:teamList){
					if(vo.getTeamName().contains(searchText)){
						searchTeamList.add(vo);
					} 
				}
				request.setAttribute("team_list", searchTeamList);
				rd = request.getRequestDispatcher("teamList.jsp");
			} else{
				String teamNo_s = request.getParameter("teamNo");
				searchText = URLDecoder.decode(searchText, "UTF-8") ;
				int teamNo = -1;
				if(teamNo_s!=null && !teamNo_s.equals("")){
					teamNo = Integer.parseInt(teamNo_s);

					TeamService teamService = TeamDAO.getInstance();
					List<TeamMemberVo> list = teamService.teamMemberList(teamNo); 
					session.setAttribute("member_list", list);

					TeamVo team = teamService.oneTeam(teamNo, ((UserEntity)session.getAttribute("user")).getUserNo());
					session.setAttribute("team", team);
				}else{
					teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();
			}
			
				JobService service = JobDAO.getInstance();
				List<JobVo> list = service.teamJobList(teamNo);
				
				List<JobVo> searchJobList = new LinkedList<JobVo>();
				for(JobVo vo:list){
					if(vo.getJobTitle().contains(searchText)){
						searchJobList.add(vo);
					} else if(vo.getUserName().contains(searchText)){
						searchJobList.add(vo);
					} else if(vo.getJobDesc().contains(searchText)){
						searchJobList.add(vo);
					}
				}

				NoticeService noticeService=NoticeDAO.getInistance();
				List<NoticeEntity> noticeList=noticeService.teamNoticeList(teamNo, 0);
				List<NoticeEntity> searchNoticeList=new LinkedList<NoticeEntity>();
				for(NoticeEntity entity: noticeList){
					if(entity.getNoticeTitle().contains(searchText)){
						searchNoticeList.add(entity);
					} else if(entity.getNoticeDesc().contains(searchText)){
						searchNoticeList.add(entity);
					}
				}
				MeetingService meetingService = MeetingDAO.getInistance();
				List<MeetingVo> meetingList = meetingService.teamMeetingList(teamNo, 1, 0);
				List<MeetingVo> searchMeetingList = new LinkedList<MeetingVo>();
				for(MeetingVo vo: meetingList){
					if(vo.getMeetingTitle().contains(searchText)){
						searchMeetingList.add(vo);
					} 
				}
				request.setAttribute("search_job_list", searchJobList);
				request.setAttribute("search_notice_list", searchNoticeList);
				request.setAttribute("search_meeting_list", searchMeetingList);
				rd = request.getRequestDispatcher("searchPage.jsp");
			}
		}else if(cmd.equals("oneSearch")){
			String page = request.getParameter("page");
			if(page.equals("view")){
				request.setAttribute("where", "view");
			}else if(page.equals("default")){
				request.setAttribute("where", "default");
			}
			request.setAttribute("search_text", request.getParameter("search_text"));
			rd = request.getRequestDispatcher("oneSearch.jsp");

		} else if(cmd.equals("test")){

			int jobNo = Integer.parseInt(request.getParameter("jobNo"));

			JobService service = JobDAO.getInstance();
			JobVo vo = service.oneJob(jobNo);

			request.setAttribute("job", vo);		
			request.setAttribute("where", "personalCalendar");
			rd = request.getRequestDispatcher("jobDetailView.jsp");
		}else if(cmd.equals("addCmt")){
			String userNo = request.getParameter("userNo");
			String jobNo = request.getParameter("jobNo");
			String desc = request.getParameter("desc");
			int user_no = Integer.parseInt(userNo);
			int job_no = Integer.parseInt(jobNo);
			CommentEntity comment = new CommentEntity();
			comment.setJobNo(job_no);
			comment.setUserNo(user_no);
			comment.setCommentDesc(desc);

			JobService service = JobDAO.getInstance();

			boolean res = service.insertComment(comment);
			PrintWriter out = response.getWriter();
			if(res){
				out.write("1");
			}else{
				out.write("2");
			}
			out.flush();
			out.close();
			return;
		}else if(cmd.equals("download")){
			String fileName = request.getParameter("file_name");
			HttpSession session = request.getSession();
			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();
			FileDownloader downloader = new FileDownloader();
			String path = request.getServletContext().getRealPath("/")+File.separator+"download";
			downloader.downloadFile(path, fileName, teamNo);
			downloadFile(response,path,fileName);
			return;
		}

		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("text/html;charset=utf-8");

		String cmd = null;
		RequestDispatcher rd = null;
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		HttpSession session = request.getSession();
		int teamNo = 0;
		if(session.getAttribute("team")!=null)
			teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();
		boolean isModal=false;
		String where = null;
		try{
			List<FileItem> params = upload.parseRequest(request);
			List<FileEntity> fileList = new ArrayList<FileEntity>();
			JobEntity job = new JobEntity();
			int userNo = 0;
			for(Object obj : params){
				FileItem item = (FileItem)obj;

				if(item.isFormField()){
					if(item.getFieldName().equals("cmd"))
						cmd = item.getString("utf-8");
					else if(item.getFieldName().toLowerCase().equals("job_no"))
						job.setJobNo(Integer.parseInt(item.getString("utf-8")));
					else if(item.getFieldName().toLowerCase().equals("job_title"))
						job.setJobTitle(item.getString("utf-8"));
					else if(item.getFieldName().toLowerCase().equals("prop"))
						job.setProp(Integer.parseInt(item.getString("utf-8")));
					else if(item.getFieldName().toLowerCase().equals("due_date"))
						job.setDueDate(Date.valueOf(item.getString("utf-8")));
					else if(item.getFieldName().toLowerCase().equals("job_desc"))
						job.setJobDesc(item.getString("utf-8"));
					else if(item.getFieldName().toLowerCase().equals("user_no"))
						userNo = Integer.parseInt(item.getString("utf-8"));
					else if(item.getFieldName().toLowerCase().equals("job_state")){
						System.out.println("123@!#$!@#"+item.getString("utf-8"));
						job.setState(JobState.valueOf(item.getString("utf-8")));
					}else if(item.getFieldName().toLowerCase().equals("update_files")){
						String files = item.getString("utf-8");
						if(files.equals(""))
							continue;

						String[] updateFiles = files.split("/");

						for(int i=0;i<updateFiles.length;i+=2){
							for(FileEntity file : fileList){
								if(file.getFileName().equals(updateFiles[i+1]))
									file.setFileNo(Integer.parseInt(updateFiles[i]));
							}
						}
					}else if(item.getFieldName().toLowerCase().equals("is_modal"))
						isModal = Boolean.parseBoolean(item.getString("utf-8"));		
					else if(item.getFieldName().toLowerCase().equals("where"))
						where = item.getString("utf-8");
					else if(item.getFieldName().toLowerCase().equals("team_no"))	
						teamNo = Integer.parseInt(item.getString("utf-8"));
				}else{
					if(item.getName()==null || item.getName().equals(""))
						continue;

					FileEntity file = new FileEntity(item.getName(), item.getSize()+"", item.getName().substring(item.getName().lastIndexOf("."), item.getName().length()));
					fileList.add(file);

					File dir = new File(request.getServletContext().getRealPath("/")+File.separator+"upload");

					if(!dir.exists())
						dir.mkdir();

					try{

						File _file = new File(dir,item.getName());

						item.write(_file);

						FileUploader uploader = new FileUploader();
						uploader.uploadFile(_file, teamNo);

					}catch(Exception e){
						e.printStackTrace();
					}
				}
			}

			if(cmd.equals("add_job")){
				JobService service = JobDAO.getInstance();
				int workInNo = service.getWorkInNo(userNo, teamNo);
				job.setWorkInNo(workInNo);
				job.setState(JobState.TO_DO);
				int jobNo = service.insertJob(job, fileList);
				//알람 추가
				if(jobNo>0){
					AlarmService alarmService = AlarmDAO.getInstance();
					AlarmEntity alarm = new AlarmEntity(jobNo, userNo);
					alarmService.insertAlarm(AlarmType.valueOf("JOB"), alarm);
				}
				response.sendRedirect(request.getContextPath()+"/JobController.do?cmd=job_manage_list");
				return;
			}else if(cmd.equals("modifyJob")){
				JobService service = JobDAO.getInstance();
				int workInNo = service.getWorkInNo(userNo, teamNo);
				job.setWorkInNo(workInNo);
				System.out.println("jobController : "+job);
				boolean res = service.updateJob(job);
				for(FileEntity file : fileList)
					file.setJobNo(job.getJobNo());
				boolean res2 = service.updateFile(fileList);
				if(res && res2){
					//jobState를 permission으로 수정했을 때 팀장에게 알람 보내기
					if(job.getState()==JobState.PERMISSION){
						System.out.println("업무 결재 해달라구요!!");
						TeamVo team = (TeamVo)session.getAttribute("team");
						int leaderNo = team.getLeaderNo();

						AlarmService alarmService = AlarmDAO.getInstance();
						AlarmEntity alarm = new AlarmEntity(job.getJobNo(), leaderNo); 
						alarmService.insertAlarm(AlarmType.JOB, alarm);
					}else{
						AlarmService alarmService = AlarmDAO.getInstance();
						AlarmEntity alarm = new AlarmEntity(job.getJobNo(), userNo);
						alarmService.insertAlarm(AlarmType.JOB, alarm);
					}
				}
				//request.setAttribute("isModal", isModal);
				System.out.println("where = "+where);
				response.sendRedirect(request.getContextPath()+"/detour.jsp?is_modal="+isModal+"&where="+where);
				return;
			}else if(cmd.equals("deleteJob")){
				JobService service = JobDAO.getInstance();
				boolean res = service.deleteJob(job.getJobNo());
				if(res){
					StringBuffer fileNames = new StringBuffer(teamNo+"/");
					for(FileEntity file:fileList){
						fileNames.append(file.getFileName()+"/");
					}
					fileNames.deleteCharAt(fileNames.length()-1);

					FileDeleter deleter = new FileDeleter();
					deleter.deleteFile(fileNames.toString());
				}
				//request.setAttribute("isModal", isModal);
				//response.sendRedirect(request.getContextPath()+"/JobController.do?cmd=job_manage_list");
				response.sendRedirect(request.getContextPath()+"/detour.jsp?is_modal="+isModal+"&where="+where);
				return;
			}

		}catch(Exception e){
			e.printStackTrace();
		}	
		//rd.forward(request, response);

	}
	
	private boolean downloadFile(HttpServletResponse response,String path,String fileName){
		FileInputStream in = null;
		ServletOutputStream out = null;
		
		try{
			File file = new File(path,fileName);
			String filename = fileName.substring(0, fileName.lastIndexOf("."));
			String ext = fileName.substring(fileName.lastIndexOf(".")+1,fileName.length());
			filename = java.net.URLEncoder.encode(filename, "UTF-8");
			filename = filename.replace('+', ' ');
			response.setContentType("application/octet-stream");//다운로드 마임타
			response.setHeader("Content-Disposition","attachment; filename="+filename+"."+ext);//파일네임을 헤더에 줘서 다운을 받을 수 있도록 함

			byte[] buffer = new byte[256];
			in = new FileInputStream(file.getAbsolutePath());
			out = response.getOutputStream();
			int numRead;

			while((numRead = in.read(buffer, 0, buffer.length)) != -1)
				out.write(buffer, 0, numRead);

			out.flush();
			return true;
		}catch(IOException e){
			e.printStackTrace();
			return false;
		}finally{
			try{
				//	out.close();
				in.close();
			}catch(Exception e){
				e.printStackTrace();
			}

		}

	}
}


