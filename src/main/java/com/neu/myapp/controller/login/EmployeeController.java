package com.neu.myapp.controller.login;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.neu.myapp.dao.order.OrderDAO;
import com.neu.myapp.pojo.order.Payment;
import com.neu.myapp.pojo.order.PaymentList;
import com.neu.myapp.pojo.user.Employee;

/**
* @author Shruti
*
*/
@Controller
public class EmployeeController {
	
	@RequestMapping(value ="/emp/empDashboard.htm", method = RequestMethod.GET)
	public String getEmpDashboard(HttpServletRequest request) {
		return "emp-dashboard";
	}
	@RequestMapping(value ="/emp/viewCustomerPayments.htm",method = RequestMethod.GET)
	public String viewCustomerPayments(HttpServletRequest request,HttpSession session,OrderDAO orderDAO,Model mod,@ModelAttribute("paymentList")PaymentList paymentList) {
		
		String values = request.getParameter("paymentToAuthorize");
		Employee emp = (Employee)session.getAttribute("employee");
		int custId = 0;
		String message = null;
		if(values != null) {
			String[] details = values.split(":");
			custId = Integer.parseInt(details[1].trim());
			String custEmailId = orderDAO.getCustomerDetails(custId);			
			message = orderDAO.authorizePayment(Integer.parseInt(details[0].trim()),emp.getId());
			if(message.equalsIgnoreCase("Payment Authorised Successfully") && custEmailId != null) {
				String emailBody = "Congratulation!!! Your Payment is authorized Successfully";
				sendEmail(custEmailId, emailBody);
			}else {
				return "error";
			}
		}
		List<PaymentList> paymentsToAuthorize = orderDAO.getPaymentList();
		mod.addAttribute("paymentsToAuthorize",paymentsToAuthorize);
		mod.addAttribute("message",message);
		return "payment-list";
	}
	
	public void sendEmail(String useremail, String message) {
		try {
			Email email = new SimpleEmail();
			email.setHostName("smtp.googlemail.com");
			email.setSmtpPort(465);
			email.setAuthenticator(new DefaultAuthenticator("contactapplication2018@gmail.com", "springmvc"));
			email.setSSLOnConnect(true);
			email.setFrom("no-reply@msis.neu.edu");
			email.setSubject("Payment Information");
			email.setContent(message, "text/html; charset=utf-8");
			;
			// email.setMsg(message); // Retrieve email from the DAO and send this
			email.addTo(useremail);
			email.send();
		} catch (EmailException e) {
			System.out.println("Email cannot be sent");
		}
	}
}
