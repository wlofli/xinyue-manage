package com.xinyue.manage.util;

import java.util.Timer;
import java.util.TimerTask;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;

import com.xinyue.manage.dao.AdvertisingDao;
import com.xinyue.manage.dao.ProductDao;
import com.xinyue.manage.service.CooperationService;
import com.xinyue.manage.service.LinkService;

public class CustomTimer extends TimerTask{

	Timer timer = new Timer();

	public CustomTimer(Timer timer) {
		this.timer = timer;
	}
	
	@Override
	public void run() {
		//应用操作
		advertDao.updateOverdue();
		pdao.updateStatus();
		
		//2015/06/15 茅 追加 START
		updateLinkFun();
		//2015/06/15 茅 追加 END
	}

	@Autowired
	private AdvertisingDao advertDao;
	
	@Autowired
	private ProductDao pdao;
	
	//2015/06/15 茅 追加 START
	@Resource
	private LinkService linkService;
	@Resource
	private CooperationService cooperationService;
	
	private void updateLinkFun() {
		//友情链接状态更新
		linkService.updateDeadLine();
		//合作机构状态更新
		cooperationService.updateDeadLine();
	}
	//2015/06/15 茅 追加 END
}
