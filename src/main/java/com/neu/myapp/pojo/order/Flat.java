package com.neu.myapp.pojo.order;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

/**
 * @author Shruti
 *
 */
@Entity
@Table(name = "flats")
public class Flat {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "flat_id", unique = true, nullable = false)
	private int flatId;

	@Column(name = "flat_no")
	private int flatNo;	
	
	@OneToOne(mappedBy = "flat")
	private Order order;

	@Column(name = "building_id")
	private int buildingId;

	@Column(name = "floor_no")
	private int floorNo;

	@Column(name = "flat_Cost_Price")
	private double flatCostPrice;

	@Column(name = "flat_selling_price")
	private double flatSellingPrice;

	@Column(name = "flat_booked_status")
	private char flatBookedStatus;

	public int getFlatId() {
		return flatId;
	}

	public void setFlatId(int flatId) {
		this.flatId = flatId;
	}

	public int getFlatNo() {
		return flatNo;
	}

	public void setFlatNo(int flatNo) {
		this.flatNo = flatNo;
	}

	

	public int getBuildingId() {
		return buildingId;
	}

	public void setBuildingId(int buildingId) {
		this.buildingId = buildingId;
	}

	public int getFloorNo() {
		return floorNo;
	}

	public void setFloorNo(int floorNo) {
		this.floorNo = floorNo;
	}

	public double getFlatCostPrice() {
		return flatCostPrice;
	}

	public void setFlatCostPrice(double flatCostPrice) {
		this.flatCostPrice = flatCostPrice;
	}

	public double getFlatSellingPrice() {
		return flatSellingPrice;
	}

	public void setFlatSellingPrice(double flatSellingPrice) {
		this.flatSellingPrice = flatSellingPrice;
	}

	public char getFlatBookedStatus() {
		return flatBookedStatus;
	}

	public void setFlatBookedStatus(char flatBookedStatus) {
		this.flatBookedStatus = flatBookedStatus;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}
	
	

}
