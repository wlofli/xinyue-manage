package com.xinyue.manage.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyue.manage.beans.InvitationMemberInfo;
import com.xinyue.manage.beans.PageData;
import com.xinyue.manage.beans.SearchCreditManager;
import com.xinyue.manage.beans.SearchMoneyAccount;
import com.xinyue.manage.beans.SelectInfo;
import com.xinyue.manage.beans.SuccessCaseSearch;
import com.xinyue.manage.model.AuthenticationCM;
import com.xinyue.manage.model.Consumption;
import com.xinyue.manage.model.CreditManager;
import com.xinyue.manage.model.Order;
import com.xinyue.manage.model.Recharge;
import com.xinyue.manage.model.Reward;
import com.xinyue.manage.model.SuccessCase;
import com.xinyue.manage.model.WithdrawMoney;
import com.xinyue.manage.service.CreditManagerService;
import com.xinyue.manage.service.FundService;
import com.xinyue.manage.service.OrganizationService;
import com.xinyue.manage.service.RewardService;
import com.xinyue.manage.service.SelectService;
import com.xinyue.manage.service.SuccessCaseService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;

/**
 * 信贷经理(后台)
 * @author MK)茅
 * @version v1.0
 * @date 创建时间：2015年8月28日
 */
@Controller
@RequestMapping("/credit/manager")
public class CreditManagerController {

	@Resource
	private SelectService selectService;
	
	@Resource
	private OrganizationService organizationService;
	
	@Resource
	private CreditManagerService creditManagerService;
	
	@Resource
	private SuccessCaseService successCaseService;
	
	@Resource
	private FundService fundService;
	
	@Resource
	private RewardService rewardService;
	
	private String managerId = "";
	
	@RequestMapping(value="/list")
	public String init(HttpServletRequest request,Model model) {
		//检索条件下拉内容
		getSelectList(model);
		
		//检索内容
		SearchCreditManager sc = new SearchCreditManager();
		model.addAttribute("searchCreditmanager", sc);
		
		//获得列表
		getCreditManagerList(model, sc);
		
		return "screens/creditManager/creditManagerList";
	}
	
	/**
	 * 根据条件查询
	 * @param request
	 * @param model
	 * @param searchCreditmanager
	 * @return
	 */
	@RequestMapping(value="search",method=RequestMethod.POST)
	public String searchCreditManager(HttpServletRequest request,Model model,SearchCreditManager searchCreditmanager) {
		
		//检索条件下拉内容
		getSelectList(model);
		
		//获得列表
		getCreditManagerList(model, searchCreditmanager);
		
		model.addAttribute("searchCreditmanager", searchCreditmanager);
		
		return "screens/creditManager/creditManagerList";
	}
	
	/**
	 * 删除信贷经理
	 * @param managerIds
	 * @return
	 */
	@RequestMapping(value="del",method=RequestMethod.POST)
	public @ResponseBody boolean deleteCreditManagers(String managerIds) {
		
		boolean result = false;
		
		result = creditManagerService.deleteCreditManagers(managerIds);
		
		return result;
	}
	
	/**
	 * 启用/屏蔽
	 * @param managerIds
	 * @param status
	 * @return
	 */
	@RequestMapping(value="lock",method=RequestMethod.POST)
	public @ResponseBody boolean lockCreditmanagers(String managerIds,String status) {
		
		boolean result = false;
		
		result = creditManagerService.updateCreditmanagers(managerIds,status);
		
		return result;
	}
	
	/**
	 * 添加/编辑信贷经理
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/add")
	public String editCreditManager(HttpServletRequest request,Model model) {
		
		CreditManager creditManager = new CreditManager();
		model.addAttribute("creditManager", creditManager);
		model.addAttribute("message", "");
		
		getSelectList(model);
		
		return "screens/creditManager/creditManagerEdit";
	}
	
	/**
	 * 信贷经理保存
	 * @param request
	 * @param model
	 * @param creditManager
	 * @return
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	public String saveCreditManager(HttpServletRequest request,Model model,CreditManager creditManager) {
		
		boolean result = creditManagerService.saveCreditManager(creditManager);
		
		if (result) {
			return "redirect:/credit/manager/list";
		}else {
			model.addAttribute("creditManager", creditManager);
			model.addAttribute("message", "保存失败");
			getSelectList(model);
		}
		
		return "screens/creditManager/creditManagerEdit";
	}
	
	/**
	 * 信贷经理详情-基本信息
	 * @param request
	 * @param model
	 * @param managerId
	 * @return
	 */
	@RequestMapping(value="/detail/bi")
	public String baseInfoCM(HttpServletRequest request,Model model,String managerId) {
		
		//标题选择
		selectTitle(request, managerId, "base_info");
		
		//基本信息
		CreditManager creditManager = creditManagerService.getCreditManagerById(managerId);
		model.addAttribute("creditManager", creditManager);
		
		//认证信息
		AuthenticationCM authenticationCM = creditManagerService.getAuthenticationById(managerId);
		model.addAttribute("authenticationCM", authenticationCM);
		
		//图片路径
		String showPath = CommonFunction.getValue("down.path");
		model.addAttribute("showPath", showPath);
		
		return "screens/creditManager/creditManagerBaseInfo";
	}
	
	/**
	 * 信贷经理详情-账户信息
	 * @param request
	 * @param model
	 * @param managerId
	 * @return
	 */
	@RequestMapping(value="/detail/ai")
	public String accountInfoCM(HttpServletRequest request,Model model,String managerId) {
		
		//标题选择
		selectTitle(request, managerId, "account_info");
		
		
		
		return "screens/creditManager/creditManagerAccountInfo";
	}
	
	/**
	 * 信贷经理详情-推荐会员
	 * @param request
	 * @param model
	 * @param managerId
	 * @return
	 */
	@RequestMapping(value="/detail/iu")
	public String inviteUserCM(HttpServletRequest request,Model model,String managerId) {
		
		clearSession(request);
		
		//标题选择
		selectTitle(request, managerId, "invite_user");
		
		// 普通会员推荐人数
		int invitationMemberCount = creditManagerService
				.getInvitationMemberCount(managerId);
		request.getSession().setAttribute("invitationMemberCount", invitationMemberCount);
		getInvitationMemberInfo(request, managerId, 1);
		
		// 信贷经理推荐人数
		int invitationManagerCount = creditManagerService
				.getInvitationManagerCount(managerId);
		request.getSession().setAttribute("invitationManagerCount", invitationManagerCount);
		getInvitationManagerInfo(request, managerId, 1);
		
		return "screens/creditManager/creditManagerInviteUser";
	}
	
	/**
	 * 推荐会员-翻页
	 * @param request
	 * @param model
	 * @param toPage
	 * @param type
	 * @return
	 */
	@RequestMapping(value={"/invitate/{type}/page"})
	public String invitationChangepage(HttpServletRequest request,Model model,int toPage,@PathVariable(value="type")String type) {
		
		if (type.equals("member")) {
			getInvitationMemberInfo(request, getManagerId(), toPage);
		}else if (type.equals("manager")) {
			getInvitationManagerInfo(request, getManagerId(), toPage);
		}
		
		return "screens/creditManager/creditManagerInviteUser";
	}
	
	/**
	 * 资金账户
	 * @param request
	 * @param model
	 * @param managerId
	 * @return
	 */
	@RequestMapping(value="/detail/ma")
	public String moneyAccount(HttpServletRequest request,Model model,String managerId) {
		
		//标题选择
		selectTitle(request, managerId, "money_account");
		
		//统括信息
//		MoneyOutline moneyOutline = creditManagerService.getMoneyAccountByManagerId(managerId);
//		request.getSession().setAttribute("moneyOutline", moneyOutline);
		
		SearchMoneyAccount searchMoneyAccount = new SearchMoneyAccount();
		searchMoneyAccount.setManagerId(managerId);
		model.addAttribute("searchMoneyAccount", searchMoneyAccount);
		
		//消费记录
		consumptionRecords(request, searchMoneyAccount);
		
		//充值记录
		rechargeRecords(request, searchMoneyAccount);
		
		//奖励记录
		rewardRecords(request, searchMoneyAccount);
		
		//提现记录
		withdrawMoneyRecords(request, searchMoneyAccount);
		
		return "screens/creditManager/creditManagerMoneyAccount";
	}
	
	@RequestMapping(value="/detail/ci")
	public String customerInfo(HttpServletRequest request,Model model,String managerId) {
		
		
		
		return "screens/creditManager/creditManagerCustomerInfo";
	}
	
	/**
	 * 成功案例
	 * @param request
	 * @param model
	 * @param managerId
	 * @return
	 */
	@RequestMapping(value="/detail/sc")
	public String successCase(HttpServletRequest request,Model model,String managerId) {
		
		clearSession(request);
		//标题选择
		selectTitle(request, managerId, "success_case");
		
		successCaseRecords(model,1);
		
		return "screens/creditManager/creditManagerSuccessCase";
	}
	
	/**
	 * 成功案例翻页
	 * @param request
	 * @param model
	 * @param toPpage
	 * @return
	 */
	@RequestMapping(value="/successcase/page")
	public String successCasePage(HttpServletRequest request,Model model,int toPpage) {
		
		successCaseRecords(model,toPpage);
		
		return "screens/creditManager/creditManagerSuccessCase";
	}
	
	/**
	 * 成功案例详情
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/successcase/detail")
	public String successCaseDetail(Model model,String id) {
		
		SuccessCase sCase = successCaseService.getSuccessCaseDetailByCaseId(id);
		model.addAttribute("sCase", sCase);
		
		return "screens/creditManager/creditManagerSuccessCaseDetail";
	}
	
	/**
	 * 服务评级
	 * @param request
	 * @param model
	 * @param managerId
	 * @return
	 */
	@RequestMapping(value="/detail/sr")
	public String serverRating(HttpServletRequest request,Model model,String managerId) {
		
		clearSession(request);
		//标题选择
		selectTitle(request, managerId, "server_rating");
		
		int serverStar = creditManagerService.getServerStar(managerId);
		request.getSession().setAttribute("star", serverStar);
		
		getServerRating(model,1,0);
		
		return "screens/creditManager/creditManagerServerRating";
	}
	
	/**
	 * 服务评级
	 * @param request
	 * @param model
	 * @param toPage
	 * @param star
	 * @return
	 */
	@RequestMapping(value="/server/rating/page")
	public String serverRatingPage(HttpServletRequest request,Model model,int toPage,int star) {
		
		getServerRating(model,toPage,star);
		
		return "screens/creditManager/creditManagerServerRating";
	}
	
	/**
	 * 资金账户检索
	 * @param request
	 * @param model
	 * @param searchMoneyAccount
	 * @return
	 */
	@RequestMapping(value="/fund/search",method=RequestMethod.POST)
	public String fundSearch(HttpServletRequest request,Model model,SearchMoneyAccount searchMoneyAccount) {
		
		model.addAttribute("tab", searchMoneyAccount.getSelectType());
		
		switch (searchMoneyAccount.getSelectType()) {
		case 0:
			break;
		case 1:
			//消费记录
			consumptionRecords(request, searchMoneyAccount);
			break;
		case 2:
			//充值记录
			rechargeRecords(request, searchMoneyAccount);
			break;
		case 3:
			//奖励记录
			rewardRecords(request, searchMoneyAccount);
			break;
		case 4:
			//提现记录
			withdrawMoneyRecords(request, searchMoneyAccount);
			break;
		default:
			break;
		}
		
		return "screens/creditManager/creditManagerMoneyAccount";
	}
	
	/**
	 * 评级信息
	 * @param model
	 * @param page
	 */
	private void getServerRating(Model model,int page,int star) {
		
		List<Order> orders = creditManagerService.getServerRatingByManagerId(getManagerId(),page,star);
		int count = creditManagerService.getServerRatingCount(getManagerId());
		PageData<Order> pageData = new PageData<>(orders, count, page);
		model.addAttribute("pageData", pageData);
	}

	/**
	 * 成功案例列表
	 * @param model
	 * @param page
	 */
	private void successCaseRecords(Model model, int page) {
		
		//列表数据
		SuccessCaseSearch search = new SuccessCaseSearch();
		search.setManagerId(getManagerId());
		search.setIndex(page-1);
		PageData<SuccessCase> pageData = successCaseService.findSuccessCaseList(search);
		model.addAttribute("pageData", pageData);
		
	}

	/**
	 * 充值记录
	 * @param request
	 * @param searchMoneyAccount
	 */
	private void rechargeRecords(HttpServletRequest request, SearchMoneyAccount searchMoneyAccount) {
		
		List<Recharge> recharges = fundService.getRechargeRecords(searchMoneyAccount);
		int count = fundService.getRechargeRecordsCount(searchMoneyAccount);
		PageData<Recharge> rechargePageData = new PageData<>(recharges, count, searchMoneyAccount.getPage());
		request.getSession().setAttribute("rechargePageData", rechargePageData);
		
	}

	/**
	 * 消费记录
	 * @param request
	 * @param searchMoneyAccount
	 */
	private void consumptionRecords(HttpServletRequest request,SearchMoneyAccount searchMoneyAccount) {
		
		List<Consumption> consumptions = fundService.getConsumptionRecords(searchMoneyAccount);
		int count = fundService.getConsumptionRecordsCount(searchMoneyAccount);
		PageData<Consumption> consumptionPageData = new PageData<>(consumptions, count, searchMoneyAccount.getPage());
		request.getSession().setAttribute("consumptionPageData", consumptionPageData);
	}
	
	/**
	 * 奖励记录
	 * @param request
	 * @param searchMoneyAccount
	 */
	private void rewardRecords(HttpServletRequest request,SearchMoneyAccount searchMoneyAccount) {
		
		List<Reward> rewards = rewardService.getRewardRecords(searchMoneyAccount);
		int count = rewardService.getRewardRecordsCount(searchMoneyAccount);
		PageData<Reward> rewardPageData = new PageData<>(rewards, count, searchMoneyAccount.getPage());
		request.getSession().setAttribute("rewardPageData", rewardPageData);
	}
	
	/**
	 * 提现记录
	 * @param request
	 * @param searchMoneyAccount
	 */
	private void withdrawMoneyRecords(HttpServletRequest request,SearchMoneyAccount searchMoneyAccount) {
		
		List<WithdrawMoney> withdrawMoneys = rewardService.getWithdrawMoneyRecords(searchMoneyAccount);
		int count = rewardService.getWithdrawMoneyRecordsCount(searchMoneyAccount);
		PageData<WithdrawMoney> withdrawMoneyPageData = new PageData<>(withdrawMoneys, count, searchMoneyAccount.getPage());
		request.getSession().setAttribute("withdrawMoneyPageData", withdrawMoneyPageData);
	}
	
	/**
	 * 清空session值
	 * @param request
	 */
	private void clearSession(HttpServletRequest request) {
		request.getSession().removeAttribute("invitationMemberCount");
		request.getSession().removeAttribute("invitationManagerCount");
		request.getSession().removeAttribute("memberPageData");
		request.getSession().removeAttribute("managerPageData");
		request.getSession().removeAttribute("moneyOutline");
		request.getSession().removeAttribute("star");
		request.getSession().removeAttribute("rechargePageData");
		request.getSession().removeAttribute("rewardPageData");
		request.getSession().removeAttribute("withdrawMoneyPageData");
		request.getSession().removeAttribute("consumptionPageData");
	}

	/**
	 * 普通会员推荐
	 * @param model
	 * @param managerId
	 * @param page
	 */
	private void getInvitationMemberInfo(HttpServletRequest request,String managerId,int page){
		
		// 普通会员推荐
		List<InvitationMemberInfo> memberInfos = creditManagerService
				.getInvitationMemberInfo(managerId, 1);
		int memberRecords = creditManagerService
				.getInvitationMemberRecords(managerId);
		PageData<InvitationMemberInfo> memberPageData = new PageData<>(
				memberInfos, memberRecords, 1);
		request.getSession().setAttribute("memberPageData", memberPageData);

	}
	
	/**
	 * 信贷经理推荐
	 * @param model
	 * @param managerId
	 * @param page
	 */
	private void getInvitationManagerInfo(HttpServletRequest request,String managerId,int page) {
		
		// 信贷经理推荐
		List<InvitationMemberInfo> managerInfos = creditManagerService
				.getInvitationManagerInfo(managerId, 1);
		int managerRecords = creditManagerService
				.getInvitationManagerRecords(managerId);
		PageData<InvitationMemberInfo> managerPageData = new PageData<>(
				managerInfos, managerRecords, 1);
		request.getSession().setAttribute("managerPageData", managerPageData);
	}
		
	/**
	 * 获取信贷经理列表
	 * @param model
	 * @param sc 检索条件
	 */
	private void getCreditManagerList(Model model,SearchCreditManager sc) {
		
		PageData<CreditManager> pageData = null;
		
		//信贷经理列表内容
		List<CreditManager> managers = creditManagerService.getMangerListByConditions(sc);
		//数量
		int count = creditManagerService.getManagerCountByConditions(sc);
		
		pageData = new PageData<>(managers, count, sc.getJumpPage());
		
		model.addAttribute("pageData", pageData);
		model.addAttribute("managers", managers);
	}
	
	/**
	 * 检索条件下拉内容
	 * @param model
	 */
	private void getSelectList(Model model) {
		// 省
		List<SelectInfo> provinces = selectService.findProvince();
		model.addAttribute("provinces", provinces);

		// 机构
		List<SelectInfo> organizations = organizationService.getOrganizations();
		model.addAttribute("organizations", organizations);

		// 星级
		List<SelectInfo> stars = selectService
				.findSelectByType(GlobalConstant.STAR_LEVEL);
		model.addAttribute("stars", stars);
	}
	
	/**
	 * 信贷经理详情-标题选择
	 * @param model
	 * @param managerId
	 * @param title
	 */
	private void selectTitle(HttpServletRequest request,String managerId,String title) {
		//信贷经理ID
		setManagerId(managerId);
//		model.addAttribute("managerId", managerId);
		request.getSession().setAttribute("title", title);
	}

	/**
	 * @return the managerId
	 */
	public String getManagerId() {
		return managerId;
	}

	/**
	 * @param managerId the managerId to set
	 */
	public void setManagerId(String managerId) {
		this.managerId = managerId;
	}
}
