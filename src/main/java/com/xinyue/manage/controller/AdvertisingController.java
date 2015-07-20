package com.xinyue.manage.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyue.authe.AutheManage;
import com.xinyue.manage.beans.AdvertisingInfo;
import com.xinyue.manage.beans.PageData;
import com.xinyue.manage.model.Advertising;
import com.xinyue.manage.model.Select;
import com.xinyue.manage.service.AdvertisingService;
import com.xinyue.manage.service.SelectService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;

/**
 * 广告控制类
 * @author wenhai.you
 * @2015年5月6日
 * @上午11:03:13
 */
@Controller
@RequestMapping("/advert")
public class AdvertisingController {

	@Autowired
	private AdvertisingService advertisingService;
	
	@Autowired
	private SelectService dicbiz;
	
	
	//首次点击
	@RequestMapping(value={"/list"})
	public String findPageData(String adtype , String topage ,HttpServletRequest req, Model model){
		//权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.ADVERT_HELP_ADD);
		authList.add(GlobalConstant.ADVERT_HELP_SHIELD);
		authList.add(GlobalConstant.ADVERT_HELP_PUBLISH);
		authList.add(GlobalConstant.ADVERT_HELP_DELETE);
		authList.add(GlobalConstant.ADVERT_HELP_UPDATE);
		
		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model,req, authList, "广告位管理");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		String index = req.getParameter("index");
		if(!GlobalConstant.isNull(index)){
			req.getSession().removeAttribute("advertInfo");
		}
		AdvertisingInfo advertInfo = (AdvertisingInfo)req.getSession().getAttribute("advertInfo");
		
		if(advertInfo == null){
			advertInfo = new AdvertisingInfo();
		}
		
		/**
		 * 所有广告
		 */
		int currentPage = 1 ;
		
		if(!GlobalConstant.isNull(adtype)){
			
			int type = Integer.valueOf(adtype);
			advertInfo.setAdtype(type);
			if( type == 0){
				advertInfo.setPageAll(topage);
			}else if(type == 1){
				advertInfo.setPageBig(topage);
			}else if(type == 2){
				advertInfo.setPageSmall(topage);
			}else{
				advertInfo.setPageIn(topage);
			}
		}
		AdvertisingInfo info = new AdvertisingInfo();
		int total = advertisingService.getAdvertCountByType(info.getTitle());
		
		currentPage = GlobalConstant.getCurrentPage(advertInfo.getPageAll(), total);
		info.setStart((currentPage-1)*GlobalConstant.PAGE_SIZE);
		List<Advertising> advert = advertisingService.getAdvertising(info);
		PageData<Advertising> pageData = new PageData<Advertising>(advert, total, currentPage);
		
		model.addAttribute("advert_all", pageData);
		/**
		 * 首页大广告
		 */
		info = new AdvertisingInfo("首页大广告");
		total = advertisingService.getAdvertCountByType(info.getTitle());
		currentPage = GlobalConstant.getCurrentPage(advertInfo.getPageBig(), total);
		info.setStart((currentPage-1)*GlobalConstant.PAGE_SIZE);
		advert = advertisingService.getAdvertising(info);
		pageData = new PageData<Advertising>(advert, total, currentPage);
		
		model.addAttribute("advert_big", pageData);
		/**
		 * 首页小广告
		 */
		info = new AdvertisingInfo("首页小广告");
		
		total = advertisingService.getAdvertCountByType(info.getTitle());
		currentPage = GlobalConstant.getCurrentPage(advertInfo.getPageSmall(), total);
		info.setStart((currentPage-1)*GlobalConstant.PAGE_SIZE);
		advert = advertisingService.getAdvertising(info);
		pageData = new PageData<Advertising>(advert, total, currentPage);
		
		model.addAttribute("advert_small", pageData);
		/**
		 * 内页广告
		 */
		info = new AdvertisingInfo("内页广告");
		total = advertisingService.getAdvertCountByType(info.getTitle());
		currentPage = GlobalConstant.getCurrentPage(advertInfo.getPageIn(), total);
		info.setStart((currentPage-1)*GlobalConstant.PAGE_SIZE);
		advert = advertisingService.getAdvertising(info);
		
		
		pageData = new PageData<Advertising>(advert, total, currentPage);
		
		model.addAttribute("advert_in", pageData);
		model.addAttribute("showImage", advertisingService.SHOW_PATH);
	
		req.getSession().setAttribute("advertInfo", advertInfo);
		return "screens/advertising/advert";
	}
	

		
	/**
	 * 删除 更新标志deleted
	 * @param advertid 主键id
	 * @return
	 */
	@RequestMapping(value ="/delAdvert", method = {RequestMethod.POST})
	public @ResponseBody String delAdvertById(@RequestBody String advertid, HttpServletRequest req){
		
		boolean b = advertisingService.delByAdvertisingId(advertid,AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
		
	}
	
	/**
	 * 删除 集合更新标志deleted
	 * @param list 集合id
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping(value ="/delAllAdvert" , method = {RequestMethod.POST})
	public @ResponseBody String delAllByAdvertId(@RequestBody List<String> list , HttpServletRequest req){
		
		boolean b = advertisingService.delAdvertisingMulti(list,AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
		
	}
	
	/**
	 * 
	 */
	@RequestMapping("/toAdd")
	public String toAdd(Model model){
		model.addAttribute("advertedit", new Advertising());
		
		List<Select> dic_advert = dicbiz.findSelectByCode("advert_type");
		model.addAttribute("dic_advert", dic_advert);
		return "screens/advertising/advertEdit";
	}
	
	@RequestMapping("/toUpdate/{id}")
	public String toUpdate(Model model ,@PathVariable String id){
		System.out.println(id);
		Advertising advert = advertisingService.getAdvertById(id);
		model.addAttribute("advertedit", advert);
		model.addAttribute("showImage", advertisingService.SHOW_PATH);
		
		List<Select> dic_advert = dicbiz.findSelectByCode("advert_type");
		model.addAttribute("dic_advert", dic_advert);
		return "screens/advertising/advertEdit";
	}
	
	
	
	//private static String DOWN_PATH = (new StringBuffer(CommonFunction.getValue("upload.path")).append("advert/temp/")).toString();
	
	@RequestMapping("/upload/pic")
	@ResponseBody
	public String upload(HttpServletRequest req , String suffix){
		
		return advertisingService.upload(suffix, req);
	}
	
	
	
	
	
	/**
	 * 添加 或 修改
	 * @return
	 */
	@RequestMapping("/edit")
	@ResponseBody
	public String adertEdit(HttpServletRequest req ,  Advertising advertedit){
	
		boolean b = advertisingService.saveAdvert(advertedit, AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
	}
	
	@RequestMapping(value = "/publish" , method = {RequestMethod.POST})
	public @ResponseBody String publish(@RequestBody List<String> list , HttpServletRequest req){
		
		boolean b = advertisingService.updatePublish(list,AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
	} 
	
	@RequestMapping(value = "/shielding" , method = {RequestMethod.POST})
	public @ResponseBody String shielding(@RequestBody List<String> list , HttpServletRequest req){
		
		boolean b = advertisingService.updateShielding(list,AutheManage.getUsername(req));
		if(!b){
			return "fail";
		}
		return "success";
	} 
	

}
