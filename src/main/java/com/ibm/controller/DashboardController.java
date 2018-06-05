package com.ibm.controller;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ibm.model.PerformanceEvalResult;
import com.ibm.model.PredictiveModel;
import com.ibm.service.FileManager;
import com.ibm.service.PerformanceEvalProcessor;

@Controller
public class DashboardController {

	// inject via application.properties
	@Value("${welcome.message:test}")
	private String message;

	@RequestMapping(value = "/")
	public String welcome (Map<String, Object> model) {
		System.out.println("Dashboard page : ");
		return "dashboard";
	}

	@RequestMapping(value = "/dashboard")
	public String dashboard (Map<String, Object> model) {
		System.out.println("Dashboard page : ");
		return "dashboard";
	}

	
	@RequestMapping(value = "/home")
	public String home (Map<String, Object> model) {
		System.out.println("home page : ");
		return "home";
	}

	
	@RequestMapping(value = "/uploadfile", method = RequestMethod.POST)
	public String uploadFile(
	        ModelMap model,
	        @RequestParam MultipartFile file,
	        HttpServletRequest request) {
	 
	    if (file.isEmpty()) {
	        model.put("message", "failed to upload file because its empty");
	        return "/";
	    }
	 
	    String rootPath = request.getSession().getServletContext().getRealPath("/");
	    File serverFile = null;
	    try {
	    	serverFile = FileManager.saveFile(file, rootPath);
	    } catch (IOException e) {
	        model.put("message", "failed to process file because : " + e.getMessage());
	        return "/";
	    }

		String serviceName = request.getParameter("serviceName");
		//String evalParam = request.getParameter("evalParam");
		//System.out.println("REQUEST::service= " + serviceName + " evalparam= " + evalParam );
		
		PredictiveModel predictiveModel = new PredictiveModel(); 
		predictiveModel.setServiceName(serviceName);
		predictiveModel.setEvalParam(request.getParameter("evalParam"));
		predictiveModel.setServiceConfig(request.getParameter("config"));

		System.out.println("REQUEST::service= " + serviceName + " evalparam= " + request.getParameter("evalParam") + " config= " + request.getParameter("config"));
		
	    PerformanceEvalResult result = PerformanceEvalProcessor.evaluatePerformance(predictiveModel, serverFile);

	    model.put("serviceName", serviceName);
	    model.put("ROCDataMap", new JSONObject(result.getRocData()).toString());
	    model.put("GTMasterList", result.getGTMaster());

	    //model.put("evalParamName", new JSONObject(result.getGTMaster().get(0)).toString());
	    //System.out.println("ROC DATA JSON MAPtoString >>>\n" + new JSONObject(result.getRocData()).toString());

	    String evalParamVal ;
		for (int i = 0; i < result.getGTMaster().size() ; i++) {
		  	evalParamVal = result.getGTMaster().get(i); // intent's value such as temperature, conditions
		    model.put(PerformanceEvalProcessor.PREFIX_GROUNDTRUTH+evalParamVal,new JSONArray(result.getRocData().get(PerformanceEvalProcessor.PREFIX_GROUNDTRUTH+evalParamVal)));
		    model.put(PerformanceEvalProcessor.PREFIX_RESPONSE+evalParamVal,new JSONArray(result.getRocData().get(PerformanceEvalProcessor.PREFIX_RESPONSE+evalParamVal)));
		}
		
		System.out.println("PUBLISHED SERVICE RESPONSE\n" + result.getRocData().toString());
		
		System.out.println("PUBLISHED SERVICE JSON RESPONSE\n" + new JSONObject(result.getRocData()).toString());
		
	    return "dashboard";
	}

}
