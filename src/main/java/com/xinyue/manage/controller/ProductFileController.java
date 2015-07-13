package com.xinyue.manage.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyue.authe.AutheManage;
import com.xinyue.manage.service.ProductFileService;

/**
 * 
 * @author wenhai.you
 * @2015年5月27日
 * @下午6:13:28
 */
@Controller
@RequestMapping("/productFile")
public class ProductFileController {

	@Autowired
	private ProductFileService pfbiz;
	
	@RequestMapping(value="del" , method = {RequestMethod.POST})
	public @ResponseBody String delProductFile(@RequestBody String id , HttpServletRequest req){
		
		boolean b = pfbiz.delProductFile(id,  AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
	}

}
