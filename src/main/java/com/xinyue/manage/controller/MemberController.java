package com.xinyue.manage.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyue.authe.AutheManage;
import com.xinyue.manage.beans.MemberInfo;
import com.xinyue.manage.beans.PageData;
import com.xinyue.manage.beans.SelectInfo;
import com.xinyue.manage.model.Member;
import com.xinyue.manage.service.CityService;
import com.xinyue.manage.service.MemberService;
import com.xinyue.manage.service.SelectService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;

/**
 * 
 * @author wenhai.you
 * @2015年6月9日
 * @下午4:36:39
 */
@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService mbiz;
	
	@Autowired
	private SelectService sbiz;
	
	
	@RequestMapping("/list")
	public String findPageList(HttpServletRequest req , Model model , MemberInfo memberinfo){
		//权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.MEMBER_HELP_ADD);
		authList.add(GlobalConstant.MEMBER_HELP_IMPORT);
		authList.add(GlobalConstant.MEMBER_HELP_ENABLE);
		authList.add(GlobalConstant.MEMBER_HELP_DISABLE);
		authList.add(GlobalConstant.MEMBER_HELP_DELETE);
		authList.add(GlobalConstant.MEMBER_HELP_UPDATE);
		
		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model,req, authList, "会员管理");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		int total = mbiz.getCount(memberinfo);
		String topage = memberinfo.getTopage();
		
		int currentPage = (GlobalConstant.isNull(topage) || topage.equals("0"))?1:Integer.valueOf(topage);
		memberinfo.setStart((currentPage-1)*GlobalConstant.PAGE_SIZE);
		List<Member> list = mbiz.findPageList(memberinfo);
		PageData<Member> pdata = new PageData<Member>(list , total , currentPage);
		model.addAttribute("memberinfo", memberinfo);
		model.addAttribute("memberpage", pdata);
		model.addAttribute("industry", sbiz.getIndustryList());
		return "screens/member/member";
	}
	
	@RequestMapping(value="/updateEnable" , method=RequestMethod.POST)
	@ResponseBody
	public String enabled(@RequestBody List<String> list , HttpServletRequest req){
		
		boolean b = mbiz.updateEnabled(list ,  AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
	}
	
	@RequestMapping(value="/updateDisable" , method=RequestMethod.POST)
	@ResponseBody
	public String disabled(@RequestBody List<String> list , HttpServletRequest req){
		
		boolean b = mbiz.updateDisabled(list,  AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
	}
	
	
	@RequestMapping(value="/delMember" , method=RequestMethod.POST)
	@ResponseBody
	public String delmember(@RequestBody List<String> list , HttpServletRequest req){
		
		boolean b  = mbiz.delMember(list,  AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
	} 
	@Autowired
	private CityService cityService;
	@RequestMapping(value="/edit")
	public String edit(HttpServletRequest req , Model model){
		List<SelectInfo> provinces = cityService.getAllProvince();
		model.addAttribute("provinces", provinces);
		
		String id = req.getParameter("editid");
		if(GlobalConstant.isNull(id)){
			String type = req.getParameter("typeid");
			Member member = new Member();
			if(GlobalConstant.isNull(type)){
				member.setMemberid("2");
			}else{
				member.setMemberid(type);
			}
			model.addAttribute("memberedit", member);
		}else{
			Member member = mbiz.editMember(id);
			model.addAttribute("memberedit", member);
		}
		
		return "screens/member/editmember";
	}
	
	@RequestMapping(value="/save" , method=RequestMethod.POST)
	@ResponseBody
	public String save(Member memberedit , HttpServletRequest req){
		
		boolean b = mbiz.saveMember(memberedit,  AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
	}
	/*-------------------------------------------------------------*/
	@RequestMapping("/xlist")
	public String findXinYue(HttpServletRequest req , Model model , MemberInfo memberinfo){
		//权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.MEMBER_HELP_ADD);
		authList.add(GlobalConstant.MEMBER_HELP_IMPORT);
		authList.add(GlobalConstant.MEMBER_HELP_ENABLE);
		authList.add(GlobalConstant.MEMBER_HELP_DISABLE);
		authList.add(GlobalConstant.MEMBER_HELP_DELETE);
		authList.add(GlobalConstant.MEMBER_HELP_UPDATE);
		
		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model,req, authList, "会员管理");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		int total = mbiz.getXinYueCount(memberinfo);
		String topage = memberinfo.getTopage();
		
		int currentPage = (GlobalConstant.isNull(topage) || topage.equals("0"))?1:Integer.valueOf(topage);
		memberinfo.setStart((currentPage-1)*GlobalConstant.PAGE_SIZE);
		List<Member> list = mbiz.findXinYuePage(memberinfo);
		PageData<Member> pdata = new PageData<Member>(list , total , currentPage);
		memberinfo.setType("2");
		model.addAttribute("memberinfo", memberinfo);
		model.addAttribute("memberpage", pdata);
		model.addAttribute("industry", sbiz.getIndustryList());
		return "screens/member/member";
	}
	
	@RequestMapping("/qlist")
	public String findQQ(HttpServletRequest req , Model model , MemberInfo memberinfo){
		//权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.MEMBER_HELP_ADD);
		authList.add(GlobalConstant.MEMBER_HELP_IMPORT);
		authList.add(GlobalConstant.MEMBER_HELP_ENABLE);
		authList.add(GlobalConstant.MEMBER_HELP_DISABLE);
		authList.add(GlobalConstant.MEMBER_HELP_DELETE);
		authList.add(GlobalConstant.MEMBER_HELP_UPDATE);
		
		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model,req, authList, "会员管理");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}		
		int total = mbiz.getQQCount(memberinfo);
		String topage = memberinfo.getTopage();
		
		int currentPage = (GlobalConstant.isNull(topage) || topage.equals("0"))?1:Integer.valueOf(topage);
		memberinfo.setStart((currentPage-1)*GlobalConstant.PAGE_SIZE);
		List<Member> list = mbiz.findQQPage(memberinfo);
		PageData<Member> pdata = new PageData<Member>(list , total , currentPage);
		memberinfo.setType("1");
		model.addAttribute("memberinfo", memberinfo);
		model.addAttribute("memberpage", pdata);
		model.addAttribute("industry", sbiz.getIndustryList());
		return "screens/member/member";
	}
	
	@RequestMapping("/wxlist")
	public String findWeixin(HttpServletRequest req , Model model , MemberInfo memberinfo){
		//权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.MEMBER_HELP_ADD);
		authList.add(GlobalConstant.MEMBER_HELP_IMPORT);
		authList.add(GlobalConstant.MEMBER_HELP_ENABLE);
		authList.add(GlobalConstant.MEMBER_HELP_DISABLE);
		authList.add(GlobalConstant.MEMBER_HELP_DELETE);
		authList.add(GlobalConstant.MEMBER_HELP_UPDATE);
		
		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model,req, authList, "会员管理");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		int total = mbiz.getWeixinCount(memberinfo);
		String topage = memberinfo.getTopage();
		
		int currentPage = (GlobalConstant.isNull(topage) || topage.equals("0"))?1:Integer.valueOf(topage);
		memberinfo.setStart((currentPage-1)*GlobalConstant.PAGE_SIZE);
		List<Member> list = mbiz.findWeixinPage(memberinfo);
		PageData<Member> pdata = new PageData<Member>(list , total , currentPage);
		memberinfo.setType("3");
		model.addAttribute("memberinfo", memberinfo);
		model.addAttribute("memberpage", pdata);
		model.addAttribute("industry", sbiz.getIndustryList());
		return "screens/member/member";
	}
	
	/*------------------------------*/
	@RequestMapping("/glist")
	public String findGuo(HttpServletRequest req , Model model , MemberInfo memberinfo){
		//权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.MEMBER_HELP_ADD);
		authList.add(GlobalConstant.MEMBER_HELP_IMPORT);
		authList.add(GlobalConstant.MEMBER_HELP_ENABLE);
		authList.add(GlobalConstant.MEMBER_HELP_DISABLE);
		authList.add(GlobalConstant.MEMBER_HELP_DELETE);
		authList.add(GlobalConstant.MEMBER_HELP_UPDATE);
		
		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model,req, authList, "会员管理");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		int total = mbiz.getGuoCount(memberinfo);
		String topage = memberinfo.getTopage();
		
		int currentPage = (GlobalConstant.isNull(topage) || topage.equals("0"))?1:Integer.valueOf(topage);
		memberinfo.setStart((currentPage-1)*GlobalConstant.PAGE_SIZE);
		List<Member> list = mbiz.findGuoPage(memberinfo);
		PageData<Member> pdata = new PageData<Member>(list , total , currentPage);
		memberinfo.setType("7");
		model.addAttribute("memberinfo", memberinfo);
		model.addAttribute("memberpage", pdata);
		model.addAttribute("industry", sbiz.getIndustryList());
		return "screens/member/member";
	}
	@RequestMapping("/wblist")
	public String findWeibo(HttpServletRequest req , Model model , MemberInfo memberinfo){
		//权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.MEMBER_HELP_ADD);
		authList.add(GlobalConstant.MEMBER_HELP_IMPORT);
		authList.add(GlobalConstant.MEMBER_HELP_ENABLE);
		authList.add(GlobalConstant.MEMBER_HELP_DISABLE);
		authList.add(GlobalConstant.MEMBER_HELP_DELETE);
		authList.add(GlobalConstant.MEMBER_HELP_UPDATE);
		
		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model,req, authList, "会员管理");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		int total = mbiz.getWeiboCount(memberinfo);
		String topage = memberinfo.getTopage();
		
		int currentPage = (GlobalConstant.isNull(topage) || topage.equals("0"))?1:Integer.valueOf(topage);
		memberinfo.setStart((currentPage-1)*GlobalConstant.PAGE_SIZE);
		List<Member> list = mbiz.findWeiboPage(memberinfo);
		PageData<Member> pdata = new PageData<Member>(list , total , currentPage);
		memberinfo.setType("4");
		model.addAttribute("memberinfo", memberinfo);
		model.addAttribute("memberpage", pdata);
		model.addAttribute("industry", sbiz.getIndustryList());
		return "screens/member/member";
	}
	@RequestMapping("/slist")
	public String findSuiwu(HttpServletRequest req , Model model , MemberInfo memberinfo){
		//权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.MEMBER_HELP_ADD);
		authList.add(GlobalConstant.MEMBER_HELP_IMPORT);
		authList.add(GlobalConstant.MEMBER_HELP_ENABLE);
		authList.add(GlobalConstant.MEMBER_HELP_DISABLE);
		authList.add(GlobalConstant.MEMBER_HELP_DELETE);
		authList.add(GlobalConstant.MEMBER_HELP_UPDATE);
		
		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model,req, authList, "会员管理");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		int total = mbiz.getSuiwuCount(memberinfo);
		String topage = memberinfo.getTopage();
		
		int currentPage = (GlobalConstant.isNull(topage) || topage.equals("0"))?1:Integer.valueOf(topage);
		memberinfo.setStart((currentPage-1)*GlobalConstant.PAGE_SIZE);
		List<Member> list = mbiz.findSuiwuPage(memberinfo);
		PageData<Member> pdata = new PageData<Member>(list , total , currentPage);
		memberinfo.setType("5");
		model.addAttribute("memberinfo", memberinfo);
		model.addAttribute("memberpage", pdata);
		model.addAttribute("industry", sbiz.getIndustryList());
		return "screens/member/member";
	}
	@RequestMapping("/dlist")
	public String findDisui(HttpServletRequest req , Model model , MemberInfo memberinfo){
		//权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.MEMBER_HELP_ADD);
		authList.add(GlobalConstant.MEMBER_HELP_IMPORT);
		authList.add(GlobalConstant.MEMBER_HELP_ENABLE);
		authList.add(GlobalConstant.MEMBER_HELP_DISABLE);
		authList.add(GlobalConstant.MEMBER_HELP_DELETE);
		authList.add(GlobalConstant.MEMBER_HELP_UPDATE);
		
		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model,req, authList, "会员管理");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		int total = mbiz.getDisuiCount(memberinfo);
		String topage = memberinfo.getTopage();
		
		int currentPage = (GlobalConstant.isNull(topage) || topage.equals("0"))?1:Integer.valueOf(topage);
		memberinfo.setStart((currentPage-1)*GlobalConstant.PAGE_SIZE);
		List<Member> list = mbiz.findDisuiPage(memberinfo);
		PageData<Member> pdata = new PageData<Member>(list , total , currentPage);
		memberinfo.setType("6");
		model.addAttribute("memberinfo", memberinfo);
		model.addAttribute("memberpage", pdata);
		model.addAttribute("industry", sbiz.getIndustryList());
		return "screens/member/member";
	}
	
	@RequestMapping("/export")
	public void export(String typeid , HttpServletResponse response , HttpServletRequest req ){
		mbiz.exprotMember(response, typeid);
	}
}
