package com.svt;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.GenericServlet;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class Test1 extends GenericServlet {

	@Override
	public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {
		
		res.setContentType("text/html;charset=utf-8");
		
		try {
			PrintWriter out = res.getWriter();
			
			out.print("<html>");
			out.print("<head>");
			out.print("<title>");
			out.print("예제 프로그램</title></head>");
			out.print("<body style='font-size:12pt);'>");
			out.print("화면 디자인은 서블릿보다 JSP보다 편하다");
			out.print("</body>");
			out.print("</html>");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}

}
