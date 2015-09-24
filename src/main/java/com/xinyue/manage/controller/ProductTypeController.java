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
 * 产品类型 productType
 * @author wenhai.you
 * @2015年5月28日
 * @上午9:11:45
 */
@Controller
@RequestMapping("/productType")
public class ProductTypeController {

	@Autowired
	private ProductTypeService ptbiz;
	
	/**
	 * ywh 产品类型列表 
	 * @param model
	 * @param info
	 * @param req
	 * @return
	 */
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
		
		model.addAttribute("pfirst", ptbiz.findFirstPagedata(info));
		model.addAttribute("psecond",  ptbiz.findSecondPagedata(info));
		
		model.addAttribute("info", info);
		return "screens/product/protypelist";
	}
	
	
	/**
	 * ywh 跳转到编辑页面
	 * @param model
	 * @param productid
	 * @return
	 */
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
	
	/**
	 * ywh 跳转到二级分类
	 * @param model
	 * @param producttypeid
	 * @return
	 */
	@RequestMapping("/tosecond")
	public String addProduct(Model model ,String producttypeid){
		
		ProductType pt =new ProductType();
		pt.setParentid(producttypeid);
		model.addAttribute("ptype", pt);
		return "screens/product/secondedit";
	}
	
	/**
	 * ywh 保存产品类型
	 * @param model
	 * @param ptype
	 * @param req
	 * @return
	 */
	@RequestMapping("/save")
	public @ResponseBody String saveProductType(Model model , ProductType ptype , HttpServletRequest req){
		
		boolean b = ptbiz.saveProductType(ptype, AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
	}
	
	/**
	 * ywh 删除产品分类 
	 * @param id
	 * @param req
	 * @return
	 */
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
	
	/**
	 * ywh 启用产品分类 
	 * @param id
	 * @param req
	 * @return
	 */
	@RequestMapping("/enable")
	@ResponseBody
	public String enable(@RequestBody String id , HttpServletRequest req){
		
		boolean b = ptbiz.enableProductType(id, AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
	}
	
	/**
	 * ywh 禁用产品分类
	 * @param id
	 * @param req
	 * @return
	 */
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
