package com.fkiller.web.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Random;
import java.util.StringTokenizer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.fkiller.web.contants.AlarmType;
import com.fkiller.web.contants.Colors;
import com.fkiller.web.contants.JobState;
import com.fkiller.web.contants.ReportCycle;
import com.fkiller.web.dao.AlarmDAO;
import com.fkiller.web.dao.JobDAO;
import com.fkiller.web.dao.MeetingDAO;
import com.fkiller.web.dao.NoticeDAO;
import com.fkiller.web.dao.TeamDAO;
import com.fkiller.web.dao.TimetableDAO;
import com.fkiller.web.dao.UserDAO;
import com.fkiller.web.entity.AlarmEntity;
import com.fkiller.web.entity.NoticeEntity;
import com.fkiller.web.entity.ProfessorEntity;
import com.fkiller.web.entity.TeamEntity;
import com.fkiller.web.entity.TimetableEntity;
import com.fkiller.web.entity.UserEntity;
import com.fkiller.web.entity.WorkInEntity;
import com.fkiller.web.service.AlarmService;
import com.fkiller.web.service.JobService;
import com.fkiller.web.service.MeetingService;
import com.fkiller.web.service.NoticeService;
import com.fkiller.web.service.TeamService;
import com.fkiller.web.service.TimeTableService;
import com.fkiller.web.service.UserService;
import com.fkiller.web.util.EmailUtil;
import com.fkiller.web.vo.AlarmVo;
import com.fkiller.web.vo.JobVo;
import com.fkiller.web.vo.MeetingReportVo;
import com.fkiller.web.vo.MeetingVo;
import com.fkiller.web.vo.ReportVo;
import com.fkiller.web.vo.TeamJobListVo;
import com.fkiller.web.vo.TeamMemberVo;
import com.fkiller.web.vo.TeamVo;

/**
 * Servlet implementation class TeamController
 */
@WebServlet("/TeamController.do")
public class TeamController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		RequestDispatcher rd = null;
		
		String cmd = request.getParameter("cmd");
		
		if(cmd.equals("teamNo")){
			TeamService service = TeamDAO.getInstance();
			int newTeamNo = service.getMaxTeamNo();
			PrintWriter out = response.getWriter();
			out.write(newTeamNo+1+"");
			out.flush();
			out.close();
			return;
		}else if(cmd.equals("completeCreateTeam")){
			request.setAttribute("cmd", "teamList");
			HttpSession session = request.getSession();
			UserService userService = UserDAO.getInstance();
			UserEntity user = (UserEntity)session.getAttribute("user");
			
			
			List<TeamVo> teamList = userService.teamList(user.getUserNo());				
			request.setAttribute("team_list", teamList);
				
			rd = request.getRequestDispatcher("/teamList.jsp");
			
				
		} /*else if(cmd.equals("inviteYes")){
			
			System.out.println("두겟 둘어왓당");
			request.setAttribute("cmd", "cancel");
			doPost(request, response);
		}*/
		
		
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		
		String cmd = request.getParameter("cmd");
		
		RequestDispatcher rd = null;
		
		if(cmd.equals("team_calendar")){
			/*rd = request.getRequestDispatcher("/personalCalendar.jsp");*/
			
			JobService jobService = JobDAO.getInstance();
			MeetingService meetingService = MeetingDAO.getInistance();			
			HttpSession session = request.getSession();
			
			
			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();
			
			List<TeamJobListVo> list = jobService.teamJobCalendar(teamNo);
			List<MeetingVo> meetList = meetingService.teamMeetingList(teamNo, -1, 0);
			
			request.setAttribute("job_list", list);
			request.setAttribute("meeting_list", meetList);
			
			
			rd = request.getRequestDispatcher("/teamCalendar.jsp");
			
		} else if(cmd.equals("sendReport")){
			HttpSession session = request.getSession();
			TeamService teamService = TeamDAO.getInstance();

			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();
			ProfessorEntity professor = teamService.getProfessorInfo(teamNo);
			
			new EmailUtil().sendReport((String)request.getParameter("teamName"),professor.getEmail());
			return;
		} else if (cmd.equals("progress_list")){
			HttpSession session =request.getSession();
			DateFormat df = new SimpleDateFormat("yyyy년 MM월 dd일");
			String startDate = df.format(((TeamVo)session.getAttribute("team")).getStartDate());
			String endDate = df.format(((TeamVo)session.getAttribute("team")).getEndDate());
			String leader = ((TeamVo)session.getAttribute("team")).getLeaderName();
			request.setAttribute("startDate", startDate);
			request.setAttribute("endDate", endDate);
			request.setAttribute("leader", leader);
			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();
			JobService jobService = JobDAO.getInstance();
			TeamService teamService = TeamDAO.getInstance();
			
			List<TeamMemberVo> memberList = (List<TeamMemberVo>)session.getAttribute("member_list");
			List<ReportVo> reportList = new LinkedList<ReportVo>();
			List<MeetingReportVo> meetingList = teamService.getMeetingReport(teamNo);
			int index=0;
			
			for(TeamMemberVo member: memberList){
				ReportVo reportVo = new ReportVo();
				int[] jobStates = new int[5];
				int jobs = 0,completion=0,closed=0;
				List<JobVo> jobList = jobService.teamJobList(member.getUserNo(),teamNo);
				for(JobVo job : jobList){
					if(job.getJobState()==JobState.TO_DO){
						jobStates[0]++;
					} else if(job.getJobState()==JobState.IN_PROGRESS){
						jobStates[1]++;
					} else if(job.getJobState()==JobState.PERMISSION){
						jobStates[2]++;
					} else if(job.getJobState()==JobState.DONE){
						jobStates[3]++;
					} else if(job.getJobState()==JobState.EXPIRED){
						jobStates[4]++;
					}
					Date dueDate = job.getDueDate();
					Date now = new Date(System.currentTimeMillis());
		
					if(dueDate.getTime() <= now.getTime()){
							closed++;
						if(job.getJobState()==JobState.DONE){
							completion++;
						}
					}
					jobs++;
					
				}
				reportVo.setUserName(member.getName());
				reportVo.setJobState(jobStates);
				reportVo.setJobs(jobs);
				if(meetingList.size()>index){
					reportVo.setTotalMeeting(meetingList.get(index).getTotalMeeting());
					reportVo.setPartInMeeting(meetingList.get(index).getPartInMeeting());
				}else{
					reportVo.setTotalMeeting(0);
					reportVo.setPartInMeeting(0);
				}
				++index;
				
				reportVo.setClosed(closed);
				reportVo.setCompletion(completion);
				if(member.getName().equals(leader))
					reportList.add(0, reportVo);
				else
					reportList.add(reportVo);
			}
			
			session.setAttribute("member_list", memberList);
			session.setAttribute("report_list", reportList);
			request.setAttribute("memberNumber", memberList.size());
			List<JobVo> totalJobList = jobService.teamJobList(teamNo);
			request.setAttribute("jobNumber", totalJobList.size());
						
			int toDo=0, inProgress=0, permission=0, done=0, expired=0;
			for(JobVo job : totalJobList){
				if(job.getJobState()==JobState.TO_DO){
					toDo++;
				} else if(job.getJobState()==JobState.IN_PROGRESS){
					inProgress++;
				} else if(job.getJobState()==JobState.PERMISSION){
					permission++;
				} else if(job.getJobState()==JobState.DONE){
					done++;
				} else if(job.getJobState()==JobState.EXPIRED){
					expired++;
				}
			}
			request.setAttribute("toDo", toDo);
			request.setAttribute("inProgress", inProgress);
			request.setAttribute("permission", permission);
			request.setAttribute("done", done);
			request.setAttribute("expired", expired);
			
			rd = request.getRequestDispatcher("/report.jsp");
		} else if(cmd.equals("createTeam")){
						
			String teamName = request.getParameter("teamName");
			String teamTopic = request.getParameter("teamTopic");
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			String profEmail = request.getParameter("email_id") + "@" + request.getParameter("email_address");
			String report = request.getParameter("report");
			String cycle=ReportCycle.ONE_WEEK.toString();
			if(report.equals("true"))
				cycle = request.getParameter("cycle");
			
			if(request.getParameter("email_id") == null)
				profEmail = null;
						
			HttpSession session = request.getSession();
			int userNo = ((UserEntity)session.getAttribute("user")).getUserNo();
			
			TeamService service = TeamDAO.getInstance();
			TeamEntity team = new TeamEntity(teamName, teamTopic, Date.valueOf(startDate), Date.valueOf(endDate),true,userNo);
			ProfessorEntity professor = new ProfessorEntity(profEmail, ReportCycle.valueOf(cycle), Boolean.parseBoolean(report));
			
			Colors[] colors = Colors.values();
			Random random = new Random();
		    Colors memberColor = colors[random.nextInt(colors.length-1)];
		    Colors teamColor = colors[random.nextInt(colors.length-1)];
			
			
			WorkInEntity work = new WorkInEntity(userNo, 2, memberColor, teamColor, false, 0,false);
			int res = service.createTeam(team, professor, work);
			
			
			PrintWriter out = response.getWriter();
			
			if(res != -1){
				out.write(res+"");				
			}else {
				out.write("-1");			
			}
			out.flush();
			out.close();
			return;
		}  else if(cmd.equals("selectTeam")){
			
			int teamNo;
			String where = request.getParameter("where");
			if(where!=null){
				if(where.equals("detour")){
					teamNo = Integer.parseInt(request.getParameter("teamNo"));
				}else{
					teamNo = Integer.parseInt(request.getParameter("selectedTeamNo"));	
				}
			}else
				teamNo = Integer.parseInt(request.getParameter("selectedTeamNo"));
			
			System.out.println("팀번호 : " +teamNo);
			//팀멤버리스트, 팀 엔티티
			TeamService teamService = TeamDAO.getInstance();
			JobService jobService = JobDAO.getInstance();
			HttpSession session = request.getSession();
			
			List<TeamMemberVo> list = teamService.teamMemberList(teamNo); 
			session.setAttribute("member_list", list);
			
			int userNo = ((UserEntity)session.getAttribute("user")).getUserNo();
			TeamVo team = teamService.oneTeam(teamNo,userNo);
			
			session.setAttribute("team", team);
			
			if(teamService.isLeader(teamNo, userNo)){
				session.setAttribute("auth", true);
			}
			
			List<JobVo> jobList = jobService.teamJobList(teamNo);
			request.setAttribute("job_list", jobList);
			
			
			/*List<TeamVo> list = (List<TeamVo>)request.getAttribute("team_list");
			for(TeamVo vo : list)
				System.out.println(vo);
			
			if(list.size() == 0)
				System.out.println("팀 없다.");*/
			
			NoticeService noticeService=NoticeDAO.getInistance();
			List<NoticeEntity> noticeList=noticeService.teamNoticeList(teamNo, 5);//최근 소식 5개만 가져옴
			request.setAttribute("notice_list", noticeList);			
			
			//나중에 회의 리스트도 가져와야함!!!!!!!!!!!!!!!
			MeetingService meetingService=MeetingDAO.getInistance();
			List<MeetingVo> meetingList=meetingService.teamMeetingList(teamNo, -1, 5);
			request.setAttribute("meeting_list", meetingList);
			
			rd = request.getRequestDispatcher("/mainOfMain.jsp");			
			
		} else if(cmd.equals("goCreateTeam")){
			
			rd = request.getRequestDispatcher("/createTeam.jsp");
		
		} else if(cmd.equals("deleteTeam")){
			
			
			int teamNo = Integer.parseInt(request.getParameter("teamNo"));
			
			TeamService teamService = TeamDAO.getInstance();
			UserService userService = UserDAO.getInstance();			
			HttpSession session = request.getSession();
			UserEntity user = (UserEntity)session.getAttribute("user");
			PrintWriter out = response.getWriter();
			
			boolean result = userService.secessionTeam(user.getUserNo(), teamNo);
			
			if(result){
				
				List<TeamVo> teamList = userService.teamList(user.getUserNo());				
				request.setAttribute("team_list", teamList);
				
				rd = request.getRequestDispatcher("/teamList.jsp");
			} else{
				out.write("<script>alert('팀 삭제를 실패하였습니다!');</script>");
				return;
			}
		} else if( cmd.equals("go_update_team" )){
			
			HttpSession session = request.getSession();
			TeamService teamService = TeamDAO.getInstance();
			
			
			UserEntity user = (UserEntity)session.getAttribute("user");
			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();
			
			ProfessorEntity professor = teamService.getProfessorInfo(teamNo);
			
			request.setAttribute("professor", professor);
			
			rd = request.getRequestDispatcher("/updateTeam.jsp");
			
		} else if( cmd.equals("updateTeam")){
			
			HttpSession session = request.getSession();
			TeamService teamService = TeamDAO.getInstance();
			UserService userService = UserDAO.getInstance();
			PrintWriter out = response.getWriter();
			
			UserEntity user = (UserEntity)session.getAttribute("user");
			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();
		
			
			String teamName = request.getParameter("teamName");
			String teamTopic = request.getParameter("teamTopic");
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			String profEmail = request.getParameter("email_id") + "@" + request.getParameter("email_address");
			String report = request.getParameter("report");
		
			int profNo = Integer.parseInt(request.getParameter("profNo"));		
			int leaderNo = Integer.parseInt(request.getParameter("leaderNo"));
			
			String deletes[] = request.getParameterValues("deleteUser");
			String deleteUsers[] = new String[deletes[0].split(",").length];
			deleteUsers = deletes[0].split(",");
			boolean auto=true;
			if(report.equals("true")){
				auto = true;
			} else {
				auto = false;
			}
					
			ReportCycle cycle=null;
			
			if(auto == true){
				
				String temp = request.getParameter("cycle");
				
				if(temp.equals("1week"))
					cycle = ReportCycle.ONE_WEEK;
				else if(temp.equals("2week"))
					cycle = ReportCycle.TWO_WEEK;
				else
					cycle = ReportCycle.ONE_MONTH;
				
			} else
				cycle = null;
			TeamEntity team = new TeamEntity(teamName, teamTopic, Date.valueOf(startDate),
									Date.valueOf(endDate),leaderNo,teamNo);			
			ProfessorEntity professor = new ProfessorEntity(profEmail, cycle, auto, profNo);
			
			
			
			boolean deleteResult = false;
				for(String no : deleteUsers){
					if(no.equals(""))
						continue;
					System.out.println("삭제할 팀원 "+no);
					deleteResult= userService.secessionTeam(Integer.parseInt(no), teamNo);
					
					if(!deleteResult){
						out.write("<script>alert('팀원 탈퇴를 실패하였습니다!');</script>");
						return;
					}
				}	
			
				boolean result = teamService.updateTeam(team, professor, null);
				
				if(result){
					session.setAttribute("team", teamService.oneTeam(teamNo, ((UserEntity)session.getAttribute("user")).getUserNo()));
					rd = request.getRequestDispatcher("/TeamController.do?cmd=selectTeam&selectedTeamNo="+teamNo);			
				} else{
					request.setAttribute("professor", professor);
					rd = request.getRequestDispatcher("/updateTeam.jsp");
				}			

		} else if(cmd.equals("inviteMember")){
			
			AlarmService service = AlarmDAO.getInstance();
			String userNo = request.getParameter("userNo");
			String teamNo = request.getParameter("teamNo");
			
			int user_no = Integer.parseInt(userNo);
			int team_no = Integer.parseInt(teamNo);
			AlarmEntity entity = new AlarmEntity(team_no,user_no);
			boolean res = service.insertAlarm(AlarmType.INVITE, entity);
			PrintWriter out = response.getWriter();
			if(res){
				out.write("1");
			} else {
				out.write("2");
			}
			out.flush();
			out.close();
			return;			
		} else if(cmd.equals("goHome")){
			
			HttpSession session = request.getSession();
			
			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();
			
			//업무, 공지, 회의 리스트 가져오기
			JobService jobService = JobDAO.getInstance();
			List<JobVo> jobList = jobService.teamJobList(teamNo);
			request.setAttribute("job_list", jobList);
			
			NoticeService noticeService=NoticeDAO.getInistance();
			List<NoticeEntity> noticeList=noticeService.teamNoticeList(teamNo, 5);//최근 소식 5개만 가져옴
			request.setAttribute("notice_list", noticeList);
			
			//나중에 회의 리스트도 가져와야함!!!!!!!!!!!!!!!
			MeetingService meetingService=MeetingDAO.getInistance();
			List<MeetingVo> meetingList=meetingService.teamMeetingList(teamNo, -1, 5);
			request.setAttribute("meeting_list", meetingList);
			
			rd = request.getRequestDispatcher("/mainOfMain.jsp");
			
		} else if( cmd.equals("teamListNews")) {
			
			HttpSession session = request.getSession();
			int teamNo = Integer.parseInt(request.getParameter("teamNo"));
			
			UserEntity user = (UserEntity)session.getAttribute("user");			
						
			AlarmService service = AlarmDAO.getInstance();
			List<AlarmVo> alarmList = service.teamAlarmList(user.getUserNo(), teamNo);
						
			if(alarmList!=null && alarmList.size() > 0){
				JSONArray array = new JSONArray();
		        
		         int i=0;
		        for(AlarmVo alarm : alarmList){
		        	System.out.println(alarm);
		        	JSONObject json = new JSONObject();
		        	
		        	if(i == 4) break;
		        	
		            json.put("alarmNo", (Integer)alarm.getAlarmNo());
		            json.put("alarmType", (alarm.getAlarmType()).toString());
		            json.put("title", alarm.getMessage());
		            json.put("num", (Integer)alarm.getDetailNo());
		            
		            array.add(json);
		            i++;
		        }
		        
		        System.out.println(array);		        
		        
		        PrintWriter out = response.getWriter();
		        out.print(array);
		        out.flush();
		        out.close();
		        
			}
			
			return;
			
		} else if (cmd.equals("sendEmail")){
			
			String email = request.getParameter("email");
			String teamName = request.getParameter("teamName");
			HttpSession session = request.getSession();
			String userName = ((UserEntity)session.getAttribute("user")).getUserName();
			System.out.println("ajax!!!!!!!!!!1");
			System.out.println(email);
			System.out.println(teamName);
			EmailUtil mail = new EmailUtil();
			mail.inviteMember(email, userName, teamName);
			
			PrintWriter out = response.getWriter();
			out.write("1");
			out.flush();
			out.close();
			return;
			
		} else if(cmd.equals("cancel")){
			
			HttpSession session = request.getSession();
						
			UserService userService = UserDAO.getInstance();
			
			UserEntity user = (UserEntity) session.getAttribute("user");
			List<TeamVo> teamList = userService.teamList(user.getUserNo());
			
			request.setAttribute("team_list", teamList);
			
			rd = request.getRequestDispatcher("/teamList.jsp");		
			
		} else if(cmd.equals("cancel_main")) {
			
			
			
			
			
			
			
		} else if(cmd.equals("recommend_time_table")){
			TimeTableService timeTableService = TimetableDAO.getInstance();
			
			String participants_s = request.getParameter("participants");
			
			List<Integer> participants = new ArrayList<Integer>();
			if(participants_s!=null){
				StringTokenizer st = new StringTokenizer(participants_s, ",");
				
				while(st.hasMoreTokens()){
					participants.add(Integer.parseInt(st.nextToken()));
				}
			}
			TimetableEntity timeTable = timeTableService.recommendTimetable(participants);
			JSONArray array = null;
			
			if(timeTable != null){
				array = new JSONArray();
				
				JSONObject sun= new JSONObject();
				sun.put("data", timeTable.getSun());
				array.add(sun);
						
				JSONObject mon = new JSONObject();			
				mon.put("data", timeTable.getMon());
				array.add(mon);
				
				JSONObject tue = new JSONObject();
				tue.put("data", timeTable.getTue());
				array.add(tue);
				
				JSONObject wen = new JSONObject();
				wen.put("data", timeTable.getWed());
				array.add(wen);
				
				JSONObject thu = new JSONObject();
				thu.put("data", timeTable.getThu());
				array.add(thu);
				
				JSONObject fri = new JSONObject();
				fri.put("data", timeTable.getFri());
				array.add(fri);
				
				JSONObject sat = new JSONObject();
				sat.put("data", timeTable.getSat());
				array.add(sat);
					
			}
			PrintWriter out = response.getWriter();
			
			out.print(array);
			out.flush();
			out.close();				
			return;
		}
		rd.forward(request, response);
	}	
}
