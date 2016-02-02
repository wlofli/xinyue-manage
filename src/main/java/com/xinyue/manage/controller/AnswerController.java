package com.xinyue.manage.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyue.authe.AutheManage;
import com.xinyue.manage.beans.PageData;
import com.xinyue.manage.beans.QuestionBean;
import com.xinyue.manage.beans.SelectInfo;
import com.xinyue.manage.beans.ShowAnswer;
import com.xinyue.manage.model.Answer;
import com.xinyue.manage.model.Question;
import com.xinyue.manage.service.AnswerService;
import com.xinyue.manage.service.CityService;
import com.xinyue.manage.service.OrganizationService;
import com.xinyue.manage.util.GlobalConstant;

/**
 * 
 * @author wenhai.you
 * @2015年10月8日
 * @下午2:37:56
 */
@Controller
@RequestMapping("/answer")
public class AnswerController {

	@Resource
	private AnswerService abiz;
	
	@Resource
	private OrganizationService obiz;
	
	@RequestMapping("/show")
	public String show(HttpServletRequest req , Model model , QuestionBean qbean){
		//查询条件
		model.addAttribute("qbean", qbean);
		//二级类型
		model.addAttribute("answertype", abiz.findSecond());
		//分页
		model.addAttribute("pagequest", abiz.findAdminQuestion(qbean));
		
		
		return "screens/answer/quest";
	}
	
	@Resource
	private CityService cityService;
	
	@RequestMapping("/detail")
	public String detail(HttpServletRequest req , Model model , QuestionBean qbean){
		
		PageData<ShowAnswer> questpage = obiz.findOrgAnswer(qbean.getQuestid(), qbean.getTopage());
		model.addAttribute("questdetail", questpage);
		//对分页数据取出第一条数据
		
		model.addAttribute("question", questpage.getData().get(0));
		//条件
		model.addAttribute("qbean", qbean);
		//二级类型
		model.addAttribute("answertype", abiz.findSecond());
		//所有 信贷经理
		model.addAttribute("allcredit", obiz.getAllCredit());
		//所有机构
		model.addAttribute("allorg", abiz.getOrgs());
		//所有 省
		List<SelectInfo> provinces = cityService.getAllProvince();
		model.addAttribute("provinces", provinces);
		//回答
		model.addAttribute("answer", new Answer());
		return "screens/answer/questdetail";
	}
	
	@RequestMapping(value = "/updateQuest" , method = RequestMethod.POST)
	@ResponseBody
	public String updateQuest(HttpServletRequest req , Model model , String status , String questtypeid , String id){
		
		boolean b = abiz.updateQuest(status, questtypeid, id);
		if(b){
			return "success";
		}
		return "fail";
	}
	
	@RequestMapping(value = "/addAnswer" , method = RequestMethod.POST)
	@ResponseBody
	public String addAnswer(HttpServletRequest req , Model model , Answer answer){
		boolean b = abiz.addAnswer(answer);
		if(b){
			return "success";
		}
		return "fail";
	}
	
	
	@RequestMapping(value = "/check" , method = RequestMethod.POST)
	@ResponseBody
	public String check(HttpServletRequest req , Model model , String aid, String option , String questid){
		
		try {
			abiz.updateAnswer(option, aid, questid);
			return "success";
		} catch (Exception e) {
			// TODO: handle exception
			return "fail";
		}
	}
	
	@RequestMapping(value = "/editQuest" , method = RequestMethod.POST)
	@ResponseBody
	public String editQuest(HttpServletRequest req , Model model , Question quest){
		
		boolean b = abiz.updateQuest(quest);
		if(b){
			return "success";
		}
		return "fail";
	}
	
	@RequestMapping("/toedit")
	public String toedit(HttpServletRequest req , Model model , String questid){
		if(GlobalConstant.isNull(questid)){
			model.addAttribute("quest", new Question());
		}else{
			Question quest = abiz.findQuestById(questid);
			model.addAttribute("quest", quest);
		}
		//二级类型
		model.addAttribute("answertype", abiz.findSecond());
		//所有机构
		model.addAttribute("allorg", abiz.getOrgs());
		return "screens/answer/questedit";
	}
	
	@RequestMapping("/delQuest")
	@ResponseBody
	public String delQuest(HttpServletRequest req , Model model , @RequestBody  List<String> questids){
		boolean b = obiz.delQuest(questids , AutheManage.getUsername(req));
		if(b){
			return "success";
		}else{
			return "fail";
		}
		
	}
	
	
	@RequestMapping("/publishQuest")
	@ResponseBody
	public String publishQuest(HttpServletRequest req , Model model , @RequestBody List<String> questids){
		
		boolean b = abiz.publishQuest(questids , String.valueOf(AutheManage.getUser(req).getUid()));
		if(b){
			return "success";
		}else{
			return "fail";
		}
		
	} 
	
}
