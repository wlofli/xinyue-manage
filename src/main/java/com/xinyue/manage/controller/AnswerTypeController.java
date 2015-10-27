package com.xinyue.manage.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyue.manage.beans.AnswerTypeBean;
import com.xinyue.manage.beans.PageData;
import com.xinyue.manage.model.AnswerType;
import com.xinyue.manage.service.AnswerTypeService;

/**
 * 
 * @author wenhai.you
 * @2015年9月30日
 * @上午9:54:28
 */
@Controller
@RequestMapping("/answertype")
public class AnswerTypeController {

	@Resource
	private AnswerTypeService abiz;
	
	/**
	 * 显示
	 * @param req
	 * @param model
	 * @param abean
	 * @return
	 */
	@RequestMapping("/show")
	public String Show(HttpServletRequest req , Model model , AnswerTypeBean abean){
		
		//一级菜单
		PageData<AnswerType> fpage = abiz.findPageAnswerType(abean.getFtopage(), "1");
		model.addAttribute("ftype", fpage);
		//二级菜单 
		PageData<AnswerType> spage = abiz.findPageAnswerType(abean.getStopage(), "2");
		model.addAttribute("stype", spage);
		//bean
		model.addAttribute("abean", abean);
		return "screens/answer/answer";
	}
	
	
	/**
	 * ywh 删除
	 * @param req
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/delType" , method=RequestMethod.POST)
	@ResponseBody
	public String delAnswerType(HttpServletRequest req , Model model , String atid){
		
		try {
			abiz.delAnswertype(atid);
			return "success";
		} catch (Exception e) {
			// TODO: handle exception
			return "fail";
		}
	}
	
	
	/**
	 * ywh 启用
	 * @param req
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/enable" , method=RequestMethod.POST)
	@ResponseBody
	public String enableStatus(HttpServletRequest req , Model model , String atid){
		boolean b = abiz.updateStatus(atid, "0");
		if(b){
			return "success";
		}
		return "fail";
	}
	
	
	/**
	 * ywh 禁用
	 * @param req
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/disable" , method=RequestMethod.POST)
	@ResponseBody
	public String disable(HttpServletRequest req , Model model , String atid){
		try {
			abiz.updateStatus(atid, "1");
			return "success";
		} catch (Exception e) {
			// TODO: handle exception
			return "fail";
		}
	}
	
	
	@RequestMapping(value="/addType" , method=RequestMethod.POST)
	@ResponseBody
	public String addAnswerType(HttpServletRequest req , Model model ,AnswerType abean){
		boolean b = abiz.updateAnswertype(abean);
		if(b){
			return "success";
		}
		return "fail";
	}
	
	@RequestMapping(value={"/toadd"})
	public String toaddType(HttpServletRequest req , Model model){
		
		model.addAttribute("abean", new AnswerType());
		
		model.addAttribute("sbean", abiz.findAnswerType());
		return "screens/answer/addanswer";
	}
	
	@RequestMapping(value={"/toedit"})
	public String toeditType(HttpServletRequest req , Model model ,  String atid){
		AnswerType atbean = abiz.getAnswertypeById(atid);
		
		model.addAttribute("abean", atbean);
		
		return "screens/answer/editanswer";
	}
	
	@RequestMapping(value={"/tosecond"})
	public String toaddSecondType(HttpServletRequest req , Model model ,  String atid){
		AnswerType atbean = new AnswerType(atid);
		model.addAttribute("abean", atbean);
		
		return "screens/answer/editanswer";
	}
}
