/*
 * 杭州摩科商用设备有限公司
 * MOKO-Commercial Device Co.,Ltd
 * 
 * 新越网
 * 
 * 创建人：茅
 * 
 * 日期：2015/04/27
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

import org.apache.log4j.Logger;
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
import com.xinyue.manage.model.LinkFriendShip;
import com.xinyue.manage.service.LinkService;
import com.xinyue.manage.service.SelectService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;

@Controller
@RequestMapping("/link")
public class LinkController {

	@Resource
	private SelectService selectService;
	
	@Resource
	private LinkService linkService;
	
	Logger log = Logger.getLogger(LinkController.class);
	
	private static String TEMP_PATH = CommonFunction.getValue("upload.path")+"link/temp/";
	
	private static String DOWN_PATH = CommonFunction.getValue("down.path")+"moko/images/link/temp/";
	
	private static String REAL_PATH = CommonFunction.getValue("upload.path")+"link/fs/";
	
	private static String SHOW_PATH = CommonFunction.getValue("down.path")+"moko/images/";
	
	private static String USER = "";
	
	@RequestMapping(value={"/frinendship/list"})
	public String friendshipLinkList(HttpServletRequest request,Model model,int index,
			SearchFsAndCo searchFriendShip) {
		
		USER = AutheManage.getUsername(request);
		
		//权限
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.AUTHORITY_FRIENDSHIP_ADD);
		authList.add(GlobalConstant.AUTHORITY_FRIENDSHIP_DELETE);
		authList.add(GlobalConstant.AUTHORITY_FRIENDSHIP_PUBLISH);
		authList.add(GlobalConstant.AUTHORITY_FRIENDSHIP_UPDATE);
		
		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model,request, authList, "友情链接");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		
		//删除临时图片文件
		deleteTempFile();
		
		//省下拉表获得
		model.addAttribute("provinces", selectService.findProvince());
		//链接类型下拉表
		model.addAttribute("linkType", linkService.getLinkType(GlobalConstant.LINK_TYPE));
		//截止日期更新
//		linkService.updateDeadLine();
		//状态下拉表
		model.addAttribute("linkPublish", linkService.getLinkStatus(GlobalConstant.LINK_PUBLISH));		
		
		if (searchFriendShip == null) {
			searchFriendShip = new SearchFsAndCo();
		}
		model.addAttribute("searchFriendShip", searchFriendShip);
		//显示列表
		List<LinkFriendShip> fsList = linkService.getList(searchFriendShip, index*10);
		
		model.addAttribute("fsList", fsList);
		//图片路径
		model.addAttribute("imgPath", SHOW_PATH);

		// 分页
		int countAll = linkService.getCount(searchFriendShip);

		PageInfo pageInfo = new PageInfo();
		
		pageInfo = cf.pageList(countAll, index + 1);

		model.addAttribute("page", pageInfo);
		
		return "screens/linkInfo/friendshipLink";
	}
	
	@RequestMapping(value="/friendship/search",method=RequestMethod.POST)
	public String name(HttpServletRequest request,Model model,int index,
			SearchFsAndCo searchFriendShip) {
		
		return friendshipLinkList(request, model, index, searchFriendShip);
	}
	
	@RequestMapping(value={"/friendship/addpage","/friendship/updatepage"})
	public String addOrUpdate(HttpServletRequest request,Model model,String code) {
	
		//省下拉表获得
		model.addAttribute("provinces", selectService.findProvince());
		
		LinkFriendShip linkFriendShip = new LinkFriendShip();
		
		if (code != null && !code.equals("")) {
			linkFriendShip = linkService.getFriendShipInfoByCode(code);
			
			if (!linkFriendShip.getLogoPath().equals("")) {
				linkFriendShip.setLogoPath(SHOW_PATH+linkFriendShip.getLogoPathHid());
			}
		}
		
		model.addAttribute("editInfo", linkFriendShip);
//		model.addAttribute("imageT", linkFriendShip.getLogoPath());
		
		return "screens/linkInfo/friendshipLinkEdit";
	}
	
	@RequestMapping("/friendship/logo/add")
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
				String code = "fs_"+df.format(new Date());
				
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
	
	@RequestMapping(value={"/friendship/edit"},method=RequestMethod.POST)
	public @ResponseBody String friendShipLinkCommit(HttpServletRequest request, Model model,
			LinkFriendShip linkFriendShip,boolean flag) {
		
		//图片保存
		if (linkFriendShip.getLogoPath() == null || linkFriendShip.getLogoPath().equals("")) {
			
			linkFriendShip.setLogoPath("link/fs/"+linkFriendShip.getLogoPathHid());
			
			String tempImg = TEMP_PATH + linkFriendShip.getLogoPathHid();
			String realImg = REAL_PATH + linkFriendShip.getLogoPathHid();
			
			File pathFile = new File(REAL_PATH);
			if (!pathFile.exists()) {
				pathFile.mkdirs();
			}
			
			File tempFile =  new File(tempImg);
			File realFile =  new File(realImg);
			
			try {
				FileCopyUtils.copy(tempFile, realFile);
				
				tempFile.delete();
			} catch (IOException e) {
				log.error(e.toString());
				e.printStackTrace();
			}
		}else {
			linkFriendShip.setLogoPath(linkFriendShip.getLogoPathHid());
		}
		
		boolean ret = linkService.saveFriendShipLink(linkFriendShip, AutheManage.getUsername(request),flag);
		
		if (ret) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	@RequestMapping("/frinendship/delete")
	public @ResponseBody String deleteLink(String code) {
		
		try {
			String enCode = URLDecoder.decode(code,"UTF-8");
			
			boolean ret = linkService.deleteFriendShipLinkByCode(enCode,USER);
			
			if (ret) {
				return "success";
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping("frinendship/publish")
	public @ResponseBody String publishOrForbid(String code,String type){
		
		String ret = "fail";
		boolean res = false;
		try {
			String enCode = URLDecoder.decode(code,"UTF-8");
			
			if (type.equals("p")) {
				res = linkService.publishLinkByCode(enCode, USER);
			}else if (type.equals("f")) {
				res = linkService.forbidLinkByCode(enCode, USER);
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
		if (linkService.checkIndexByIndex(index)) {
			//更新序列
			boolean res = linkService.updateSortIndex(code, index,USER);
			
			if (res) {
				ret = "updateS";
			}
		}else {
			ret = "exist";
		}
		return ret;
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
}
