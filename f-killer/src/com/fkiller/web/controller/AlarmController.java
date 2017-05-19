package com.fkiller.web.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.fkiller.web.dao.AlarmDAO;
import com.fkiller.web.entity.UserEntity;
import com.fkiller.web.service.AlarmService;
import com.fkiller.web.vo.AlarmVo;
import com.fkiller.web.vo.TeamVo;

/**
 * Servlet implementation class AlarmController
 */
@WebServlet("/AlarmController.do")
public class AlarmController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AlarmController() {
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
		AlarmService service = AlarmDAO.getInstance();
		HttpSession session = request.getSession();
		
		if(cmd == null || cmd.equals("alarm_list")){
			String type = request.getParameter("type");
			List<AlarmVo> alarmList=null;
			
		
			
			int userNo = ((UserEntity)session.getAttribute("user")).getUserNo();
			
//			if(type.equals("personal_alarm")){
			alarmList = service.personalAlarmList(userNo);
//			}else if(type.equals("team_alarm")){
//				int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();
//				alarmList = service.teamAlarmList(userNo, teamNo);
//			}
			
			JSONArray array = new JSONArray();
			PrintWriter out = response.getWriter();
			
			if(alarmList!=null && alarmList.size()>0){
		        for(AlarmVo alarm : alarmList){
		        	JSONObject json = new JSONObject();
		            json.put("alarmNo", (Integer)alarm.getAlarmNo());
		            json.put("alarmType", (alarm.getAlarmType()).toString());
		            json.put("message", alarm.getMessage());
		            json.put("detailNo", (Integer)alarm.getDetailNo());
		            json.put("teamNo", (Integer)alarm.getTeamNo());
		            
		            array.add(json);
		        }
		        
			}
			out.print(array);
			out.flush();
	        out.close();
	        return;
			
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
