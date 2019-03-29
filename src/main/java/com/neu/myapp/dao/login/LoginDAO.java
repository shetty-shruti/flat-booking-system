package com.neu.myapp.dao.login;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;

import com.neu.myapp.dao.DAO;
import com.neu.myapp.dao.order.OrderDAO;
import com.neu.myapp.pojo.user.Customer;
import com.neu.myapp.pojo.user.Employee;

/**
 * @author Shruti
 *
 */
public class LoginDAO extends DAO {

	private static final Logger LOGGER = Logger.getLogger(OrderDAO.class);

	public Employee authenticateEmployee(String userName, String password) throws Exception {
		try {
			begin();
			Query q = getSession().createQuery("from Employee where username = :userName");
			q.setString("userName", userName);
			Employee emp = (Employee) q.uniqueResult();
			return emp;
		} catch (HibernateException hb) {
			rollback();
			LOGGER.error(hb);
			throw new Exception("Unable to find Employee with username" + userName, hb);
		}
	}

	public Customer authenticateCustomer(String userName, String password) throws Exception {
		try {
			begin();
			Query q = getSession().createQuery("from Customer where username = :userName");
			q.setString("userName", userName);

			Customer cust = (Customer) q.uniqueResult();
			return cust;
		} catch (HibernateException hb) {
			rollback();
			throw new Exception("Unable to find Employee with username" + userName, hb);
		}
	}

	public String registerEmployee(Employee emp) {
		try {
			begin();
			System.out.println("inside DAO");
			getSession().save(emp);
			commit();
		} catch (Exception e) {
			LOGGER.info(e);
			rollback();
			return "error";
		}
		return "success";
	}

	public String registerCustomer(Customer cust) {
		try {
			begin();
			System.out.println("inside DAO");
			getSession().save(cust);
			commit();
		} catch (Exception e) {
			LOGGER.info(e);
			rollback();
			return "error";
		}
		return "success";
	}

	public boolean updateEmployee(String email) throws Exception {
		try {
			begin();
			System.out.println("inside DAO");
			Query q = getSession().createQuery("from Employee where email = :useremail");
			q.setString("useremail", email);
			Employee emp = (Employee) q.uniqueResult();
			if (emp != null) {
				emp.setStatus('A');
				getSession().update(emp);
				commit();
				return true;
			} else {
				return false;
			}

		} catch (HibernateException e) {
			rollback();
			throw new Exception("Exception while creating user: " + e.getMessage());
		}

	}

	public boolean updateCustomer(String email) throws Exception {
		// TODO Auto-generated method stub
		try {
			begin();
			System.out.println("inside DAO");
			Query q = getSession().createQuery("from Customer where email = :useremail");
			q.setString("useremail", email);
			Customer cust = (Customer) q.uniqueResult();
			if (cust != null) {
				cust.setStatus('A');
				getSession().update(cust);
				commit();
				return true;
			} else {
				return false;
			}

		} catch (HibernateException e) {
			rollback();
			throw new Exception("Exception while creating user: " + e.getMessage());
		}
	}

	public Employee getEmployeePassword(String useremail) {
		try {
			begin();
			Query q = getSession().createQuery("from Employee where email = :useremail");
			q.setString("useremail", useremail);
			Employee emp = (Employee) q.uniqueResult();
			return emp;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}

	public Customer getCustomerPassword(String useremail) {
		try {
			begin();
			Query q = getSession().createQuery("from Customer where email = :useremail");
			q.setString("useremail", useremail);
			Customer cust = (Customer) q.uniqueResult();
			return cust;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}

	public String checkUniquesnessForEmail(String email) {
		// TODO Auto-generated method stub
		String message = null;
		try {
			begin();
			Query q = getSession().createQuery("from Customer where email = :email");
			q.setString("email", email);
			List<Customer> custResult = q.list();
			if (custResult.size() == 0) {
				q = getSession().createQuery("from Employee where email = :email");
				q.setString("email", email);
				List<Employee> empResult = q.list();
				if (empResult.size() == 0) {
					message = "valid";
				} else {
					message = "Registered Email Id";
				}
			} else {
				message = "Registered Email Id";
			}
		} catch (Exception e) {
			rollback();
			message = "error";
			return message;
		}
		return message;
	}

}
