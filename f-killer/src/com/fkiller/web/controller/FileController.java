package com.fkiller.web.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fkiller.web.dao.JobDAO;
import com.fkiller.web.service.JobService;
import com.fkiller.web.socket.FileDeleter;
import com.fkiller.web.socket.FileDownloader;
import com.fkiller.web.vo.FileVo;
import com.fkiller.web.vo.TeamVo;

/**
 * Servlet implementation class FileController
 */
@WebServlet("/FileController.do")
public class FileController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FileController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		String cmd = request.getParameter("cmd");
		RequestDispatcher rd = null;
		if(cmd.equals("storage")){
			rd = storageList(request, response);
		}

		rd.forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		RequestDispatcher rd = null;
		String cmd = request.getParameter("test");
		if(cmd.equals("download")){
			String[] files = request.getParameterValues("selected_file");
			String[] fileNames = new String[files.length];
			int cnt=0;
			for(String fileName : files){
				fileNames[cnt++] = fileName.split("/")[1];
			}
			FileDownloader downloader = new FileDownloader();
			HttpSession session = request.getSession();
			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();
			String path = request.getServletContext().getRealPath("/")+File.separator+"download";
			for(String file : fileNames)
				if(!downloader.downloadFile(path, file,teamNo))
					return;
			
			String zipFile="";
			if(files.length > 1){
				zipFile = fileNames[0].substring(0, fileNames[0].lastIndexOf("."))+".zip";
				creatZipFile(fileNames, path, zipFile);
				downloadFile(response, path, zipFile);
			}else
				downloadFile(response,path,fileNames[0]);
			
			
			
			
		}else if(cmd.equals("delete")){
			String[] files = request.getParameterValues("selected_file");
			int[] fileNos = new int[files.length];
			String[] fileNames = new String[files.length];
			int cnt=0;
			for(String file : files){
				String[] splitStr = file.split("/");
				fileNos[cnt] = Integer.parseInt(splitStr[0]);
				fileNames[cnt] = splitStr[1];
				cnt++;
 			}
			
			JobService service = JobDAO.getInstance();
			HttpSession session = request.getSession();
			int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();
			StringBuffer _fileNames = new StringBuffer(teamNo+"/");
			cnt=0;
			for(int fileNo : fileNos){
				service.deleteFile(fileNo);
				_fileNames.append(fileNames[cnt++]+"/");
			}
			_fileNames.deleteCharAt(_fileNames.length()-1);
			
			
			FileDeleter deleter = new FileDeleter();
			deleter.deleteFile(_fileNames.toString());
			
			response.sendRedirect(request.getContextPath()+"/FileController.do?cmd=storage");
		}
		//rd.forward(request, response);
	}

	private RequestDispatcher storageList(HttpServletRequest request,HttpServletResponse response){
		RequestDispatcher rd = null;
		JobService service = JobDAO.getInstance();
		HttpSession session = request.getSession();
		int teamNo = ((TeamVo)session.getAttribute("team")).getTeamNo();
		List<FileVo>fileList = service.teamFileList(teamNo);
		request.setAttribute("file_list", fileList);

		rd = request.getRequestDispatcher("storage.jsp");

		return rd;
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

	

	public void creatZipFile(String[] files,String path,String fileName){

		int size = 1024;
		// Create a buffer for reading the files
		byte[] buf = new byte[size];
		try {

			ZipOutputStream out = new ZipOutputStream(new BufferedOutputStream(new FileOutputStream(path+File.separator+fileName)));

			for (int i=0; i<files.length; i++) {

				FileInputStream fs = new FileInputStream( path + "/" + files[i]);
				BufferedInputStream in = new BufferedInputStream(fs, size);

				out.putNextEntry(new ZipEntry(files[i]));

				int len;
				while ((len = in.read(buf, 0, size)) > 0) {
					out.write(buf, 0, len);
				}

				out.closeEntry();
				in.close();
			}

			out.close();


		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
}
