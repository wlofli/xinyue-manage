package com.xinyue.manage.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyue.authe.AutheManage;
import com.xinyue.manage.beans.PageData;
import com.xinyue.manage.beans.ProductInfo;
import com.xinyue.manage.model.Product;
import com.xinyue.manage.service.BankInfoService;
import com.xinyue.manage.service.ProductFileService;
import com.xinyue.manage.service.ProductService;
import com.xinyue.manage.service.ProductTypeService;
import com.xinyue.manage.service.SelectService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;

/**
 * 
 * @author wenhai.you
 * @2015年5月22日
 * @下午6:13:28
 */
@Controller
@RequestMapping("/product")
public class ProductController {

	@Autowired
	private ProductService pbiz;
	
	@Autowired
	private ProductTypeService ptbiz;
	
	@Autowired
	private SelectService sbiz;
	
	@Autowired
	private BankInfoService bibiz;
	
	@Autowired
	private ProductFileService pfbiz;
	
	
	@RequestMapping("/list")
	public String findPage(HttpServletRequest req , HttpServletResponse resp ,  Model model , ProductInfo pinfo){
	
		//权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.PRODUCT_HELP_ADD);
		authList.add(GlobalConstant.PRODUCT_HELP_DELETE);
		authList.add(GlobalConstant.PRODUCT_HELP_UPDATE);
		authList.add(GlobalConstant.PRODUCT_HELP_SHELVE);
		authList.add(GlobalConstant.PRODUCT_HELP_UNSHELVE);
		
		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model,req, authList, "贷款产品列表");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		String topage = req.getParameter("topage");
		int currentPage = (GlobalConstant.isNull(topage)|| topage=="0")?1:Integer.valueOf(topage);
		int count = pbiz.getCount(pinfo);
		pinfo.setStart((currentPage-1)*GlobalConstant.PAGE_SIZE);
		List<Product> pro = pbiz.findList(pinfo);
		
		PageData<Product> pdata = new PageData<Product>(pro, count, currentPage);
		model.addAttribute("prodata", pdata);
		
		model.addAttribute("pinfo", pinfo);
		model.addAttribute("product_bank", bibiz.findAllList());
		model.addAttribute("product_type", ptbiz.findProductTypeList());
		model.addAttribute("product_status", sbiz.findSelectByCode("product_status"));
		return "screens/product/prolist";
	}
	
	@RequestMapping("/todetail/{id}")
	public String toDetail(@PathVariable String id , Model model,HttpServletRequest req){
		//权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.PRODUCT_HELP_UPDATE);
		authList.add(GlobalConstant.PRODUCT_HELP_SHELVE);
		authList.add(GlobalConstant.PRODUCT_HELP_UNSHELVE);
		
		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model,req, authList, "贷款产品列表");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		Product pro = pbiz.getProductById(id);
		model.addAttribute("pro", pro);
		return "screens/product/proxq";
	}
	
	@RequestMapping("/edit/{id}")
	public String toedit(@PathVariable String id , Model model){
		Product pro = pbiz.getProductById(id);
		model.addAttribute("pro", pro);
		model.addAttribute("product_type", ptbiz.findProductTypeList());
		model.addAttribute("product_bank", bibiz.findAllList());
		return "screens/product/proedit";
	}
	
	@RequestMapping("/toadd")
	public String toadd(Model model){
		model.addAttribute("pro", new Product());
		model.addAttribute("product_type", ptbiz.findProductTypeList());
		model.addAttribute("product_bank", bibiz.findAllList());
		return "screens/product/proadd";
	}
	
	
	@RequestMapping(value = "/shelve", method = {RequestMethod.POST })
	public @ResponseBody String shelve(@RequestBody List<String> shelve , HttpServletRequest req){
		
		boolean b = pbiz.updateShelve(shelve , AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
	}
	
	@RequestMapping(value = "/unshelve" , method={RequestMethod.POST})
	@ResponseBody
	public String unshelve(HttpServletRequest req , @RequestBody List<String> shelve){
		
		boolean b = pbiz.updateUnShelve(shelve, AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
	}
	
	
	@RequestMapping(value="/save" , method = {RequestMethod.POST})
	@ResponseBody
	public String save(@RequestBody Product pro , HttpServletRequest req){
		
		try {
			pbiz.saveProduct(pro, AutheManage.getUsername(req));
			return "success";
		} catch (Exception e) {
			// TODO: handle exception
			return "fail";
		}
	}
	
}
