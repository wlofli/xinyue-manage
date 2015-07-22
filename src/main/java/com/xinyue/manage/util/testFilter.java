package com.xinyue.manage.util;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

/**
 * author lzc
 * 2015年6月18日下午5:09:11
 */
public class testFilter extends OncePerRequestFilter{

	@Override
	protected void doFilterInternal(HttpServletRequest request,
			HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String uri = request.getRequestURI();
		
		System.err.println("uri=" + uri);
		filterChain.doFilter(request, response);
	}

}