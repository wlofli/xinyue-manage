/*
 * 杭州摩科商用设备有限公司
 * MOKO-Commercial Device Co.,Ltd
 * 
 * 新越网
 * 
 * 创建人：茅
 * 
 * 日期：2015/05/06
 * 
 * 版本v1.0.0
 * 
 * bug修改:
 * 
 * 
 */
package com.xinyue.manage.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyue.authe.AutheManage;
import com.xinyue.manage.beans.PageInfo;
import com.xinyue.manage.beans.SelectInfo;
import com.xinyue.manage.model.HelpType;
import com.xinyue.manage.model.Helper;
import com.xinyue.manage.service.HelpService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;

@Controller
@RequestMapping("/help")
public class HelpCenterController {

	//当前用户
	private static String USER = "";
	
	@Resource
	private HelpService helpService;
	
	@RequestMapping("/list")
	public String helpList(HttpServletRequest request,Model model,int index){
		
		
		//当前用户取得
		USER = AutheManage.getUsername(request);
		
		//权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.AUTHORITY_HELP_ADD);
		authList.add(GlobalConstant.AUTHORITY_HELP_TYPE);
		authList.add(GlobalConstant.AUTHORITY_HELP_PUBLISH);
		authList.add(GlobalConstant.AUTHORITY_HELP_DELETE);
		authList.add(GlobalConstant.AUTHORITY_HELP_UPDATE);
		
		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model,request, authList, "帮助中心");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		
		
		//列表取得
		List<Helper> help = helpService.getList(index*GlobalConstant.PAGE_SIZE);
		model.addAttribute("helpList", help);
		
		//总条数
		int total = helpService.getCount();

		PageInfo pageInfo = new PageInfo();
		//分页
		pageInfo = cf.pageList(total, index+1);
		
		model.addAttribute("page", pageInfo);
		return "screens/helpCenter/helpCenter";
	}
	
	@RequestMapping("/publishorforbid")
	public @ResponseBody String publishOrForbid(String code,String type){
		
		String retStr = GlobalConstant.RET_FAIL;
		boolean res = false;
		try {
			//解码字符串
			String enCode = URLDecoder.decode(code,"UTF-8");
			
			if (type.equals("p")) {
				res = helpService.publishHelperByCode(enCode, USER);
			}else if (type.equals("f")) {
				res = helpService.forbidHelperByCode(enCode, USER);
			}
			
			if (res) {
				retStr = GlobalConstant.RET_SUCCESS;
			}			
		} catch (UnsupportedEncodingException e) {
			
			e.printStackTrace();
		}
		
		return retStr;
	}
	
	@RequestMapping("/delete")
	public @ResponseBody String deleteHelper(String code){
		
		String retStr = GlobalConstant.RET_FAIL;
		boolean res = false;
		
		try {
			//解码字符串
			String enCode = URLDecoder.decode(code,"UTF-8");
			
			res = helpService.deleteHelperByCode(enCode,USER);
			
			if (res) {
				retStr = GlobalConstant.RET_SUCCESS;
			}
		} catch (UnsupportedEncodingException e) {
			
			e.printStackTrace();
		}
		return retStr;
	}
	
	@RequestMapping("/edit/page")
	public String gotoHelpEdit(Model model,String code,String type){
		//跳转页面
		String retStr = "screens/helpCenter/helpCenterEdit";
		
		Helper helper = new Helper();
		
		//获得类型
		List<SelectInfo> typeList = helpService.getTypes();
		model.addAttribute("typeList", typeList);
		//添加页面
		if (type.equals("a")) {
			helper.setStatus("1");
		//修改页面
		}else if (type.equals("u")) {
			helper = helpService.getHelperByCode(code);
		}
		
		model.addAttribute("help", helper);
		return retStr;
	}
	
	@RequestMapping(value={"/edit/submit"},method=RequestMethod.POST)
	public @ResponseBody String editSubmit(Helper helper,boolean flag){
		//跳转
		String retStr = GlobalConstant.RET_FAIL;
		
		//添加
		if (flag) {
			if (helpService.addHelper(helper,USER)) {
				retStr = GlobalConstant.RET_SUCCESS;
			}
		//更新
		}else {
			if (helpService.updateHelper(helper,USER)) {
				retStr = GlobalConstant.RET_SUCCESS;
			}
		}
		
		return retStr;
	}
	
	@RequestMapping("/type/edit")
	public String editType(HttpServletRequest req , Model model , String typeid) {
		
		if(GlobalConstant.isNull(typeid)){
			HelpType ht = new HelpType();
			
			model.addAttribute("helpType", ht);
		}else{
			HelpType ht = helpService.findHelpTypeById(typeid);
			
			model.addAttribute("helpType", ht);
		}
		
		return "screens/helpCenter/helpTypeEdit";
	}
	
	@RequestMapping(value="/type/submit",method=RequestMethod.POST)
	public @ResponseBody String saveType(HttpServletRequest req , HelpType helpType) {
		
		String retStr = GlobalConstant.RET_FAIL;
		helpType.setCreateName(AutheManage.getUsername(req));
		if (helpService.addHelpType(helpType)) {
			retStr = GlobalConstant.RET_SUCCESS; 
		}
		
		return retStr;
	}
	
	//you wh start 2015-11-19 以下添加帮助分类
	@RequestMapping("/helptype/list")
	public String helptypelist(HttpServletRequest req , Model model , String topage){
		
		model.addAttribute("helptypelist", helpService.findHelpType(topage));
		
		return "screens/helpCenter/helptype";
	}
	
	@RequestMapping("/helptype/publish")
	@ResponseBody
	public boolean publish(HttpServletRequest req , Model model , @RequestBody List<String> ids){
		
		
		return helpService.updateHelpTypePublish(ids, AutheManage.getUsername(req));
	}
	
	@RequestMapping("/helptype/del")
	@ResponseBody
	public boolean del(HttpServletRequest req , Model model ,@RequestBody List<String> ids){
		
		
		return helpService.delHelpType(ids, AutheManage.getUsername(req));
	}
	//ywh over
}
