/*
 * 杭州摩科商用设备有限公司
 * MOKO-Commercial Device Co.,Ltd
 * 
 * 新越网
 * 
 * 创建人：茅
 * 
 * 日期：2015/04/07
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

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyue.manage.beans.CityInfo;
import com.xinyue.manage.beans.PageInfo;
import com.xinyue.manage.beans.SearchCity;
import com.xinyue.manage.beans.SelectInfo;
import com.xinyue.manage.model.SubStation;
import com.xinyue.manage.service.CityService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;

@Controller
@RequestMapping("/city")
public class CitySettingController {

	//当前用户
//	private static String USER = "";
		
	@Resource
	private CityService cityService;
	
	CommonFunction cf = new CommonFunction();
		
	@RequestMapping("/list")
	public String cityList(HttpServletRequest request,Model model,int index) {
		
		// 当前用户取得
//		USER = AutheManage.getUsername(request);
		
		if (!this.checkAuth(model, request)) {
			return "redirect:/errors/fail_authority.html";
		}

		List<CityInfo> cityInfo = cityService.getCityInfoByIndex(index*10);
		
		//城市分站
		model.addAttribute("searchCityInfo", new SearchCity());
		
		//省下拉表获得
		List<SelectInfo> provinces = cityService.getAllProvince();
		model.addAttribute("provinces", provinces);
		
		model.addAttribute("cityList", cityInfo);
		
		PageInfo pageInfo = new PageInfo();
		
		int total = cityService.getCount();

		pageInfo = cf.pageList(total, index+1);
		
		model.addAttribute("page", pageInfo);
		
		return "screens/city/citySetting";
	}
	
	@RequestMapping(value={"/search"},method=RequestMethod.POST)
	public String searchCities(HttpServletRequest request,Model model,SearchCity searchCity) {
		
		//获取权限
		if (!this.checkAuth(model, request)) {
			return "redirect:/errors/fail_authority.html";
		}
		
		List<CityInfo> cityInfo = cityService.getCityInfoBySearchConditions(searchCity);
		
		searchCity.setSearchCityHid(searchCity.getSearchCity());
		searchCity.setSearchZoneHid(searchCity.getSearchZone());
		model.addAttribute("searchCityInfo", searchCity);
		model.addAttribute("cityList", cityInfo);
		
		//省下拉表获得
		List<SelectInfo> provinces = cityService.getAllProvince();
		model.addAttribute("provinces", provinces);
		
		//分页
		PageInfo pageInfo = new PageInfo();
		int total = cityService.getCountBySearchConditions(searchCity);
		
		int index = searchCity.getSearchPage();
		
		pageInfo = cf.pageList(total, index+1);

		model.addAttribute("page", pageInfo);
		
		return "screens/city/citySetting";
	}
	
	@RequestMapping(value={"/add","/edit"},method=RequestMethod.POST)
	public @ResponseBody String addOrUpdateSubCity(HttpServletRequest request,SubStation subStationInfo) {
		
		boolean retFlag = cityService.addOrUpdateSubStationInfo(
				subStationInfo,
				request.getSession()
						.getAttribute(GlobalConstant.SESSION_USER_NAME)
						.toString());
		
		if (retFlag) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	@RequestMapping("/pulldown")
	public @ResponseBody List<SelectInfo> getPullDown(String id,String type) {
		
		if (type.equals(GlobalConstant.TYPE_CITY)) {
			List<SelectInfo> cities = cityService.getCitiesByProvinceId(id);
			
			return cities;
		}else if (type.equals(GlobalConstant.TYPE_ZONE)) {
			List<SelectInfo> zones = cityService.getZonesByCityId(id);
			
			return zones;
		}
		
		return null;
	}
	
	@RequestMapping("/delete/substation")
	public @ResponseBody String delSubStation(String code) {
		
		if (cityService.deleteSubStation(code)) {
			return "success";
		}else {
			return "fail";
		}
		
	}
	
	@RequestMapping(value={"/addpage","/updatepage"})
	public String goAddOrUpdatePage(Model model,String stationCode) {
		
		SubStation subStation = new SubStation();
		
		List<SelectInfo> provinces = cityService.getAllProvince();
		model.addAttribute("provinces", provinces);
		
		if (!stationCode.equals("")) {
			subStation = cityService.selectSubStation(stationCode);
		}
		model.addAttribute("subStationInfo", subStation);
		return "/screens/city/cityEdit";
	}
	
	/**
	 * 权限取得
	 * @param model
	 * @param request
	 * @return
	 */
	private boolean checkAuth(Model model,HttpServletRequest request){
		// 权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.AUTHORITY_CITY_ADD);
		authList.add(GlobalConstant.AUTHORITY_CITY_UPDATE);
		authList.add(GlobalConstant.AUTHORITY_CITY_DELETE);

		boolean ret_auth = cf.getAuth(model, request, authList, "城市分站");
		return ret_auth;

	}
}
