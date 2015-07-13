package com.xinyue.manage.util;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class CustomListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		
		try {
			goTimmer();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void goTimmer() {
		Timer timmerTask = new Timer();

		Calendar calEnviron = Calendar.getInstance();

		calEnviron.set(Calendar.HOUR_OF_DAY, 0);
		calEnviron.set(Calendar.MINUTE, 00);

		// date为制定时间
		Date dateSetter = new Date();
		dateSetter = calEnviron.getTime();
		
		// nowDate为当前时间
		Date nowDateSetter = new Date();
		// 所得时间差为，距现在待触发时间的间隔
		long intervalEnviron = dateSetter.getTime() - nowDateSetter.getTime();
		if (intervalEnviron < 0) {
			calEnviron.add(Calendar.DAY_OF_MONTH, 1);
			dateSetter = calEnviron.getTime();
			intervalEnviron = dateSetter.getTime() - nowDateSetter.getTime();
		}

		// 每24小时执行一次
		timmerTask.schedule(new CustomTimer(timmerTask), intervalEnviron, 1 * 1000
				* 60 * 60 * 24);
		
	}

}
