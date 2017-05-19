package com.fkiller.web.controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import com.fkiller.web.dao.NoticeDAO;
import com.fkiller.web.dao.TeamDAO;
import com.fkiller.web.dao.UserDAO;
import com.fkiller.web.entity.AlarmEntity;
import com.fkiller.web.entity.NoticeEntity;
import com.fkiller.web.entity.UserEntity;
import com.fkiller.web.service.AlarmService;
import com.fkiller.web.service.NoticeService;
import com.fkiller.web.service.TeamService;
import com.fkiller.web.service.UserService;
import com.fkiller.web.vo.TeamMemberVo;
import com.fkiller.web.vo.TeamVo;

/**
 * Servlet implementation class NoticeController
 */
@WebServlet("/NoticeController.do")
public class NoticeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		RequestDispatcher rd = null;
		HttpSession session = request.getSession();
		NoticeService service=NoticeDAO.getInistance();
		TeamService teamService = TeamDAO.getInstance();
		
		String cmd = request.getParameter("cmd");
		
		if(cmd.equals("notice_list")){
			String page = (String)request.getAttribute("page");
			String page2 = request.getParameter("fake");
			if(page2!=null){
				page="noticeAll";
			}
			String teamNo_s = request.getParameter("teamNo");
			int teamNo = -1;
			if(teamNo_s!=null && !teamNo_s.equals("")){
				teamNo = Integer.parseInt(teamNo_s);
				TeamVo team = teamService.oneTeam(teamNo, ((UserEntity)session.getAttribute("user")).getUserNo());
				
			}else{
				teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();
			}
			
			List<NoticeEntity> list=null;
			if(page.equals("team_event")){//5개
				list=service.teamNoticeList(teamNo, 5);				
				request.setAttribute("notice_list", list);
				list=service.teamNoticeList(teamNo, 5);

				rd = request.getRequestDispatcher("teamEventList.jsp");

			}else if(page.equals("noticeAll")){
				list=service.teamNoticeList(teamNo, 0);
				request.setAttribute("where", "view");
				request.setAttribute("notice_list", list);
				
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
					
					
					if( alarmService.deleteAlarm(AlarmType.NOTICE, alarmNo) ){
						TeamVo team = teamService.oneTeam(teamNo, user.getUserNo());
						List<TeamMemberVo> memberList = teamService.teamMemberList(teamNo);
						request.setAttribute("detailNo", detailNo);
						session.setAttribute("team", team);
						session.setAttribute("member_list", memberList);
					} else {
						
						List<TeamVo> teamList = userService.teamList(user.getUserNo());				
						request.setAttribute("team_list", teamList);
						
						
						rd = request.getRequestDispatcher("/teamList.jsp");
					}
					
				}
				
				rd = request.getRequestDispatcher("noticeManageMain.jsp");
				
			}else if(page.equals("manage")){
				list=service.teamNoticeList(teamNo, 0);
				request.setAttribute("where", "manage");
				request.setAttribute("notice_list", list);
				rd = request.getRequestDispatcher("noticeManageMain.jsp");

			}
			request.setAttribute("notice_list", list);
			
		} else if(cmd.equals("oneNotice")){
			
			String page = request.getParameter("page");
			String where = request.getParameter("where");
			if(!page.equals("default")){
				int noticeNo=Integer.parseInt((String)request.getParameter("no"));
				NoticeEntity notice = service.oneNotice(noticeNo);
				request.setAttribute("notice", notice);				
			}
			
			if(page.equals("manage")){
				request.setAttribute("where", "manage");	
			}else if(page.equals("view")){
				request.setAttribute("where", "view");
			}else if(page.equals("default")){
				request.setAttribute("where", "default");
			}
			if(where!=null && where.length()>0){
				request.setAttribute("page", where);
			}
			rd = request.getRequestDispatcher("oneNotice.jsp");
			
		}else if(cmd.equals("delete_notice")){
			
			String noticeNo_s=(String)request.getParameter("noticeNo");
			int noticeNo=Integer.parseInt(noticeNo_s);
			
			boolean result=service.deleteNotice(noticeNo);
			PrintWriter out = response.getWriter();
			if(result){
				out.write("1");
			}else{
				out.write("NG");
			}
			
			out.flush();
			out.close();
			return;
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
		HttpSession session = request.getSession();
		NoticeService service=NoticeDAO.getInistance();
		
		if(cmd.equals("notice_list")){
			
			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo(); 
			List<NoticeEntity> list=service.teamNoticeList(teamNo, 0);
			
			request.setAttribute("notice_list", list);
			request.setAttribute("where", "manage");
			rd = request.getRequestDispatcher("/noticeManageMain.jsp");
		}else if(cmd.equals("add_notice")){
			System.out.println("dopost - add_notice");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();
			UserEntity user = (UserEntity)session.getAttribute("user");
			
			NoticeEntity entity= new NoticeEntity(user.getUserNo(), teamNo, title, content);
			System.out.println("공지 등록 시도");
			int result=service.insertNotice(entity);
			PrintWriter out = response.getWriter();
			if(result>0){
				System.out.println("공지 등록 성공 : "+result);
				//알람 저장
				AlarmService alarmService = AlarmDAO.getInstance();
				
				int userNo = ((UserEntity)session.getAttribute("user")).getUserNo();
				
				TeamService teamService = TeamDAO.getInstance();
				List<TeamMemberVo> memberList = teamService.teamMemberList(teamNo);
				boolean sendAlarm = false;
				if(memberList!=null && memberList.size()>0){
					for(TeamMemberVo member:memberList){
						//int memberNo = 0;
						//if(member.getUserNo()!=userNo){
							int memberNo = member.getUserNo();
							AlarmEntity alarm = new AlarmEntity(result, memberNo);
							sendAlarm = alarmService.insertAlarm(AlarmType.valueOf("NOTICE"), alarm);
							if(sendAlarm){
								System.out.println("알람도 보냄!!!");
							}else{
								System.out.println("알람 보내기 실패!!!");
							}
						//}
						
					}
				}else{
					sendAlarm = true;
				}
				
				if(sendAlarm){
					out.write("1");
				}else{
					out.write("NG");
				}
				
				/*AlarmEntity alarm = new AlarmEntity(result, ((UserEntity)session.getAttribute("user")).getUserNo());
				boolean sendAlarm = alarmService.insertAlarm(AlarmType.valueOf("NOTICE"), alarm);
				if(sendAlarm){
					System.out.println("알람도 보냄!!!");
					out.write("1");
				}else{
					System.out.println("알람 보내기 실패!!!");
					out.write("NG");
				}*/
			}else{
				System.out.println("공지 등록 실패");
				out.write("NG");
			}
			System.out.println("페이지 돌아가기");
			out.flush();
			out.close();
			return;
			
		}else if(cmd.equals("update_notice")){
			
			int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
			String title = request.getParameter("title");
			String desc = request.getParameter("desc");
			
			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();
			UserEntity user = (UserEntity)session.getAttribute("user");
			
			NoticeEntity entity= new NoticeEntity(user.getUserNo(), teamNo, title, desc);
			entity.setNoticeNo(noticeNo);
			
			boolean result=service.updateNotice(entity);
			PrintWriter out = response.getWriter();
			if(result){
				out.write("1");
			}else{
				out.write("NG");
			}
			
			out.flush();
			out.close();
			return;
		}		
		rd.forward(request, response);	
	}
}
