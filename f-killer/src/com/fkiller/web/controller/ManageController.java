package com.fkiller.web.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.fkiller.web.dao.JobDAO;
import com.fkiller.web.dao.TeamDAO;
import com.fkiller.web.dao.UserDAO;
import com.fkiller.web.entity.UserEntity;
import com.fkiller.web.service.JobService;
import com.fkiller.web.service.TeamService;
import com.fkiller.web.service.UserService;
import com.fkiller.web.socket.FileDownloader;
import com.fkiller.web.vo.FileAdminVo;
import com.fkiller.web.vo.TeamMemberVo;
import com.fkiller.web.vo.TeamVo;

/**
 * Servlet implementation class ManageController
 */
@WebServlet("/ManageController.do")
public class ManageController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ManageController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		RequestDispatcher rd = request.getRequestDispatcher("/managerMain.jsp");
		HttpSession session = request.getSession();
		String cmd = request.getParameter("cmd");
		if(cmd!=null){
			if(cmd.equals("one_team")){
				int teamNo = Integer.parseInt(request.getParameter("team_no"));
				TeamService service = TeamDAO.getInstance();
				TeamVo team = service.oneTeam(teamNo,((UserEntity)session.getAttribute("user")).getUserNo());
				List<TeamMemberVo> memberList = service.teamMemberList(teamNo);
				request.setAttribute("team", team);
				request.setAttribute("member_list", memberList);
				rd = request.getRequestDispatcher("/TeamAdmin.jsp");
			}else if(cmd.equals("one_user")){
				int userNo = Integer.parseInt(request.getParameter("user_no"));
				UserService service = UserDAO.getInstance();
				UserEntity user = service.oneUser(userNo);
				List<TeamVo>teamList = service.teamList(userNo);
				request.setAttribute("user", user);
				request.setAttribute("team_list", teamList);
				rd = request.getRequestDispatcher("/userAdmin.jsp");
			}else if(cmd.equals("one_file")){
				
			}
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
		RequestDispatcher rd = request.getRequestDispatcher("/managerMain.jsp");
		PrintWriter writer = null;
		JSONArray array = new JSONArray();
		if(cmd==null || cmd.equals("team_list")){
			TeamService service = TeamDAO.getInstance();
			List<TeamVo>teamList = service.getTeamList();
			request.setAttribute("team_list", teamList);
			writer = response.getWriter();
			
			if(teamList != null && teamList.size()>0){
				for(TeamVo vo : teamList){
					JSONObject json = new JSONObject();
					json.put("team_no", (Integer)vo.getTeamNo());
					json.put("team_name", vo.getTeamName());
					json.put("team_topic", vo.getTeamTopic());
					json.put("start_date", vo.getStartDate().toString());
					json.put("end_date", vo.getEndDate().toString());
					json.put("oper", vo.isOper());
					json.put("leader_name", vo.getLeaderName());
					json.put("team_color", vo.getTeamColor().toString());
					json.put("favorites", vo.isFavorites());
					
					array.add(json);
				}
			}

			writer.print(array);
			writer.flush();
			writer.close();

			return;

		}else if(cmd.equals("user_list")){
			UserService service = UserDAO.getInstance();
			List<UserEntity> userList = service.getUserList();
			request.setAttribute("user_list",userList);

			writer = response.getWriter();

			if(userList != null && userList.size()>0){
				for(UserEntity entity : userList){
					JSONObject json = new JSONObject();
					json.put("user_no", (Integer)entity.getUserNo());
					json.put("user_name", entity.getUserName());
					json.put("user_email", entity.getUserEmail());
					json.put("user_pwd", entity.getUserPwd());
					json.put("user_profile", entity.getUserProfile());
					json.put("join_method", entity.getJoinMethod());
					json.put("reg_date", entity.getRegDate().toString());
					if(entity.isDelFlg())
						json.put("del_date", entity.getDelDate().toString());
					else
						json.put("del_date", "-");
					
					json.put("del_flg", entity.isDelFlg());

					array.add(json);
				}
			}

			writer.print(array);
			writer.flush();
			writer.close();

			return;

		}else if(cmd.equals("file_list")){
			JobService service = JobDAO.getInstance();
			List<FileAdminVo> fileList = service.getAdminFileList();
			request.setAttribute("file_list", fileList);

			writer = response.getWriter();

			if(fileList != null && fileList.size()>0){
				for(FileAdminVo vo : fileList){
					JSONObject json = new JSONObject();
					json.put("file_no", (Integer)vo.getFileNo());
					json.put("file_name", vo.getFileName());
					json.put("team_no", (Integer)vo.getTeamNo());
					json.put("team_name", vo.getTeamName());
					json.put("file_size", vo.getFileSize());
					json.put("reg_date", vo.getRegDate().toString());
					
					array.add(json);
				}
			}

			writer.print(array);
			writer.flush();
			writer.close();

			return;
		}else if(cmd.equals("download")){
			String fileName = request.getParameter("file_name");
			int teamNo = Integer.parseInt(request.getParameter("team_no"));
			
			FileDownloader downloader = new FileDownloader();
			
			String path = request.getServletContext().getRealPath("/")+File.separator+"download";
			if(downloader.downloadFile(path, fileName, teamNo)){
				if(downloadFile(response,path,fileName)){
					
					return;
				}
			}
		}
		rd.forward(request, response);
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
