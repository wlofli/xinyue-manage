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
import com.xinyue.manage.beans.OrgEditInfo;
import com.xinyue.manage.beans.OrganizationInfo;
import com.xinyue.manage.beans.PageData;
import com.xinyue.manage.model.Organization;
import com.xinyue.manage.model.Select;
import com.xinyue.manage.service.OrganizationService;
import com.xinyue.manage.service.SelectService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;

/**
 * 
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
		int total = orgbiz.getOrganizationCount(orgInfo);
		String topage = orgInfo.getTopage();
		int currentPage = (GlobalConstant.isNull(topage) || topage == "0")?1:Integer.valueOf(topage);
		orgInfo.setStart((currentPage-1)*GlobalConstant.PAGE_SIZE);
		List<Organization> list =  orgbiz.findPageData(orgInfo);
		PageData<Organization> pageData = new PageData<Organization>(list, total, currentPage);
		
		List<Select> dic = sbiz.getOrgList();
		model.addAttribute("org_data", pageData);
		model.addAttribute("orgSearch", orgInfo);
		model.addAttribute("dic", dic);
		return "screens/organization/orglist";
	}
	
	@RequestMapping(value = "/todisable" , method={ RequestMethod.POST})
	@ResponseBody
	public String disable(HttpServletRequest req ,@RequestBody List<String> list){
		
		boolean b = orgbiz.updateDisable(list , AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
		
	}
	
	@RequestMapping(value = "/toenable" , method={RequestMethod.POST})
	@ResponseBody
	public String enable(HttpServletRequest req ,@RequestBody List<String> list){
		
		boolean b = orgbiz.updateEnable(list , AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
		
	}
	
	@RequestMapping(value = "/tomarker" , method={RequestMethod.POST})
	@ResponseBody
	public String marker(HttpServletRequest req ,@RequestBody List<String> list){
		
		boolean b = orgbiz.updateMarker(list , AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
	}
	
	@RequestMapping("/todetail/{number}")
	public String detail(HttpServletRequest req , @PathVariable String number , Model model){
		
		List<Organization> list =  orgbiz.findListByNumber(number);
		model.addAttribute("org_detail", list);
		return "screens/organization/orgdetail";
	}
	
	

	@RequestMapping("/toaddorg")
	public String orgAdd(Model model ){
		//List<Organization> orgList = new LinkedList<Organization>();
		model.addAttribute("orgList", new OrgEditInfo());
		//model.addAttribute("orgList", orgList);
		
		List<Select> dicorg = sbiz.getOrgList();
		model.addAttribute("dic_org", dicorg);
		List<Select> dicsex = sbiz.findSelectByCode("sex");
		model.addAttribute("dic_sex", dicsex);
		return "screens/organization/orgadd";
	}
	
	@RequestMapping("/addorg")
	@ResponseBody
	public String addOrg(@RequestBody String orgedit , HttpServletRequest req) {
		
		boolean b = orgbiz.saveOrganization(orgedit , AutheManage.getUsername(req));
		if(b){
			return "success";
		}
		return "fail";
	}
	
	
	@RequestMapping("/toupdate/{orgNumber}")
	public String orgUpdate(Model model,  @PathVariable String orgNumber){
		//List<Organization> orgList = new LinkedList<Organization>();
		List<Organization> list = orgbiz.editListByNumber(orgNumber);
		OrgEditInfo editinfo = new OrgEditInfo();
		editinfo.setOrgedit(list);
		model.addAttribute("orgList", editinfo);
		//model.addAttribute("orgList", orgList);
		
		List<Select> dicorg = sbiz.getOrgList();
		model.addAttribute("dic_org", dicorg);
		List<Select> dicsex = sbiz.findSelectByCode("sex");
		model.addAttribute("dic_sex", dicsex);
		return "screens/organization/orgedit";
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

}
