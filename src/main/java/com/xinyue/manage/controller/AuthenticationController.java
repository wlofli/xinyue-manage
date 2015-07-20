/*
 * 杭州摩科商用设备有限公司
 * MOKO-Commercial Device Co.,Ltd
 * 
 * 新越网
 * 
 * 创建人：茅
 * 
 * 日期：2015/05/06
 * 
 * 版本v1.0.0
 * 
 * bug修改:
 * 
 * 
 */
package com.xinyue.manage.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyue.authe.AutheManage;
import com.xinyue.manage.beans.PageInfo;
import com.xinyue.manage.beans.SearchAuthentication;
import com.xinyue.manage.beans.SelectInfo;
import com.xinyue.manage.model.Authentication;
import com.xinyue.manage.service.AuthenticationService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;

@Controller
@RequestMapping("/authentication")
public class AuthenticationController {

	@Resource
	AuthenticationService authenticationService;
	
	//当前用户
	private static String USER = "admin";
	
	private Logger log = Logger.getLogger(AuthenticationController.class);
	
	@RequestMapping(value={"/list","/search"})
	public String getList(HttpServletRequest request,Model model,SearchAuthentication searchAuthentication,int index) {
		
		// 当前用户取得
		USER = AutheManage.getUsername(request);

		// 权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.AUTHORITY_AUTHENTICATION_EXPORT);
		authList.add(GlobalConstant.AUTHORITY_AUTHENTICATION_DETAIL);

		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model, request, authList, "企业实名认证");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		
		//行业取得
		List<SelectInfo> industryList = authenticationService.getIndustryList();
		model.addAttribute("industryList",industryList);
		
		//列表
		List<Authentication> info = authenticationService.getAuthenticationInfo(searchAuthentication,index*10);
		model.addAttribute("authenticationList", info);
		//搜索框数据
		model.addAttribute("searchInfo", searchAuthentication);
		
		//分页信息
		int totalCount = authenticationService.getAllCount();

		PageInfo pageInfo = new PageInfo();
		
		pageInfo = cf.pageList(totalCount, index+1);
		
		model.addAttribute("page", pageInfo);
		
		return "screens/authentication/authentication";
	}
	
	@RequestMapping("/detail")
	public String goDetail(Model model,String code) {
		
		//详细信息取得
		Authentication authentication = authenticationService.getDetailByCode(code);
		model.addAttribute("detailInfo", authentication);
		
		return "screens/authentication/authenticationDetail";
	}
	
	@RequestMapping(value={"/update/status"},method=RequestMethod.POST)
	public @ResponseBody String sendMessages(Authentication authentication) {
		String ret = GlobalConstant.RET_FAIL;
		
		if (authenticationService.updateAuthenticationStatusByCode(authentication,USER)) {
			ret = GlobalConstant.RET_SUCCESS;
		}
		return ret;
	}
	
	@RequestMapping("/export")
	public void exportData(SearchAuthentication searchAuthentication,HttpServletResponse response) {
		
		try {
			//取得数据
			List<Authentication> info = authenticationService.getAuthenticationInfo(searchAuthentication,-99);
						
			authenticationService.exportData(response,info);

		} catch (Exception e) {
			log.debug(e.getMessage());
			log.error("企业实名认证信息导出错误："+e);
		}
	}
}
