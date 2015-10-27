package com.xinyue.manage.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.xinyue.authe.AutheManage;
import com.xinyue.manage.beans.CheckboxInfo;
import com.xinyue.manage.beans.PageInfo;
import com.xinyue.manage.beans.SearchNew;
import com.xinyue.manage.beans.SelectInfo;
import com.xinyue.manage.model.NewInfo;
import com.xinyue.manage.model.NewType;
import com.xinyue.manage.service.NewService;
import com.xinyue.manage.service.NewSubstationService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;

/**
 * 
 * @author lzc
 * @date 2015年6月26日
 */

@Controller
@RequestMapping("/new")
public class NewController {
	@Autowired
	private NewService newService;
	
	@Autowired
	private NewSubstationService newSubstationService;
	
	
	Logger log = Logger.getLogger(getClass());
	
	private static List<SelectInfo> newtypes = null;
	
	private static List<SelectInfo> substations = null;
	

	private static String TEMP_PATH = CommonFunction.getValue("upload.path")+"new/temp/";
	
	private static String DOWN_PATH = CommonFunction.getValue("down.path")+"moko/images/new/temp/";
	
	private static String REAL_PATH = CommonFunction.getValue("upload.path");
	
	private static String SHOW_PATH = CommonFunction.getValue("down.path")+"moko/images/";
	
	public static List<SelectInfo> getNewtypes() {
		return newtypes;
	}

	public static void setNewtypes(List<SelectInfo> newtypes) {
		NewController.newtypes = newtypes;
	}
	
	
	
	private synchronized void getNewTypeList(){
		if(getNewtypes() == null){
			setNewtypes(newService.getAllNewTypeList());
		}
	}
	
	public static List<SelectInfo> getSubstations() {
		return substations;
	}

	public static void setSubstations(List<SelectInfo> substations) {
		NewController.substations = substations;
	}
	
	
	//导致新闻城市无法实时刷新
	private synchronized void getSustationList(){
		if(getSubstations() == null){
			setSubstations(newService.getAllSubstationList());
		}
	}

	@RequestMapping(value={"/addnew","/updatenew"})
	public @ResponseBody String addOrUpdateNew(Model model, @ModelAttribute("newinfo")NewInfo newInfo,HttpServletRequest request){
		if(newInfo.getSubstationList() == null)
			return GlobalConstant.RET_FAIL;
		
		//新闻类型列表
		newInfo.setModifiedId(AutheManage.getUsername(request));
			if(StringUtils.isEmpty(newInfo.getId())){
				try {
					String id = UUID.randomUUID().toString().replaceAll("-", "");
					//添加城市与新闻之间的关系
					newInfo.setId(id);
					newInfo.setDeleted(0);
					newService.addNewInfo(newInfo);
					return GlobalConstant.RET_SUCCESS;
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
			else {
				try {
					//修改城市与新闻之间的关系 
					newService.updateNewInfo(newInfo);
					return GlobalConstant.RET_SUCCESS;
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
		return GlobalConstant.RET_FAIL;
	}
	
	@RequestMapping(value="/addnewtype",method=RequestMethod.POST)
	public @ResponseBody String addOrUpdateNewType(Model model, NewType newType,HttpServletRequest request){
		newType.setModifiedId(AutheManage.getUsername(request));
		if(!newType.getId().equals("")){
			newType.setModifiedId(AutheManage.getUsername(request));
			try {
				newService.updateNewType(newType);
				return GlobalConstant.RET_SUCCESS;
			} catch (Exception e) {
				// TODO: handle exception
			}
		}else {
			newType.setModifiedId(AutheManage.getUsername(request));
			newType.setCreatedId(AutheManage.getUsername(request));
			newType.setId(UUID.randomUUID().toString().replaceAll("-", ""));
			try {
				newService.addNewType(newType);
				newtypes = null;
				return GlobalConstant.RET_SUCCESS;
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
		return GlobalConstant.RET_FAIL;
		
	}
	
	@RequestMapping("publishnewinfo")
	public @ResponseBody String updateOrDeleteNewInfoList(@ModelAttribute("list")List<String> idList, int status,
			HttpServletRequest request){
		try {
			newService.updateNewInfo(idList, status,AutheManage.getUsername(request));
			return GlobalConstant.RET_SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
			log.error(e.toString());
			return GlobalConstant.RET_FAIL;
		}			
	}
	
	@RequestMapping("publishnewtype")
	public @ResponseBody String updateOrDeleteNewTypeList(@ModelAttribute("list")List<String> idList, int status,HttpServletRequest request){
		try {
			newService.updateNewType(idList, status, AutheManage.getUsername(request));
			newtypes = null ;
			return GlobalConstant.RET_SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
			log.error(e.toString());
			return GlobalConstant.RET_FAIL;
		}
	
	}
	
	@RequestMapping("turnnew")
	public String turnNew(Model model, NewInfo newInfo){
		getSustationList();
		getNewTypeList();
		
		if(newInfo == null){
			newInfo = new NewInfo();
		}
		model.addAttribute("newInfo", newInfo);
		model.addAttribute("substationList", newSubstationService.getCheckBoxEmptyList(getSubstations()));
		model.addAttribute("newTypeList", getNewtypes());
		return "screens/new/newAdd";
	}
	
	@RequestMapping("turnnewtype")
	public String turnNewType(){
		return "screens/new/newTypeEdit";
	}
	
	
	
	
	@RequestMapping(value=("/list") )
	public String newList(@ModelAttribute("searchnew")SearchNew searchNew, Model model, int index){
		getNewTypeList();
		getSustationList();
		List<NewInfo> newInfos = newService.getNewInfoListByPage(index, searchNew);
		model.addAttribute("newList", newInfos);
		model.addAttribute("keywordsList", newService.getSearchNewList(GlobalConstant.SEARCH_NEW));
		model.addAttribute("newTypeList", getNewtypes());
		model.addAttribute("substationList", getSubstations());
		
		PageInfo pageInfo = new PageInfo();
		CommonFunction cf = new CommonFunction();
		
		// 分页传值
		int countAll = newService.getNewInfoCount(searchNew);

		pageInfo = cf.pageList(countAll, index + 1);
		model.addAttribute("page", pageInfo);
		
		
		return "screens/new/newlist";
	}
	
	@RequestMapping("/typelist")
	public String newTypeList(Model model,int index){
		List<NewType> newTypes = newService.getNewTypeByPage(index);
		for(NewType newType :newTypes){
			newType.setNewNum(newService.getNewNumber(newType.getId()));
		}
		model.addAttribute("newTypeList", newTypes);
		
		PageInfo pageInfo = new PageInfo();
		
		CommonFunction cf = new CommonFunction();
		
		// 分页
		int countAll = newService.getNewTypeCount();

		pageInfo = cf.pageList(countAll, index + 1);
		model.addAttribute("page", pageInfo);
		
		return "screens/new/newTypeList";
	}
	
	@RequestMapping("editnewinfo")
	public String editNewInfo(Model model, String id){
		getSustationList();
		getNewTypeList();
		NewInfo newInfo = newService.getNewInfo(id);
		model.addAttribute("newInfo", newInfo);
		List<CheckboxInfo> list = 
				newSubstationService.getCheckBoxListByName(getSubstations(), newInfo.getSubstationList());
		model.addAttribute("substationList", list);
		model.addAttribute("newTypeList", getNewtypes());
		return "screens/new/newAdd";
	}
	
	@RequestMapping("editnewtype")
	public String editNewType(Model model, String id){
		NewType newType = newService.getNewType(id);
		model.addAttribute("newtype", newType);
		return "screens/new/newTypeEdit";
	}
	@RequestMapping("deletenewtype")
	public @ResponseBody String deleteNewType(String id,HttpServletRequest request){
		try {
			newService.deleteNewType(id,AutheManage.getUsername(request));
			newtypes = null;
			//在分页中加载+1页的内容
			return GlobalConstant.RET_SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
			return GlobalConstant.RET_FAIL;
		}
	}
	
	@RequestMapping(value={"/deletenew"})
	public @ResponseBody String deleteNew(String id,HttpServletRequest request){
		try {
			newService.deleteNewInfo(id,AutheManage.getUsername(request));
			return GlobalConstant.RET_SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return GlobalConstant.RET_FAIL;
	}
	

	
	@RequestMapping("/upload")
	@ResponseBody
	public String upload(HttpServletRequest request, String suffix){
		File pathFile = new File(TEMP_PATH);
		if (!pathFile.exists()) {
			pathFile.mkdirs();
		}
		CommonsMultipartResolver resolver = new CommonsMultipartResolver(request.getServletContext());
		if(resolver.isMultipart(request)){
			MultipartHttpServletRequest mhtsr = (MultipartHttpServletRequest) request;
			Iterator<String> it = mhtsr.getFileNames();
			while(it.hasNext()){
				String fileName = it.next();
				String code = "new_" + new SimpleDateFormat("yyyyMMddHHmmssms").format(System.currentTimeMillis());
				MultipartFile file = mhtsr.getFile(fileName);
				File uploadFile = new File(TEMP_PATH +  code + "." + suffix);
				try {
					FileCopyUtils.copy(file.getBytes(), uploadFile);
					String retPath = DOWN_PATH + code + "." + suffix;
					return "{'name':'"+code+"."+suffix+"','path':'"+_filterStr(retPath)+"'}";
					
				} catch (Exception e) {
					// TODO: handle exception
					log.error(e.toString());
					return "fail";
				}
			}
		}
		return "fail";
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
