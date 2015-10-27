package com.xinyue.manage.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.xinyue.manage.beans.PageInfo;
import com.xinyue.manage.beans.Recommend;
import com.xinyue.manage.service.RecommendService;
import com.xinyue.manage.service.SelectService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;

/**
 * author lzc
 */
@Controller
@RequestMapping("recommend")
public class RecommendController {
	
	@Autowired
	private RecommendService recommendService;
	
	@Autowired
	private SelectService selectService;
	
	@RequestMapping("credit/list")
	public String getRecommendListByCondition(@ModelAttribute("search")Recommend recommend,
			@RequestParam(defaultValue="0")int index,Model model){
		selectService.addAreaToModel(model, recommend.getProvince(), recommend.getCity(), recommend.getZone());
		List<Recommend> recommends = recommendService.getRecommendCreditByCondition(recommend, index * GlobalConstant.PAGE_SIZE, GlobalConstant.PAGE_SIZE);
		model.addAttribute("list", recommends);
		int count = recommendService.countRecommendCreditByCondition(recommend);
		
		PageInfo pageInfo = new PageInfo();
		CommonFunction cf = new CommonFunction();
		// 分页传值
		pageInfo = cf.pageList(count, index + 1);
		model.addAttribute("page", pageInfo);
		return "screens/recommend/recommendCredit";
	}
	
	
	
	@RequestMapping("member/list")
	public String getMemberListByCondition(@ModelAttribute("search")Recommend recommend, @RequestParam(defaultValue="0")int index, Model model){
		selectService.addAreaToModel(model, recommend.getProvince(), recommend.getCity(), recommend.getZone());
		List<Recommend> recommends = recommendService.getRecommendMemberByCondition(recommend, index * GlobalConstant.PAGE_SIZE, GlobalConstant.PAGE_SIZE);
		model.addAttribute("list", recommends);
		int count = recommendService.countRecommendMemberByCondition(recommend);
		PageInfo pageInfo = new PageInfo();
		CommonFunction cf = new CommonFunction();
		// 分页传值
		pageInfo = cf.pageList(count, index + 1);
		model.addAttribute("page", pageInfo);
		return "screens/recommend/recommendMember";
	}
	

}
