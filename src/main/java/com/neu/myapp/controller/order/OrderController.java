package com.neu.myapp.controller.order;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.neu.myapp.controller.login.LoginController;
import com.neu.myapp.dao.order.OrderDAO;
import com.neu.myapp.pojo.building.Building;
import com.neu.myapp.pojo.order.Flat;
import com.neu.myapp.pojo.order.Order;
import com.neu.myapp.pojo.order.Payment;
import com.neu.myapp.pojo.user.Customer;

/**
 * @author Shruti
 *
 */
@Controller
public class OrderController {
	private static final Logger LOGGER = Logger.getLogger(OrderController.class);

	@RequestMapping(value = "/order/viewOrder.htm", method = RequestMethod.GET)
	public String getOrderList(HttpServletRequest request, Model mod, @ModelAttribute("order") Order order,
			HttpSession session, OrderDAO orderDAO) {
		Customer cust = (Customer) session.getAttribute("customer");
		List<Order> orderList = orderDAO.getOrderList(cust.getId());
		mod.addAttribute("orderList", orderList);
		return "order-list";

	}

	@RequestMapping(value = "/order/showBuildingDetails", method = RequestMethod.GET)
	public String viewFlatDetails(HttpServletRequest request, Model mod, OrderDAO orderDAO) {
		int buildingId = Integer.parseInt(request.getParameter("buildingId"));
		Building building = orderDAO.getFlatBuildingDetails(buildingId);
		if (building != null) {
			mod.addAttribute("building", building);
			return "viewBuildingList";
		} else {
			return "error";
		}
	}

	@RequestMapping(value = "/order/makePayment.htm", method = RequestMethod.GET)
	public String viewPaymentScreen(HttpServletRequest request, Model mod, @ModelAttribute("payment") Payment payment) {
		int orderId = Integer.parseInt(request.getParameter("orderId"));
		mod.addAttribute("orderId", orderId);
		return "make-payment";
	}

	@RequestMapping(value = "/order/makePayment.htm", method = RequestMethod.POST)
	public String makePayment(HttpServletRequest request, Model mod, @ModelAttribute("payment") Payment payment,
			OrderDAO orderDAO, HttpSession session) {
		String message = "";
		int paymentMode = Integer.parseInt(request.getParameter("paymentMode"));
		Customer cust = (Customer) session.getAttribute("customer");
		String result = orderDAO.makePayment(payment, paymentMode, cust);
		if (result.equalsIgnoreCase("success")) {
			message = generateMailBody(payment, cust);
			sendEmail(cust.getEmail(), message);
			return "make-payment-success";
		} else {
			return "error";
		}

	}

	private String generateMailBody(Payment payment, Customer cust) {
		String date = getDate();
		String message = "<html>\r\n" + "    <head>\r\n" + "        <style>\r\n" + "            table, th, td {\r\n"
				+ "    border: 1px solid black;\r\n" + "}\r\n" + "        </style>\r\n" + "    </head>\r\n"
				+ "    <body>\r\n" + "        <p>Please Find the Payment Details below</p>\r\n" + "        <table>\r\n"
				+ "            <tr>\r\n" + "                <th>Order Id</th>\r\n"
				+ "                <th>Payment Data Time</th>\r\n" + "                <th>Status</th>\r\n"
				+ "                <th>Account No</th>\r\n" + "                <th>Payment Amount</th>\r\n"
				+ "            </tr>\r\n" + "            <tr>\r\n" + "                <td>" + payment.getOrderId()
				+ "</td>\r\n" + "                <td>" + date + "</td>\r\n"
				+ "                <td>CUSTOMER SUBMITTED</td>\r\n" + "                <td>" + payment.getAccountNo()
				+ "</td>\r\n" + "                <td>" + payment.getPaymentAmount() + "</td>\r\n"
				+ "            </tr>\r\n" + "        </table>\r\n" + "    <p>Thank You!!!</p>\r\n" + "    </body>\r\n"
				+ "</html>";
		return message;
	}

	private String getDate() {
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		LocalDateTime now = LocalDateTime.now();
		return dtf.format(now);
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
