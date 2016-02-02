/*
 * 杭州摩科商用设备有限公司
 * MOKO-Commercial Device Co.,Ltd
 * 
 * 新越网
 * 
 * 创建人：茅
 * 
 * 日期：2015/05/23
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
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyue.authe.AutheManage;
import com.xinyue.manage.beans.BusinessInfos;
import com.xinyue.manage.beans.HoldInfos;
import com.xinyue.manage.beans.PageData;
import com.xinyue.manage.beans.SearchCompanyInfo;
import com.xinyue.manage.beans.SelectInfo;
import com.xinyue.manage.model.Applicant;
import com.xinyue.manage.model.Business;
import com.xinyue.manage.model.CompanyBase;
import com.xinyue.manage.model.CompanyInfo;
import com.xinyue.manage.model.Control;
import com.xinyue.manage.model.Debt;
import com.xinyue.manage.model.Document;
import com.xinyue.manage.model.Hold;
import com.xinyue.manage.model.RealEstate;
import com.xinyue.manage.service.CompanyInfoService;
import com.xinyue.manage.service.SelectService;
import com.xinyue.manage.util.CommonFunction;
import com.xinyue.manage.util.GlobalConstant;
/**
 * modify 2015-11-30 ywh scanDetail
 */
@Controller
@RequestMapping("/company")
public class CompanyInfoController {

	@Resource
	CompanyInfoService companyInfoService;
	
	@Resource
	SelectService selectService;
	
	Logger log = Logger.getLogger(CompanyInfoController.class);
	
	private static String USER = "";
	
	@RequestMapping(value={"/list"})
	public String infoList(HttpServletRequest request,Model model,int index) {
		
		//当前用户取得
		USER = AutheManage.getUsername(request);

		// 权限取得
		List<String> authList = new ArrayList<String>();
		authList.add(GlobalConstant.AUTHORITY_COMPANY_EXPORT);
		authList.add(GlobalConstant.AUTHORITY_COMPANY_DETAIL);
		authList.add(GlobalConstant.AUTHORITY_COMPANY_PUBLISH);
		authList.add(GlobalConstant.AUTHORITY_COMPANY_UPDATE);
		authList.add(GlobalConstant.AUTHORITY_COMPANY_DELETE);
		authList.add(GlobalConstant.AUTHORITY_AUTHENTICATION_DETAIL);

		CommonFunction cf = new CommonFunction();
		boolean ret_auth = cf.getAuth(model, request, authList, "企业信息");
		if (!ret_auth) {
			return "redirect:/errors/fail_authority.html";
		}
		
		SearchCompanyInfo searchCompanyInfo = new SearchCompanyInfo();
		
		//行业
		List<SelectInfo> industry = companyInfoService.getIndustryList();
		request.getSession().setAttribute("industry", industry);
		
		//分页信息
		int[] indexTemp = new int[4];
		
//		if (type == 99) {
			indexTemp = new int[]{0,0,0,0};
			model.addAttribute("tab", 0);
//		} else {
//			int[] indexArr = searchCompanyInfo.getIndexArr();
//			
//			for (int i = 0; i < 4; i++) {
//				indexTemp[i] = indexArr[i];
//				if (type == i) {
//					indexTemp[i] = index;
//				}
//			}
//			model.addAttribute("tab", type);
//		}
		
		searchCompanyInfo.setIndexArr(indexTemp);
		model.addAttribute("searchCompanyInfo", searchCompanyInfo);
		
		//列表数据取得
		getData(model,searchCompanyInfo, indexTemp);

		return "screens/companyInfo/companyInfo";
	}
	
	@RequestMapping(value={"/search","/changePage"},method=RequestMethod.POST)
	public String searchList(Model model,SearchCompanyInfo searchCompanyInfo,int index,int type){
		
		int[] indexTemp = new int[4];
		int tab = type;
		
		if (type == -99) {
			tab = 0;
			indexTemp = new int[]{0,0,0,0};
		} else {
			for (int i = 0; i < searchCompanyInfo.getIndexArr().length; i++) {
				
				if (i==type) {
					indexTemp[i] = index;
				}else {
					indexTemp[i] = searchCompanyInfo.getIndexArr()[i];
				}
			}
		}
		
		model.addAttribute("tab", tab);
		//列表数据取得
		getData(model, searchCompanyInfo, indexTemp);
		
		//更新index
		searchCompanyInfo.setIndexArr(indexTemp);
		
		model.addAttribute("searchCompanyInfo", searchCompanyInfo);
		
		return "screens/companyInfo/companyInfo";
	}
	
	@RequestMapping("/export")
	public void exportExcel(HttpServletResponse response) {
		
		SearchCompanyInfo info = new SearchCompanyInfo();
		
		try {
			List<CompanyInfo> allList = companyInfoService.getCompanyInfoByCondition(info,-99,0);
			
			companyInfoService.exprot(response,allList);
		} catch (Exception e) {
			log.debug(e.getMessage());
			log.error("企业实名认证信息导出错误："+e);
		}
	}
	
	@RequestMapping("/delete")
	public @ResponseBody String deleteCompany(String code) {
		String ret = GlobalConstant.RET_FAIL;
		
		if (companyInfoService.deleteCompanyById(code,USER)) {
			ret = GlobalConstant.RET_SUCCESS;
		}
		
		return ret;
	}
	
	/**
	 * modify :ywh 2015-11-30 添加分页
	 */
	@RequestMapping("/scan/detail")
	public String scanDetail(Model model,String code , int topage) {
		
		try {
			code = URLDecoder.decode(code,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		//企业相关信息id获取
		HashMap<String, String> companyDetail = companyInfoService.getDetailIdByMemberId(code);
		
		//申请人信息
		Applicant applicant = new Applicant();
		if (companyDetail.containsKey("applicant_id")) {
			applicant = companyInfoService.getApplicantInfoById(companyDetail.get("applicant_id"));
		}
		//ywh modify 2015-12-18 
		model.addAttribute("applicantInfo", applicant);
		
		//企业基本信息
		CompanyBase companyBase = null;
		if (companyDetail.containsKey("license_id")) {
			companyBase = companyInfoService.getCompanyBaseInfoById(companyDetail.get("license_id"));
		}
		model.addAttribute("companyInfo", companyBase);
		
		//公司控股信息 
		List<Hold> holdList = null;
		//基本经营信息
		List<Business> businessList = null;
		//上传资料信息
		List<Document> documentList = new ArrayList<Document>();
		int total = 0;
		if (companyDetail.containsKey("member_id")) {
			holdList = companyInfoService.getHoldInfoById(companyDetail.get("member_id"));
			
			businessList = companyInfoService.getBusinessInfoById(companyDetail.get("member_id"));
			
			documentList = companyInfoService.getDocumentInfoById(companyDetail.get("member_id"),topage*10);
			total = companyInfoService.getDocumentCount();
		}
		if (holdList == null || holdList.size() == 0) {
			holdList = new ArrayList<Hold>();
			Hold hold = new Hold();
			holdList.add(hold);
		}
		if (businessList == null || businessList.size() == 0) {
			businessList = new ArrayList<Business>();
			Business business = new Business();
			businessList.add(business);
		}
		model.addAttribute("holdList", holdList);
		model.addAttribute("businessList", businessList);
		PageData<Document> dc = new PageData<Document>(documentList, total, topage+1);
		model.addAttribute("documentList", dc);
		
		//公司治理信息
		Control control = null;
		if (companyBase != null) {
			control = companyInfoService.getControlInfoById(companyDetail.get("control_id"));
		}
		model.addAttribute("controlinfo", control);
		
		//抵押物与负债
		RealEstate realEstate = new RealEstate();
		if (companyDetail.containsKey("estate_id")) {
			realEstate = companyInfoService.getRealEstateInfoById(companyDetail.get("estate_id"));
		}
		model.addAttribute("estateInfo", realEstate);
		
		Debt debt = new Debt();
		if (companyDetail.containsKey("debt_id")) {
			debt = companyInfoService.getDebtInfoById(companyDetail.get("debt_id"));
		}
		model.addAttribute("debtInfo", debt);
		model.addAttribute("showpath", CommonFunction.getValue("down.path"));
//		//评价信息
//		Rating rating = new Rating();
//		if (companyDetail.containsKey("rating_id")) {
//			rating = companyInfoService.getRatingInfoById(companyDetail.get("rating_id"));
//		}
//		model.addAttribute("ratingInfo", rating);
		
		model.addAttribute("code", code);
		
		
		return "screens/companyInfo/companyDetail";
	}
	
	@RequestMapping("/document/download")
	public void documentDownload(HttpServletResponse response,String id) {
		
		companyInfoService.downloadFile(response,id);
		
	}
	
	/**
	 * 编辑列表
	 * @param model
	 * @param code 企业id
	 * @return
	 */
	@RequestMapping("/edit/detail")
	public String editDetail(Model model,String code) {
		
		//可接受最高利率下拉表内容
		List<SelectInfo> maxRateList = selectService.findSelectByType(GlobalConstant.COMPANY_MAX_RATE_TYPE);
		model.addAttribute("maxRateList", maxRateList);
		//还款方式下拉表内容
		List<SelectInfo> repayList = selectService.findSelectByType(GlobalConstant.COMPANY_REPAY_TYPE);
		model.addAttribute("repayList", repayList);
		//主要担保方式
		List<SelectInfo> guaranteeList = selectService.findSelectByType(GlobalConstant.COMPANY_GUARANTEE_TYPE);
		model.addAttribute("guaranteeList", guaranteeList);
		//省
		List<SelectInfo> provinceList = selectService.findProvince();
		model.addAttribute("provinceList", provinceList);
		//证件类型
		List<SelectInfo> idTypeList = selectService.findSelectByType(GlobalConstant.COMPANY_IDCARD_TYPE);
		model.addAttribute("idTypeList", idTypeList);
		//资本类型
		List<SelectInfo> capitalList = selectService.findSelectByType(GlobalConstant.COMPANY_CAPITAL_TYPE);
		model.addAttribute("capitalList", capitalList);
		//企业性质
		List<SelectInfo> companyNatureList = selectService.findSelectByType(GlobalConstant.COMPANY_TYPE);
		model.addAttribute("companyNatureList", companyNatureList);
		//工商登记类型
		List<SelectInfo> businessRegList = selectService.findSelectByType(GlobalConstant.COMPANY_BUSINESS_TYPE);
		model.addAttribute("businessRegList", businessRegList);
		//机构类型
		List<SelectInfo> agencyTypeList = selectService.findSelectByType(GlobalConstant.COMPANY_AGENCY_TYPE);
		model.addAttribute("agencyTypeList", agencyTypeList);
		//控股方式
		List<SelectInfo> holdTypeList = selectService.findSelectByType(GlobalConstant.COMPANY_HOLD_TYPE);
		model.addAttribute("holdTypeList", holdTypeList);
		//学历
		List<SelectInfo> educationTypeList = selectService.findSelectByType(GlobalConstant.COMPANY_EDUCATION_TYPE);
		model.addAttribute("educationTypeList", educationTypeList);
		//婚姻情况
		List<SelectInfo> marriageTypeList = selectService.findSelectByType(GlobalConstant.COMPANY_MARRIAGE_TYPE);
		model.addAttribute("marriageTypeList", marriageTypeList);
		//产品销售区域
		List<SelectInfo> businessAreaList = selectService.findSelectByType(GlobalConstant.COMPANY_BUSINESS_AREA);
		model.addAttribute("businessAreaList", businessAreaList);
		//审计意见类型
		List<SelectInfo> auditTypeList = selectService.findSelectByType(GlobalConstant.COMPANY_AUDIT_TYPE);
		model.addAttribute("auditTypeList", auditTypeList);
		//抵质押物情况
		List<SelectInfo> collateralTypeList = selectService.findSelectByType(GlobalConstant.COMPANY_COLLATERAL_TYPE);
		model.addAttribute("collateralTypeList", collateralTypeList);
		
		//企业相关信息id获取
		HashMap<String, String> companyDetail = companyInfoService.getDetailIdByMemberId(code);
		//会员id
		model.addAttribute("memberId", companyDetail.get("member_id"));
		
		//申请人信息
		Applicant applicant = new Applicant();
		if (companyDetail.containsKey("applicant_id") && !companyDetail.get("applicant_id").equals("")) {
			applicant = companyInfoService.editApplicantInfoById(companyDetail.get("applicant_id"));
		}
		model.addAttribute("applicationInfo", applicant);
		
		// 企业基本信息
		CompanyBase companyBase = new CompanyBase();
		if (companyDetail.containsKey("license_id") && !companyDetail.get("license_id").equals("")) {
			companyBase = companyInfoService
					.editCompanyBaseInfoById(companyDetail.get("license_id"));
		}
		model.addAttribute("companyInfo", companyBase);

		// 公司控股信息
		HoldInfos holdInfos = new HoldInfos();
		// 基本经营信息
		BusinessInfos businessInfos = new BusinessInfos();
		// 上传资料信息
		List<Document> documentList = new ArrayList<Document>();
		if (companyDetail.containsKey("member_id") && !companyDetail.get("member_id").equals("")) {
			holdInfos = companyInfoService.editHoldInfoById(companyDetail
					.get("member_id"));

			businessInfos = companyInfoService.editBusinessInfoById(companyDetail
					.get("member_id"));

			documentList = companyInfoService.editDocuments(companyDetail.get("member_id"));
		}

		model.addAttribute("holdInfos", holdInfos);
		model.addAttribute("businessInfos", businessInfos);
		model.addAttribute("documentList", documentList);

		// 公司治理信息
		Control control = new Control();
		if (companyBase != null && !companyBase.getControlInfo().equals("")) {
			control = companyInfoService.editControlInfoById(companyBase
					.getControlInfo());
		}
		model.addAttribute("controlinfo", control);

		// 抵押物与负债
		RealEstate realEstate = new RealEstate();
		if (companyDetail.containsKey("estate_id") && !companyDetail.get("estate_id").equals("")) {
			realEstate = companyInfoService.editRealEstateInfoById(companyDetail
					.get("estate_id"));
		}
		model.addAttribute("estateInfo", realEstate);

		Debt debt = new Debt();
		if (companyDetail.containsKey("debt_id") && !companyDetail.get("debt_id").equals("")) {
			debt = companyInfoService.editDebtInfoById(companyDetail
					.get("debt_id"));
		}
		model.addAttribute("debtInfo", debt);
		
		return "screens/companyInfo/companyEdit";
	}
	
	/**
	 * 申请人信息保存
	 * @param applicant
	 * @return
	 */
	@RequestMapping(value="/edit/applicant/save",method=RequestMethod.POST)
	public @ResponseBody String saveApplicant(Applicant applicant,String memberId){
		
		try {
			//保存
			if (companyInfoService.saveApplicant(applicant,memberId,USER)) {
				return GlobalConstant.RET_SUCCESS;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return GlobalConstant.RET_FAIL;
		
	}
	
	/**
	 * 企业基本信息保存
	 * @param companyBase
	 * @param memberId
	 * @return
	 */
	@RequestMapping(value="/edit/company/save",method=RequestMethod.POST)
	public @ResponseBody String saveCompanyBase(CompanyBase companyBase,String memberId) {
		
		try {
			if (companyInfoService.saveCompanyBase(companyBase,memberId,USER)) {
				return GlobalConstant.RET_SUCCESS;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return GlobalConstant.RET_FAIL;
	}
	
	/**
	 * 公司控股信息保存
	 * @param holdInfos
	 * @param memberId
	 * @return
	 */
	@RequestMapping(value="/edit/hold/save",method=RequestMethod.POST)
	public @ResponseBody String saveHolds(@ModelAttribute("holdInfos")HoldInfos holdInfos,String memberId) {
		
		if (companyInfoService.saveHolds(holdInfos,USER)) {
			return GlobalConstant.RET_SUCCESS;
		}
		return GlobalConstant.RET_FAIL;
	}
	
	/**
	 * 公司治理信息保存
	 * @param control
	 * @param memberId
	 * @return
	 */
	@RequestMapping(value="/edit/control/save",method=RequestMethod.POST)
	public @ResponseBody String saveControl(Control control,String memberId) {

		try {
			if (companyInfoService.saveControl(control,memberId,USER)) {
				return GlobalConstant.RET_SUCCESS;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return GlobalConstant.RET_FAIL;
	}
	
	/**
	 * 公司基本经营信息保存
	 * @param businessInfos
	 * @param memberId
	 * @return
	 */
	@RequestMapping(value="/edit/business/save",method=RequestMethod.POST)
	public @ResponseBody String saveBusiness(BusinessInfos businessInfos,String memberId) {
		
		if (companyInfoService.saveBusiness(businessInfos,memberId,USER)) {
			return GlobalConstant.RET_SUCCESS;
		}
		
		return GlobalConstant.RET_FAIL;
	}
	
	/**
	 * 抵押物信息保存
	 * @param estate
	 * @param memberId
	 * @return
	 */
	@RequestMapping(value="/edit/estate/save",method=RequestMethod.POST)
	public @ResponseBody String saveEstate(RealEstate estate,String memberId) {
		
		try {
			if (companyInfoService.saveEstate(estate,memberId,USER)) {
				return GlobalConstant.RET_SUCCESS;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return GlobalConstant.RET_FAIL;
	}
	
	/**
	 * 负债信息保存
	 * @param debt
	 * @param memberId
	 * @return
	 */
	@RequestMapping(value="/edit/debt/save",method=RequestMethod.POST)
	public @ResponseBody String saveDebt(Debt debt,String memberId) {
		try {
			if (companyInfoService.saveDebt(debt,memberId,USER)) {
				return GlobalConstant.RET_SUCCESS;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return GlobalConstant.RET_FAIL;
	}
	
	@RequestMapping(value="/get/authentication/code",method=RequestMethod.POST)
	public @ResponseBody String getAuthenticationCode(Model model,String code) {
		
		try {
			code = URLDecoder.decode(code,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		HashMap<String, String> companyDetail = companyInfoService.getDetailIdByMemberId(code);
		
		if (companyDetail.containsKey("realname_id")) {
			return companyDetail.get("realname_id");
		}
		
		return GlobalConstant.RET_FAIL;
	}
	
	@RequestMapping(value="/scan/authentication")
	public String gotoAuthentication(String code) {
		
		return "redirect:/authentication/detail?code="+code;
	}
	
	@RequestMapping("/pulldown")
	public @ResponseBody List<SelectInfo> getPullDown(String id,String type) {
		
		if (type.equals(GlobalConstant.TYPE_CITY)) {
			List<SelectInfo> cities = selectService.findCitiesByProvinceCode(id);
			
			return cities;
		}else if (type.equals(GlobalConstant.TYPE_ZONE)) {
			List<SelectInfo> zones = selectService.findZonesByCityCode(id);
			
			return zones;
		}
		
		return null;
	}
	
	/**
	 * 数据取得及设置
	 * @param model
	 * @param searchCompanyInfo
	 * @param index
	 */
	private void getData(Model model,SearchCompanyInfo searchCompanyInfo,int[] index) {
		
		int total = 0;
		
		PageData<CompanyInfo> pageData = null;
		
		//列表数据取得（所有企业）
		List<CompanyInfo> allList = companyInfoService.getCompanyInfoByCondition(searchCompanyInfo,index[0],0);
		total = companyInfoService.getAllCountBySearchInfo(searchCompanyInfo,0);
		pageData = new PageData<CompanyInfo>(allList, total, index[0]+1);

		model.addAttribute("allList", allList);
		model.addAttribute("allPage", pageData);
		
		//列表数据取得（认证企业）
		List<CompanyInfo> authenticationCompanyList = companyInfoService.getCompanyInfoByCondition(searchCompanyInfo,index[1],1);
		total = companyInfoService.getAllCountBySearchInfo(searchCompanyInfo,1);
		pageData = new PageData<CompanyInfo>(authenticationCompanyList, total, index[1]+1);
		
		model.addAttribute("authenticationCompanyList", authenticationCompanyList);
		model.addAttribute("authenticationPage", pageData);
		
		
		//列表数据取得（待审核企业）
		List<CompanyInfo> waitAuthenticationList = companyInfoService.getCompanyInfoByCondition(searchCompanyInfo,index[2],2);
		total = companyInfoService.getAllCountBySearchInfo(searchCompanyInfo,2);
		pageData = new PageData<CompanyInfo>(waitAuthenticationList, total, index[2]+1);
		
		model.addAttribute("waitAuthenticationList", waitAuthenticationList);
		model.addAttribute("waitAuthenticationPage", pageData);
		
		//列表数据取得（屏蔽企业）
		List<CompanyInfo> forbidList = companyInfoService.getCompanyInfoByCondition(searchCompanyInfo,index[3],3);
		total = companyInfoService.getAllCountBySearchInfo(searchCompanyInfo,3);
		pageData = new PageData<CompanyInfo>(forbidList, total, index[3]+1);

		model.addAttribute("forbidList", forbidList);
		model.addAttribute("forbidPage", pageData);
	}
}
