package com.neu.myapp.controller.login;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
* @author Shruti
*
*/
@Controller
public class CustomerController {
	
	@RequestMapping(value="/cust/custDashboard.htm", method=RequestMethod.GET)
	public String getCustDashboard(HttpServletRequest request) {		
		return "cust-dashboard";
	}
}
