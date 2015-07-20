package com.xinyue.manage.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyue.authe.AutheManage;
import com.xinyue.manage.beans.PageData;
import com.xinyue.manage.model.OrganizationType;
import com.xinyue.manage.service.OrganizationTypeService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;

/**
 * 
 * @author wenhai.you
 * @2015年6月2日
 * @下午4:58:18
 */
@Controller
@RequestMapping("/organizationType")
public class OrganizationTypeController {

	@Autowired
	private OrganizationTypeService otbiz;
	
	
	@RequestMapping("/list")
	public String findListPage(HttpServletRequest req , Model model){

		//权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.ORGAN_TYPE_HELP_ADD);
		authList.add(GlobalConstant.ORGAN_TYPE_HELP_DELETE);
		authList.add(GlobalConstant.ORGAN_TYPE_HELP_UPDATE);
		
		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model,req, authList, "机构分类");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		int count = otbiz.getCount();
		String topage = req.getParameter("topage");
		int currentPage = GlobalConstant.isNull(topage) || topage == "0"?1:Integer.valueOf(topage);
		
		List<OrganizationType> list = otbiz.findListPage((currentPage-1)*GlobalConstant.PAGE_SIZE , GlobalConstant.PAGE_SIZE);
		PageData<OrganizationType> pd = new PageData<OrganizationType>(list, count, currentPage);
		model.addAttribute("pagedata", pd);
		return "screens/organization/orgtypelist";
	}
	
	@RequestMapping(value="/save" , method=RequestMethod.POST)
	@ResponseBody
	public String addOrganizationType(OrganizationType otype, HttpServletRequest req){
		
		boolean b = otbiz.saveOrganizationType(otype,AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
	}
	
	@RequestMapping(value={"/add" , "/update"})
	public String editOrganizationType(String otypeid , Model model){
		OrganizationType type = null;
		if(GlobalConstant.isNull(otypeid)){
			type = new OrganizationType();
		}else{
			type = otbiz.findTypeById(otypeid);
		}
		model.addAttribute("otype", type);
		return "screens/organization/orgtypeedit";
	}
	
	@RequestMapping(value="/del" , method=RequestMethod.POST)
	@ResponseBody
	public String delOrganizationType(@RequestBody List<String> id , HttpServletRequest req){
		
		try {
			otbiz.delOrganizationType(id ,  AutheManage.getUsername(req));
			return "success";
		} catch (Exception e) {
			// TODO: handle exception
			return "fail";
		}
	}
	
}
