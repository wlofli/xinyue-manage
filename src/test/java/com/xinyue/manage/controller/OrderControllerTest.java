package com.xinyue.manage.controller;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.portlet.MockActionRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.RequestBuilder;
import org.springframework.ui.Model;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.web.servlet.HandlerAdapter;
import org.springframework.web.servlet.ModelAndView;

import com.xinyue.manage.service.FastProductService;
import com.xinyue.manage.service.OrderService;

/**
 * author lzc
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/resources/conf/spring-mvc.xml",
		"file:src/main/resources/conf/spring-mybatis.xml"})
public class OrderControllerTest {

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
	}

	@Before
	public void setUp() throws Exception {
		System.out.println("begin");
	}

	@After
	public void tearDown() throws Exception {
		System.out.println("end");
	}
	

	@Resource
	private OrderService orderService;
	
	@Resource
	private FastProductService fastProductService;
	
	@Resource
	private OrderController orderController;
	
	@Resource
	private DispatcherServlet DispatcherServlet;
	
	@Test
	public void testGetOrgDetail() {
		MockHttpServletRequest request = new MockHttpServletRequest();  
        MockHttpServletResponse response = new MockHttpServletResponse(); 
        ModelAndView mv = new ModelAndView();
         request.setServletPath("order/getorgdetail");
        request.addParameter("orderId", "01e40c96fcff44c1a26c3074ffac7f3c");
        request.addParameter("orderType", "1");
		try {
//			orderController.getOrgDetail("01e40c96fcff44c1a26c3074ffac7f3c", "1",mv.getModel());
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		
		fail("Not yet implemented");
	}

	@Test
	public void testGetOrgEdit() {
		fail("Not yet implemented");
	}

}
