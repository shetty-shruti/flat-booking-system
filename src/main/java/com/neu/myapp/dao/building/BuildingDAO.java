package com.neu.myapp.dao.building;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.ParameterMode;
import javax.persistence.StoredProcedureQuery;

import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.procedure.ProcedureCall;
import org.hibernate.procedure.ProcedureOutputs;
import org.hibernate.result.ResultSetOutput;

import com.neu.myapp.controller.buildings.BuildingController;
import com.neu.myapp.dao.DAO;
import com.neu.myapp.pojo.building.Building;

/**
 * @author Shruti
 *
 */
public class BuildingDAO extends DAO {

	private static final Logger LOGGER = Logger.getLogger(BuildingController.class);

	public String insertBuildingDetails(Building building) {
		try {
			begin();
			System.out.println("inside BuildingDAO insert");
			getSession().save(building);
			commit();
		} catch (Exception e) {
			LOGGER.error(e);
			rollback();
			return "error";
		}
		return "success";
	}

	public List<Building> getBuildingList(Building building) {
		List<Building> buildingList = new ArrayList<Building>();
		try {
			begin();
			Query q = getSession().createQuery("from Building where state = :state and city= :city");
			q.setString("state", building.getState());
			q.setString("city", building.getCity());
			buildingList = q.list();
			commit();
		} catch (Exception e) {
			LOGGER.error(e);
			rollback();
		}
		return buildingList;
	}

	public Building getBuildingDetails(int id) {
		Building build = null;
		try {
			begin();
			Query q = getSession().createQuery(" from Building where id = :id");
			q.setInteger("id", id);
			build = (Building) q.uniqueResult();
			commit();
		} catch (Exception e) {
			LOGGER.info(e);
			rollback();
		}
		return build;
	}

	public String bookFlats(int flatId, int custId) {
		// TODO Auto-generated method stub
		try {
			begin();
			ProcedureCall procedureCall = getSession().createStoredProcedureCall("SP_PLACE_ORDERS");
			procedureCall.registerParameter(1, Integer.class, ParameterMode.IN);
			procedureCall.registerParameter(2, Integer.class, ParameterMode.IN);
			procedureCall.getParameterRegistration(1).bindValue(custId);
			procedureCall.getParameterRegistration(2).bindValue(flatId);
			ProcedureOutputs procedureOutputs = procedureCall.getOutputs();
			ResultSetOutput resultSetOutput = (ResultSetOutput) procedureOutputs.getCurrent();
			commit();
		} catch (Exception e) {
			e.printStackTrace();
			rollback();
			LOGGER.info(e);
			return "error";
		}
		return "success";
	}

	public int getFlatId(int id, int flatNo, int floorNo) {
		int flatId = 0;
		try {
			begin();
			Query q = getSession().createSQLQuery(
					"select flat_id from flats where building_id = :building_id and flat_no  = :flat_no and floor_no = :floor_no");
			q.setInteger("building_id", id);
			q.setInteger("flat_no", flatNo);
			q.setInteger("floor_no", floorNo);
			flatId = (Integer) q.uniqueResult();
			commit();
		} catch (Exception e) {
			LOGGER.error(e);
			rollback();
		}
		return flatId;
	}

}
