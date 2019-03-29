package com.neu.myapp.controller.buildings;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;

import com.neu.myapp.dao.building.BuildingDAO;
import com.neu.myapp.dao.login.LoginDAO;
import com.neu.myapp.dao.order.OrderDAO;
import com.neu.myapp.pojo.building.Building;
import com.neu.myapp.pojo.user.Customer;

/**
 * @author Shruti
 *
 */
@Controller
public class BuildingController {
	@Autowired
	ServletContext context;

	private static final Logger LOGGER = Logger.getLogger(BuildingController.class);
	
	@RequestMapping(value = "/emp/addBuilding.htm", method = RequestMethod.GET)
	public String addBuilding(HttpServletRequest request) {
		LOGGER.info("Entering Add Building");
		return "add-building";
	}

	@RequestMapping(value = "/emp/addBuilding.htm", method = RequestMethod.POST)
	public String insertBuildingDetails(HttpServletRequest request, BuildingDAO buildDAO, ModelMap map,
			@ModelAttribute("building") Building building) {

		String result = "success";
		CommonsMultipartFile file = building.getFile();
		String fileName = file.getOriginalFilename();
		building.setFolderName(fileName.substring(0, fileName.lastIndexOf(".")));
		moveToFolderAndUnzipFile(file, fileName.substring(0, fileName.lastIndexOf(".")));
		result = buildDAO.insertBuildingDetails(building);
		if (result.equalsIgnoreCase("success")) {
			return "add-building-success";
		} else {
			return "error";
		}

	}

	@RequestMapping(value = "/order/viewBuilding.htm", method = RequestMethod.GET)
	public String viewBuilding(HttpServletRequest request) {
		return "view-building";
	}

	@RequestMapping(value = "/order/viewBuilding.htm", method = RequestMethod.POST)
	public String listBuildings(HttpServletRequest request, BuildingDAO buildDAO,
			@ModelAttribute("building") Building building, ModelMap map) {
		List<Building> buildingList = buildDAO.getBuildingList(building);
		map.addAttribute("buildingList", buildingList);
		return "view-building";
	}

	@RequestMapping(value = "/building/showPhotos.htm", method = RequestMethod.GET)
	public String populateStreet(HttpServletRequest request, Model map) {
		String folderName = request.getParameter("folderName");
		int id = Integer.parseInt(request.getParameter("buildingId"));
		File folder = new File("D:\\Eclipse\\Webtools_Project\\src\\main\\webapp\\resources\\images\\" + folderName);
		File[] fileList = folder.listFiles();
		List<String> imagesList = new ArrayList<String>();
		for (File f : fileList) {
			imagesList.add(f.getName());
		}
		map.addAttribute("imagesList", imagesList);
		map.addAttribute("folderName", folderName);
		map.addAttribute("buildingId", id);
		return "viewBuildingPhotos";
	}

	@RequestMapping(value = "building/bookFlat.htm", method = RequestMethod.GET)
	public String bookFlat(HttpServletRequest request, BuildingDAO buildDAO, Model map,
			@ModelAttribute("building") Building building) {
		int id = Integer.parseInt(request.getParameter("buildingId"));
		building = buildDAO.getBuildingDetails(id);
		if(building != null) {
			map.addAttribute("building", building);
			return "book-flat";
		}else {
			return "error";
		}
		
	}

	@RequestMapping(value = "building/bookFlat.htm", method = RequestMethod.POST)
	public String bookFlatByCustomer(HttpServletRequest request, BuildingDAO buildDAO, Model map,
			@ModelAttribute("building") Building building, HttpSession session) {
		int flatNo = Integer.parseInt(request.getParameter("flatId"));
		int floorNo = Integer.parseInt(request.getParameter("floorNo"));
		int buildingId = Integer.parseInt(request.getParameter("buildingId"));
		int flatId = buildDAO.getFlatId(buildingId, flatNo, floorNo);
		Customer cust = (Customer) session.getAttribute("customer");
		String result = buildDAO.bookFlats(flatId, cust.getId());
		if (result.equalsIgnoreCase("success")) {
			return "book-flat-success";
		} else {
			return "error";
		}
	}

	private void moveToFolderAndUnzipFile(CommonsMultipartFile file, String flatName) {
		// TODO Auto-generated method stub
		String destFileName = "D:\\Documents\\Lectures\\Sem2\\Web Tools\\FinalProject\\Photos\\"
				+ file.getOriginalFilename();
		String photosDirectory = "D:\\Eclipse\\Webtools_Project\\src\\main\\webapp\\resources\\images\\" + flatName;
		File destFile = new File(destFileName);
		createDirectory(photosDirectory);
		try {
			file.transferTo(destFile);
			ZipInputStream zipIn = new ZipInputStream(new FileInputStream(destFile));
			ZipEntry entry = zipIn.getNextEntry();

			while (entry != null) {
				String filePath = photosDirectory + File.separator + entry.getName();
				if (!entry.isDirectory()) {
					extractFile(zipIn, filePath);
				} else {
					// if the entry is a directory, make the directory
					File dir = new File(filePath);
					dir.mkdir();
				}
				zipIn.closeEntry();
				entry = zipIn.getNextEntry();
			}
			zipIn.close();
		} catch (IllegalStateException e) {			
			LOGGER.error(e);			
		} catch (IOException e) {			
			LOGGER.error(e);		
		}

	}

	private void createDirectory(String photosDirectory) {
		File directory = new File(photosDirectory);
		if (!directory.exists()) {
			directory.mkdir();
		}

	}

	private void extractFile(ZipInputStream zipIn, String filePath) throws IOException {
		BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(filePath));
		byte[] bytesIn = new byte[4096];
		int read = 0;
		while ((read = zipIn.read(bytesIn)) != -1) {
			bos.write(bytesIn, 0, read);
		}
		bos.close();

	}

}
