package com.fkiller.web.socket;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.Socket;

public class FileDeleter {
	private static String serverIp = "192.168.10.32";
	private static int serverPort = 9003;
	private Socket socket;
	
	public FileDeleter(){
		
	}
	
	public boolean deleteFile(String files){
		try{
			this.socket = new Socket(serverIp,serverPort);
			System.out.println("서버에 연결되었습니다.");
			
			return delete(files);
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}finally{
			try{
				socket.close();
			}catch(IOException e){
				e.printStackTrace();
			}
		}
	}
	
	private boolean delete(String files){
		PrintWriter writer = null;
		try{
			writer = new PrintWriter(socket.getOutputStream());
			writer.println(files);
			writer.flush();
			writer.close();
			return true;
		}catch(IOException e){
			e.printStackTrace();
			return false;
		}finally{
			try{
				writer.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}
}
