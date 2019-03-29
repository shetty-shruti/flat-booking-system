package com.neu.myapp.config;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.neu.myapp.pojo.user.Customer;
import com.neu.myapp.pojo.user.Employee;

/**
 * @author Shruti
 *
 */
public class SessionFilter implements Filter {

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		String url = request.getRequestURI();
		Customer cust = null;
		Employee emp = null;
 
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
		response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
		response.setDateHeader("Expires", 0); // Proxies.
		HttpSession session = request.getSession(false);
		if (session != null) {
			cust = (Customer) session.getAttribute("customer");
			emp = (Employee) session.getAttribute("employee");
			
			if (emp != null) {
				if (url.contains("order")) {
					//session.removeAttribute("employee");
					response.sendRedirect(request.getContextPath() + "/user/invalid.htm");
					return;
				}
			} else if (cust != null) {
				if (url.contains("emp")) {
					//session.removeAttribute("customer");
					response.sendRedirect(request.getContextPath() + "/user/invalid.htm");
					return;					
				}
				}

		}		
	
		chain.doFilter(req, res);
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub

	} 

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}
}