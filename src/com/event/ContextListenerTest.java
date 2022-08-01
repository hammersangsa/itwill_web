package com.event;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class ContextListenerTest implements ServletContextListener{

	@Override//서버 시작 시
	public void contextDestroyed(ServletContextEvent sce) {
		
		System.out.println("서버가 중지됩니다");
		
	}

	@Override//서버 종료 시
	public void contextInitialized(ServletContextEvent sce) {
		
		System.out.println("서버가 숨쉰다");
		
		/*ServletContext sc = sce.getServletContext();
		sc.setAttribute("name", "Servlet");*/
		
	}

	
}
