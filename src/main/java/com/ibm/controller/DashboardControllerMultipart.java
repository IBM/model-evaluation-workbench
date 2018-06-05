package com.ibm.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ibm.model.MultipleFileUpload;
import com.ibm.model.PerformanceEvalResult;
import com.ibm.model.PredictiveModel;
import com.ibm.service.FileManager;
import com.ibm.service.PerformanceEvalProcessor;

@Controller
public class DashboardControllerMultipart {

	// inject via application.properties
	@Value("${welcome.message:test}")
	private String message;

	@RequestMapping(value = "/multiple")
	public String welcome (Map<String, Object> model) {
		System.out.println("Dashboard page : ");
		return "dashboard";
	}

	@RequestMapping(value = "/dashboardmultiple")
	public String dashboard (Map<String, Object> model) {
		System.out.println("Dashboard page : ");
		return "dashboard";
	}

	
	@RequestMapping(value = "/homemultiple")
	public String home (Map<String, Object> model) {
		System.out.println("home page : ");
		return "home";
	}

   @RequestMapping(value = "/uploadfiles", method = RequestMethod.POST)
    public String uploadMultipleFiles(
            @ModelAttribute("uploadForm") MultipleFileUpload uploadForm,
            ModelMap model, HttpServletRequest request) throws IllegalStateException, IOException {
 
        List<MultipartFile> files = uploadForm.getFiles();
        //List<String> fileNames = new ArrayList<String>();
        String[] models = request.getParameterValues("model");
        
        List<String> modelList = new ArrayList<String>(Arrays.asList(models)); 
               
        System.out.println(">>>> Models String 1 " + new JSONArray(modelList) );
        //System.out.println("Models String 2 " + new JSONObject(models.toString()).toString() );
        model.put("models",  new JSONArray(modelList) );
    	//System.out.println("models!! "+ models[0] + " " + models[1] );
        String fileName = null;
        int index = 0;
        PerformanceEvalResult result = new PerformanceEvalResult();
        PerformanceEvalResult processResult = null;
        if (null != files && files.size() > 0) {
            for (MultipartFile multipartFile : files) {
                fileName = multipartFile.getOriginalFilename();
                if (!"".equalsIgnoreCase(fileName)) {
                	System.out.println("Files Names Multipart!! "+ fileName);
                    processResult = processFile(multipartFile,request,models[index],model);
                    result.getRocData().putAll(processResult.getRocData());
                }
                index++;
            }
        }
        model.put("ROCDataMap", new JSONObject(result.getRocData()).toString());
        return "dashboard";
    }
	
	private PerformanceEvalResult processFile(MultipartFile file,HttpServletRequest request,String modelconfig, ModelMap model) {

		if (file.isEmpty()) {
	        model.put("message", "failed to upload file because its empty");
	        return new PerformanceEvalResult();
	    }
	 
	    String rootPath = request.getSession().getServletContext().getRealPath("/");
	    File serverFile = null;
	    try {
	    	serverFile = FileManager.saveFile(file, rootPath);
	    } catch (IOException e) {
	        model.put("message", "failed to process file because : " + e.getMessage());
	        return new PerformanceEvalResult();
	    }

		String serviceName = request.getParameter("serviceName");
		//String evalParam = request.getParameter("evalParam");
		//System.out.println("REQUEST::service= " + serviceName + " evalparam= " + evalParam );
		
		PredictiveModel predictiveModel = new PredictiveModel(); 
		predictiveModel.setServiceName(serviceName);
		predictiveModel.setEvalParam(request.getParameter("evalParam"));
		predictiveModel.setServiceConfig(modelconfig);

	    PerformanceEvalResult result = PerformanceEvalProcessor.evaluatePerformance(predictiveModel, serverFile);

	    model.put("serviceName", serviceName);
	    //model.put("ROCDataMap", new JSONObject(result.getRocData()).toString());
	    model.put("GTMasterList", result.getGTMaster());

	    //model.put("evalParamName", new JSONObject(result.getGTMaster().get(0)).toString());
		System.out.println("REQUEST::service= " + serviceName + " evalparam= " + request.getParameter("evalParam") + " config= " + modelconfig);

	    System.out.println("ROC DATA JSON MAPtoString >>>\n" + new JSONObject(result.getRocData()).toString());

	    String evalParamVal ;
		for (int i = 0; i < result.getGTMaster().size() ; i++) {
		  	evalParamVal = result.getGTMaster().get(i); // intent's value such as temperature, conditions
		    model.put(PerformanceEvalProcessor.CONFIG_ + modelconfig + "_" + PerformanceEvalProcessor.PREFIX_GROUNDTRUTH+evalParamVal,new JSONArray(result.getRocData().get(PerformanceEvalProcessor.CONFIG_ + modelconfig + "_" +  PerformanceEvalProcessor.PREFIX_GROUNDTRUTH+evalParamVal)));
		    model.put(PerformanceEvalProcessor.CONFIG_ + modelconfig + "_" + PerformanceEvalProcessor.PREFIX_RESPONSE+evalParamVal,new JSONArray(result.getRocData().get(PerformanceEvalProcessor.CONFIG_ + modelconfig + "_" +  PerformanceEvalProcessor.PREFIX_RESPONSE+evalParamVal)));
		}
		System.out.println("PUBLISHED SERVICE RESPONSE\n" + result.getRocData().toString());
		//System.out.println("PUBLISHED SERVICE JSON RESPONSE\n" + new JSONObject(result.getRocData()).toString());
		
	    return result;
	}

   

}
