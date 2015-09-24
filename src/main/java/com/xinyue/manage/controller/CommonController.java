package com.xinyue.manage.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyue.manage.beans.SelectInfo;
import com.xinyue.manage.service.CityService;
import com.xinyue.manage.service.CommonXService;
import com.xinyue.manage.util.GlobalConstant;
import com.xinyue.manage.util.SecurityUtils;

/**
 * 共通控制器
 * @author MK)茅
 * @version v1.0
 * @date 创建时间：2015年9月1日
 */
@Controller
public class CommonController {

	private Logger log = Logger.getLogger(CommonController.class);
	
	@Resource
	private CityService cityService;
	
	@Resource
	private CommonXService commonService;
	
	/**
	 * 检验手机验证码(validate)
	 * @param request
	 * @param checkCode 输入验证码
	 * @return
	 */
	@RequestMapping(value="/common/check/code",method=RequestMethod.POST)
	public @ResponseBody boolean checkTelCode(HttpServletRequest request,String checkCode) {
		
		try {
			String sessionCode = request.getSession().getAttribute(GlobalConstant.SESSION_CHECK_CODE).toString();
			
			//比较(忽略大小写)
			if (checkCode.toLowerCase().equals(sessionCode.toLowerCase())) {
				return true;
			}
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return false;
	}
	
	/**
	 * 市/区下拉列表
	 * @param id
	 * @param type
	 * @return
	 */
	@RequestMapping(value={"/get/cities","/get/zones"})
	public @ResponseBody List<SelectInfo> getCitiesOrZones(String id,String type) {
		
		if (type.equals(GlobalConstant.TYPE_CITY)) {
			List<SelectInfo> cities = cityService.getCitiesByProvinceId(id);
			
			return cities;
		}else if (type.equals(GlobalConstant.TYPE_ZONE)) {
			List<SelectInfo> zones = cityService.getZonesByCityId(id);
			
			return zones;
		}
		return null;
	}
	
	/**
	 * 手机验证码发送
	 * @param phone
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/send/tel/code",method=RequestMethod.POST)
	public @ResponseBody String sendCode(String phone,HttpServletRequest request) {
		
		String code = SecurityUtils.randomStr(4);
		
		boolean result = commonService.sendCode(phone,code);
		
		if (result) {
			log.info("验证码发送成功---手机号："+phone+"；验证码："+code);
			request.getSession().setAttribute(GlobalConstant.SESSION_CHECK_CODE, code);
			return "true";
		}else {
			log.info("验证码发送失败!!!---手机号："+phone+"；验证码："+code);
			return "false";
		}
		
	}
}
