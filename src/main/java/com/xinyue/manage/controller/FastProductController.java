package com.xinyue.manage.controller;


import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyue.authe.AutheManage;
import com.xinyue.manage.beans.PageInfo;
import com.xinyue.manage.beans.SelectInfo;
import com.xinyue.manage.model.FastProduct;
import com.xinyue.manage.model.OrderAppointed;
import com.xinyue.manage.model.OrderAuction;
import com.xinyue.manage.model.OrderFixed;
import com.xinyue.manage.model.OrderLowPrice;
import com.xinyue.manage.service.FastProductService;
import com.xinyue.manage.service.OrderCustomerService;
import com.xinyue.manage.service.SelectService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;


@Controller
@RequestMapping("/fastproduct")
public class FastProductController {
	@Autowired
	private FastProductService fastProductService;
	
	@Autowired
	private OrderCustomerService orderCustomerService;
	
	@Resource
	private SelectService selectService;
	
	@RequestMapping("/list")
	public String fastProductList(Model model, @ModelAttribute("fastproduct")FastProduct fastProduct, int index){
		model.addAttribute("fastproductlist", fastProductService.getListByPage(fastProduct, index, GlobalConstant.PAGE_SIZE));
		PageInfo pageInfo = new PageInfo();
		CommonFunction cf = new CommonFunction();
		
		// 分页传值
		int countAll = fastProductService.countFastProduct(fastProduct);

		pageInfo = cf.pageList(countAll, index + 1);
		model.addAttribute("page", pageInfo);
	
		model.addAttribute("status", fastProductService.getStatus(GlobalConstant.ORDER_STATUS));
		model.addAttribute("ordertype", fastProductService.getStatus(GlobalConstant.ORDER_TYPE));
		model.addAttribute("orderstatus",fastProductService.getStatus(GlobalConstant.ORDER_GET_STATUS));

		return "screens/fastProduct/fastProductList";
	}
	
	
	@RequestMapping(value={"turnupdate"})
	public String turnFastProductEdit(Model model,String id){
		FastProduct fastProduct = fastProductService.getFastProduct(id);
		model.addAttribute("fspdt", fastProduct);
		if(fastProduct.getStatus().equals(GlobalConstant.ORDER_STATUS_PASS_CHINESE) 
				|| fastProduct.getStatus().equals(GlobalConstant.ORDER_STATUS_PASS_SET_CHINESE)){
System.out.println(fastProduct.getOrderType());
			if(fastProduct.getOrderType() != null){
				switch (fastProduct.getOrderType()) {
					case GlobalConstant.ORDER_TYPE_FIXED_CHINESE:
						OrderFixed orderFixed  = orderCustomerService.getOrderFixed(fastProduct.getId(),GlobalConstant.FASUPRODUCT_CUSTOMER_TYPE);
						model.addAttribute("fixed",orderFixed);
						break;
					case GlobalConstant.ORDER_TYPE_AUCTION_CHINESE:
						OrderAuction orderAuction = orderCustomerService.getOrderAuction(fastProduct.getId(),GlobalConstant.FASUPRODUCT_CUSTOMER_TYPE);
						model.addAttribute("auction", orderAuction);
						break;
					case GlobalConstant.ORDER_TYPE_LOWPRICE_CHINESE:
						OrderLowPrice orderLowPrice = orderCustomerService.getOrderLowPrice(fastProduct.getId(),GlobalConstant.FASUPRODUCT_CUSTOMER_TYPE);
						model.addAttribute("lowprice", orderLowPrice);
						break;
					case GlobalConstant.ORDER_TYPE_APPOINTED_CHINESE:
						OrderAppointed orderAppointed = orderCustomerService.getOrderAppointed(fastProduct.getId(),GlobalConstant.FASUPRODUCT_CUSTOMER_TYPE);
						model.addAttribute("appointed", orderAppointed);
						break;
					default:
						break;
				}
			}
			getOrderDetailSelectInfo(model);
			return "screens/fastProduct/fastProductOrderEdit";
		}else {
			return "screens/fastProduct/fastProductEdit";
		}
	}
	
	
	@RequestMapping(value={"update"})
	public @ResponseBody String  updateFastProduct(@ModelAttribute("fspdt")FastProduct fastProduct,HttpServletRequest request){
//System.out.println(fastProduct.getStatus());
//System.out.println(fastProduct.getRemark());
		try {
			fastProductService.updateFastProductStatus(fastProduct,AutheManage.getUsername(request));
		} catch (Exception e) {
			// TODO: handle exception
			return GlobalConstant.RET_FAIL;
		}
		return GlobalConstant.RET_SUCCESS;
	}
	
	@RequestMapping("updatestatuslist")
	public @ResponseBody String updateStatusList(@ModelAttribute("list")List<String> idList, HttpServletRequest request){
		try {
			fastProductService.updateFastProductStatusList(idList, GlobalConstant.ORDER_STATUS_BLANK, AutheManage.getUsername(request));
		} catch (Exception e) {
			// TODO: handle exception
			return GlobalConstant.RET_FAIL;
		}
		return GlobalConstant.RET_SUCCESS;
	}
	
	
	@RequestMapping("addfixed")
	public @ResponseBody String addFixed(String id,@ModelAttribute("fixed")OrderFixed orderFixed,
			HttpServletRequest request){
		orderFixed.setType(GlobalConstant.FASUPRODUCT_CUSTOMER_TYPE);
		orderFixed.setCreatedId(AutheManage.getUsername(request));
		orderFixed.setModifiedId(AutheManage.getUsername(request));
		orderFixed.setOrderId(id);
		orderFixed.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		try {
			orderCustomerService.addOrderFixed(orderFixed, GlobalConstant.FASTPRODUCT_TABNAME_FAST, 
					GlobalConstant.ORDER_ORDERSTATUS_NOSTART);
		} catch (Exception e) {
			// TODO: handle exception
			return GlobalConstant.RET_FAIL;
		}
		return GlobalConstant.RET_SUCCESS;
	}
	
	@RequestMapping("addauction")
	public @ResponseBody String addAuction(String id,@ModelAttribute("auction")OrderAuction orderAuction, 
			HttpServletRequest request){
//System.out.println("in");
		orderAuction.setType(GlobalConstant.FASUPRODUCT_CUSTOMER_TYPE);
		orderAuction.setCreatedId(AutheManage.getUsername(request));
		orderAuction.setModifiedId(AutheManage.getUsername(request));
		orderAuction.setOrderId(id);
		orderAuction.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		try {
			orderCustomerService.addOrderAuction(orderAuction, GlobalConstant.FASTPRODUCT_TABNAME_FAST,
					GlobalConstant.ORDER_ORDERSTATUS_NOSTART);
		} catch (Exception e) {
			// TODO: handle exception
			return GlobalConstant.RET_FAIL;
		}
		return GlobalConstant.RET_SUCCESS;
	}
	
	@RequestMapping("addlowprice")
	public @ResponseBody String addLowPrice(String id,@ModelAttribute("lowprice")OrderLowPrice orderLowPrice, HttpServletRequest request){
		orderLowPrice.setType(GlobalConstant.FASUPRODUCT_CUSTOMER_TYPE);
		orderLowPrice.setCreatedId(AutheManage.getUsername(request));
		orderLowPrice.setModifiedId(AutheManage.getUsername(request));
		orderLowPrice.setOrderId(id);
		orderLowPrice.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		try {
			orderCustomerService.addOrderLowPrice(orderLowPrice, GlobalConstant.FASTPRODUCT_TABNAME_FAST,
					GlobalConstant.ORDER_ORDERSTATUS_NOSTART);
		} catch (Exception e) {
			// TODO: handle exception
			return GlobalConstant.RET_FAIL;
		}
		return GlobalConstant.RET_SUCCESS;
	}
	
	
	@RequestMapping("addappoint")
	public @ResponseBody String addAppointed(String id,@ModelAttribute("appint")OrderAppointed orderAppointed, 
			HttpServletRequest request){
		
		orderAppointed.setType(GlobalConstant.FASUPRODUCT_CUSTOMER_TYPE);
		orderAppointed.setCreatedId(AutheManage.getUsername(request));
		orderAppointed.setModifiedId(AutheManage.getUsername(request));
		orderAppointed.setOrderId(id);
		orderAppointed.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		try {
			orderCustomerService.addOrderAppointed(orderAppointed, GlobalConstant.FASTPRODUCT_TABNAME_FAST, 
					GlobalConstant.ORDER_ORDERSTATUS_NOSTART);
		} catch (Exception e) {
			// TODO: handle exception
			return GlobalConstant.RET_FAIL;
		}
		return GlobalConstant.RET_SUCCESS;
	}
	
	
	@RequestMapping("deleteordercustomer")
	public @ResponseBody String deleteOrderCustomer(String id, HttpServletRequest request){
		try {
			orderCustomerService.deleteOrderCustom(GlobalConstant.FASTPRODUCT_TABNAME_FAST, id, 
					AutheManage.getUsername(request), GlobalConstant.ORDER_ORDERSTATUS_RESET);
		} catch (Exception e) {
			// TODO: handle exception
			return GlobalConstant.RET_FAIL;
		}
		
		return GlobalConstant.RET_SUCCESS;
	}
	
	
	
	@RequestMapping("getappointed")
	@ResponseBody
	public String getAppointed(String orderId){
		JSONObject json = new JSONObject();
System.out.println(orderId);
		OrderAppointed appointed = orderCustomerService.getOrderAppointedFromFastProduct(orderId);
//System.out.println(appointed);
		if(appointed != null){
			json.accumulate("appointed", appointed);
			json.accumulate(GlobalConstant.RET_JSON_RESULT, GlobalConstant.RET_SUCCESS);
		}else {
			json.accumulate(GlobalConstant.RET_JSON_RESULT, GlobalConstant.RET_FAIL);
		}
		return json.toString();
	}
	
	
	@RequestMapping("getfixed")
	@ResponseBody
	public String getFixed(String orderId){
System.out.println(orderId);
		JSONObject json = new JSONObject();
		OrderFixed fixed = orderCustomerService.getOrderFixedFromFastProduct(orderId);
System.out.println(fixed);
		if(fixed != null){
			json.accumulate("fixed", fixed);
//			System.out.println(fixed.getCompanyType());
			json.accumulate(GlobalConstant.RET_JSON_RESULT, GlobalConstant.RET_SUCCESS);
		}else {
			json.accumulate(GlobalConstant.RET_JSON_RESULT, GlobalConstant.RET_FAIL);
		}
		return json.toString();
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