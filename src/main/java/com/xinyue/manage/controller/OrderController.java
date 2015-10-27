package com.xinyue.manage.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyue.authe.AutheManage;
import com.xinyue.manage.beans.OrderInfo;
import com.xinyue.manage.beans.PageInfo;
import com.xinyue.manage.beans.SelectInfo;
import com.xinyue.manage.model.Applicant;
import com.xinyue.manage.model.Business;
import com.xinyue.manage.model.CompanyBase;
import com.xinyue.manage.model.Control;
import com.xinyue.manage.model.CreditManager;
import com.xinyue.manage.model.Debt;
import com.xinyue.manage.model.Document;
import com.xinyue.manage.model.FastProduct;
import com.xinyue.manage.model.FastProductApplicant;
import com.xinyue.manage.model.FastProductCompany;
import com.xinyue.manage.model.Hold;
import com.xinyue.manage.model.Order;
import com.xinyue.manage.model.OrderAppointed;
import com.xinyue.manage.model.OrderAuction;
import com.xinyue.manage.model.OrderFixed;
import com.xinyue.manage.model.OrderLowPrice;
import com.xinyue.manage.model.OrderTrack;
import com.xinyue.manage.model.RealEstate;
import com.xinyue.manage.plugin.JsonConfigFactory;
import com.xinyue.manage.service.CompanyInfoService;
import com.xinyue.manage.service.FastProductService;
import com.xinyue.manage.service.OrderCustomerService;
import com.xinyue.manage.service.OrderService;
import com.xinyue.manage.service.OrderTrackService;
import com.xinyue.manage.service.SelectService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;

/**
 * author lzc
 * 2015年5月30日下午4:01:32
 */

@Controller
@RequestMapping("/order")
public class OrderController {
	
	
	@Autowired
	private ApplicationContext ctx;
	
	@Autowired
	private OrderService orderService;
	
	@Resource
	private FastProductService fastProductService;
	
	@Resource
	private CompanyInfoService companyInfoService;
	
	@Resource
	private OrderCustomerService orderCustomerService;
	
	@Resource
	private SelectService selectService;
	
	@Resource
	private OrderTrackService orderTrackService;
	
	
	
	@RequestMapping(value={"auditeorderlist"})
	public String getAuditeList(HttpServletRequest request,@ModelAttribute Order order, Model model, int index,
			@RequestParam(value="list",required=false)List<String> statusList,@RequestParam(value="block",required=false)String block){
		//权限操作
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.ORDER_AUDITE_UNCHECK);
		authList.add(GlobalConstant.ORDER_AUDITE_TAX);
		authList.add(GlobalConstant.ORDER_AUDITE_BLANK);
		
		CommonFunction cf = new CommonFunction();
		cf.getAuth(model,request, authList, GlobalConstant.ORDER_AUDITE_NAME);
		

		List<Order> list = orderService.getListByStatus(order, GlobalConstant.PAGE_SIZE, index, statusList);
		model.addAttribute("auditestatus", block);
		model.addAttribute("orderlist", list);
		model.addAttribute("status", orderService.getStatus(GlobalConstant.ORDER_STATUS));
		model.addAttribute("ordertype", orderService.getStatus(GlobalConstant.ORDER_TYPE));
		model.addAttribute("orderstatus", orderService.getStatus(GlobalConstant.ORDER_GET_STATUS));
		PageInfo pageInfo = new PageInfo();
		
		// 分页传值
		int countAll = orderService.getCountByStatus(order, statusList);

		pageInfo = cf.pageList(countAll, index + 1);
		model.addAttribute("page", pageInfo);
                       
		return "screens/order/orderAudite";
	}
	
	
	@RequestMapping("list")
	public String getListByPage(@ModelAttribute("order")Order order,Model model, @RequestParam(defaultValue="0")int index){
		List<Order> list = orderService.getListByPage(order, GlobalConstant.PAGE_SIZE, index);
		
		model.addAttribute("orderlist", list);
		model.addAttribute("status", orderService.getStatus(GlobalConstant.ORDER_STATUS));
		model.addAttribute("ordertype", orderService.getStatus(GlobalConstant.ORDER_TYPE));
		model.addAttribute("orderstatus",orderService.getStatus(GlobalConstant.ORDER_GET_STATUS));
		PageInfo pageInfo = new PageInfo();
		CommonFunction cf = new CommonFunction();
		
		// 分页传值
		int countAll = orderService.getCount(order);

		pageInfo = cf.pageList(countAll, index + 1);
		model.addAttribute("page", pageInfo);
		return "screens/order/OrderList";
	}
	
	@RequestMapping("turnauditedetail")
	public String turnAuditedetail(Model model, String id, String status){
		Order order = orderService.getOrder(id);
		model.addAttribute("order", order);
		model.addAttribute("auditestatus", status);//useless
		if(order.getStatus() != null &&  (order.getStatus().equals(GlobalConstant.ORDER_STATUS_PASS_SET_CHINESE)|| 
				order.getStatus().equals(GlobalConstant.ORDER_STATUS_PASS_CHINESE))){
			if(order.getOrderType() != null){
				switch (order.getOrderType()) {
				case GlobalConstant.ORDER_TYPE_FIXED_CHINESE:
					OrderFixed orderFixed  = orderCustomerService.getOrderFixed(order.getId(),GlobalConstant.ORDER_CUSTOMER_TYPE);
					model.addAttribute("fixed",orderFixed);
					break;
				case GlobalConstant.ORDER_TYPE_AUCTION_CHINESE:
					OrderAuction orderAuction = orderCustomerService.getOrderAuction(order.getId(),GlobalConstant.ORDER_CUSTOMER_TYPE);
					model.addAttribute("auction", orderAuction);
					break;
				case GlobalConstant.ORDER_TYPE_LOWPRICE_CHINESE:
					OrderLowPrice orderLowPrice = orderCustomerService.getOrderLowPrice(order.getId(),GlobalConstant.ORDER_CUSTOMER_TYPE);
					model.addAttribute("lowprice", orderLowPrice);
					break;
				case GlobalConstant.ORDER_TYPE_APPOINTED_CHINESE:
					OrderAppointed orderAppointed = orderCustomerService.getOrderAppointed(order.getId(),GlobalConstant.ORDER_CUSTOMER_TYPE);
					model.addAttribute("appointed", orderAppointed);
					break;
				default:
					break;
				}
			}
			getOrderDetailSelectInfo(model);
			return "screens/order/orderAuditeCustomer";
		}else {
			return "screens/order/orderAuditeEdit";
		}
	}
	
	@RequestMapping("turndetail")
	public String turnDetail(Model model, String id){
		Order order = orderService.getOrder(id);
		
		model.addAttribute("order", order);
		if(order.getStatus() != null && (order.getStatus().equals(GlobalConstant.ORDER_STATUS_PASS_SET_CHINESE) 
				|| order.getStatus().equals(GlobalConstant.ORDER_STATUS_PASS_CHINESE))){
			if(order.getOrderType() != null){
				switch (order.getOrderType()) {
				case GlobalConstant.ORDER_TYPE_FIXED_CHINESE:
					OrderFixed orderFixed  = orderCustomerService.getOrderFixed(order.getId(),GlobalConstant.ORDER_CUSTOMER_TYPE);
					model.addAttribute("fixed",orderFixed);
					break;
				case GlobalConstant.ORDER_TYPE_AUCTION_CHINESE:
					OrderAuction orderAuction = orderCustomerService.getOrderAuction(order.getId(),GlobalConstant.ORDER_CUSTOMER_TYPE);
					model.addAttribute("auction", orderAuction);
					break;
				case GlobalConstant.ORDER_TYPE_LOWPRICE_CHINESE:
					OrderLowPrice orderLowPrice = orderCustomerService.getOrderLowPrice(order.getId(),GlobalConstant.ORDER_CUSTOMER_TYPE);
					model.addAttribute("lowprice", orderLowPrice);
					break;
				case GlobalConstant.ORDER_TYPE_APPOINTED_CHINESE:
					OrderAppointed orderAppointed = orderCustomerService.getOrderAppointed(order.getId(),GlobalConstant.ORDER_CUSTOMER_TYPE);
					model.addAttribute("appointed", orderAppointed);
					break;
				default:
					break;
				}
			}
			getOrderDetailSelectInfo(model);
			
			return "screens/order/orderDetailCustomer";
		}else {
			return "screens/order/OrderDetail";
		}
		
	}
	
	@RequestMapping("getappointed")
	@ResponseBody
	public String getAppointed(String orderId){
		JSONObject json = new JSONObject();
		OrderAppointed appointed = orderCustomerService.getOrderAppointedFromOrder(orderId);
		if(appointed != null){
			json.accumulate("appointed", appointed,JsonConfigFactory.getInstance());
			json.accumulate(GlobalConstant.RET_JSON_RESULT, GlobalConstant.RET_SUCCESS);
		}else {
			json.accumulate(GlobalConstant.RET_JSON_RESULT, GlobalConstant.RET_FAIL);
		}
		return json.toString();
	}
	
	
	@RequestMapping("getfixed")
	@ResponseBody
	public String getFixed(Model model,String orderId){
		JSONObject json = new JSONObject();
		OrderFixed fixed = orderCustomerService.getOrderFixedFromOrder(orderId);
		if(fixed != null){
			json.accumulate("fixed", fixed,JsonConfigFactory.getInstance());
			json.accumulate(GlobalConstant.RET_JSON_RESULT, GlobalConstant.RET_SUCCESS);
		}else {
			json.accumulate(GlobalConstant.RET_JSON_RESULT, GlobalConstant.RET_FAIL);
		}
		return json.toString();
	}
	
	
	@RequestMapping("turnapplicantdata")
	public String turnApplicantDetail(Model model ,String id){
		Order order = orderService.getOrderInfo(id);

		Applicant applicant = new Applicant();
		applicant = companyInfoService.getApplicantInfoById(order.getApplicantInfo());
		model.addAttribute("applicantInfo", applicant);
		
		CompanyBase companyBase = companyInfoService.getCompanyBaseInfoById(order.getLicenseInfo());
		model.addAttribute("companyInfo", companyBase);
		
		
		List<Hold> holdList = companyInfoService.getHoldByOrderId(order.getId());
		model.addAttribute("holdList", holdList);		
		
		List<Business> businesseList = companyInfoService.getBusinessInfoById(order.getId());
		model.addAttribute("businessList", businesseList);
		
		List<Document> documentList = new ArrayList<Document>();
		documentList = orderService.getDocumentInfoById(order.getId());
		model.addAttribute("documentList", documentList);

				
		RealEstate realEstate = companyInfoService.getRealEstateInfoById(order.getRealEstate());
		model.addAttribute("estateInfo", realEstate);
		
		Debt debt = companyInfoService.getDebtInfoById(order.getDebtInfo());
		model.addAttribute("debtInfo", debt);
		
				
		Control control = companyInfoService.getControlInfoById(order.getControlInfo());
		model.addAttribute("controlinfo", control);
		
		return "screens/companyInfo/companyDetail";
	}
	
	
	@RequestMapping("track/list")
	public String trackList(String id,  Model model){
		Order order = orderService.getOrder(id);
		String customerId = new String();
		String orderType = new String();
		if(order.getOrderType() != null){
			switch (order.getOrderType()) {
			case GlobalConstant.ORDER_TYPE_FIXED_CHINESE:
				OrderFixed orderFixed  = orderCustomerService.getOrderFixed(order.getId(),GlobalConstant.ORDER_CUSTOMER_TYPE);
				customerId = orderFixed.getId();
				orderType = GlobalConstant.ORDER_TYPE_FIXED;
				break;
			case GlobalConstant.ORDER_TYPE_AUCTION_CHINESE:
				OrderAuction orderAuction = orderCustomerService.getOrderAuction(order.getId(),GlobalConstant.ORDER_CUSTOMER_TYPE);
				customerId = orderAuction.getId();
				orderType = GlobalConstant.ORDER_TYPE_AUCTION;
				break;
			case GlobalConstant.ORDER_TYPE_LOWPRICE_CHINESE:
				OrderLowPrice orderLowPrice = orderCustomerService.getOrderLowPrice(order.getId(),GlobalConstant.ORDER_CUSTOMER_TYPE);
				customerId = orderLowPrice.getId();
				orderType = GlobalConstant.ORDER_TYPE_LOWPRICE;
				break;
			case GlobalConstant.ORDER_TYPE_APPOINTED_CHINESE:
				OrderAppointed orderAppointed = orderCustomerService.getOrderAppointed(order.getId(),GlobalConstant.ORDER_CUSTOMER_TYPE);
				customerId = orderAppointed.getId();
				orderType = GlobalConstant.ORDER_TYPE_APPOINTED;
				break;
			default:
				break;
			}
		}
		OrderInfo info = orderTrackService.getOrderInfo(customerId, orderType);
		//目前不需要分页展示
		List<OrderTrack> tracklList = orderTrackService.getOrderTrackList(info.getId(), info.getType(),0 ,0);
		model.addAttribute("order", info);
		model.addAttribute("tracklist", tracklList);
		return "screens/order/orderTrackList";
	}
	
	@RequestMapping("updatestatuslist")
	public @ResponseBody String updateOrderStatus(HttpServletRequest request,@ModelAttribute("list")List<String> idList){
		try {
			orderService.updateOrderList(idList, GlobalConstant.ORDER_STATUS_BLANK, AutheManage.getUsername(request));
		} catch (Exception e) {
			// TODO: handle exception
			return GlobalConstant.RET_FAIL;
		}
		return GlobalConstant.RET_SUCCESS;
	}
	
	@RequestMapping("update")
	public @ResponseBody String updateOrder(HttpServletRequest request,@ModelAttribute("order")Order order){
		try {
			order.setModifiedId(AutheManage.getUsername(request));
			orderService.updateOrder(order);
		} catch (Exception e) {
			// TODO: handle exception
			return GlobalConstant.RET_FAIL;
		}
		return GlobalConstant.RET_SUCCESS;
	}
	
	
	@RequestMapping("addfixed")
	public @ResponseBody String addFixed(String id,@ModelAttribute("fixed")OrderFixed orderFixed,HttpServletRequest request){
		orderFixed.setType(GlobalConstant.ORDER_CUSTOMER_TYPE);
		orderFixed.setCreatedId(AutheManage.getUsername(request));
		orderFixed.setModifiedId(AutheManage.getUsername(request));
		orderFixed.setOrderId(id);
		orderFixed.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		try {
			orderCustomerService.addOrderFixed(orderFixed, GlobalConstant.ORDER_TABLENAME, GlobalConstant.ORDER_ORDERSTATUS_NOSTART);
		} catch (Exception e) {
			// TODO: handle exception
			return GlobalConstant.RET_FAIL;
		}
		return GlobalConstant.RET_SUCCESS;
	}
	
	@RequestMapping("addauction")
	public @ResponseBody String addAuction(String id,@ModelAttribute("auction")OrderAuction orderAuction, HttpServletRequest request){
		orderAuction.setType(GlobalConstant.ORDER_CUSTOMER_TYPE);
		orderAuction.setCreatedId(AutheManage.getUsername(request));
		orderAuction.setModifiedId(AutheManage.getUsername(request));
		orderAuction.setOrderId(id);
		orderAuction.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		try {
			orderCustomerService.addOrderAuction(orderAuction, GlobalConstant.ORDER_TABLENAME, GlobalConstant.ORDER_ORDERSTATUS_NOSTART);
		} catch (Exception e) {
			// TODO: handle exception
			return GlobalConstant.RET_FAIL;
		}
		return GlobalConstant.RET_SUCCESS;
	}
	
	@RequestMapping(value="addlowprice", method=RequestMethod.POST)
	public @ResponseBody String addLowPrice(String id,@ModelAttribute("lowprice")OrderLowPrice orderLowPrice, HttpServletRequest request){
		orderLowPrice.setType(GlobalConstant.ORDER_CUSTOMER_TYPE);
		orderLowPrice.setCreatedId(AutheManage.getUsername(request));
		orderLowPrice.setModifiedId(AutheManage.getUsername(request));
		orderLowPrice.setOrderId(id);
		orderLowPrice.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		try {
			orderCustomerService.addOrderLowPrice(orderLowPrice, GlobalConstant.ORDER_TABLENAME, GlobalConstant.ORDER_ORDERSTATUS_NOSTART);
		} catch (Exception e) {
			// TODO: handle exception
			return GlobalConstant.RET_FAIL;
		}
		return GlobalConstant.RET_SUCCESS;
	}
	
	
	@RequestMapping("addappoint")
	public @ResponseBody String addAppointed(String id,@ModelAttribute("appoint")OrderAppointed orderAppointed, HttpServletRequest request){
		orderAppointed.setType(GlobalConstant.ORDER_CUSTOMER_TYPE);
		orderAppointed.setCreatedId(AutheManage.getUsername(request));
		orderAppointed.setModifiedId(AutheManage.getUsername(request));
		orderAppointed.setOrderId(id);
		orderAppointed.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		try {
			orderCustomerService.addOrderAppointed(orderAppointed, GlobalConstant.ORDER_TABLENAME, GlobalConstant.ORDER_ORDERSTATUS_NOSTART);
		} catch (Exception e) {
			// TODO: handle exception
			return GlobalConstant.RET_FAIL;
		}
		return GlobalConstant.RET_SUCCESS;
	}
	
	
	@RequestMapping("deleteordercustomer")
	public @ResponseBody String deleteOrderCustomer(String id, HttpServletRequest request){
		try {
			orderCustomerService.deleteOrderCustom(GlobalConstant.ORDER_TABLENAME, id, 
					AutheManage.getUsername(request), GlobalConstant.ORDER_ORDERSTATUS_RESET);
		} catch (Exception e) {
			// TODO: handle exception
			return GlobalConstant.RET_FAIL;
		}
		return GlobalConstant.RET_SUCCESS;
	}
	
	
	@RequestMapping("getmanagelist")
	@ResponseBody
	public String getManageList(){
		JSONObject json = new JSONObject();
		List<SelectInfo> manageList = orderService.getCreditMangerList();
		if(manageList.size() > 0){
			json.accumulate(GlobalConstant.RET_JSON_RESULT, GlobalConstant.RET_SUCCESS);
			json.accumulate("list", manageList);
		}else {
			json.accumulate(GlobalConstant.RET_JSON_RESULT, GlobalConstant.RET_FAIL);
		}
		return json.toString();
		
	}
	
	@RequestMapping("getmanageinfo")
	@ResponseBody
	public String getManageInfo(String name){
		JSONObject json = new JSONObject();
		try {
			CreditManager creditManager = orderService.getCreditManagerByName(name);
			json.accumulate("manager", creditManager);
			json.accumulate(GlobalConstant.RET_JSON_RESULT, GlobalConstant.RET_SUCCESS);
		} catch (Exception e) {
			// TODO: handle exception
			json.accumulate(GlobalConstant.RET_JSON_RESULT, GlobalConstant.RET_FAIL);
			json.accumulate(GlobalConstant.RET_MESSAGE, "用户姓名出错");
		}
		return json.toString();
	}
	
	
	/**机构管理订单详情
	 * add by lzc     date: 2015年10月9日
	 * @param orderId
	 * @param orderType 1订单2快速申贷
	 * @param model
	 * @return
	 */
	@RequestMapping("getorgdetail")
	public String getOrgDetail(String orderId, String orderType, Model model){
		if(orderType.equals("1")){//订单
			Order order = orderService.getOrderInfo(orderId);
			model.addAttribute("order", order);
			return "screens/organization/orderDetail";
		}else {//快速申贷
			FastProduct fastProduct = fastProductService.getFastProduct(orderId);
			model.addAttribute("fspdt", fastProduct);
			if(fastProduct != null && fastProduct.getType().equals("2")){
				FastProductApplicant applicant = fastProductService.getApplicant(fastProduct.getApplicantFastId());
				FastProductCompany company  = fastProductService.getCompany(fastProduct.getCompanyFastId());
				model.addAttribute("applicant", applicant);
				model.addAttribute("company", company);
			}
			return "screens/organization/fastDetail";
		}
	}
	
	@RequestMapping("getorgedit")
	public String getOrgEdit(String orderId, String orderType, Model model){
		if(orderType.equals("1")){//订单
			Order order = orderService.getOrderInfo(orderId);
			model.addAttribute("order", order);
			return "screens/organization/orderEdit";
		}else {//快速申贷
			FastProduct fastProduct = fastProductService.getFastProduct(orderId);
			model.addAttribute("fspdt", fastProduct);
			if(fastProduct != null && fastProduct.getType().equals("2")){
				FastProductApplicant applicant = fastProductService.getApplicant(fastProduct.getApplicantFastId());
				FastProductCompany company  = fastProductService.getCompany(fastProduct.getCompanyFastId());
				model.addAttribute("applicant", applicant);
				model.addAttribute("company", company);
			}
			return "screens/organization/fastEdit";
		}
	}
	
	
	private void getOrderDetailSelectInfo(Model model){
		List<SelectInfo> companyTypes = selectService.findSelectByType(GlobalConstant.COMPANY_BUSINESS_TYPE);
		model.addAttribute("companytypeList", companyTypes);
		List<SelectInfo> guaranteeTypes = selectService.findSelectByType(GlobalConstant.COMPANY_GUARANTEE_TYPE);
		model.addAttribute("guaranteetypeList", guaranteeTypes);
		List<SelectInfo> creditTypes = selectService.findSelectByType(GlobalConstant.COMPANY_CREDIT_TYPE);
		model.addAttribute("credittypeList", creditTypes);
	}
}