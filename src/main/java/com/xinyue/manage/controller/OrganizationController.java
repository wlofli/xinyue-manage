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
import com.xinyue.manage.beans.EmailBean;
import com.xinyue.manage.beans.OrganizationInfo;
import com.xinyue.manage.beans.PageData;
import com.xinyue.manage.beans.QuestionBean;
import com.xinyue.manage.beans.RecommendMember;
import com.xinyue.manage.beans.SearchCreditManager;
import com.xinyue.manage.beans.SelectInfo;
import com.xinyue.manage.beans.ShowAnswer;
import com.xinyue.manage.model.Answer;
import com.xinyue.manage.model.AuthenticationCM;
import com.xinyue.manage.model.CreditManager;
import com.xinyue.manage.model.Organization;
import com.xinyue.manage.model.OrganizationType;
import com.xinyue.manage.model.Question;
import com.xinyue.manage.model.Select;
import com.xinyue.manage.model.SuccessCase;
import com.xinyue.manage.service.CityService;
import com.xinyue.manage.service.CommonService;
import com.xinyue.manage.service.CreditManagerService;
import com.xinyue.manage.service.OrganizationService;
import com.xinyue.manage.service.OrganizationTypeService;
import com.xinyue.manage.service.SelectService;
import com.xinyue.manage.service.SuccessCaseService;
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
	
	@Resource
	private SuccessCaseService successCaseService;
	
	@Resource
	private CreditManagerService creditManagerService;
	
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
	@RequestMapping("/shop")
	public String shopshow(HttpServletRequest req , Model model, String orgid){
		model.addAttribute("shop", orgbiz.findShop(orgid));
		//显示图片路径
		model.addAttribute("showpath", orgbiz.SHOW_PATH);
		
		//标题
		model.addAttribute("title", "shop");
		//机构id
		model.addAttribute("orgid", orgid);
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
		model.addAttribute("city", orgbiz.findAllStation());
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
	@RequestMapping("/shopcontent")
	public String shopcontent(HttpServletRequest req , Model model, String orgid){
		//店铺信息
		model.addAttribute("shop", orgbiz.findShop(orgid));
		//标题
		model.addAttribute("title", "content");
		
		//机构id
		model.addAttribute("orgid", orgid);
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
	
	
	/**
	 * ywh 店铺问题
	 * @param model
	 * @param qbean
	 * @param req
	 * @return
	 */
	@RequestMapping("/quest")
	public String findQuest(Model model ,  QuestionBean qbean , HttpServletRequest req){
		//qbean.setOrgid(orgid);
		PageData<Question> questpage = orgbiz.findOrgQuest(qbean);
		
		model.addAttribute("questpage", questpage);
		// 叶签
		model.addAttribute("title", "quest");
		//查询条件
		model.addAttribute("qbean", qbean);
		//叶签
		model.addAttribute("orgid", qbean.getOrgid());
		return "screens/organization/shopquest";
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
		return "screens/organization/shopquestxq";
	}
	
	/**
	 * ywh 添加问题
	 * @param answer
	 * @return
	 */
	@RequestMapping("/addAnswer")
	@ResponseBody
	public String answer(Answer answer){
		boolean b = orgbiz.addAnswer(answer);
		if(b){
			return "success";
		}else{
			return "fail";
		}
		
	}
	
	
	@RequestMapping("/delQuest")
	@ResponseBody
	public String delQuest(HttpServletRequest req , @RequestBody List<String> questids){
		boolean b = orgbiz.delQuest(questids, AutheManage.getUsername(req));
		if(b){
			return "success";
		}
		return "fail";
	}
	
	/**
	 * 信贷
	 * @param model
	 * @param sc
	 * @param req
	 * @return
	 */
	@RequestMapping("/credit")
	public String findCredit(Model model ,  SearchCreditManager sc , HttpServletRequest req){
		model.addAttribute("creditpage", orgbiz.findCreditByOrgid(sc));
		model.addAttribute("sc", sc);
		// 星级
		List<SelectInfo> stars = sbiz
			.findSelectByType(GlobalConstant.STAR_LEVEL);
		model.addAttribute("stars", stars);
		// 省
		List<SelectInfo> provinces = sbiz.findProvince();
		model.addAttribute("provinces", provinces);
		//机构id
		model.addAttribute("orgid", sc.getOrgid());
		
		return "screens/organization/orgcredit";
	}
	
	@RequestMapping("/email")
	@ResponseBody
	public String emailMember(List<String> email , String content , HttpServletRequest req){
		List<String> erroremail = new ArrayList<String>();
		for (String e : email) {
			boolean result = new EmailBean().sendMail(e, "网站登录地址", content);
			if(!result){
				erroremail.add(e);
			}
		}
		if(erroremail.size() == 0){
			return "success";
		}else{
			return erroremail.toString();
		}
	}
	@Resource
	private CommonService cbiz;
	@RequestMapping("/tel")
	@ResponseBody
	public String telMember(List<String> tel , String content , HttpServletRequest req){
		List<String> errortel = new ArrayList<String>();
		for (String t : tel) {
			boolean result = cbiz.sendCodeByPhone(t , content);
			if(!result){
				errortel.add(t);
			}
		}
		if(errortel.size() == 0){
			return "success";
		}else{
			return errortel.toString();
		}
	}
	
	@RequestMapping("/creditdetail")
	public String creditdetail(HttpServletRequest request,Model model,String managerid){
			
		//基本信息
		CreditManager creditManager = creditManagerService.getCreditManagerById(managerid);
		model.addAttribute("creditManager", creditManager);
		
		//认证信息
		AuthenticationCM authenticationCM = creditManagerService.getAuthenticationById(managerid);
		model.addAttribute("authenticationCM", authenticationCM);
		
		//图片路径
		String showPath = CommonFunction.getValue("down.path");
		model.addAttribute("showPath", showPath);
		
		
		return "screens/organization/creditdetail";
	}
	
	/**
	 * 机构管理-店铺设置-成功案例
	 * @param request
	 * @param model
	 * @param orgid 机构id
	 * @return
	 */
	@RequestMapping(value="/success/case")
	public String orgSucccessCase(HttpServletRequest request,Model model,String orgid) {
		
		//标题
		model.addAttribute("title", "suc");
		model.addAttribute("orgid", orgid);
		
		//列表
		List<SuccessCase> cases = successCaseService.getSuccessCasesByOrgId(orgid,1);
		int count = successCaseService.getSuccessCasesCountByOrgId(orgid);
		PageData<SuccessCase> scPageData = new PageData<>(cases, count, 1);
		model.addAttribute("scPageData", scPageData);
		
		return "screens/organization/shopSuccessCase";
	}
	
	/**
	 * 成功案例启用/屏蔽
	 * @param code
	 * @param type 0:启用;1:屏蔽
	 * @return
	 */
	@RequestMapping(value="/success/case/publish",method=RequestMethod.POST)
	public @ResponseBody boolean successCasePublish(String code,String type) {
		
		boolean ret = false;
		//更新
		ret = successCaseService.updateOrgSuccessCaseUseFlag(code,type);
		
		return ret;
	}
	
	/**
	 * 成功案例删除
	 * @param code
	 * @return
	 */
	@RequestMapping(value="/success/case/delete",method=RequestMethod.POST)
	public boolean successCaseDelete(String code) {
		boolean ret = false;
		
		ret = successCaseService.deleteSuccessCaseByIds(code);
		
		return ret;
	}
	
	/**
	 * 成功案例翻页
	 * @param request
	 * @param model
	 * @param toPage
	 * @return
	 */
	@RequestMapping(value="/success/case/page",method=RequestMethod.POST)
	public String successCasePage(HttpServletRequest request,Model model,int toPage,String orgid) {
		
		//标题
		model.addAttribute("title", "suc");
		model.addAttribute("orgid", orgid);

		// 列表
		List<SuccessCase> cases = successCaseService.getSuccessCasesByOrgId(orgid, toPage);
		int count = successCaseService.getSuccessCasesCountByOrgId(orgid);
		PageData<SuccessCase> scPageData = new PageData<>(cases, count, toPage);
		model.addAttribute("scPageData", scPageData);
		
		return "screens/organization/shopSuccessCase";
	}
	
	
}
