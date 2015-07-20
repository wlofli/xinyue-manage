package com.xinyue.manage.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

/**
 * 
 * @author apple
 * 
 */
public class SessionFilter extends OncePerRequestFilter {

	@Override
	protected void doFilterInternal(HttpServletRequest arg0,
			HttpServletResponse arg1, FilterChain arg2)
			throws ServletException, IOException {
		// 不过滤的URI
		String[] notFilter = new String[] { "login", "index", "register", "/",
				"/logout" };

		// 请求的URI
		String uri = arg0.getRequestURI();
		
		System.err.println("uri=" + uri);
		// uri中包含b
		if (uri.indexOf("bb") != -1) {
			// 是否过滤
			boolean doFilter = true;
			for (String s : notFilter) {
				if (uri.indexOf(s) != -1) {
					doFilter = false;
					break;
				}
			}

			if (doFilter) {
				Object object = arg0.getSession().getAttribute(
						GlobalConstant.SESSION_USER_NAME);
				if (object == null) {
					arg0.setCharacterEncoding("UTF-8");
					arg1.setCharacterEncoding("UTF-8");
					arg1.setContentType("text/html;charset=utf-8");
					PrintWriter out = arg1.getWriter();
					// 获取项目名称，使用绝对路径访问页面
					String ctx = arg0.getServletContext().getContextPath();
					// System.err.println(ctx);
					String loginPage = ctx + "/";
					System.err.println("loginPage=" + loginPage);
					StringBuilder sBuilder = new StringBuilder();
					sBuilder.append("<script type=\"text/javascript\">");
					sBuilder.append("alert('网页过期，请重新登录！');");
					sBuilder.append("window.top.location.href='");
					sBuilder.append(loginPage);
					sBuilder.append("';");
					sBuilder.append("</script>");
					out.print(sBuilder.toString());
				} else {
					arg2.doFilter(arg0, arg1);
				}
			} else {
				arg2.doFilter(arg0, arg1);
			}
		} else {
			arg2.doFilter(arg0, arg1);
		}
	}

}
