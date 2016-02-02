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
import com.xinyue.manage.beans.OrderInfo;
import com.xinyue.manage.beans.PageData;
import com.xinyue.manage.beans.QuestionBean;
import com.xinyue.manage.beans.Recommend;
import com.xinyue.manage.beans.SearchReward;
import com.xinyue.manage.beans.SelectInfo;
import com.xinyue.manage.beans.ShowAnswer;
import com.xinyue.manage.model.Answer;
import com.xinyue.manage.model.Member;
import com.xinyue.manage.service.AnswerService;
import com.xinyue.manage.service.CityService;
import com.xinyue.manage.service.MemberService;
import com.xinyue.manage.service.OrganizationService;
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
	
	@Autowired
	private OrganizationService orgbiz;
	
	@Autowired
	private AnswerService abiz;
	
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
		PageData<Member> pdata = mbiz.findPageList(memberinfo);
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
			member.setType(type);
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
		memberinfo.setType("2");
		PageData<Member> pdata = mbiz.findPageList(memberinfo);
		
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
		memberinfo.setType("1");
		PageData<Member> pdata = mbiz.findPageList(memberinfo);
		
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
		memberinfo.setType("3");
		PageData<Member> pdata = mbiz.findPageList(memberinfo);
		
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
		memberinfo.setType("7");
		PageData<Member> pdata = mbiz.findPageList(memberinfo);
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
		memberinfo.setType("4");
		PageData<Member> pdata = mbiz.findPageList(memberinfo);
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
		memberinfo.setType("5");
		PageData<Member> pdata = mbiz.findPageList(memberinfo);
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
		memberinfo.setType("6");
		PageData<Member> pdata = mbiz.findPageList(memberinfo);
		model.addAttribute("memberinfo", memberinfo);
		model.addAttribute("memberpage", pdata);
		model.addAttribute("industry", sbiz.getIndustryList());
		return "screens/member/member";
	}
	
	@RequestMapping("/export")
	public void export(String typeid , HttpServletResponse response , HttpServletRequest req ){
		mbiz.exprotMember(response, typeid);
	}
	
	/**
	 * 2015-10-17
	 */
	/**
	 * ywh admin 查看基本信息
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/detail")
	public String detail(HttpServletRequest req , Model model){
	
		//详情
		String id = req.getParameter("memberid");
		Member member = mbiz.editMember(id);
		model.addAttribute("memberdetail", member);
		//标签
		model.addAttribute("title", "basic");
		//会员id
		model.addAttribute("memberid", id);
		return "screens/member/memberdetail";
	}
	
	/**
	 * ywh admin 推荐
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/recommend")
	public String recommend(HttpServletRequest req , Model model , Recommend rec){
		
		//信贷
		model.addAttribute("memberpage", mbiz.findRecommendMember(rec));
		//普通
		model.addAttribute("creditpage", mbiz.findRecommendCredit(rec));
		//标签
		model.addAttribute("title", "recommend");
		//会员id
		model.addAttribute("memberid", rec.getMemberid());
		//子标签
		model.addAttribute("typeid", rec.getTypeid());
		//查询条件
		model.addAttribute("rec", rec);
		return "screens/member/recommend";
	}
	
	/**
	 * ywh admin 推荐
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/quest")
	public String quest(HttpServletRequest req , Model model , QuestionBean qbean){
		
		model.addAttribute("questpage", abiz.findMemberQuest(qbean));
		model.addAttribute("memberid", qbean.getMemberid());
		model.addAttribute("title", "quest");
		model.addAttribute("qbean", qbean);
		return "screens/member/quest";
	}
	
	/**
	 * ywh 店铺问题详情
	 * @param model
	 * @param qbean
	 * @param req
	 * @return
	 */
	@RequestMapping("/quest/detail")
	public String findQuestDetail(Model model , QuestionBean qbean , HttpServletRequest req){
		
		PageData<ShowAnswer> answerpage = orgbiz.findOrgAnswer(qbean.getQuestid(), qbean.getTopage());
		model.addAttribute("answerpage", answerpage);
		//显示问题内容
		ShowAnswer answer = answerpage.getData().get(0);
		model.addAttribute("answer", answer);
		//查询条件
		model.addAttribute("qbean", qbean);
		//信贷经理
		model.addAttribute("credit", orgbiz.getAllCredit());
		//省
		List<SelectInfo> provinces = cityService.getAllProvince();
		model.addAttribute("provinces", provinces);
		//用于回答
		Answer questanswer = new Answer();
		questanswer.setQuestid(answer.getId());
		model.addAttribute("questanswer", questanswer);
		
		model.addAttribute("memberid", qbean.getMemberid());
		return "screens/member/questxq";
	}
	
	/**
	 * ywh member order
	 * @param model
	 * @param info
	 * @param req
	 * @return
	 */
	@RequestMapping("/order")
	public String findOrder(Model model , OrderInfo info , HttpServletRequest req){
		//分页
		model.addAttribute("orderpage", mbiz.findMemberOrder(info));
		//条件
		model.addAttribute("info", info);
		//
		model.addAttribute("memberid", info.getMemberid());
		//标签
		model.addAttribute("title", "order");
		return "screens/member/order";
	}
	
	/**
	 * ywh member 
	 * @param model
	 * @param info
	 * @param req
	 * @return
	 */
	@RequestMapping("/reward")
	public String findReward(Model model , SearchReward sc , HttpServletRequest req){
		//标签
		model.addAttribute("title", "record");
		//奖励
		model.addAttribute("rewardpage", mbiz.findMemberReword(sc));
		model.addAttribute("sc", sc);
		//memberid
		model.addAttribute("memberid", sc.getMemberid());
	
		return "screens/member/reward";
	}
	
	/**
	 * ywh member 
	 * @param model
	 * @param info
	 * @param req
	 * @return
	 */
	@RequestMapping("/draw")
	public String findDraw(Model model , SearchReward sc , HttpServletRequest req){
		//标签
		model.addAttribute("title", "record");
	
		//提现
		model.addAttribute("drawpage", mbiz.findMemberDraw(sc));
		model.addAttribute("sc", sc);
		//memberid
		model.addAttribute("memberid", sc.getMemberid());
		
		return "screens/member/draw";
	}
}
