package com.xinyue.manage.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyue.authe.AutheManage;
import com.xinyue.manage.beans.PageInfo;
import com.xinyue.manage.model.Applicant;
import com.xinyue.manage.model.Business;
import com.xinyue.manage.model.CompanyBase;
import com.xinyue.manage.model.Control;
import com.xinyue.manage.model.Debt;
import com.xinyue.manage.model.Document;
import com.xinyue.manage.model.Hold;
import com.xinyue.manage.model.Order;
import com.xinyue.manage.model.OrderAppointed;
import com.xinyue.manage.model.OrderAuction;
import com.xinyue.manage.model.OrderFixed;
import com.xinyue.manage.model.OrderLowPrice;
import com.xinyue.manage.model.RealEstate;
import com.xinyue.manage.service.CompanyInfoService;
import com.xinyue.manage.service.OrderCustomerService;
import com.xinyue.manage.service.OrderService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;

/**
 * author lzc
 * 2015年5月30日下午4:01:32
 */

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Resource
	private OrderService orderService;
	
	@Resource
	private CompanyInfoService companyInfoService;
	
	@Resource
	private OrderCustomerService orderCustomerService;
	
	
	
	@RequestMapping("auditeorderlist")
	public String getAuditeList(HttpServletRequest request,@ModelAttribute Order order, Model model, int index,
			@RequestParam(value="list",required=false)List<String> statusList,@RequestParam(value="block",required=false)String block){
//System.out.println(order.getStatus());
System.out.println(statusList);	
System.out.println(block);
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
	
	
//	@RequestMapping("ajax/auditeorderlist")
//	public @ResponseBody String getAuditeListJson(@ModelAttribute Order order, Model model, int index){
//		JSONObject jsonObject = new JSONObject();
//		List<Order> list = orderService.getListByPage(order, GlobalConstant.PAGE_SIZE, index);
//		jsonObject.accumulate("list", list);
//		CommonFunction cf = new CommonFunction();
//		
//		// 分页传值
//		int countAll = orderService.getCount(order);
//
//		cf.pageList(countAll, index + 1);
////		jsonObject.accumulate("page", pageInfo);
//		
//		
//		return jsonObject.toString();
//	}
	
	
	
	
	@RequestMapping("list")
	public String getListByPage(@ModelAttribute("order")Order order,Model model, int index){
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
	
	
	
//	@RequestMapping("listjson")
//	public @ResponseBody List<Order> getList(@ModelAttribute("order")Order order, int index){
//		List<Order> list = orderService.getListByPage(order, GlobalConstant.PAGE_SIZE, index);
//		return list;
//	}
	
	
	@RequestMapping("turnauditedetail")
	public String turnAuditedetail(Model model, String id, String status){
//System.out.println(status);
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
			return "screens/order/orderAuditeCustomer";
		}else {
			return "screens/order/orderAuditeEdit";
		}
	}
	
	
	@RequestMapping("turndetail")
	public String turnDetail(Model model, String id){
		Order order = orderService.getOrder(id);
		
		model.addAttribute("order", order);
System.out.println(order.getStatus());	
System.out.println(order.getStatus().equals(GlobalConstant.ORDER_STATUS_PASS_SET_CHINESE) 
		|| order.getStatus().equals(GlobalConstant.ORDER_STATUS_PASS_CHINESE));
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
System.out.println(appointed);
		json.accumulate("appointed", appointed);
		
		
		return json.toString();
	}
	
	
	@RequestMapping("getfixed")
	@ResponseBody
	public String getFixed(String orderId){
		JSONObject json = new JSONObject();
		OrderFixed fixed = orderCustomerService.getOrderFixedFromOrder(orderId);
System.out.println(fixed);
		json.accumulate("fixed", fixed);
		return json.toString();
	}
	
	
	/**
	 * 
	 * add by lzc
	 * date: 2015年6月23日
	 * @param request
	 * @param model
	 * @param id 订单的id
	 * @return
	 * 
	 * 修改自companyInfo的scanDetail(Model, String)方法
	 */
	@RequestMapping("turnapplicantdata")
	public String turnApplicantData(HttpServletRequest request,Model model ,String id){
		Order order = orderService.getOrder(id);
		if(order != null){
		//企业相关信息id获取
			HashMap<String, String> companyDetail = companyInfoService.getDetailIdByMemberId(order.getMemberId());
			if(companyDetail != null){
				//申请人信息
				Applicant applicant = new Applicant();
				if (companyDetail.containsKey("applicant_id")) {
					applicant = companyInfoService.getApplicantInfoById(companyDetail.get("applicant_id"));
				}
				model.addAttribute("applicantInfo", applicant);
				
				//企业基本信息
				CompanyBase companyBase = null;
				if (companyDetail.containsKey("license_id")) {
					companyBase = companyInfoService.getCompanyBaseInfoById(companyDetail.get("license_id"));
				}
				model.addAttribute("companyInfo", companyBase);
				
				//公司控股信息 
				List<Hold> holdList = null;
				//基本经营信息
				List<Business> businessList = null;
				
				
				//上传资料信息
				List<Document> documentList = new ArrayList<Document>();
				if (companyDetail.containsKey("member_id")) {
					holdList = companyInfoService.getHoldInfoById(companyDetail.get("member_id"));
					
					businessList = companyInfoService.getBusinessInfoById(companyDetail.get("member_id"));
					
					//modify by lzc 加入订单有关的document 
					
					documentList = orderService.getDocumentInfoById(order.getId());
				}
				if (holdList == null || holdList.size() == 0) {
					holdList = new ArrayList<Hold>();
					Hold hold = new Hold();
					holdList.add(hold);
				}
				if (businessList == null || businessList.size() == 0) {
					businessList = new ArrayList<Business>();
					Business business = new Business();
					businessList.add(business);
				}
				model.addAttribute("holdList", holdList);
				model.addAttribute("businessList", businessList);
				model.addAttribute("documentList", documentList);
				
				//公司治理信息
				Control control = null;
				if (companyBase != null) {
					control = companyInfoService.getControlInfoById(companyBase.getControlInfo());
				}
				model.addAttribute("controlinfo", control);
				
				//抵押物与负债
				RealEstate realEstate = new RealEstate();
				if (companyDetail.containsKey("estate_id")) {
					realEstate = companyInfoService.getRealEstateInfoById(companyDetail.get("estate_id"));
				}
				model.addAttribute("estateInfo", realEstate);
				
				Debt debt = new Debt();
				if (companyDetail.containsKey("debt_id")) {
					debt = companyInfoService.getDebtInfoById(companyDetail.get("debt_id"));
				}
				model.addAttribute("debtInfo", debt);
			}
		
		}
		
		
		return "screens/companyInfo/companyDetail";
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
//System.out.println(order.getStatus());	
		try {
			order.setModifiedId(AutheManage.getUsername(request));
			orderService.updateOrder(order);
		} catch (Exception e) {
			// TODO: handle exception
			return GlobalConstant.RET_FAIL;
		}
		return GlobalConstant.RET_SUCCESS;
//		return "redirect:/order/auditeorderlist?index=0";
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
System.out.println("in");
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
	
	@RequestMapping("addlowprice")
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
	public @ResponseBody String addAppointed(String id,@ModelAttribute("appint")OrderAppointed orderAppointed, HttpServletRequest request){
		
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
	
	
	
}