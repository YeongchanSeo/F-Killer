package com.fkiller.web.socket;

import java.io.BufferedInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.Socket;

public class FileUploader {
	private static String serverIp = "192.168.10.32";
	private static int serverPort = 9002;
	private Socket socket;
	
	public FileUploader() {
		
	}
	
	public boolean uploadFile(File file,int teamNo){
		try{
			this.socket = new Socket(serverIp,serverPort);
			System.out.println("서버에 연결되었습니다.");
			
			return upload(file,teamNo);
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
	
	private boolean upload(File file,int teamNo){
		DataOutputStream dos = null;
		FileInputStream fis = null;
		BufferedInputStream bis = null;
		
		try{
			dos = new DataOutputStream(socket.getOutputStream());
			dos.writeUTF(file.getName());
			//dos.flush();
			dos.writeInt(teamNo);
			//dos.flush();
			fis = new FileInputStream(file);
			bis = new BufferedInputStream(fis);
			
			int len;
			int size = 4096;
			byte[] data = new byte[size];
			while((len = bis.read(data)) != -1)
				dos.write(data,0,len);
			
			dos.flush();
		
			
			System.out.println("파일 전송 작업을 완료하였습니다.");
            System.out.println("보낸 파일의 사이즈 : " + file.length());
            
            return true;
		}catch(IOException e){
			e.printStackTrace();
			return false;
		}finally{
			try{
				dos.close();
				bis.close();
				fis.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}
}
