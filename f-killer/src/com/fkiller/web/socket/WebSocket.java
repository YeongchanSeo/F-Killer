package com.fkiller.web.socket;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.websocket.Extension;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/broadcasting")
public class WebSocket {

	private static Set<Session> clients = Collections
			.synchronizedSet(new HashSet<Session>());
	private static Map<Integer,Session> client = Collections.synchronizedMap(new HashMap<Integer,Session>());
	private int userNo;
	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
		
		boolean result = message.startsWith("c:");
		if(result){
			message = message.substring(2);
			System.out.println("연결성공!!!"+session);
			System.out.println("size:"+client.size());
			System.out.println(message);
			int userNo = Integer.parseInt(message);
			this.userNo = userNo;
			client.put(userNo, session);
		}else{
			synchronized (client) {
				Set<Integer> keys = client.keySet();
				Iterator<Integer> it = keys.iterator();
				String[] str = message.split("%");
				
				int target = Integer.parseInt(str[0]);
				String alarm = str[1];
				while(it.hasNext()){
					int no = it.next();
					System.out.println("no:"+no);
					System.out.println("target:"+target);
					if(no==target){
						System.out.println("보낼게요!!!");
						Session s= client.get(no);
						s.getBasicRemote().sendText(alarm);
						break;
					}
				}
				
			}
		}
	}


	@OnOpen
	public void onOpen(Session session) {
		// Add session to the connected sessions set
		clients.add(session);		
	}

	@OnClose
	public void onClose(Session session) {
		// Remove session from the connected sessions set
		clients.remove(userNo);
	}
}