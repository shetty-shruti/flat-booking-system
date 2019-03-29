package com.neu.myapp.dao.order;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.ParameterMode;

import org.apache.log4j.Logger;
import org.hibernate.procedure.ProcedureCall;
import org.hibernate.procedure.ProcedureOutputs;
import org.hibernate.query.Query;
import org.hibernate.result.Output;
import org.hibernate.result.ResultSetOutput;
import org.hibernate.result.UpdateCountOutput;

import com.neu.myapp.controller.login.LoginController;
import com.neu.myapp.dao.DAO;
import com.neu.myapp.pojo.building.Building;
import com.neu.myapp.pojo.order.Order;
import com.neu.myapp.pojo.order.Payment;
import com.neu.myapp.pojo.order.PaymentList;
import com.neu.myapp.pojo.user.Customer;

/**
 * @author Shruti
 * 
 * 
 *
 */
public class OrderDAO extends DAO {
	private static final Logger LOGGER = Logger.getLogger(OrderDAO.class);

	public List<Order> getOrderList(int id) {
		List<Order> orderList = new ArrayList<Order>();
		try {
			begin();
			Query q = getSession().createQuery("from Order where customerId =:customerId and orderStatus in ('Booked', 'Payment Completed')");
			q.setInteger("customerId", id);
			orderList = q.list();
			commit();
		} catch (Exception e) {
			rollback();
			LOGGER.error(e);
			rollback();
		}
		return orderList;
	}

	public Building getFlatBuildingDetails(int buildingId) {
		Building building = null;
		try {
			begin();
			Query q = getSession().createQuery("from Building where id = :buildingId");
			q.setInteger("buildingId", buildingId);
			building = (Building) q.uniqueResult();
			commit();
		} catch (Exception e) {
			rollback();
			LOGGER.error(e);
		}
		return building;
	}

	public String makePayment(Payment payment, int paymentMode, Customer cust) {
		// TODO Auto-generated method stub
		try {
			begin();
			ProcedureCall procedureCall = getSession().createStoredProcedureCall("SP_MAKE_PAYMENT_BY_CUSTOMER");
			procedureCall.registerParameter(1, Integer.class, ParameterMode.IN); // order Id
			procedureCall.registerParameter(2, String.class, ParameterMode.IN); // Account No
			procedureCall.registerParameter(3, Double.class, ParameterMode.IN); // Amount
			procedureCall.registerParameter(4, Integer.class, ParameterMode.IN); // payment Type
			procedureCall.registerParameter(5, Integer.class, ParameterMode.IN); // payment Type
			procedureCall.getParameterRegistration(1).bindValue(payment.getOrderId());
			procedureCall.getParameterRegistration(2).bindValue(payment.getAccountNo());
			procedureCall.getParameterRegistration(3).bindValue(payment.getPaymentAmount());
			procedureCall.getParameterRegistration(4).bindValue(paymentMode);
			procedureCall.getParameterRegistration(5).bindValue(cust.getId());
			ProcedureOutputs procedureOutputs = procedureCall.getOutputs();
			ResultSetOutput resultSetOutput = (ResultSetOutput) procedureOutputs.getCurrent();
			commit();
			return "success";
		} catch (Exception e) {
			rollback();
			LOGGER.error(e);
			return "error";
		}

	}

	public List<PaymentList> getPaymentList() {
		List<PaymentList> paymentList = new ArrayList<PaymentList>();
		try {
			begin();
			Query q = getSession().createQuery("from PaymentList where statusId = 10");
			paymentList = q.list();
			commit();
		} catch (Exception e) {
			LOGGER.error(e);
			rollback();
		}
		return paymentList;
	}

	public String authorizePayment(int paymentId, int id) {
		String message = null;
		try {
			begin();
			ProcedureCall procedureCall = getSession().createStoredProcedureCall("SP_AUTHORIZE_PAYMENTS");
			procedureCall.registerParameter(1, Integer.class, ParameterMode.IN); // payment id
			procedureCall.registerParameter(2, Integer.class, ParameterMode.IN); // authorizer
			procedureCall.getParameterRegistration(1).bindValue(paymentId);
			procedureCall.getParameterRegistration(2).bindValue(id);
			ProcedureOutputs procedureOutputs = procedureCall.getOutputs();
			// ResultSetOutput resultSetOutput = (ResultSetOutput)
			// procedureOutputs.getCurrent();
			do {
				Output current = procedureOutputs.getCurrent();

				if (current.isResultSet()) {
					ResultSetOutput resultSetOutput = (ResultSetOutput) current;
					message = "Payment Authorised Successfully";
				} else {
					UpdateCountOutput updateCountOutput = (UpdateCountOutput) current;
					message = "Payment Authorised Successfully";
				}
			} while (procedureOutputs.goToNext());

			procedureOutputs.release();
			commit();

		} catch (Exception e) {
			// TODO: handle exception
			message = "Authorization Unsuccessfull";
		}
		return message;
	}

	public String getCustomerDetails(int custId) {
		String email = null;
		try {

			begin();
			Query q = getSession().createQuery("select email from Customer where id = :id");
			q.setInteger("id", custId);
			email = (String) q.uniqueResult();
			commit();
		} catch (Exception e) {
			LOGGER.error(e);
			rollback();
		}
		return email;
	}

}
