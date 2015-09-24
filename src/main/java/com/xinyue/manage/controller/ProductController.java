package com.xinyue.manage.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
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
import com.xinyue.manage.beans.ProductInfo;
import com.xinyue.manage.beans.SelectInfo;
import com.xinyue.manage.model.Product;
import com.xinyue.manage.model.ProductContent;
import com.xinyue.manage.service.CityService;
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
	
	
	
	
	
	//2015-09-14
	/**
	 * ywh 产品列表展示
	 * @param req
	 * @param resp
	 * @param model
	 * @param pinfo
	 * @return
	 */
	@RequestMapping("/list")
	public String findPage(HttpServletRequest req , HttpServletResponse resp ,  Model model , ProductInfo pinfo){
	
		//权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.PRODUCT_HELP_ADD);
		
		authList.add(GlobalConstant.PRODUCT_HELP_UPDATE);
		authList.add(GlobalConstant.PRODUCT_HELP_SHELVE);
		authList.add(GlobalConstant.PRODUCT_HELP_UNSHELVE);
		
		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model,req, authList, "贷款产品列表");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		//产品列表信息
		model.addAttribute("prodata", pbiz.findPageData(pinfo));
		//查询条件
		model.addAttribute("pinfo", pinfo);
		//机构信息
		model.addAttribute("orginfo", pbiz.getOrgs());
		//产品类型
		model.addAttribute("product_type", ptbiz.findProductTypeList());
		//产品状态
		model.addAttribute("product_status", sbiz.findSelectByCode("product_status"));
		return "screens/product/prolist";
	}
	
	/**
	 * ywh 加载选项设置
	 * @param model
	 * @param productid
	 * @return
	 */
	@RequestMapping("/editOption")
	public String option(Model model , String productid){
		ProductContent pc = pbiz.findOptionByProductid(productid);
		System.out.println(productid);
		System.out.println(pc==null);
		if(GlobalConstant.isNull(pc)){
			pc = new ProductContent();
			pc.setProductcode(productid);
		}
		model.addAttribute("productContentInfo", pc);
		return "screens/product/contentEdit";
	}
	
	/**
	 * ywh 保存选项 
	 * @param model
	 * @param pc
	 * @param req
	 * @return
	 */
	@RequestMapping("/saveOption")
	@ResponseBody
	public String saveOption(Model model , ProductContent pc , HttpServletRequest req){
		
		boolean b = pbiz.saveOption(pc,  AutheManage.getUsername(req));
		if(b){
			return "success";
		}
		return "fail";
		
	}
	
	@Resource
	private CityService cityService;
	/**
	 * ywh 跳转添加产品
	 * @param model
	 * @return
	 */
	@RequestMapping("/toadd")
	public String toadd(Model model){
		//产品
		model.addAttribute("pro", new Product());
		//产品类型
		model.addAttribute("product_type", ptbiz.findProductTypeList());
		//机构信息
		model.addAttribute("orginfo", pbiz.getOrgs());
		//省
		List<SelectInfo> provinces = cityService.getAllProvince();
		model.addAttribute("provinces", provinces);
		return "screens/product/proadd";
	}
	
	/**
	 * ywh 添加产品
	 * @param pro
	 * @param req
	 * @return
	 */
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
	
	/**
	 * ywh 临时上传图片
	 * @param req
	 * @param suffix
	 * @return
	 */
	@RequestMapping("/upload")
	@ResponseBody
	public String upload(HttpServletRequest req , String suffix){
		
		return pbiz.upload(suffix, req);
	}
	
	/**
	 * ywh 跳转到 编辑页面
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/edit/{id}")
	public String toedit(@PathVariable String id , Model model){
		//产品
		Product pro = pbiz.getProductById(id);
		model.addAttribute("pro", pro);
		//产品类型
		model.addAttribute("product_type", ptbiz.findProductTypeList());
		//机构信息
		model.addAttribute("orginfo", pbiz.getOrgs());
		//省
		List<SelectInfo> provinces = cityService.getAllProvince();
		model.addAttribute("provinces", provinces);
		
		//显示产品路径
		model.addAttribute("showpath", pbiz.SHOW_PATH);
		return "screens/product/proedit";
	}
	

	/**
	 * ywh 跳转到详情页面
	 * @param id
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/todetail/{id}")
	public String toDetail(@PathVariable String id , Model model,HttpServletRequest req){
		//权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.PRODUCT_HELP_UPDATE);
		authList.add(GlobalConstant.PRODUCT_HELP_SHELVE);
		authList.add(GlobalConstant.PRODUCT_HELP_UNSHELVE);
		authList.add(GlobalConstant.PRODUCT_HELP_DELETE);
		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model,req, authList, "贷款产品列表");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		//产品详情信息
		Product pro = pbiz.getProductById(id);
		model.addAttribute("pro", pro);
		//显示产品路径
		model.addAttribute("showpath", pbiz.SHOW_PATH);
		return "screens/product/proxq";
	}
	
	/**
	 * ywh 删除产品
	 * @param productid
	 * @param req
	 * @return
	 */
	@RequestMapping("/del")
	public String del(String productid , HttpServletRequest req){
		boolean b = pbiz.delPro(productid, AutheManage.getUsername(req));
		if(b){
			return "success";
		}
		return "fail";
	}
}
