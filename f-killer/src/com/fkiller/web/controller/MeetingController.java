package com.fkiller.web.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fkiller.web.contants.AlarmType;
import com.fkiller.web.dao.AlarmDAO;
import com.fkiller.web.dao.JobDAO;
import com.fkiller.web.dao.MeetingDAO;
import com.fkiller.web.dao.TeamDAO;
import com.fkiller.web.dao.UserDAO;
import com.fkiller.web.entity.AlarmEntity;
import com.fkiller.web.entity.MeetingEntity;
import com.fkiller.web.entity.PartInEntity;
import com.fkiller.web.entity.UserEntity;
import com.fkiller.web.service.AlarmService;
import com.fkiller.web.service.JobService;
import com.fkiller.web.service.MeetingService;
import com.fkiller.web.service.TeamService;
import com.fkiller.web.service.UserService;
import com.fkiller.web.vo.MeetingVo;
import com.fkiller.web.vo.TeamJobListVo;
import com.fkiller.web.vo.TeamMemberVo;
import com.fkiller.web.vo.TeamVo;

/**
 * Servlet implementation class MeetingController
 */
@WebServlet("/MeetingController.do")
public class MeetingController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MeetingController() {
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
		HttpSession session = request.getSession();
		System.out.println("!@#$!@#$"+cmd);
		if(cmd==null || cmd.equals("meeting_list") || cmd.equals("") ){
			rd = meetingList(request, response);
			
		}else if(cmd.equals("one_meeting")){
			
			
			MeetingService service = MeetingDAO.getInistance();
			
			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo(); 
			int meetingNo = Integer.parseInt(request.getParameter("meeting_no"));
			
			MeetingVo vo = service.oneMeeting(meetingNo, teamNo);
			
			String type=request.getParameter("type");
			
			if(type!=null && type.equals("meeting_log")){
				rd = request.getRequestDispatcher("meetingLogDetail.jsp");
			}else{
				rd = request.getRequestDispatcher("meetingDetail.jsp");
			}
			request.setAttribute("meeting", vo);
			
		}else if(cmd.equals("add_meeting")){
			
			TeamService service = TeamDAO.getInstance();
			TeamVo team = (TeamVo)session.getAttribute("team");
			List<TeamMemberVo> list = service.teamMemberList(team.getTeamNo());
			session.setAttribute("member_list", list);
			rd = request.getRequestDispatcher("addMeeting.jsp");
			
		} else if(cmd.equals("update_meeting")){
			
			TeamService service = TeamDAO.getInstance();
			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo(); 
			List<TeamMemberVo> list = service.teamMemberList(teamNo);
			session.setAttribute("member_list", list);
			
			int meetingNo = Integer.parseInt(request.getParameter("meeting_no"));
			MeetingService mservice = MeetingDAO.getInistance();
			MeetingVo vo = mservice.oneMeeting(meetingNo, teamNo);
			request.setAttribute("meeting", vo);
			
			rd = request.getRequestDispatcher("updateMeeting.jsp");
			
		} else if(cmd.equals("delete_meeting")){
			MeetingService service = MeetingDAO.getInistance();
			
			int meetingNo=Integer.parseInt(request.getParameter("meeting_no"));
			
			boolean result = service.deleteMeeting(meetingNo);
			
			PrintWriter out = response.getWriter();
			if(result){
				out.write("OK");
			}else{
				out.write("NG");
			}
			out.flush();
			out.close();
			return;
		}else if(cmd.equals("write_meetingLog")){
			MeetingService service = MeetingDAO.getInistance();
			
			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo(); 
			int meetingNo = Integer.parseInt(request.getParameter("meeting_no"));
			
			MeetingVo vo = service.oneMeeting(meetingNo, teamNo);
			
			rd = request.getRequestDispatcher("addMeetingLog.jsp");
			request.setAttribute("meeting", vo);
		}
		
		rd.forward(request, response);	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		String cmd = request.getParameter("cmd");
		RequestDispatcher rd = null;
		
		
		if(cmd==null || cmd.equals("meeting_list") ){
			rd = meetingList(request, response);
		} else if(cmd.equals("one_meeting")){
			List<MeetingVo>list = (List<MeetingVo>)request.getAttribute("meeting_list");
		} else if(cmd.equals("add_meeting")){
			MeetingService service = MeetingDAO.getInistance();
			
			String meetingTitle=request.getParameter("meeting_title");
			String meetingTopic=request.getParameter("meeting_topic");
			String[] userNoList=request.getParameterValues("part_in");
			Date meetingDate=Date.valueOf(request.getParameter("meeting_date"));
			Time meetingTime=Time.valueOf(request.getParameter("meeting_time_h")+":"+request.getParameter("meeting_time_m")+":00");
			String meetingLoc=request.getParameter("meeting_loc");
			//int teamNo = ((TeamEntity)session.getAttribute("team")).getTeamNo(); 
			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo(); 
			
			boolean isThereMeeting = service.hasMeeting(teamNo, meetingDate);
			PrintWriter out = response.getWriter();
			if(isThereMeeting){
				out.write("EXIST");
			} else{
				MeetingEntity meeting = new MeetingEntity(teamNo,meetingDate,meetingTime,meetingTopic,meetingTitle,meetingLoc,false);
				List<PartInEntity> partInList = new ArrayList<PartInEntity>();
				for(String userNo : userNoList){
					PartInEntity partIn = new PartInEntity(Integer.parseInt(userNo));
					partInList.add(partIn);
				}
				int result = service.insertMeeting(meeting, partInList);
				
				if(result>0){
					//알람 추가
					AlarmService alarmService = AlarmDAO.getInstance();
					
					int userNo = ((UserEntity)session.getAttribute("user")).getUserNo();
					
					TeamService teamService = TeamDAO.getInstance();
					List<TeamMemberVo> memberList = teamService.teamMemberList(teamNo);
					boolean sendAlarm = false;
					if(memberList!=null && memberList.size()>1){
						for(TeamMemberVo member:memberList){
							//int memberNo = 0;
							//if(member.getUserNo()!=userNo){
								int memberNo = member.getUserNo();
								AlarmEntity alarm = new AlarmEntity(result, memberNo);
								sendAlarm = alarmService.insertAlarm(AlarmType.valueOf("MEETING"), alarm);
								if(sendAlarm){
									System.out.println("알람도 보냄!!!");
								}else{
									System.out.println("알람 보내기 실패!!!");
									break;
								}
							//}
							
						}
					}else{
						sendAlarm=true;
					}
					
					if(sendAlarm){
						out.write("OK");
					}else{
						out.write("NG");
					}
					/*AlarmEntity alarm = new AlarmEntity(result, ((UserEntity)session.getAttribute("user")).getUserNo());
					boolean sendAlarm = alarmService.insertAlarm(AlarmType.valueOf("MEETING"), alarm);
					if(sendAlarm){
						System.out.println("알람도 보냄!!!");
						out.write("OK");
					}else{
						System.out.println("알람 보내기 실패!!!");
						out.write("NG");
					}*/
				}else{
					out.write("NG");
				}
			}
			out.flush();
			out.close();
			return;
		} else if(cmd.equals("update_meeting")){
			MeetingService service = MeetingDAO.getInistance();
			
			String meetingTitle=request.getParameter("meeting_title");
			String meetingTopic=request.getParameter("meeting_topic");
			String[] userNoList=request.getParameterValues("part_in");
			Date meetingDate=Date.valueOf(request.getParameter("meeting_date"));
			Time meetingTime=Time.valueOf(request.getParameter("meeting_time_h")+":"+request.getParameter("meeting_time_m")+":00");
			String meetingLoc=request.getParameter("meeting_loc");
			int meetingNo=Integer.parseInt(request.getParameter("meeting_no"));
			
			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo(); 
			
			MeetingEntity meeting = new MeetingEntity(meetingNo,teamNo,meetingDate,meetingTime,meetingTopic,meetingTitle,meetingLoc,false);
			List<PartInEntity> partInList = new ArrayList<PartInEntity>();
			for(String user : userNoList){
				String [] token=user.split("/");
				String userNo=token[0];
				String partInNo=token[1];
				PartInEntity partIn = new PartInEntity(Integer.parseInt(partInNo),Integer.parseInt(userNo),meetingNo);
				partInList.add(partIn);
			}
			
			boolean result = service.updateMeeting(meeting, partInList, teamNo);
			
			PrintWriter out = response.getWriter();
			if(result){
				out.write("OK");
			}else{
				out.write("NG");
			}
			out.flush();
			out.close();
			return;
		} else if(cmd.equals("write_meetingLog")){
			MeetingService service = MeetingDAO.getInistance();
			
			String meetingDesc=request.getParameter("meeting_desc");
			String[] partInNoList=request.getParameterValues("part_in");
			int meetingNo=Integer.parseInt(request.getParameter("meeting_no"));
			
			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo(); 
			
			MeetingEntity meeting = new MeetingEntity();
			meeting.setMeetingNo(meetingNo);
			meeting.setMeetingDesc(meetingDesc);
			List<PartInEntity> partInList = new ArrayList<PartInEntity>();
			for(String partInNo : partInNoList){
				PartInEntity partIn = new PartInEntity();
				partIn.setPartInNo(Integer.parseInt(partInNo));
				partIn.setState(true);
				partInList.add(partIn);
			}
			
			boolean result = service.writeMeetingLog(meeting, partInList);
			
			PrintWriter out = response.getWriter();
			if(result){
				out.write("OK");
			}else{
				out.write("NG");
			}
			out.flush();
			out.close();
			return;
		}
		
		rd.forward(request, response);
	}

	private RequestDispatcher meetingList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		HttpSession session = request.getSession();		
		MeetingService service = MeetingDAO.getInistance();
		String type=request.getParameter("type");

		String teamNo_s = request.getParameter("teamNo");
		int teamNo = -1;
		if(teamNo_s!=null && !teamNo_s.equals("")){
			teamNo = Integer.parseInt(teamNo_s);
		} else {
			teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();
		}
		
		RequestDispatcher rd=null;
		List<MeetingVo> list=null;
		
		if(type.equals("leader")){
			 rd = request.getRequestDispatcher("/meetingManage.jsp");
			 list= service.teamMeetingList(teamNo, 0, 0);
		}else{
			rd = request.getRequestDispatcher("/meetingList.jsp");
			list= service.teamMeetingList(teamNo, 1, 0);
		}
		
		//알람으로 타고왔는지 검사
		String detailNo_s = request.getParameter("detailNo");
		
		if(detailNo_s!=null && !detailNo_s.equals("")){
			
			int index = detailNo_s.indexOf("/");
			String detail = detailNo_s.substring(0,index);
			String alarm = detailNo_s.substring(index+1,detailNo_s.length());
			
			int detailNo = Integer.parseInt(detail);
			int alarmNo = Integer.parseInt(alarm);
			
			
			AlarmService alarmService = AlarmDAO.getInstance();
			
			UserService userService = UserDAO.getInstance();
			UserEntity user = (UserEntity)session.getAttribute("user");
			
			if( alarmService.deleteAlarm(AlarmType.MEETING, alarmNo) ){
				
				request.setAttribute("detailNo", detailNo);
				request.setAttribute("teamNo", teamNo);
								
				JobService jobService = JobDAO.getInstance();
				MeetingService meetingService = MeetingDAO.getInistance();				
				TeamService teamService = TeamDAO.getInstance();
				
				List<TeamJobListVo> joblist = jobService.teamJobCalendar(teamNo);
				List<MeetingVo> meetList = meetingService.teamMeetingList(teamNo, -1, 0);
				TeamVo team = teamService.oneTeam(teamNo, ((UserEntity)session.getAttribute("user")).getUserNo());
				
				session.setAttribute("team", team);
				request.setAttribute("job_list", joblist);
				request.setAttribute("meeting_list", meetList);
				request.setAttribute("where", "alarm");
				
				rd = request.getRequestDispatcher("/teamCalendar.jsp");
				
			} else {				
						
				request.setAttribute("detailNo", detailNo);
				
				List<TeamVo> teamList = userService.teamList(user.getUserNo());				
				request.setAttribute("team_list", teamList);												
				
				rd = request.getRequestDispatcher("/teamList.jsp");
			}
			
		}		
		request.setAttribute("meeting_list", list);
		return rd;
	}
}
