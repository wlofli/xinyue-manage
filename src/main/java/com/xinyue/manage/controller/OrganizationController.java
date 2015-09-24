package com.xinyue.manage.controller;


import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyue.authe.AutheManage;
import com.xinyue.manage.beans.OrganizationInfo;
import com.xinyue.manage.beans.PageData;
import com.xinyue.manage.beans.SelectInfo;
import com.xinyue.manage.model.Organization;
import com.xinyue.manage.model.OrganizationType;
import com.xinyue.manage.model.Select;
import com.xinyue.manage.service.CityService;
import com.xinyue.manage.service.OrganizationService;
import com.xinyue.manage.service.OrganizationTypeService;
import com.xinyue.manage.service.SelectService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;

/**
 * @author wenhai.you
 * @2015年5月16日
 * @下午3:34:50
 */
@Controller
@RequestMapping("/organization")
public class OrganizationController {

	@Autowired
	private OrganizationService orgbiz;
	
	@Resource
	private SelectService sbiz;
	
	/**
	 * ywh 机构禁用
	 * @param req
	 * @param list
	 * @return
	 */
	@RequestMapping(value = "/todisable" , method={ RequestMethod.POST})
	@ResponseBody
	public String disable(HttpServletRequest req ,@RequestBody List<String> list){
		
		boolean b = orgbiz.updateDisable(list , AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
		
	}
	
	/**
	 * ywh 机构启用
	 * @param req
	 * @param list
	 * @return
	 */
	@RequestMapping(value = "/toenable" , method={RequestMethod.POST})
	@ResponseBody
	public String enable(HttpServletRequest req ,@RequestBody List<String> list){
		
		boolean b = orgbiz.updateEnable(list , AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
		
	}
	
	/**
	 * ywh 机构删除
	 * @param req
	 * @param list
	 * @return
	 */
	@RequestMapping(value = "/tomarker" , method={RequestMethod.POST})
	@ResponseBody
	public String marker(HttpServletRequest req ,@RequestBody List<String> list){
		
		boolean b = orgbiz.updateMarker(list , AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
	}
	
	
	/**
	 * ywh 机构和联系人详情
	 * @param req
	 * @param orgid
	 * @param model
	 * @return
	 */
	@RequestMapping("/todetail/{orgid}")
	public String detail(HttpServletRequest req , @PathVariable String orgid , Model model){
		
		Organization org =  orgbiz.findShop(orgid);
		model.addAttribute("org", org);
		return "screens/organization/orgdetail";
	}
	
	
	/**
	 * ywh跳转到机构和联系人编辑界面
	 * @param model
	 * @param orgid
	 * @return
	 */
	@RequestMapping("/toupdate/{orgid}")
	public String orgUpdate(Model model,  @PathVariable String orgid){
		
		//机构和联系人信息
		Organization org = orgbiz.findShop(orgid);
		model.addAttribute("org", org);
		//机构类型
		List<OrganizationType> dicorg = orgbiz.findOrgTypeAll();
		model.addAttribute("orgtype", dicorg);
		//性别
		List<Select> dicsex = sbiz.findSelectByCode("sex");
		model.addAttribute("dic_sex", dicsex);
		//省
		List<SelectInfo> provinces = cityService.getAllProvince();
		model.addAttribute("provinces", provinces);
		return "screens/organization/orgedit";
	}

	
	/**
	 * ywh跳转到机构和联系人添加界面
	 * @param model
	 * @param orgid
	 * @return
	 */
	@RequestMapping("/toaddorg")
	public String orgAdd(Model model ){
	
		//机构和联系人信息
		model.addAttribute("org", new Organization());
		
		//机构类型
		List<OrganizationType> dicorg = orgbiz.findOrgTypeAll();
		model.addAttribute("orgtype", dicorg);
		//性别
		List<Select> dicsex = sbiz.findSelectByCode("sex");
		model.addAttribute("dic_sex", dicsex);
		//省
		List<SelectInfo> provinces = cityService.getAllProvince();
		model.addAttribute("provinces", provinces);
		return "screens/organization/orgadd";
	}
	
	
	/**
	 * ywh 修改机构基本信息和联系人信息
	 * @param orgedit
	 * @param req
	 * @return
	 */
	@RequestMapping("/addorg")
	@ResponseBody
	public String addOrg(@RequestBody String orgedit , HttpServletRequest req) {
		
		try {
			orgbiz.saveOrg(orgedit , AutheManage.getUsername(req));
			return "success";
		} catch (Exception e) {
			// TODO: handle exception
			return "fail";
		}
	}
	
	
	

	
	@RequestMapping("/pinyin")
	public void orgAutoCmp(HttpServletRequest request,HttpServletResponse response){
		String code = request.getParameter("orgcode");
		if (code==null)
			return;
		
		code = code.toUpperCase();
		
		List<Organization> list = null;
		try{
			list = orgbiz.findOrgNameByPinying(code);
		}
		catch(Exception e){
			return;
		}
		if (list==null)
			return;
		
		StringBuilder re = new StringBuilder();
		re.append("[");
		for (int i=0;i<list.size();i++){
			Organization org = list.get(i);
			if (i>0)
				re.append(",");
			re.append("{");
			re.append("\"label\":\"" + org.getName() + "\",");
			re.append("\"value\":\"" + org.getId()+"\"");
			re.append("}");
		}
		re.append("]");
		
		response.setContentType("text/html;charset=utf-8");
		try{
			PrintWriter out = response.getWriter();
			out.print(re.toString());
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	/**
	 * ywh店铺信息显示
	 * @param model
	 * @param orgid
	 * @return
	 */
	@RequestMapping("/shop/{orgid}")
	public String shopshow(Model model,  @PathVariable String orgid){
		model.addAttribute("shop", orgbiz.findShop(orgid));
		//显示图片路径
				model.addAttribute("showpath", orgbiz.SHOW_PATH);
		return "screens/organization/shopset";
	}
	

	
	@Resource
	private OrganizationTypeService otbiz;
	@Resource
	private CityService cityService;
	
	/**
	 * ywh店铺信息修改
	 * @param model
	 * @param orgid
	 * @return
	 */
	@RequestMapping("/shopupdate/{orgid}")
	public String updateshop(Model model,  @PathVariable String orgid){
		//店铺信息
		model.addAttribute("shop", orgbiz.findShop(orgid));
		//店铺规模
		model.addAttribute("org_scale", sbiz.findSelectByCode("org_scale"));
		//机构类型
		model.addAttribute("org_type", otbiz.findTypes());
		//城市分站信息
		model.addAttribute("city", orgbiz.findAll());
		//擅长业务
		model.addAttribute("ptype", orgbiz.findProductTypeByList());
		//省
		List<SelectInfo> provinces = cityService.getAllProvince();
		model.addAttribute("provinces", provinces);
		//显示图片路径
		model.addAttribute("showpath", orgbiz.SHOW_PATH);
		
		return "screens/organization/shopupdate";
	}
	
	/**
	 * ywh店铺内容修改
	 * @param model
	 * @param orgid
	 * @return
	 */
	@RequestMapping("/contentupdate/{orgid}")
	public String updateshopcontent(Model model,  @PathVariable String orgid){
		//店铺信息
		model.addAttribute("shop", orgbiz.findShop(orgid));
		
		return "screens/organization/contentupdate";
	}

	/**
	 * ywy店铺内容显示
	 * @param model
	 * @param orgid
	 * @return
	 */
	@RequestMapping("/shopcontent/{orgid}")
	public String shopcontent(Model model,  @PathVariable String orgid){
		//店铺信息
		model.addAttribute("shop", orgbiz.findShop(orgid));
		
		return "screens/organization/shopcontent";
	}
	/**
	 * ywh修改店铺信息
	 * @param model
	 * @param shop
	 * @param req
	 * @return
	 */
	@RequestMapping(value = "/shopsave" , method={RequestMethod.POST})
	@ResponseBody
	public String shopsave(Model model , Organization shop , HttpServletRequest req){
		
		try {
			orgbiz.saveShop(shop, AutheManage.getUsername(req));
			return "success";
		} catch (Exception e) {
			return "fail";
		}
		
	}
	
	/**
	 * ywh修改店铺内容信息
	 * @param model
	 * @param shop
	 * @param req
	 * @return
	 */
	@RequestMapping(value = "/shopcontentsave" , method={RequestMethod.POST})
	@ResponseBody
	public String shopcontentsave(Model model , Organization shop , HttpServletRequest req){
		boolean b = orgbiz.saveShopcontent(shop, AutheManage.getUsername(req));
		if(b){
			return "success";
		}
		return "fail";
		
	}
	
	/**
	 * ywh检测域名
	 * @param domain
	 * @return
	 */
	@RequestMapping(value="/ckDomain", method={RequestMethod.POST})
	@ResponseBody
	public String checkDomain(@RequestBody String orgid , @RequestBody String domain){
		boolean b = orgbiz.checkDomain(orgid , domain);
		if(b){
			return "success";
		}
		return "fail";
	}
	
	/**
	 * ywh 临时上传图片
	 * @param req
	 * @param suffix
	 * @return
	 */
	@RequestMapping("/upload")
	@ResponseBody
	public String upload(HttpServletRequest req , String suffix){
		
		return orgbiz.upload(suffix, req);
	}
	
	/**
	 * ywh显示机构列表
	 * @param req
	 * @param orgInfo
	 * @param model
	 * @return
	 */
	@RequestMapping("/list")
	public String findPageData(HttpServletRequest req , OrganizationInfo orgInfo , Model model){
		
		//权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.ORGAN_HELP_ADD);
		authList.add(GlobalConstant.ORGAN_HELP_ENABLE);
		authList.add(GlobalConstant.ORGAN_HELP_DISABLE);
		authList.add(GlobalConstant.ORGAN_HELP_DELETE);
		authList.add(GlobalConstant.ORGAN_HELP_UPDATE);
		
		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model,req, authList, "机构管理");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		//显示机构列表
		PageData<Organization> pageData = orgbiz.findPageData(orgInfo);
		model.addAttribute("org_data", pageData);
		//查询条件
		model.addAttribute("orgSearch", orgInfo);
		//机构分类
		List<OrganizationType> dic = orgbiz.findOrgTypeAll();
		model.addAttribute("dic", dic);
		return "screens/organization/orglist";
	}
}
