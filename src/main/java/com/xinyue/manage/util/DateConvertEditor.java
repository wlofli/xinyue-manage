package com.xinyue.manage.util;

import java.beans.PropertyEditorSupport;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Pattern;

import org.springframework.util.StringUtils;

/**
 * 
 * @author wenhai.you
 * @2015年5月25日
 * @上午10:34:53
 */
public class DateConvertEditor extends PropertyEditorSupport{

	private final SimpleDateFormat datetimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	private final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

	private final SimpleDateFormat mouthFormat = new SimpleDateFormat("yyyy-MM");

	public void setAsText(String text) throws IllegalArgumentException {
		if (StringUtils.hasText(text)) {
			try {
				if (text.indexOf(":") == -1 && text.length() == 10) {
					setValue(convert2GMTDate(this.dateFormat, text));
				} else if (text.indexOf(":") > 0 && text.length() == 19) {
					setValue(convert2GMTDate(this.datetimeFormat, text));
				} else if (isLong(text)) {
					Date date = new Date(Long.parseLong(text));
					setValue(date);
				} else if (text.indexOf("-") > 0) {
					Date date= mouthFormat.parse(text);
					setValue(date);
				} else {
					throw new IllegalArgumentException("Could not parse date, date format is error ");
				}

			}
			catch (ParseException ex) {
				IllegalArgumentException iae = new IllegalArgumentException("Could not parse date: " + ex.getMessage());
				iae.initCause(ex);
				throw iae;
			}
		} else {
			setValue(null);
		}
	}

	private Date convert2GMTDate(SimpleDateFormat sdf, String text) throws ParseException {
		Date dateFromPage = sdf.parse(text);
		return dateFromPage;
	}

	private boolean isLong(String text) {
		Pattern pattern = Pattern.compile("^[1-9][0-9]+$");
		return pattern.matcher(text).matches();
	}
}
