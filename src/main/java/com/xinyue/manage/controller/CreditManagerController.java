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

import com.xinyue.manage.beans.CustomerInfo;
import com.xinyue.manage.beans.InvitationMemberInfo;
import com.xinyue.manage.beans.OrderCustomer;
import com.xinyue.manage.beans.PageData;
import com.xinyue.manage.beans.QuestionBean;
import com.xinyue.manage.beans.SearchCreditManager;
import com.xinyue.manage.beans.SearchCustomer;
import com.xinyue.manage.beans.SearchMoneyAccount;
import com.xinyue.manage.beans.SelectInfo;
import com.xinyue.manage.beans.SuccessCaseSearch;
import com.xinyue.manage.model.AuthenticationCM;
import com.xinyue.manage.model.Consumption;
import com.xinyue.manage.model.CreditManager;
import com.xinyue.manage.model.Order;
import com.xinyue.manage.model.OrderTrack;
import com.xinyue.manage.model.Recharge;
import com.xinyue.manage.model.Reward;
import com.xinyue.manage.model.SuccessCase;
import com.xinyue.manage.model.WithdrawMoney;
import com.xinyue.manage.service.AnswerService;
import com.xinyue.manage.service.CreditManagerService;
import com.xinyue.manage.service.FundService;
import com.xinyue.manage.service.OrderCustomerService;
import com.xinyue.manage.service.OrderService;
import com.xinyue.manage.service.OrderTrackService;
import com.xinyue.manage.service.OrganizationService;
import com.xinyue.manage.service.ProductService;
import com.xinyue.manage.service.RewardService;
import com.xinyue.manage.service.SelectService;
import com.xinyue.manage.service.SuccessCaseService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;
/**
 * ywh modify 
 * 2015-12-01 invitationChangepage
 * 2015-12-08 modify  saveCreditManager  saveAudit
 * 2015-12-09 baseInfoCM  inviteUserCM   getServerRating
 */
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
	
	@Resource
	private ProductService productService;
	
	@Resource
	private OrderService orderService;
	
	@Resource
	private OrderTrackService orderTrackService;
	
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
		
		try {
			creditManagerService.saveCreditManager(creditManager);
			return "redirect:/credit/manager/list";
		} catch (Exception e) {
			// TODO: handle exception
			model.addAttribute("creditManager", creditManager);
			model.addAttribute("message", "保存失败");
			getSelectList(model);
			return "screens/creditManager/creditManagerEdit";
		}
	
	}
	
	//ywh 2015-11-13 
	@RequestMapping(value="/audit/save",method=RequestMethod.POST)
	@ResponseBody
	public String saveAudit(HttpServletRequest request,Model model,AuthenticationCM authenticationCM) {
		
		try {
			creditManagerService.updateAudit(authenticationCM);
			return GlobalConstant.RET_SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
			return GlobalConstant.RET_FAIL;
		}
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
		if(GlobalConstant.isNull(managerId)){
			selectTitle(request, getManagerId(), "base_info");
		}else{
			selectTitle(request,managerId, "base_info");
		}
		//基本信息
		CreditManager creditManager = creditManagerService.getCreditManagerById(getManagerId());
		model.addAttribute("creditManager", creditManager);
		
		//认证信息
		AuthenticationCM authenticationCM = creditManagerService.getAuthenticationById(managerId);
		//you start
		if(GlobalConstant.isNull(authenticationCM)){
			authenticationCM = new AuthenticationCM();
		}
		authenticationCM.setRecommend(creditManager.getRecommend());
		authenticationCM.setManagerId(managerId);
		//you over
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
	public String inviteUserCM(HttpServletRequest request,Model model) {
		
		clearSession(request);
		
		//标题选择
		String managerId = request.getParameter("managerId");
		if(GlobalConstant.isNull(managerId)){
			selectTitle(request, getManagerId(), "invite_user");
		}else{
			selectTitle(request,managerId, "invite_user");
		}
		
		
		// 普通会员推荐人数
		int invitationMemberCount = creditManagerService
				.getInvitationMemberCount(getManagerId());
		request.getSession().setAttribute("invitationMemberCount", invitationMemberCount);
		getInvitationMemberInfo(request, getManagerId(), 1);
		
		// 信贷经理推荐人数
		int invitationManagerCount = creditManagerService
				.getInvitationManagerCount(getManagerId());
		request.getSession().setAttribute("invitationManagerCount", invitationManagerCount);
		getInvitationManagerInfo(request, getManagerId(), 1);
		String i = request.getParameter("i");
		if(!GlobalConstant.isNull(i)){
			model.addAttribute("i", i);
		}
		model.addAttribute("i", i);
		
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
			model.addAttribute("i", 0);
		}else if (type.equals("manager")) {
			getInvitationManagerInfo(request, getManagerId(), toPage);
			model.addAttribute("i", 1);
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
	public String moneyAccount(HttpServletRequest request,Model model) {
		
		clearSession(request);
		//标题选择
		selectTitle(request, getManagerId(), "money_account");
		model.addAttribute("tab", "1");
		//统括信息
//		MoneyOutline moneyOutline = creditManagerService.getMoneyAccountByManagerId(managerId);
//		request.getSession().setAttribute("moneyOutline", moneyOutline);
		
		SearchMoneyAccount searchMoneyAccount = new SearchMoneyAccount();
		searchMoneyAccount.setManagerId(getManagerId());
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
	
	/**
	 * 客户信息
	 * @param request
	 * @param model
	 * @param managerId
	 * @return
	 */
	@RequestMapping(value="/detail/ci")
	public String customerInfo(HttpServletRequest request,Model model) {
		
		clearSession(request);
		
		selectTitle(request, getManagerId(), "customer_info");
		
		//检索条件
		SearchCustomer searchCustomer = new SearchCustomer();
		searchCustomer.setManagerId(getManagerId());
		model.addAttribute("searchCustomer", searchCustomer);
		
		//产品信息
		List<SelectInfo> products = productService.findProductsManagerId(getManagerId());
		request.getSession().setAttribute("products", products);
		
		//订单状态
		List<SelectInfo> orderStatus = selectService.findSelectByType(GlobalConstant.ORDER_STATUS);
		request.getSession().setAttribute("orderStatus", orderStatus);
		
		//领取方式
		List<SelectInfo> orderTypes = selectService.findSelectByType(GlobalConstant.ORDER_TYPE);
		request.getSession().setAttribute("orderTypes", orderTypes);
		
		//全部订单
		getCustomerInfoAll(request,searchCustomer);
		//系统推送
		
		//人工推送
		
		return "screens/creditManager/creditManagerCustomerInfo";
	}
	
	
	
	/**
	 * 客户信息查询
	 * @param request
	 * @param model
	 * @param searchCustomer
	 * @return
	 */
	@RequestMapping(value="/customer/search",method=RequestMethod.POST)
	public String customerInfoPage(HttpServletRequest request,Model model,SearchCustomer searchCustomer) {
		
		getCustomerInfoAll(request, searchCustomer);
		model.addAttribute("searchCustomer", searchCustomer);
		
		return "screens/creditManager/creditManagerCustomerInfo";
	}
	
	/**
	 * 客户信息跟踪
	 * @param request
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/detail/ci/track")
	public String customerTrack(HttpServletRequest request,Model model,String id) {
		
		//订单详情
		CustomerInfo customerInfo = orderService.getOrderTrackByOrderId(id);
		model.addAttribute("customerInfo", customerInfo);
		
		//跟踪记录
		 List<OrderTrack> orderTracks = orderTrackService.getOrderTrackList(id, "1", 0, 0);
		 model.addAttribute("orderTracks", orderTracks);
		 
		return "screens/creditManager/creditManagerCustomerInfoTrack";
	}
	
	/**
	 * 成功案例
	 * @param request
	 * @param model
	 * @param managerId
	 * @return
	 */
	@RequestMapping(value="/detail/sc")
	public String successCase(HttpServletRequest request,Model model) {
		
		clearSession(request);
		//标题选择
		selectTitle(request, getManagerId(), "success_case");
		
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
	public String successCasePage(HttpServletRequest request,Model model,int toPage) {
		
		successCaseRecords(model,toPage);
		
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
	public String serverRating(HttpServletRequest request,Model model) {
		
		clearSession(request);
		//标题选择
		selectTitle(request, getManagerId(), "server_rating");
		
		int serverStar = creditManagerService.getServerStar(getManagerId());
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
	 * 全部订单
	 * @param request
	 * @param searchCustomer
	 */
	/**
	private void getCustomerInfoAll(HttpServletRequest request,
			SearchCustomer searchCustomer) {
		
		List<CustomerInfo> allInfo = orderService.getCustomerInfoByCondition(searchCustomer);
		int count = orderService.getCustomerInfoCountByCondition(searchCustomer);
		PageData<CustomerInfo> allPageData = new PageData<>(allInfo, count, searchCustomer.getPage());
		request.getSession().setAttribute("allPageData", allPageData);
	}
	*/
	
	//ywh start 2015-12-18
	@Resource
	private OrderCustomerService os;
	private void getCustomerInfoAll(HttpServletRequest request,
			SearchCustomer searchCustomer) {
		
		List<OrderCustomer> allInfo = os.getMyCustomer(searchCustomer, searchCustomer.getManagerId(), (searchCustomer.getPage()-1)*GlobalConstant.PAGE_SIZE, GlobalConstant.PAGE_SIZE);
		int count = os.countMyCustomer(searchCustomer,searchCustomer.getManagerId());
		PageData<OrderCustomer> allPageData = new PageData<OrderCustomer>(allInfo, count, searchCustomer.getPage());
		request.getSession().setAttribute("allPageData", allPageData);
	}
	
	//ywh over 2015-12-18
	
	
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
		model.addAttribute("st", star);
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
		request.getSession().removeAttribute("products");
		request.getSession().removeAttribute("orderTypes");
		request.getSession().removeAttribute("orderStatus");
		request.getSession().removeAttribute("allPageData");
		request.getSession().removeAttribute("title");
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
				.getInvitationMemberInfo(managerId, page);
		int memberRecords = creditManagerService
				.getInvitationMemberRecords(managerId);
		PageData<InvitationMemberInfo> memberPageData = new PageData<>(
				memberInfos, memberRecords, page);
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
				.getInvitationManagerInfo(managerId, page);
		int count = creditManagerService
				.getInvitationManagerRecords(managerId);
		PageData<InvitationMemberInfo> managerPageData = new PageData<>(
				managerInfos, count, page);
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
	
	//ywh start
	@Resource
	private AnswerService abiz;
	/**
	 * 后台  信贷经理 客户问答 新越网问题
	 * @param req
	 * @param model
	 * @param managerId
	 * @return
	 */
	@RequestMapping("/detail/xans")
	public String answerx(HttpServletRequest req , Model model){
		//标题选择
		String createid = getManagerId();
		selectTitle(req , createid , "customer_question");
		
		String index = req.getParameter("index");
		if(GlobalConstant.isNull(index)){
			QuestionBean myanswer = abiz.getMyAnswer(createid);
			if(GlobalConstant.isNull(myanswer)){
				myanswer = new QuestionBean();
			}
			req.getSession().setAttribute("myanswer", myanswer);
			
			QuestionBean recentanswer = abiz.getRecentlyAnswer(createid);
			if(GlobalConstant.isNull(recentanswer)){
				recentanswer = new QuestionBean();
			}
			req.getSession().setAttribute("recentanswer", recentanswer);
		}
		
		//新越平台问题
		model.addAttribute("xanswerpage", abiz.findAdminXPossAnswer(createid, "1", req.getParameter("topage")));
		return "screens/creditManager/creditquestx";
	}
	
	/**
	 * 后台  信贷经理 客户问答 机构问题
	 * @param req
	 * @param model
	 * @param managerId
	 * @return
	 */
	@RequestMapping("/detail/jans")
	public String answerj(HttpServletRequest req , Model model){
		//标题选择
		String createid = getManagerId();
		selectTitle(req , createid, "customer_question");
		
		
		String index = req.getParameter("index");
		if(GlobalConstant.isNull(index)){
			QuestionBean myanswer = abiz.getMyAnswer(createid);
			if(GlobalConstant.isNull(myanswer)){
				myanswer = new QuestionBean();
			}
			req.getSession().setAttribute("myanswer", myanswer);
			
			QuestionBean recentanswer = abiz.getRecentlyAnswer(createid);
			if(GlobalConstant.isNull(recentanswer)){
				recentanswer = new QuestionBean();
			}
			req.getSession().setAttribute("recentanswer", recentanswer);
		}
		//新越平台问题
		model.addAttribute("janswerpage", abiz.findAdminXPossAnswer(createid, "2", req.getParameter("topage")));
		return "screens/creditManager/creditquestj";
	}
	//ywh over
}
