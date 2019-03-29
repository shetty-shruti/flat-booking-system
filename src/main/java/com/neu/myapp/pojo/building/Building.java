package com.neu.myapp.pojo.building;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedStoredProcedureQuery;
import javax.persistence.ParameterMode;
import javax.persistence.StoredProcedureParameter;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
* @author Shruti
*
*/
@Entity
@Table(name="buildings")
@NamedStoredProcedureQuery(
name = "SP_PLACE_ORDERS",
procedureName="SP_PLACE_ORDERS",
parameters = {
		@StoredProcedureParameter(mode = ParameterMode.IN, type = Integer.class, name = "cust_id"),
		@StoredProcedureParameter(mode = ParameterMode.IN, type = Integer.class, name = "flat_id")
})
public class Building {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="building_id",unique=true,nullable=false)
	private int id;
	
	@Column(name="building_name")
	private String buildingName;
	
	@Column(name="no_of_floors")
	private int noOfFloors;
	
	@Column(name="Flats_Per_Floor")
	private int flatsPerFloor;
	
	@Column(name="street")
	private String streetName;
	
	@Column(name="city")
	private String city;
	
	@Column(name="state")
	private String state;
	
	@Column(name = "folderName")
	private String folderName;
	
	@Transient
	private CommonsMultipartFile file;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getBuildingName() {
		return buildingName;
	}

	public void setBuildingName(String buildingName) {
		this.buildingName = buildingName;
	}

	public int getNoOfFloors() {
		return noOfFloors;
	}

	public void setNoOfFloors(int noOfFloors) {
		this.noOfFloors = noOfFloors;
	}

	public int getFlatsPerFloor() {
		return flatsPerFloor;
	}

	public void setFlatsPerFloor(int flatsPerFloor) {
		this.flatsPerFloor = flatsPerFloor;
	}

	public String getStreetName() {
		return streetName;
	}

	public void setStreetName(String streetName) {
		this.streetName = streetName;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getFolderName() {
		return folderName;
	}

	public void setFolderName(String folderName) {
		this.folderName = folderName;
	}

	public CommonsMultipartFile getFile() {
		return file;
	}

	public void setFile(CommonsMultipartFile file) {
		this.file = file;
	}
	
	
	
	

}
