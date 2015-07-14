package com.xinyue.manage.util;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.Template;

/**
 * author lzc
 * 2015年7月13日下午6:33:02
 */
public class WordUtil {
	
	private Configuration configuration = null;
	
	public WordUtil(){
		try {
			configuration = new Configuration();
			configuration.setDefaultEncoding("UTF-8");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}
	
	
	private Template getTemplate(String templatePath, String templateName) throws IOException{
		configuration.setClassForTemplateLoading(this.getClass(), templatePath);
		Template t  = configuration.getTemplate(templateName);
		t.setEncoding("UTF-8");

		return t;
		
	}
	
	
	public void write(String templatePath, String templateName , Map<String, String> dataMap, Writer out){
		try {
			Template t = getTemplate(templatePath, templateName);
			t.process(dataMap, out);
			out.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	
	
	public static void main(String[] args){
		Map<String, String> map = new HashMap<String, String>();
		map.put("code", "20150713");
		map.put("phone", "18768104912");
		map.put("status", "新越网审核中");
		map.put("createdTime", new Date().toString());
		map.put("contactName", "李先生");
		map.put("company", "摩科商用设备有限公司");
		
		WordUtil handler = new WordUtil();
		Writer out;
		try {
			out = new OutputStreamWriter(new FileOutputStream("D:/tmp/test.doc"), "UTF-8");
			handler.write("/com/xinyue/manage/util", "order.xml", map, out);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

}
