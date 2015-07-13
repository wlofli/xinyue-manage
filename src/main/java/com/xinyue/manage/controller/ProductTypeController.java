package com.xinyue.manage.controller;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyue.authe.AutheManage;
import com.xinyue.manage.beans.PageData;
import com.xinyue.manage.beans.ProductTypeInfo;
import com.xinyue.manage.model.ProductType;
import com.xinyue.manage.service.ProductTypeService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;

/**
 * 
 * @author wenhai.you
 * @2015年5月28日
 * @上午9:11:45
 */
@Controller
@RequestMapping("/productType")
public class ProductTypeController {

	@Autowired
	private ProductTypeService ptbiz;
	
	@RequestMapping("/list")
	public String show(Model model , ProductTypeInfo info , HttpServletRequest req){
		//权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.PRODUCT_TYPE_HELP_ADD);
		authList.add(GlobalConstant.PRODUCT_TYPE_HELP_DELETE);
		authList.add(GlobalConstant.PRODUCT_TYPE_HELP_UPDATE);
		authList.add(GlobalConstant.PRODUCT_TYPE_HELP_ENABLE);
		authList.add(GlobalConstant.PRODUCT_TYPE_HELP_DISABLE);
		
		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model,req, authList, "贷款产品分类");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		info.setFstart((info.getFpage()-1)*info.getPageSize());
		PageData<ProductType> pfirst = new PageData<ProductType>(
			ptbiz.findTypeFirst(info), 
			ptbiz.getTypeFirstCount(), info.getFpage());
		
		info.setSstart((info.getSpage()-1)*info.getPageSize());
		PageData<ProductType> psecond = new PageData<ProductType>(
				ptbiz.findTypeSecond(info), 
				ptbiz.getTypeSecondCount(), info.getSpage());
		
		model.addAttribute("pfirst", pfirst);
		model.addAttribute("psecond", psecond);
		model.addAttribute("info", info);
		return "screens/product/protypelist";
	}
	
	@RequestMapping("/toedit")
	public String addProductType(Model model ,String productid){
		if(!GlobalConstant.isNull(productid)){
			ProductType pt = ptbiz.findTypeById(productid);
			
			model.addAttribute("ptype", pt);
			return "screens/product/firstedit";
		}else{
			
			model.addAttribute("ptype", new ProductType());
			model.addAttribute("ptfirst", ptbiz.findTypeFirstList());
		}
		
		return "screens/product/protypeedit";
	}
	
	@RequestMapping("/tosecond")
	public String addProduct(Model model ,String producttypeid){
		
		ProductType pt =new ProductType();
		pt.setParentid(producttypeid);
		model.addAttribute("ptype", pt);
		return "screens/product/secondedit";
	}
	
	@RequestMapping("/save")
	public @ResponseBody String saveProductType(Model model , ProductType ptype , HttpServletRequest req){
		
		boolean b = ptbiz.saveProductType(ptype, AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
	}
	
	@RequestMapping("/del")
	@ResponseBody
	public String delProductType(@RequestBody String id , HttpServletRequest req){
		
		try {
			ptbiz.delProductType(id ,AutheManage.getUsername(req));
			return "success";
		} catch (Exception e) {
			// TODO: handle exception
			return "fail";
		}
	}
	
	
	@RequestMapping("/enable")
	@ResponseBody
	public String enable(@RequestBody String id , HttpServletRequest req){
		
		boolean b = ptbiz.enableProductType(id, AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
	}
	
	@RequestMapping("/unenable")
	@ResponseBody
	public String unenable(@RequestBody String id, HttpServletRequest req){
		
		boolean b = ptbiz.unenableProductType(id, AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
	}
}
