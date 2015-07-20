package com.xinyue.manage.util;

import java.util.Date;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.support.WebBindingInitializer;
import org.springframework.web.context.request.WebRequest;


/**
 * 
 * @author wenhai.you
 * @2015年5月25日
 * @上午10:33:52
 */
public class DateConverBinding implements WebBindingInitializer{

	@Override
	public void initBinder(WebDataBinder binder, WebRequest request) {
		// TODO Auto-generated method stub
		binder.registerCustomEditor(Date.class, new DateConvertEditor());
	}
}
