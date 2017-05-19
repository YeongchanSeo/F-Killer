package com.fkiller.web.util;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
 
public class EmailUtil {
	private MimeMessage msg;

	public EmailUtil(){
		Properties p = System.getProperties();
        p.put("mail.smtp.starttls.enable", "true");     // gmail은 무조건 true 고정
        p.put("mail.smtp.host", "smtp.gmail.com");      // smtp 서버 주소
        p.put("mail.smtp.auth","true");                 // gmail은 무조건 true 고정
        p.put("mail.smtp.port", "587");                 // gmail 포트
           
        Authenticator auth = new MyAuthentication();
        Session session = Session.getDefaultInstance(p, auth);
        msg = new MimeMessage(session);
	}
	
	public void inviteMember(String email, String userName, String teamName){
		try{
			setEmailAddr(email);
			msg.setSubject("[에프킬라] " + teamName+ "팀 " + userName+"님으로부터 가입 초대가 왔습니다.", "UTF-8");
			msg.setContent(getHttpHTML(userName,"http://localhost:8080/f-killer/invitation.html"), "text/html; charset=utf-8");
			sendEmail();
		}catch (AddressException addr_e) {
            addr_e.printStackTrace();
        }catch (MessagingException msg_e) {
            msg_e.printStackTrace();
        }catch (UnsupportedEncodingException uee){
        	uee.printStackTrace();
        }
	}
	
	public void sendReport(String teamName, String email) {
		try{
			setEmailAddr(email);
			msg.setSubject("[에프킬라] " + teamName + "팀의 업무 보고서입니다.", "UTF-8");
			Calendar calender = Calendar.getInstance();
		    int year = calender.get(Calendar.YEAR);
		    int month = calender.get(Calendar.MONTH)+1;
		    int date = calender.get(Calendar.DAY_OF_MONTH);
		    String fileName = teamName+' '+year+"-"+month+"-"+date;
		    attachFile(teamName, fileName);
			sendEmail();
		}catch (AddressException addr_e) {
            addr_e.printStackTrace();
        }catch (MessagingException msg_e) {
            msg_e.printStackTrace();
        }catch (UnsupportedEncodingException uee){
        	uee.printStackTrace();
        }catch(Exception e){}
        
	}
	
	private void attachFile(String teamName, String fileName)throws MessagingException, UnsupportedEncodingException{
		Multipart multipart = new MimeMultipart();
        MimeBodyPart attachPart = new MimeBodyPart();
        attachPart.setDataHandler(new DataHandler(new FileDataSource("C:/temp/report.html")));
        attachPart.setFileName(MimeUtility.encodeText(fileName + ".html","UTF-8","B")); // 파일명

        MimeBodyPart messageBodyPart = new MimeBodyPart();
     	messageBodyPart.setContent(getHttpHTML(teamName, "http://localhost:8080/f-killer/reportForm.html"),
     	"text/html;charset=utf-8");

     	multipart.addBodyPart(messageBodyPart);
     	multipart.addBodyPart(attachPart);
     	msg.setContent(multipart);
     	msg.setHeader("Content-Transfer-Encoding","base64");
	}
	
    private void setEmailAddr(String addr) throws MessagingException, UnsupportedEncodingException{  
        msg.setSentDate(new Date());

        InternetAddress from = new InternetAddress("stackoverflowpro@gmail.com");
        from.setPersonal("에프킬라");
        msg.setFrom(from);
        
        InternetAddress to = new InternetAddress(addr);
        msg.setRecipient(Message.RecipientType.TO, to);
       
    }
    
    private void sendEmail() throws MessagingException{
    	javax.mail.Transport.send(msg);
    }

    public static String getHttpHTML(String replacement, String urlToRead) {
        URL url;
        HttpURLConnection conn;
        BufferedReader rd;
        String line;
        String result = "";
        try {
            url = new URL(urlToRead);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            Calendar calender = Calendar.getInstance();
		    int year = calender.get(Calendar.YEAR);
		    int month = calender.get(Calendar.MONTH)+1;
		    int date = calender.get(Calendar.DAY_OF_MONTH);
		    String nowdate = year+"년 "+month+"월 "+date+"일 <br/>";
            while ((line = rd.readLine()) != null) {
            	line = line.replaceAll("regex", replacement);
            	line = line.replaceAll("date", nowdate);
                result += line + "\n";
            }
            rd.close();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
 
}
