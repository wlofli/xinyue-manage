package com.xinyue.manage.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyue.authe.AutheManage;
import com.xinyue.manage.beans.PageInfo;
import com.xinyue.manage.beans.SearchOrderCredit;
import com.xinyue.manage.beans.SearchReward;
import com.xinyue.manage.beans.SelectInfo;
import com.xinyue.manage.model.Consumption;
import com.xinyue.manage.model.Recharge;
import com.xinyue.manage.model.Reward;
import com.xinyue.manage.model.User;
import com.xinyue.manage.model.WithdrawMoney;
import com.xinyue.manage.service.FundService;
import com.xinyue.manage.service.RewardService;
import com.xinyue.manage.service.SelectService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;

/**后台资金管理
 * author lzc
 */
@RequestMapping("/fund")
@Controller
public class FundController {
	
	
	@Resource
	private FundService fundService;
	
	@Resource
	private RewardService rewardService;
	
	@Resource
	private SelectService selectService;
	
	@RequestMapping("recharge/list")
	public String rechargeList(@ModelAttribute("search")SearchReward searchReward, @RequestParam(defaultValue="0")int index,
			Model model){
		List<Recharge> recharges  = fundService.getRechargesBySearch(searchReward, 
				index * GlobalConstant.PAGE_SIZE, GlobalConstant.PAGE_SIZE);
		int count = fundService.countRechargesBySearch(searchReward);
//System.out.println(recharges.get(0).getRechargeAmount());
		model.addAttribute("list", recharges);
		Double sum  = fundService.sumRechargeAmountByCondition(null);
		model.addAttribute("sum", sum);
		List<SelectInfo> selectInfos = selectService.findSelectByType(GlobalConstant.RECHARGE_TYPE);
		model.addAttribute("type", selectInfos);
		CommonFunction cf = new CommonFunction();
		PageInfo pageInfo = new PageInfo();
		pageInfo = cf.pageList(count, index + 1);
		model.addAttribute("page", pageInfo);
		
		return "screens/fund/rechargeList";
	}
	
	
	@RequestMapping("recharge/detail")
	public String rechargeDetail(String id,Model model){
		Recharge recharge = fundService.getRechargeById(id);
		model.addAttribute("recharge", recharge);
		return "screens/fund/rechargeDetail";
	}
	
	
	@RequestMapping("recharge/add")
	@ResponseBody
	public String rechargeAdd(Recharge recharge , HttpServletRequest request){
//System.out.println(AutheManage.getUsername(request));
		try {
			fundService.addRecharge(recharge, AutheManage.getUsername(request));
		} catch (Exception e) {
			// TODO: handle exception
			return GlobalConstant.RET_FAIL;
		}
		return GlobalConstant.RET_SUCCESS;
	}
	
	
	
	@RequestMapping("/recharge")
	public String recharge(){
		return "screens/fund/recharge";
	}
	
	@RequestMapping("consumption/list")
	public String consumptionList(Model model,@ModelAttribute("search")SearchReward searchReward, 
			@RequestParam(defaultValue="0")int index){
		List<Consumption> consumptions = fundService
				.getConsumptionByCondition(index * GlobalConstant.PAGE_SIZE, GlobalConstant.PAGE_SIZE, searchReward);
		model.addAttribute("list", consumptions);
//System.out.println(consumptions.get(0).getConsumptionTime());
		
		Double sum = fundService.sumConsumptionByCondition(null);
		
		model.addAttribute("sum", sum);
		
		List<SelectInfo> type = selectService.findSelectByType(GlobalConstant.CONSUMPTION_TYPE);
		model.addAttribute("type", type);
		
		
		int count = fundService.countConsumptionByCondition(searchReward);
		CommonFunction cf = new CommonFunction();
		PageInfo pageInfo = new PageInfo();
		pageInfo = cf.pageList(count, index + 1);
		model.addAttribute("page", pageInfo);
		
		return "screens/fund/consumptionList";
	}
	
	@RequestMapping("consumption/detail")
	public String consumptionDetail(Model model, String id){
		Consumption consumption = fundService.getConsumptionById(id);
		model.addAttribute("consumption", consumption);
		return "screens/fund/consumptionDetail";
	}
	
	@RequestMapping("withdraw/list")
	public String withdrawList(@ModelAttribute("search")SearchReward searchReward,
			@RequestParam(defaultValue="0")int index, Model model, HttpServletRequest request){
System.out.println(searchReward.getStatus());
		CommonFunction cf = new CommonFunction();
		//权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.AUTHE_WITHDRAW_AUDITE);
		authList.add(GlobalConstant.AUTHE_WITHDRAW_PAY);
		authList.add(GlobalConstant.AUTHE_WITHDRAW_DETAIL);
		
		boolean ret_auth = cf.getAuth(model,request, authList, GlobalConstant.AUTHE_WITHDRAW);
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		//总共提现记录
		int allCount = rewardService.countWithdrawListByCondition(null);
		model.addAttribute("allCount", allCount);
		
		List<SearchOrderCredit> menuList = rewardService.getWithdrawInfoWithNum(GlobalConstant.WITHDRAW_CONDITION);
		model.addAttribute("menu", menuList);
		
		List<WithdrawMoney> withdrawMoneys = rewardService
				.getWithdrawListByCondition(searchReward, GlobalConstant.PAGE_SIZE * index, GlobalConstant.PAGE_SIZE);
		model.addAttribute("list", withdrawMoneys);
		int count = rewardService.countWithdrawListByCondition(searchReward);
		PageInfo pageInfo = new PageInfo();
		pageInfo = cf.pageList(count, index + 1);
		model.addAttribute("page", pageInfo);
		return "screens/fund/withdrawList";
	}
	
	
	@RequestMapping("withdraw/detail")
	public String withdrawDetail(Model model,String id){
		WithdrawMoney withdrawMoney = rewardService.getWithdrawMoneyById(id);
		model.addAttribute("ob", withdrawMoney);
		return "screens/fund/withdrawDetail";
	}
	
	
	@RequestMapping("withdraw/edit")
	public String withdrawEdit(Model model, String id){
		WithdrawMoney withdrawMoney = rewardService.getWithdrawMoneyById(id);
		model.addAttribute("ob", withdrawMoney);
		return "screens/fund/withdrawEdit";
	}
	
	@RequestMapping("withdraw/update")
	@ResponseBody
	public String updateWithdraw(WithdrawMoney withdrawMoney, HttpSession session){
System.out.println(withdrawMoney.getAuditePerson());
		try {
			rewardService.updateWithdraw(withdrawMoney);
		} catch (Exception e) {
			// TODO: handle exception
			return GlobalConstant.RET_FAIL;
		}
		
		return GlobalConstant.RET_SUCCESS;
	}
	
	
	@RequestMapping("reward/list")
	public String rewardList(Model model, @ModelAttribute("search")SearchReward searchReward,
			@RequestParam(defaultValue="0")int index){
		List<Reward> rewards = rewardService.getRewardListByCondition(searchReward, GlobalConstant.PAGE_SIZE * index, GlobalConstant.PAGE_SIZE);
		model .addAttribute("list", rewards);
		
		Double remain = rewardService.getAllAwardRemain();
		Double reward = rewardService.getAllReward();
		Double withdraw = rewardService.getAllWithdraw();
		model.addAttribute("remain", remain);
		model.addAttribute("reward", reward);
		model.addAttribute("withdraw", withdraw);
		
		//会员类型
		List<SelectInfo> status = selectService.findSelectByType(GlobalConstant.USER_TYPE);
		//来源
		List<SelectInfo> source = selectService.findSelectByType(GlobalConstant.REWARD_SOURCE);
		
		// 省
		List<SelectInfo> provinceList = selectService.findProvince();
		model.addAttribute("provinceList", provinceList);
		
		if(searchReward.getCity() != null){
			// 市
			List<SelectInfo> cityList = selectService.findCitiesByProvinceCode(searchReward.getProvince());
			model.addAttribute("cityList", cityList);
			if(searchReward.getZone() != null){
				List<SelectInfo> zoneList = selectService.findZonesByCityCode(searchReward.getCity());
				model.addAttribute("zoneList", zoneList);
			}
		}
		
		
		model.addAttribute("status", status);
		model.addAttribute("source", source);
		
		int count = rewardService.countRewardListBycondition(searchReward);
		CommonFunction cf = new CommonFunction();
		PageInfo pageInfo = new PageInfo();
		pageInfo = cf.pageList(count, index + 1);
		model.addAttribute("page", pageInfo);
		
		
		
		return "screens/fund/rewardList";
	}
	
	
	
	

}
