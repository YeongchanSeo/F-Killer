package com.fkiller.web.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.fkiller.web.contants.AlarmType;
import com.fkiller.web.contants.Colors;
import com.fkiller.web.dao.AlarmDAO;
import com.fkiller.web.dao.JobDAO;
import com.fkiller.web.dao.MeetingDAO;
import com.fkiller.web.dao.NoticeDAO;
import com.fkiller.web.dao.TeamDAO;
import com.fkiller.web.dao.TimetableDAO;
import com.fkiller.web.dao.UserDAO;
import com.fkiller.web.entity.NoticeEntity;
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
import com.fkiller.web.vo.AlarmVo;
import com.fkiller.web.vo.JobVo;
import com.fkiller.web.vo.MeetingVo;
import com.fkiller.web.vo.TeamMemberVo;
import com.fkiller.web.vo.TeamVo;

/**
 * Servlet implementation class UserController
 */
@WebServlet("/UserController.do")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * 
     * @see HttpServlet#HttpServlet()
     */
    public UserController() {
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
		HttpSession session = null;
		
		if(cmd.equals("p_calendar")){			
			
			UserService service = UserDAO.getInstance();
			JobService jobService = JobDAO.getInstance();
			session = request.getSession();
			
			int userNo = ((UserEntity)session.getAttribute("user")).getUserNo();			
			
			List<JobVo> list = service.personalJobList(userNo);						

			for(JobVo job : list){
				System.out.println(job);
			}
			
			request.setAttribute("job_list", list);
						
			rd = request.getRequestDispatcher("/personalCalendar.jsp");
			
		}else if(cmd.equals("job_detail")){
			
			rd = request.getRequestDispatcher("");
			int jobNo = Integer.parseInt(request.getParameter("job_no"));
			JobService service = JobDAO.getInstance();
			
			JobVo job = service.oneJob(jobNo);
	
			request.setAttribute("job", job);
			
			PrintWriter out = response.getWriter();
			out.print("이지은 개멍청");
			out.flush();
			out.close();
			
			return;
		}else if(cmd.equals("loginOK")){
			UserService service = UserDAO.getInstance();
			session = request.getSession();
			session.setAttribute("team", null);
			UserEntity user = (UserEntity) session.getAttribute("user");
			
			session.removeAttribute("auth");
			List<TeamVo> teamList = service.teamList(user.getUserNo());
			
			request.setAttribute("team_list", teamList);
			
			rd = request.getRequestDispatcher("/teamList.jsp");
		}else if(cmd.equals("loginNG")){
			rd = request.getRequestDispatcher("/login.jsp");
		}else if(cmd.equals("checkUser")){
			String id = request.getParameter("id");
			String email = request.getParameter("email");
			
			UserService service = UserDAO.getInstance();
			UserEntity entity = service.oneUser(id+"@"+email);
			PrintWriter out = response.getWriter();
			if(entity!=null){			
				out.write(entity.getUserNo()+"");
			}else {				
				out.write("-1");
			}
			out.flush();
			out.close();
			return;
		}else if(cmd.equals("update_userInfo")){
			UserService user_service = UserDAO.getInstance();
			TimeTableService timeTable_serService = TimetableDAO.getInstance();
			session = request.getSession();	
			
			UserEntity user = (UserEntity) session.getAttribute("user");
			TimetableEntity entity = timeTable_serService.oneTimetable(user.getUserNo());
			request.setAttribute("timeTable", entity);
			rd = request.getRequestDispatcher("/updateUserInfo.jsp");
			
		}  else if(cmd.equals("logout")){
						
			session = request.getSession();
			
			
			Cookie cookies[] = request.getCookies();
			for(Cookie cookie : cookies){
				cookie.setMaxAge(-1);
				cookie = null;
			}
			session.invalidate();
			
			rd = request.getRequestDispatcher("/login.jsp");
		}	
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String cmd = request.getParameter("cmd");
		RequestDispatcher rd = null;
		HttpSession session = null;
		UserService service = UserDAO.getInstance();
		
		PrintWriter out = response.getWriter();
		
		if(cmd.equals("join")){
			
			System.out.println("조인 컨트롤러 진입");
			String name  = request.getParameter("name");
			String email = request.getParameter("email_id")+"@"+request.getParameter("email_address");
			String pwd 	 = request.getParameter("password");
			
			boolean result = service.insertUser(new UserEntity(name,email,pwd,"fkiller"));
			
			if(!result){
				
				out.write("<script>alert('Login Fail!!!'); location.href='"+request.getContextPath()+"/login.jsp';</script>");
				out.flush();
				out.close();
				return;
			}
			
			System.out.println("유저 저장 다녀왔음");
			
			if(request.getParameter("isTimeTable").equals("true")){
				String sun = request.getParameter("sun");
				String mon = request.getParameter("mon");
				String tue = request.getParameter("tue");
				String wen = request.getParameter("wen");
				String thu = request.getParameter("thu");
				String fri = request.getParameter("fri");
				String sat = request.getParameter("sat");
				UserEntity user = service.oneUser(email);			
				TimeTableService timeTableService = TimetableDAO.getInstance();
				TimetableEntity timeTable = new TimetableEntity(user.getUserNo(), mon,tue,wen,thu,fri,sat,sun); 
				timeTableService.insertTimetable(timeTable);
			}
			
			rd = request.getRequestDispatcher("/login.jsp");
			
		} else if(cmd.equals("login")){
			String email = request.getParameter("email");
			String pwd 	 = request.getParameter("password");
			
			if(email.equals("admin") && pwd.equals("admin")){
				//rd = request.getRequestDispatcher("/ManageController.do");
				response.sendRedirect(request.getContextPath()+"/ManageController.do");
				return;
			} else{
				boolean result = service.login(email, pwd);
				
				if(result){
					session = request.getSession();
					UserEntity user = service.oneUser(email);
					session.setAttribute("user", user);
					session.setMaxInactiveInterval(60*60);
					
					AlarmService alarmService = AlarmDAO.getInstance();
					List<AlarmVo> pList = alarmService.personalAlarmList(user.getUserNo());
					if(pList==null)
						session.setAttribute("alarm_cnt", 0);
					else
						session.setAttribute("alarm_cnt", pList.size());
					
					List<TeamVo> teamList = service.teamList(user.getUserNo());
					
					request.setAttribute("team_list", teamList);
					
					rd = request.getRequestDispatcher("/teamList.jsp");
					
					
				} else {
										
					
					Cookie[] cookies = request.getCookies() ;
				     
				    if(cookies != null){
				        for(int i=0; i < cookies.length; i++){
				             
				            // 쿠키의 유효시간을 0으로 설정하여 만료시킨다
				            cookies[i].setMaxAge(0) ;
				             
				            // 응답 헤더에 추가한다
				            response.addCookie(cookies[i]) ;
				        }
				    }
										
					out.write("<script>alert('Login Fail!!!'); location.href='"+request.getContextPath()+"/login.jsp';</script>");
					out.flush();
					out.close();
	
				}
			}
		} else if(cmd.equals("facebookLogin")){
			String email = request.getParameter("Femail");
			String name = request.getParameter("Fname");
			String noFace = request.getParameter("noFace");
			UserEntity result = service.oneUser(email);
			
			System.out.println("이메일과 이름="+email+"/"+name+"/"+noFace);
			
			if(noFace.equals("") || noFace == null || noFace.equals("null")){
				out.write("<script>location.href='"+request.getContextPath()+"/login.jsp';</script>");
				out.flush();
				out.close();
				
				return;
			}
			
			
			if(result==null){
				String time = "111111111111111111111111";
				boolean r = service.insertUser(new UserEntity(name,email,"0000","facebook"));
				UserEntity user = service.oneUser(email);			
				TimeTableService timeTableService = TimetableDAO.getInstance();
				TimetableEntity timeTable = new TimetableEntity(user.getUserNo(), time,time,time,time,time,time,time); 
				timeTableService.insertTimetable(timeTable);
				if(!r){
					out.write("<script>alert('Facebook Login Fail!!!'); location.href='"+request.getContextPath()+"/login.jsp';</script>");
					out.flush();
					out.close();
					
					return;
				}				
			}
				
				session = request.getSession();
				UserEntity user = service.oneUser(email);
				session.setAttribute("user", user);
				session.setMaxInactiveInterval(60*60);
				
				AlarmService alarmService = AlarmDAO.getInstance();
				List<AlarmVo> pList = alarmService.personalAlarmList(user.getUserNo());
				
				session.setAttribute("alarm_cnt", pList.size());
				List<TeamVo> teamList = service.teamList(user.getUserNo());
				
				request.setAttribute("team_list", teamList);
				
				rd = request.getRequestDispatcher("/teamList.jsp");
				

		} else if(cmd.equals("oneTimeTable")){
			
			TimeTableService timeTable_serService = TimetableDAO.getInstance();
			String userNo = request.getParameter("userNo");
			int user_no = Integer.parseInt(userNo);
			TimetableEntity entity = timeTable_serService.oneTimetable(user_no);
			JSONArray array = null;
			
			if(entity != null){
				array = new JSONArray();
				
				JSONObject sun= new JSONObject();
				sun.put("data", entity.getSun());
				array.add(sun);
						
				JSONObject mon = new JSONObject();			
				mon.put("data", entity.getMon());
				array.add(mon);
				
				JSONObject tue = new JSONObject();
				tue.put("data", entity.getTue());
				array.add(tue);
				
				JSONObject wen = new JSONObject();
				wen.put("data", entity.getWed());
				array.add(wen);
				
				JSONObject thu = new JSONObject();
				thu.put("data", entity.getThu());
				array.add(thu);
				
				JSONObject fri = new JSONObject();
				fri.put("data", entity.getFri());
				array.add(fri);
				
				JSONObject sat = new JSONObject();
				sat.put("data", entity.getSat());
				array.add(sat);
					
			}
			out = response.getWriter();
			out.print(array);
			out.flush();
			out.close();				
			return;
			
		} else if(cmd.equals("update_user_info")){
			
			String userNo = request.getParameter("userNo");
			int user_no = Integer.parseInt(userNo);
			String email = request.getParameter("email_address");
			String isTimeTable=request.getParameter("isTimeTable");
			String userName = request.getParameter("name");
			String password = request.getParameter("password");
			
			UserService user_service = UserDAO.getInstance();
			UserEntity entity = new UserEntity();
			entity.setUserNo(user_no);
			entity.setUserName(userName);
			entity.setUserPwd(password);
			entity.setUserProfile(null);//profile수정해야함
			
			boolean res = user_service.updateUser(entity);
			
			if(isTimeTable.equals("true")){
				String sun = request.getParameter("sun");
				String mon = request.getParameter("mon");
				String tue = request.getParameter("tue");
				String wen = request.getParameter("wen");
				String thu = request.getParameter("thu");
				String fri = request.getParameter("fri");
				String sat = request.getParameter("sat");
			
				UserEntity user = service.oneUser(email);			
				TimeTableService timeTableService = TimetableDAO.getInstance();
				TimetableEntity timeTable = new TimetableEntity(user_no, mon,tue,wen,thu,fri,sat,sun); 
				timeTableService.updateTimetable(timeTable);
			}
			
			
			//session.setAttribute("team", arg1);
			if(res){
				TeamService teamService = TeamDAO.getInstance();
				JobService jobService = JobDAO.getInstance();
				NoticeService noticeService=NoticeDAO.getInistance();
				MeetingService meetingService=MeetingDAO.getInistance();
				
				session = request.getSession();
				TeamVo team = (TeamVo)session.getAttribute("team");
				int teamNo = team.getTeamNo();
				
				UserEntity user = service.oneUser(email);
				session.setAttribute("user", user);
				session.setMaxInactiveInterval(60*60);			
				
				List<TeamVo> teamList = service.teamList(user.getUserNo());	
				request.setAttribute("team_list", teamList);
				
				List<TeamMemberVo> list = teamService.teamMemberList(teamNo); 
				session.setAttribute("member_list", list);
				
				List<JobVo> jobList = jobService.teamJobList(teamNo);
				request.setAttribute("job_list", jobList);	
				
				List<NoticeEntity> noticeList=noticeService.teamNoticeList(teamNo, 5);//최근 소식 5개만 가져옴
				request.setAttribute("notice_list", noticeList);
				
				//나중에 회의 리스트도 가져와야함!!!!!!!!!!!!!!!
				List<MeetingVo> meetingList=meetingService.teamMeetingList(teamNo, -1, 5);
				request.setAttribute("meeting_list", meetingList);
				
				request.setAttribute("where", "update_user_info");
				
				rd = request.getRequestDispatcher("/mainOfMain.jsp");
			}else{
				rd = request.getRequestDispatcher("/updateUserInfo.jsp");
			}
			
		} else if(cmd.equals("work_in")){
			session = request.getSession();
			int userNo = ((UserEntity)session.getAttribute("user")).getUserNo();
			int teamNo = Integer.parseInt(request.getParameter("teamNo"));
			int alarmNo = Integer.parseInt(request.getParameter("alarmNo"));
			String intention = request.getParameter("intention");
			
			AlarmService alarmService = AlarmDAO.getInstance();
			boolean result = true;
			if(intention.equals("yes")){
				TeamService teamService = TeamDAO.getInstance();
				
				Colors[] colors = Colors.values();
				Random random = new Random();
			    Colors memberColor = colors[random.nextInt(colors.length-1)];
			    Colors teamColor = colors[random.nextInt(colors.length-1)];
			    
				WorkInEntity entity = new WorkInEntity(userNo, teamNo, memberColor, teamColor, false, 0, false);
				result = teamService.insertMemeber(entity);
				
				
			}
			
			if(result){
				boolean alarmResult = alarmService.deleteAlarm(AlarmType.INVITE, alarmNo);
				UserEntity user = (UserEntity) session.getAttribute("user");
				AlarmService alarm_service = AlarmDAO.getInstance();
				userNo = user.getUserNo();
				int pListSize = alarm_service.personalAlarmList(userNo).size();
				session.setAttribute("alarm_cnt", pListSize);
				
				
				if(alarmResult){
					out.write("OK");
				}else{
					out.write("NG");
				}
			}else{
				out.write("NG");
			}
			out.flush();
			out.close();
			return;
			
		} else if(cmd.equals("favorites")){
			
			
			UserService user_service = UserDAO.getInstance();
			session = request.getSession();
			UserEntity user = (UserEntity) session.getAttribute("user");
			out = response.getWriter();
			
			String isFavor_s = request.getParameter("isFavorite");
			
		
			boolean isFavor = Boolean.parseBoolean(isFavor_s);
			
			String teamNo_s = request.getParameter("teamNo");
			int teamNo = Integer.parseInt(teamNo_s);
		
			int result = user_service.changeFavorites(isFavor, teamNo, user.getUserNo());
			
			if(result == 1){
				out.write("true");
			} else if(result == 0){
				out.write("false");
			} else {
				out.write("");
			}
			out.flush();
			out.close();
			return;			
			
		} else if(cmd.equals("update_alarm")){
			session = request.getSession();
			UserEntity user = (UserEntity) session.getAttribute("user");
			AlarmService alarm_service = AlarmDAO.getInstance();
			int userNo = user.getUserNo();
			int pListSize = alarm_service.personalAlarmList(userNo).size();
			System.out.println("알갯수는???"+pListSize);
			session.setAttribute("alarm_cnt", pListSize);
			
			try {
				out = response.getWriter();
				out.print(pListSize);
				out.flush();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				out.close();
			}
			
			
			return;
		}
		rd.forward(request, response);
	}
	
//	private void updateAlarm(HttpServletRequest request, HttpServletResponse response, PrintWriter out){
//		HttpSession session = request.getSession();
//		UserEntity user = (UserEntity) session.getAttribute("user");
//		AlarmService alarm_service = AlarmDAO.getInstance();
//		int userNo = user.getUserNo();
//		int pListSize = alarm_service.personalAlarmList(userNo).size();
//		
//		session.setAttribute("alarm_cnt", pListSize);
//		
//		try {
//			out = response.getWriter();
//			out.print(pListSize);
//			out.flush();
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}finally{
//			out.close();
//		}
//		
//		
//		return;
//	}
	
}
