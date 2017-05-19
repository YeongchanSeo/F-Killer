package com.fkiller.web.socket;

import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.Socket;

public class FileDownloader {
	private static String serverIp = "192.168.10.32";
	private static int serverPort = 9001;
	private Socket socket;
//	private DataInputStream dis;
//	private PrintWriter writer;
	public FileDownloader(){
		
	}
	
	public boolean downloadFile(String path,String fileName,int teamNo){
		try{
			this.socket = new Socket(serverIp,serverPort);
//			this.dis = new DataInputStream(socket.getInputStream());
//			this.writer = new PrintWriter(socket.getOutputStream());
			System.out.println("서버에 연결되었습니다.");
			
			return download(path,fileName,teamNo);
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}finally{
			try {
				socket.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public boolean downloadFiles(String path,String[] fileNames,int teamNo){
		try{
			this.socket = new Socket(serverIp,serverPort);
			System.out.println("서버에 연결되었습니다.");
			
			return downloads(path,fileNames, teamNo);
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}finally{
			try {
				socket.close();
//				dis.close();
//				writer.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}
	
	private boolean downloads(String path,String[] fileNames,int teamNo){
		FileOutputStream fos = null;
		BufferedOutputStream bos = null;
		DataInputStream dis = null;
		try{
			PrintWriter writer = new PrintWriter(socket.getOutputStream());
			StringBuffer sb = new StringBuffer();
			for(String fileName : fileNames)
				sb.append(fileName+"/");
			sb.deleteCharAt(sb.length()-1);
			writer.println(sb.toString());
			writer.flush();
			dis = new DataInputStream(socket.getInputStream());
			for(String fileName : fileNames){
				
				System.out.println("파일 수신 작업을 시작합니다.");
				
				System.out.println("파일명 "+fileName + "을 전송받았습니다.");
				
				File dir = new File(path);
				if(!dir.exists())
					dir.mkdirs();
				
				File file = new File(dir,fileName);
				System.out.println("파일이름:::"+file.getName());
				fos = new FileOutputStream(file);
				bos = new BufferedOutputStream(fos);
				System.out.println(fileName+"파일을 생성하였습니다.");
				
				int len;
				int size = 4096;
				byte[] data = new byte[size];
				while((len = dis.read(data)) != -1)
					bos.write(data,0,len);
				
				bos.flush();
				bos.close();
				fos.close();
				System.out.println("파일 수신 작업을 완료하였습니다.");
				System.out.println("받은 파일의 사이즈 : "+file.length());
			}
			
			dis.close();
			return true;
			
		}catch(IOException e){
			e.printStackTrace();
		}
		return false;
	}
	
	
	private boolean download(String path,String fileName,int teamNo){
		FileOutputStream fos = null;
		BufferedOutputStream bos = null;
		DataInputStream dis = null;
		try{
			PrintWriter writer = new PrintWriter(socket.getOutputStream());
			writer.println(teamNo+"/"+fileName);
			System.out.println(fileName);
			writer.flush();
			
			dis = new DataInputStream(socket.getInputStream());
			//String fName = dis.readUTF();
			System.out.println("파일 수신 작업을 시작합니다.");
			
			System.out.println("파일명 "+fileName + "을 전송받았습니다.");
			
			File dir = new File(path);
			if(!dir.exists())
				dir.mkdirs();
			
			File file = new File(dir,fileName);
			System.out.println("파일이름:::"+file.getName());
			fos = new FileOutputStream(file);
			bos = new BufferedOutputStream(fos);
			System.out.println(fileName+"파일을 생성하였습니다.");
			
			int len;
			int size = 4096;
			byte[] data = new byte[size];
			while((len = dis.read(data)) != -1)
				bos.write(data,0,len);
			
			bos.flush();
			bos.close();
			fos.close();
			dis.close();
			writer.close();
			System.out.println("파일 수신 작업을 완료하였습니다.");
			System.out.println("받은 파일의 사이즈 : "+file.length());
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
}
