package com.event;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

//HTTPSessionListener : 技记捞 积己, 辆丰
//ServletContextListener : 辑滚啊 矫累, 吝瘤

public class CountManager implements HttpSessionListener{

	private static CountManager countManager;
	private static int count;
	
	public CountManager() {
		countManager = this;
	}
	public static synchronized CountManager getInstance() throws Exception{
		
		if(countManager==null) {
			countManager = new CountManager();
		}
		return countManager;
	}
	
	public static int getCount() {
		return count;
	}	
	@Override
	public void sessionCreated(HttpSessionEvent evt) {
		
		HttpSession session = evt.getSession();
		session.setMaxInactiveInterval(5*60);//5盒
		
		count++;
		
		System.out.print(session.getId() + ":技记积己, ");
		System.out.println("立加磊荐: " + count);
	}
	@Override
	public void sessionDestroyed(HttpSessionEvent evt) {
		
		HttpSession session = evt.getSession();
		
		count--;
		
		System.out.print(session.getId() + ":技记家戈, ");
		System.out.println("立加磊荐: " + count);
	}

}
