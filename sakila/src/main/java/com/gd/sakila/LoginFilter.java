package com.gd.sakila;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebFilter(urlPatterns ="/admin/*") //urlPatterns = 어드민으로 시작하는 모든 페이지
public class LoginFilter implements Filter {

 
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		//요청전
		log.debug("★★★★★ Login filter 요청전");
		HttpSession session = null;
		if (request instanceof HttpServletRequest) {
			session = ((HttpServletRequest)request).getSession(); //(HttpServletRequest)형태로 형변환
		}
		/* 개발중이라 로그인 부분 주석처리
		if (session.getAttribute("loginStaff")==null) {
			if(response instanceof HttpServletResponse) {
				((HttpServletResponse)response).sendRedirect("/home");
			}
		}
		*/
		chain.doFilter(request, response); //요청전후를 가르는 chain
		//요청후
		log.debug("★★★★★ Login filter 요청후");
	}
}
