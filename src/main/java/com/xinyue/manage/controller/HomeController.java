package com.xinyue.manage.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.xinyue.authe.AutheManage;
import com.xinyue.manage.model.User;
import com.xinyue.manage.util.GlobalConstant;

@Controller
@SessionAttributes(GlobalConstant.USER_LOGIN)
public class HomeController {
		
	/**
	 * 跳转到登录界面，在模型中添加User对象，让登录界面中值能够注入
	 * @return
	 */
	@RequestMapping({"/","/index","index.jsp","index.html"})
	public ModelAndView welcome() {
		ModelAndView maView = new ModelAndView("screens/login");
		maView.addObject(GlobalConstant.USER_LOGIN, new User());
		return maView;
	}
	
	@RequestMapping("/changepsw")
	public String chanagePassword() {
		return "screens/changePsw";
	}
	
	@RequestMapping("/updatepsw")
	public String updatePassword(HttpServletRequest request) {
		String errMsg = "";
		try{
			AutheManage.changePwd(request);
		}
		catch(Exception e){
			errMsg = e.getMessage();
		}
		
		if (errMsg.equals("")){
			errMsg = "密码修改成功";
		}
		
		request.setAttribute("errmsg", errMsg);
		return "screens/changePsw";
	}
	
	@RequestMapping("/head")
	public String head(HttpServletRequest request) {
		String username = AutheManage.getUsername(request);
		String logintime = AutheManage.getLoginTime(request);
		request.setAttribute("username", username);
		request.setAttribute("logintime", logintime);
		return "commons/head";
	}
	
	@RequestMapping("/foot")
	public String foot() {
		return "commons/foot";
	}
	
	@RequestMapping("/welcome")
	public String welcomePage() {
		return "screens/welcome";
	}
	
	@RequestMapping("/login")
	public String login(HttpServletRequest request,HttpServletResponse response) {
/*
		setUser("admin");
		//用户名和密码不能同时为空
		if ((user.getName()==null || user.getName()=="") 
				&& (user.getPassword()==null || user.getPassword()=="")) {
			return "redirect:/";
		}
		//如果用户不存在系统中则返回登录界面
		if (!isExist(session,user)) {
			return "redirect:/";
		}
		User u =(User) session.getAttribute(GlobalConstant.USER_LOGIN);
		logger.info("**********************************************" + u.getName());*/
		
		//设置菜单,并将菜单信息放置到bean中去
		boolean re = false;
		try{
			re = AutheManage.login(request, response);
		}
		catch(Exception e){
			request.setAttribute("errmsg", e.getMessage());
			return "screens/login";
		}
//		HttpSession session = request.getSession();
//		
//		
//		HashMap<String, int[]> leftMenu = new HashMap<>();
//
//		leftMenu.clear();
//		String rootMenu = "";
//		int[] leafMenu = null;
//		
//		for (int i = 0; i < 11; i++) {
//			switch (i) {
//			case 0:
//				rootMenu = "a";
//				leafMenu = new int[]{1,1};
//				break;
//			case 1:
//				rootMenu = "b";
//				leafMenu = new int[8];
//				for (int j = 0; j < leafMenu.length; j++) {
//					leafMenu[j] = 1;
//				}
//				break;
//			case 2:
//				rootMenu = "c";
//				leafMenu = new int[]{1};
//				break;
//			case 3:
//				rootMenu = "d";
//				leafMenu = new int[]{1};
//				break;
//			case 4:
//				rootMenu = "e";
//				leafMenu = new int[]{1,1};
//				break;
//			case 5:
//				rootMenu = "f";
//				leafMenu = new int[]{1};
//				break;
//			case 6:
//				rootMenu = "g";
//				leafMenu = new int[]{1};
//				break;
//			case 7:
//				rootMenu = "h";
//				leafMenu = new int[]{1};
//				break;
//			case 8:
//				rootMenu = "i";
//				leafMenu = new int[]{1,1};
//				break;
//			case 9:
//				rootMenu = "j";
//				leafMenu = new int[]{1};
//				break;
//			case 10:
//				rootMenu = "k";
//				leafMenu = new int[]{1};
//				break;
//			default:
//				break;
//			}
//			leftMenu.put(rootMenu, leafMenu);
//		}
//		
//		session.setAttribute("leftMenu", leftMenu);
//		model.addAttribute("leftMenu", leftMenu);
		
		return "screens/main";
	}
	


	@RequestMapping(value="/logout",method=RequestMethod.GET)
	public String logout(HttpServletRequest request,HttpServletResponse response) {
		AutheManage.loginOut(request, response);
		return "commons/logout";
	}

	/**
	 * @return the user
	 */
//	public static String getUser() {
//		return user;
//	}

	/**
	 * @param user the user to set
	 */
//	public static void setUser(String user) {
//		HomeController.user = user;
//	}
 }
