package com.xinyue.manage.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.UrlPathHelper;

import com.xinyue.authe.AutheManage;

/**
 * 
 * @author apple
 *
 * 2015年5月7日- 下午4:18:40
 * 
 *  a 防止用户直接访问后台
 */
public class AccessibilityInterceptor extends HandlerInterceptorAdapter {

	/**
	 * 判断用户是不是有访问该URL的权限
	 *   如果没有 用户重新登陆
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) {
		try{
			
			//2015/06/18 茅 修改 START
			UrlPathHelper urlPathHelper = new UrlPathHelper();
			String uri = urlPathHelper.getLookupPathForRequest(request);
//			String uri = request.getRequestURI();
			System.err.println(uri);	
			
			if (uri.contains("imgauthcode")) {
				return true;
			}
//			if (uri.indexOf("/imgauthcode")>0)
//				return true;
//			
//			if (uri.indexOf("/images")>=0)
//				return true;
//			
//			if (uri.indexOf(".js")>=0)
//				return true;
//			
//			if (uri.indexOf(".css")>=0)
//				return true;
//			
//			if (uri.indexOf(".map")>=0)
//				return true;
			//2015/06/18 茅 修改 END
			
			if (AutheManage.pageIsPublic(request))
				return true;
			
			int re = AutheManage.chkAuthe(request);
			if (re>0){
				return true;
			}
			else{
				if (re == -1) {
					response.sendRedirect(GlobalConstant.URL_OVERDUE);
				}
				
				return false;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	
	/**
	 * 
	 */
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
//		System.out.println("===========HandlerInterceptor1 postHandle");
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
//		System.out.println("===========HandlerInterceptor1 afterCompletion");
	}
}
