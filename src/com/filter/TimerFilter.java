package com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class TimerFilter implements Filter {

	private FilterConfig config;
	
	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		long before = System.currentTimeMillis();
		
		chain.doFilter(request, response);
		//클라이언트에 요청과 반환값을 체인에 의해 필터를 거쳐 넘어가게함
		long after = System.currentTimeMillis();
		
		String uri;
		
		if(request instanceof HttpServletRequest) {
			
			HttpServletRequest req = (HttpServletRequest)request;
			
			uri = req.getRequestURI();
			
/*			config.getServletContext().log(uri + ":" 
			+ (after-before) + "ms"); 로그파일*/
			
			System.out.print(uri + ":" + (after-before) + "ms\n");
		}
		
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
		this.config = filterConfig;
	}

}
