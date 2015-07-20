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

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.xinyue.authe.AutheManage;
import com.xinyue.manage.beans.PageInfo;
import com.xinyue.manage.beans.SearchFsAndCo;
import com.xinyue.manage.model.Cooperation;
import com.xinyue.manage.service.CooperationService;
import com.xinyue.manage.service.LinkService;
import com.xinyue.manage.service.SelectService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;

@Controller
@RequestMapping("/cooperate")
public class CooperationController {

	@Resource
	private SelectService selectService;
	
	@Resource
	private LinkService linkService;
	
	@Resource
	private CooperationService cooperationService;
	
	private static String TEMP_PATH = CommonFunction.getValue("upload.path")+"cooperate/temp/";
	
	private static String DOWN_PATH = CommonFunction.getValue("down.path")+"moko/images/cooperate/temp/";
	
	private static String REAL_PATH = CommonFunction.getValue("upload.path")+"cooperate/co/";
	
	private static String SHOW_PATH = CommonFunction.getValue("down.path")+"moko/images/";
	
	private static String USER = "";
	
	@RequestMapping(value={"/organization/list"})
	public String cooperationList(HttpServletRequest request,Model model,int index,
			SearchFsAndCo searchCooperation) {
		
		USER = AutheManage.getUsername(request);
		
		// 权限
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.AUTHORITY_COOPERATION_ADD);
		authList.add(GlobalConstant.AUTHORITY_COOPERATION_DELETE);
		authList.add(GlobalConstant.AUTHORITY_COOPERATION_PUBLISH);
		authList.add(GlobalConstant.AUTHORITY_COOPERATION_UPDATE);

		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model, request, authList, "合作机构");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		
		//删除临时图片
		deleteTempFile();
		
		//省下拉表获得
		model.addAttribute("provinces", selectService.findProvince());
		//链接类型下拉表
		model.addAttribute("linkType", linkService.getLinkType(GlobalConstant.LINK_TYPE));
//		//截止日期更新
//		cooperationService.updateDeadLine();
		//状态下拉表
		model.addAttribute("publish", linkService.getLinkStatus(GlobalConstant.LINK_PUBLISH));
		
		if (searchCooperation == null) {
			searchCooperation = new SearchFsAndCo();
		}
		
		model.addAttribute("searchInfo", searchCooperation);
		
		//列表
		List<Cooperation> coopList = cooperationService.getList(searchCooperation, index*10);
		model.addAttribute("fsList", coopList);
		
		//图片路径
		model.addAttribute("imgPath", SHOW_PATH);
		
		//分页
		int countAll = cooperationService.getCount(searchCooperation);
		
		PageInfo pageInfo = new PageInfo();
		
		pageInfo = cf.pageList(countAll, index+1);
		
		model.addAttribute("page", pageInfo);
		
		return "screens/linkInfo/cooperation";
	}
	
	@RequestMapping(value="/organization/search",method=RequestMethod.POST)
	public String search(HttpServletRequest request,Model model,int index, SearchFsAndCo searchInfo) {
		
		return cooperationList(request, model, index, searchInfo);
	}
	
	@RequestMapping(value={"/organization/addpage","/organization/updatepage"})
	public String addOrUpdate(HttpServletRequest request,Model model,String code) {
		//省下拉表获得
		model.addAttribute("provinces", selectService.findProvince());
		
		Cooperation cooperation = new Cooperation();
		
		if (code != null && !code.equals("")) {
			cooperation = cooperationService.getCooperationInfoByCode(code);
			
			if (!cooperation.getLogoPath().equals("")) {
				cooperation.setLogoPath(SHOW_PATH+cooperation.getLogoPathHid());
			}
		}
		
		model.addAttribute("editInfo", cooperation);
		
		return "screens/linkInfo/cooperationEdit";
	}
	
	@RequestMapping("/organization/logo/add")
	@ResponseBody
	public String uploadLogo(HttpServletRequest request,HttpServletResponse response,String suffix) {
		
		File pathFile = new File(TEMP_PATH);
		if (!pathFile.exists()) {
			pathFile.mkdirs();
		}
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		
		
		CommonsMultipartResolver resolver = new CommonsMultipartResolver(request.getServletContext());
		
		if (resolver.isMultipart(request)) {
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			
			Iterator<String> iter = multiRequest.getFileNames();

			while (iter.hasNext()) {
				String fileName = iter.next();
				String code = "co_"+df.format(new Date());
				
				MultipartFile file = multiRequest.getFile(fileName);
				
				File uploadFile = new File(TEMP_PATH+code+"."+suffix);
								
				try {
					FileCopyUtils.copy(file.getBytes(), uploadFile);
					String retPath = DOWN_PATH+code+"."+suffix;
	
					String ret = "{'name':'"+code+"."+suffix+"','path':'"+_filterStr(retPath)+"'}";
					return ret;
				} catch (Exception e) {
					return "fail";
				}
			}
		}

		return "";
	}
	
	@RequestMapping(value={"/organization/edit"},method=RequestMethod.POST)
	public @ResponseBody String friendShipLinkCommit(HttpServletRequest request, Model model,
			Cooperation cooperation,boolean flag) {
		
		//图片保存
		if (cooperation.getLogoPath() == null || cooperation.getLogoPath().equals("")) {
			
			cooperation.setLogoPath("cooperate/co/"+cooperation.getLogoPathHid());
			
			String tempImg = TEMP_PATH + cooperation.getLogoPathHid();
			String realImg = REAL_PATH + cooperation.getLogoPathHid();
			
			File pathFile = new File(REAL_PATH);
			if (!pathFile.exists()) {
				pathFile.mkdirs();
			}
			
			File tempFile =  new File(tempImg);
			File realFile =  new File(realImg);
			
			try {
				FileCopyUtils.copy(tempFile, realFile);
			} catch (IOException e) {
//				log.error(e.toString());
				e.printStackTrace();
			}
		}else {
			cooperation.setLogoPath(cooperation.getLogoPathHid());
		}
		
		boolean ret = cooperationService.saveCooperation(cooperation, USER,flag);
		
		if (ret) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	@RequestMapping("/organization/delete")
	public @ResponseBody String deleteCoop(HttpServletRequest request,String code) {
		try {
			String enCode = URLDecoder.decode(code,"UTF-8");
			
			boolean ret = cooperationService.deleteCooperationByCode(enCode,USER);
			
			if (ret) {
				return "success";
			}
		} catch (UnsupportedEncodingException e) {

			e.printStackTrace();

			return "fail";
		}
		return "fail";
	}
	
	@RequestMapping("/organization/publish")
	public @ResponseBody String publishOrForbid(String code,String type){
		
		String ret = "fail";
		boolean res = false;
		try {
			String enCode = URLDecoder.decode(code,"UTF-8");
			
			if (type.equals("p")) {
				res = cooperationService.publishCooperationByCode(enCode, USER);
			}else if (type.equals("f")) {
				res = cooperationService.forbidCooperationByCode(enCode, USER);
			}
			
			if (res) {
				ret = "success";
			}
		} catch (UnsupportedEncodingException e) {
			
			e.printStackTrace();
		}
		return ret;
	}
	
	@RequestMapping(value={"/organization/change/array"},method=RequestMethod.POST)
	public @ResponseBody String changeIndex(String code,String index){
		
		String ret = "fail";
		//判断序列是否重复
		if (cooperationService.checkIndexByIndex(index)) {
			//更新序列
			boolean res = cooperationService.updateSortIndex(code, index,USER);
			
			if (res) {
				ret = "updateS";
			}
		}else {
			ret = "exist";
		}
		return ret;
	}

	private void deleteTempFile(){
		File file = new File(TEMP_PATH);
		
		if (file.exists()) {
			if (file.isDirectory()) {
				String[] leaf = file.list();
				
				for (String fileName : leaf) {
					File temp = new File(TEMP_PATH+fileName);
					temp.delete();
				}
			}
		}
	}
	
	protected String _filterStr(String s) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < s.length(); i++) {

			char c = s.charAt(i);
			switch (c) {
			case '\"':
				sb.append("\\\"");
				break;
			case '\\':
				sb.append("\\\\");
				break;
			case '/':
				sb.append("\\/");
				break;
			case '\b':
				sb.append("\\b");
				break;
			case '\f':
				sb.append("\\f");
				break;
			case '\n':
				sb.append("\\n");
				break;
			case '\r':
				sb.append("\\r");
				break;
			case '\t':
				sb.append("\\t");
				break;
			default:
				sb.append(c);
			}
		}
		return sb.toString();
	}
}
