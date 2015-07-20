/*
 * 杭州摩科商用设备有限公司
 * MOKO-Commercial Device Co.,Ltd
 * 
 * 新越网
 * 
 * 创建人：goto
 * 
 * 日期：2015/04/27
 * 
 * 版本v1.0.0
 * 
 * bug修改:
 * 
 * 
 */
package com.xinyue.manage.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.event.MenuListener;
import javax.xml.stream.events.StartDocument;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.druid.sql.dialect.oracle.ast.stmt.OracleIfStatement.Else;
import com.xinyue.authe.AutheManage;
import com.xinyue.authe.AutheMapper;
import com.xinyue.authe.UserInfo;
import com.xinyue.authe.util.ImageAuthcode;
import com.xinyue.manage.model.AdminInfo;


@Controller
public class AutheController {
		
	@RequestMapping("/authe/imgauthcode")
	public void ImageAuthcode(HttpServletRequest request,HttpServletResponse response){
		try{
		//	UserInfo userInfo  = new UserInfo();
		//	userInfo.addUser(request);
			ImageAuthcode.authCode(request, response);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/authe/menulist")
	public void MenuList(HttpServletRequest request,HttpServletResponse response){
		String reStr = AutheManage.getMenuJson(request);
		response.setContentType("text/html;charset=utf-8");
		try{
			PrintWriter out = response.getWriter();
			out.print(reStr);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/authe/adminlist")
	public String adminList(HttpServletRequest request){
		int re  = AutheManage.chkAuthe(request);
		if (re<=0)
			return "screens/login";
		return "screens/authe/set_power";
	}
	 
	@RequestMapping("/authe/adminadd")
	public String addAdmin(){
		return "screens/authe/add_admin";
	}

	/**
	 * 添加管理员
	 * @param request
	 * @param response
	 */
	@RequestMapping("/authe/useradd")
	public void userAdd(HttpServletRequest request,HttpServletResponse response){
		UserInfo userInfo = new UserInfo();
		String result = "ok";
		try{
			try{
				boolean re = userInfo.addUser(request);
			}
			catch(Exception e){
				result = e.getMessage();
			}
			
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().print(result);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/**
	 * 删除管理员
	 * @param id
	 * @param response
	 */
	@RequestMapping("/authe/deladmin")
	public void deladmin(int id,HttpServletResponse response){
		try{
			SqlSessionFactory sessionFactory =   AutheManage.getSqlSession();
			SqlSession session = sessionFactory.openSession();
			AutheMapper mapper = session.getMapper(AutheMapper.class);
			int re = mapper.deladmin(id);
			session.close();
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			if (re>0)
				out.print("{\"result\":\"true\"}");
			else
				out.print("{\"result\":\"false\"}");
		}
		catch(Exception e){
			
		}
	}
	
	/**
	 * 获取管理员列表数据
	 * @param request
	 * @param response
	 */
	@RequestMapping("/authe/adminlistjson")
	public void adminGrid(HttpServletRequest request,HttpServletResponse response){
		int page =1;
		try{
			page = Integer.parseInt(request.getParameter("page"));
		}
		catch(Exception e){
		}
		
		int rows = 10;
		try{
			rows = Integer.parseInt(request.getParameter("rows"));
		}
		catch(Exception e){
			rows = 10;
		}
		
		int start = (page-1)*rows;
		int end = page*rows;
		int totalCount = 0;
		
		StringBuilder sBuilder = new StringBuilder();
		
		try{
			SqlSessionFactory sessionFactory =   AutheManage.getSqlSession();
			SqlSession session = sessionFactory.openSession();
			AutheMapper mapper = session.getMapper(AutheMapper.class);
			List<AdminInfo> list = mapper.getAdminInfos(start, end);
			session.close(); 
			sBuilder.append("[\r\n");
			for (int i=0;i<list.size();i++){
				
				if (i>0)
					sBuilder.append(",");
			
				AdminInfo aInfo = list.get(i);
				if (i==0){
					totalCount = aInfo.getTotalCount();
				}
				sBuilder.append("{\r\n");
				sBuilder.append("\"id\":\""+aInfo.getId() +"\",");
				sBuilder.append("\"cell\":[");
				sBuilder.append("\"" +(start + i+1)+ "\",");
				sBuilder.append("\""+aInfo.getUsername()+"\",");
				sBuilder.append("\""+aInfo.getName()+"\",");
				sBuilder.append("\""+aInfo.getPhone()+"\",");
				sBuilder.append("\""+aInfo.getOrgcode()+"\",");
				sBuilder.append("\""+aInfo.getOrgname()+"\",");
				if (aInfo.getStatus()==0){
					sBuilder.append("\"正常\"");
				}
				else if(aInfo.getStatus()==1){
					sBuilder.append("\"关闭\"");
				}
				else{
					sBuilder.append("\"已删除\"");
				}
				sBuilder.append("]");
				sBuilder.append("}\r\n");
			}
			sBuilder.append("]\r\n");
			int total = totalCount % rows == 0 ? totalCount / rows : totalCount / rows + 1;
			
			String pageTotal = "{\"page\":\""+page+"\",\"total\":\"" + total +"\",\"records\":\""+rows+"\",\"rows\":";
			sBuilder.insert(0, pageTotal);
			String pageEnd = ",\"userdata\":{}\r\n}";
			sBuilder.append(pageEnd);
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(sBuilder.toString());
		}
		catch(Exception e){
			
		}	
	}
	
	/**
	 * 修改管理员信息
	 * @param id
	 * @param name
	 * @param phone
	 * @param position
	 * @param status
	 * @param gid
	 * @param response
	 */
	@RequestMapping("/authe/admininfoupdate")
	public void admininfoupdate(int id,String name,String phone,String position,int status,String gid,HttpServletResponse response){
		String re = "";
		if (phone==null)
			phone = "";
		
		if (position==null)
			position = "";
		
		boolean result = true;
		try{
			SqlSessionFactory sessionFactory =   AutheManage.getSqlSession();
			SqlSession session = sessionFactory.openSession();
			AutheMapper mapper = session.getMapper(AutheMapper.class);
			int sl = mapper.updateUserInfo(id, name, phone,status,gid);
			if (sl<=0){
				session.rollback();
				session.close();
				result = false;
			}
			if (result){
				sl = mapper.updatePosition(id, position);
				session.close();
			}
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			if (result)
				out.print("{\"result\":\"true\"}");
			else
				out.print("{\"result\":\"false\"}");
		}
		catch(Exception e){
			
		}
	}
	
	/**
	 * 通过id获取管理员详细信息
	 * @param request
	 * @param response
	 */
	@RequestMapping("/authe/admininfobyid")
	public void adminInfo(int id,HttpServletResponse response){
		StringBuilder sBuilder = new StringBuilder();
		
		try{
			SqlSessionFactory sessionFactory =   AutheManage.getSqlSession();
			SqlSession session = sessionFactory.openSession();
			AutheMapper mapper = session.getMapper(AutheMapper.class);
			AdminInfo aInfo = mapper.getAdminInfo(id);
			session.close(); 
			if (aInfo!=null){
				sBuilder.append("{");
				sBuilder.append("\"username\":\""+aInfo.getUsername()+"\",");
				sBuilder.append("\"name\":\""+aInfo.getName()+"\",");
				sBuilder.append("\"phone\":\"" + aInfo.getPhone()+"\",");
				sBuilder.append("\"position\":\""+aInfo.getPosition()+"\",");
				sBuilder.append("\"orgname\":\"" + aInfo.getOrgname()+"\",");
				sBuilder.append("\"groupid\":\""+aInfo.getGroupid()+"\",");
				sBuilder.append("\"status\":\""+aInfo.getStatus()+"\"");
				sBuilder.append("}");
			}
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(sBuilder.toString());
		}catch(Exception e){
			
		}
	}
}
