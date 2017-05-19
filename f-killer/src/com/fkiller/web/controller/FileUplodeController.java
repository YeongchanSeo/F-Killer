package com.fkiller.web.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.fkiller.web.dao.TimetableDAO;
import com.fkiller.web.dao.UserDAO;
import com.fkiller.web.entity.TimetableEntity;
import com.fkiller.web.entity.UserEntity;
import com.fkiller.web.service.TimeTableService;
import com.fkiller.web.service.UserService;
import com.fkiller.web.vo.TeamVo;

/**
 * Servlet implementation class FileUplodeController
 */
@WebServlet("/FileUplodeController.do")
public class FileUplodeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileUplodeController() {
        super();
        // TODO Auto-generated constructor stub
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher rd = null;
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		
		String cmd = null;
						
		String userName=null;
		String userPwd=null;
		String profile=null;
		String mon=null;
		String tue=null;
		String wed=null;
		String thu=null;
		String fri=null;
		String sat=null;
		String sun=null;
		
		HttpSession session = request.getSession();
		UserEntity user =(UserEntity)session.getAttribute("user");
		UserEntity oldUser = user;
		
		TimeTableService timeTabService = TimetableDAO.getInstance();
		UserService userservice = UserDAO.getInstance();
		TimetableEntity entity = new TimetableEntity();
		
		try{
			List params = upload.parseRequest(request);
			
			
			for(Object obj : params){
				
				FileItem item = (FileItem)obj;
				if(item.isFormField()){					
					
					if(item.getFieldName().equals("name"))
						user.setUserName(item.getString("utf-8"));
					else if(item.getFieldName().equals("password"))
						user.setUserPwd(item.getString("utf-8"));					
					else if(item.getFieldName().equals("mon"))
						entity.setMon(item.getString("utf-8"));
					else if(item.getFieldName().equals("tue"))
						entity.setTue(item.getString("utf-8"));
					else if(item.getFieldName().equals("wen")){
						entity.setWed(item.getString("utf-8"));
						//System.out.println("수요일 : " + entity.getWed());
					}						
					else if(item.getFieldName().equals("thu"))
						entity.setThu(item.getString("utf-8"));
					else if(item.getFieldName().equals("fri"))
						entity.setFri(item.getString("utf-8"));
					else if(item.getFieldName().equals("sat"))
						entity.setSat(item.getString("utf-8"));
					else if(item.getFieldName().equals("sun"))
						entity.setSun(item.getString("utf-8"));	
				} else {
					
					if( item.getName() != null && item.getName() != "" && item.getName() != "null") {
						
						String fileSize = item.getSize()+"";
						String fileName = item.getName();
											
						int pos = fileName.lastIndexOf(".");
						String fileext=null;
						
						if(pos != -1) {			    		
				    		fileext = fileName.substring(pos);
				    	}					
						
										
						File dir = new File(request.getServletContext().getRealPath("/") +"img"+ File.separator + "userProfile");
						
						File tempFile = null;
										
						if(!dir.exists()){
							dir.mkdirs();
						}
						try{
							
							tempFile = new File(dir, user.getUserEmail()+fileext);
							System.out.println(tempFile.getName());
							item.write(tempFile);
							user.setUserProfile(tempFile.getName());
							
							session.setAttribute("user", user);
							
						} catch(Exception e) { e.printStackTrace(); }
					} else {
						System.out.println("엘스입니다.");
						user.setUserProfile(oldUser.getUserProfile());
					}
				}  
				
			}  //for문 끝
			
			entity.setUserNo(user.getUserNo());
			
			if(entity.getMon() == null || entity.getMon() == "")
				entity = timeTabService.oneTimetable(user.getUserNo());
			
			boolean userResult = userservice.updateUser(user);
			
			
			
			boolean tableResult = timeTabService.updateTimetable(entity);
			
			if(userResult != true || tableResult != true){
				//실패했을경우
				
				session.setAttribute("user", oldUser);
				
				TimetableEntity time = timeTabService.oneTimetable(user.getUserNo());
				request.setAttribute("timeTable", time);
				rd = request.getRequestDispatcher("/updateUserInfo.jsp");			
				
			} else {		//성공했을 경우
				
				
				session.setAttribute("user", user);
				session.setMaxInactiveInterval(60*60);				
				
				List<TeamVo> teamList = userservice.teamList(user.getUserNo());
				
				request.setAttribute("team_list", teamList);
				request.setAttribute("cmd", "updatePersonalInfo");
				
				rd = request.getRequestDispatcher("/teamList.jsp");
			}		
		} catch(FileUploadException e){
				e.printStackTrace();	
		}
		
		rd.forward(request, response);
	}

}
