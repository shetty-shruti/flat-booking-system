package com.neu.myapp.controller.login;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.captcha.botdetect.web.servlet.Captcha;
import com.neu.myapp.dao.login.LoginDAO;
import com.neu.myapp.pojo.user.Customer;
import com.neu.myapp.pojo.user.Employee;

/**
 * @author Shruti
 *
 */
@Controller
public class LoginController {

	private static final Logger LOGGER = Logger.getLogger(LoginController.class);

	@RequestMapping(value = "/user/login.htm", method = RequestMethod.GET)
	public String showLoginForm(HttpServletRequest request, LoginDAO loginDAO, ModelMap map, HttpSession session) {
		try {
		if(session != null) {
			String role = (String)session.getAttribute("role");
			if (role != null && role.equalsIgnoreCase("employee")) {
				Employee emp = new Employee();
				Employee loggedInEmp = (Employee) session.getAttribute("employee");
				emp = loginDAO.authenticateEmployee(loggedInEmp.getUserName(), loggedInEmp.getPassword());
				if (emp != null) {
					session.setAttribute("employee", emp);
					session.setAttribute("role", role);
					return "emp-dashboard";
				}
			} else if (role != null && role.equalsIgnoreCase("customer")) {
				Customer cust = new Customer();
				Customer loggeInCust = (Customer) session.getAttribute("customer");
				 cust = loginDAO.authenticateCustomer(loggeInCust.getUserName(), loggeInCust.getPassword());
				if (cust != null) {
					session.setAttribute("customer", cust);
					session.setAttribute("role", role);
					return "cust-dashboard";
				}
			}
		}
		}catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "user-login";
	}
	
	@RequestMapping(value = "/user/login1.htm", method = RequestMethod.GET)
	public String userLoggedIn() {

		return "user-login";
	}

	@RequestMapping(value = "/user/logout.htm", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, Model map, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.removeAttribute("customer");
		session.removeAttribute("employee");
		session.invalidate();		
		String message = "You are successfully logged out";
		//map.addAttribute("message", message);`
		LOGGER.info("User logged out");
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0); // Proxies.
        map.addAttribute("message",message);
		//return "redirect:/";
        return "user-login";
	}

	@RequestMapping(value = "/user/login.htm", method = RequestMethod.POST)
	public String checkAuthentication(HttpServletRequest request, LoginDAO loginDAO, ModelMap map) {
		
		String userName = request.getParameter("username");
		String password = request.getParameter("password");
		String role = request.getParameter("role");
		HttpSession session = request.getSession();

		try {
			if (role.equalsIgnoreCase("employee")) {
				Employee emp;
				emp = loginDAO.authenticateEmployee(userName, password);
				if (emp != null) {
					session.setAttribute("employee", emp);
					session.setAttribute("role", role);
					return "emp-dashboard";
				}
			} else if (role.equalsIgnoreCase("customer")) {
				Customer cust = loginDAO.authenticateCustomer(userName, password);
				if (cust != null) {
					session.setAttribute("customer", cust);
					session.setAttribute("role", role);
					return "cust-dashboard";
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "error";
	}
	
	
	@RequestMapping(value = "/user/invalid.htm", method = RequestMethod.GET)
	public String invalid() {

		return "invalid";
	}

	@RequestMapping(value = "/user/create.htm", method = RequestMethod.GET)
	public String showCreateForm() {

		return "user-create-form";
	}
	@RequestMapping(value = "/user/error.htm", method = RequestMethod.GET)
	public String errorForm() {

		return "error";
	}

	@RequestMapping(value = "/user/create.htm", method = RequestMethod.POST)
	public String createUser(HttpServletRequest request, LoginDAO loginDAO, ModelMap map) {
		Captcha captcha = Captcha.load(request, "CaptchaObject");
		String captchaCode = request.getParameter("captchaCode");
		HttpSession session = request.getSession();
		String role = request.getParameter("role");
		String email = request.getParameter("inputEmail");
		String result = "success";
		if (captcha.validate(captchaCode)) {
			if (role.equalsIgnoreCase("employee")) {
				Employee emp = new Employee();
				emp = setemployeeDetails(request);
				result = loginDAO.registerEmployee(emp);
			} else if (role.equalsIgnoreCase("customer")) {
				Customer cust = new Customer();
				cust = setCustomerDetails(request);
				result = loginDAO.registerCustomer(cust);
			}
			if (result.equalsIgnoreCase("success")) {
				Random rand = new Random();
				int randomNum1 = rand.nextInt(5000000);
				int randomNum2 = rand.nextInt(5000000);
				try {
					String str = "http://localhost:8080/myapp/user/validateemail.htm?email=" + email + "&key1="
							+ randomNum1 + "&key2=" + randomNum2 + "&role=" + role;
					session.setAttribute("key1", randomNum1);
					session.setAttribute("key2", randomNum2);
					sendEmail(email, "Click on this link to activate your account : " + str);
				} catch (Exception e) {
					System.out.println("Email cannot be sent");
				}
			} else {
				map.addAttribute("errorMessage", "Invalid Captcha!");
				return "error";
			}
		} else {
			map.addAttribute("errorMessage", "Invalid Captcha!");
			return "user-create-form";
		}
		return "user-created";
	}

	@RequestMapping(value = "/user/validateemail.htm", method = RequestMethod.GET)
	public String validateEmail(HttpServletRequest request, LoginDAO loginDAO, ModelMap map) {

		// The user will be sent the following link when the use registers
		// This is the format of the email
		// http://hostname:8080/lab10/user/validateemail.htm?email=useremail&key1=<random_number>&key2=<body
		// of the email that when user registers>
		boolean updateStatus = false;
		HttpSession session = request.getSession();
		String email = request.getParameter("email");
		int key1 = Integer.parseInt(request.getParameter("key1"));
		int key2 = Integer.parseInt(request.getParameter("key2"));
		String role = request.getParameter("role");
		System.out.println(session.getAttribute("key1"));
		System.out.println(session.getAttribute("key2"));

		if ((Integer) (session.getAttribute("key1")) == key1 && ((Integer) session.getAttribute("key2")) == key2) {
			try {
				if (role.equalsIgnoreCase("employee")) {
					updateStatus = loginDAO.updateEmployee(email);
				} else {
					updateStatus = loginDAO.updateCustomer(email);
				}
				if (updateStatus) {
					return "user-login";
				} else {
					return "error";
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			map.addAttribute("errorMessage", "Link expired , generate new link");
			map.addAttribute("resendLink", true);
			return "error1";
		}

		return "user-login";

	}

	@RequestMapping(value = "user/resendemail.htm", method = RequestMethod.POST)
	public String resendEmail(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String useremail = request.getParameter("inputEmail");
		Random rand = new Random();
		int randomNum1 = rand.nextInt(5000000);
		int randomNum2 = rand.nextInt(5000000);
		try {
			String str = "http://localhost:8080/myapp/user/validateemail.htm?email=" + useremail + "&key1=" + randomNum1
					+ "&key2=" + randomNum2;
			session.setAttribute("key1", randomNum1);
			session.setAttribute("key2", randomNum2);
			sendEmail(useremail, "Click on this link to activate your account : " + str);
		} catch (Exception e) {
			System.out.println("Email cannot be sent");
		}

		return "user-created";
	}

	@RequestMapping(value = "/user/forgotpassword.htm", method = RequestMethod.GET)
	public String getForgotPasswordForm(HttpServletRequest request) {

		return "forgot-password";
	}

	@RequestMapping(value = "/user/checkUser.htm", method = RequestMethod.GET)
	public @ResponseBody String checkUniquesnessForEmail(HttpServletRequest request, LoginDAO loginDAO) {
		String message = null;
		String email = request.getParameter("email");
		message = loginDAO.checkUniquesnessForEmail(email);
		return message;
	}

	@RequestMapping(value = "/user/forgotpassword.htm", method = RequestMethod.POST)
	public String handleForgotPasswordForm(HttpServletRequest request, LoginDAO loginDAO) {
		String useremail = request.getParameter("inputEmail");
		String role = request.getParameter("role");
		Captcha captcha = Captcha.load(request, "CaptchaObject");
		String captchaCode = request.getParameter("captchaCode");

		if (captcha.validate(captchaCode)) {
			if (role.equalsIgnoreCase("employee")) {
				Employee emp = loginDAO.getEmployeePassword(useremail);
				if (emp != null) {
					sendEmail(useremail, "Your password is : " + emp.getPassword());
				} else {
					return "error";
				}
			} else {
				Customer cust = loginDAO.getCustomerPassword(useremail);
				if (cust != null) {
					sendEmail(useremail, "Your password is : " + cust.getPassword());
				} else {
					return "error";
				}
			}
			return "forgot-password-success";
		} else {
			request.setAttribute("captchamsg", "Captcha not valid");
			return "forgot-password";
		}
	}

	public void sendEmail(String useremail, String message) {
		try {
			Email email = new SimpleEmail();
			email.setHostName("smtp.googlemail.com");
			email.setSmtpPort(465);
			email.setAuthenticator(new DefaultAuthenticator("contactapplication2018@gmail.com", "springmvc"));
			email.setSSLOnConnect(true);
			email.setFrom("no-reply@msis.neu.edu");// This user email does not // exist
			email.setSubject("Password Reminder");
			email.setMsg(message); // Retrieve email from the DAO and send this
			email.addTo(useremail);
			email.send();
		} catch (EmailException e) {
			System.out.println("Email cannot be sent");
		}
	}

	private Customer setCustomerDetails(HttpServletRequest request) {
		// TODO Auto-generated method stub
		Customer cust = new Customer();
		cust.setFirstName(request.getParameter("firstName"));
		cust.setLastName(request.getParameter("lastName"));
		cust.setUserName(request.getParameter("userName"));
		cust.setPassword(request.getParameter("password"));
		cust.setAge(request.getParameter("age"));
		cust.setEmail(request.getParameter("inputEmail"));
		cust.setPhone(request.getParameter("phoneNumber"));
		cust.setBirthDate(request.getParameter("date"));
		cust.setGender(request.getParameter("gender"));
		cust.setStatus('D');
		return cust;
	}

	private Employee setemployeeDetails(HttpServletRequest request) {
		Employee emp = new Employee();
		emp.setFirstName(request.getParameter("firstName"));
		emp.setLastName(request.getParameter("lastName"));
		emp.setUserName(request.getParameter("userName"));
		emp.setPassword(request.getParameter("password"));
		emp.setAge(request.getParameter("age"));
		emp.setEmail(request.getParameter("inputEmail"));
		emp.setPhone(request.getParameter("phoneNumber"));
		emp.setBirthDate(request.getParameter("date"));
		emp.setGender(request.getParameter("gender"));
		emp.setSalary(Double.parseDouble(request.getParameter("salary")));
		emp.setStatus('D');
		return emp;
	}

}
