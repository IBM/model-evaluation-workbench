package com.ibm.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ibm.model.PerformanceEvalResult;
import com.ibm.model.PredictiveModel;
import com.ibm.service.ClassifierProcessor;
import com.ibm.service.FileManager;
import com.ibm.service.NLUProcessor;
import com.ibm.service.PerformanceEvalProcessor;

//@RestController
@Controller
public class DashboardRestController {
	
	@RequestMapping(value = "/NLCEvaluation", method = RequestMethod.POST)
	@ResponseBody
	public String evaluationNLC(@RequestBody String modeldata) {
		System.out.println("Model Data:\n"+modeldata);

		PredictiveModel predictiveModel = new PredictiveModel(); 
		predictiveModel.setServiceName(PredictiveModel.SERVICE_NLC);
		predictiveModel.setEvalParam(PredictiveModel.NLC_EVALPARAM_CLASSESS);
		predictiveModel.setServiceConfig("1"); // Config 1

		List<String> messages = Arrays.asList( modeldata.split(Pattern.quote("\\n")));
		System.out.println("Size:" + messages.size() + "messages\n"  + messages);
		
		PerformanceEvalResult result = ClassifierProcessor.evaluatePerformance(predictiveModel, messages);
		System.out.println("REST NLC Response: \n" + new JSONObject(result.getRocListData()).toString());
		return new JSONObject(result.getRocListData()).toString();
	}

	@RequestMapping(value = "/ConversationEvaluation", method = RequestMethod.POST)
	@ResponseBody
	public String evaluationConversation(@RequestBody String modeldata) {
		System.out.println("Model Data:\n"+modeldata);

		PredictiveModel predictiveModel = new PredictiveModel(); 
		predictiveModel.setServiceName(PredictiveModel.SERVICE_CONVERSATION);
		predictiveModel.setEvalParam(PredictiveModel.CONVERSATION_EVALPARAM_INTENTS);
		predictiveModel.setServiceConfig("1"); // Config 1

		List<String> messages = Arrays.asList( modeldata.split(Pattern.quote("\\n")));
		System.out.println("Size:" + messages.size() + "messages\n"  + messages);
		
		PerformanceEvalResult result = ClassifierProcessor.evaluatePerformance(predictiveModel, messages);
		System.out.println("REST NLC Response: \n" + new JSONObject(result.getRocListData()).toString());
		return new JSONObject(result.getRocListData()).toString();
	}

	
	@RequestMapping(value = "/NLUEvaluation", method = RequestMethod.POST)
	@ResponseBody
	public String evaluationNLU(@RequestBody String modeldata) {
		System.out.println("Model Data:\n"+modeldata);
		modeldata = modeldata.replace("\\n", "").replace("\\r", "").replace("\\\"", "\"");
		modeldata = modeldata.substring(1,modeldata.length()-1); 
		
		PredictiveModel predictiveModel = new PredictiveModel(); 
		predictiveModel.setServiceName(PredictiveModel.SERVICE_NLU);
		predictiveModel.setServiceConfig("1"); // Config 1

		PerformanceEvalResult result = NLUProcessor.evaluatePerformance(predictiveModel, modeldata);
		System.out.println("REST NLC Response: \n" + new JSONObject(result.getRocListData()).toString());
		return new JSONObject(result.getRocListData()).toString();
	}

	
	@RequestMapping(value = "/NLCEvaluationCSV", method = RequestMethod.POST)
	@ResponseBody
	public String evaluationNLCCSV(@RequestBody String modeldata) {
		System.out.println("Model Data:\n"+modeldata);

		PredictiveModel predictiveModel = new PredictiveModel(); 
		predictiveModel.setServiceName(PredictiveModel.SERVICE_NLC);
		predictiveModel.setEvalParam(PredictiveModel.NLC_EVALPARAM_CLASSESS);
		predictiveModel.setServiceConfig("1"); // Config 1

		//List<String> messages = null;
		//String modeldata = "What are the chances for rain?,conditions\nIs it warm?,temperature\nWill it be uncomfortably hot?,temperature\nWill high temperatures be dangerous?,temperature\nWhen will the heat subside?,temperature";
		//String[] arr =
		//List<String> messages = Arrays.asList( modeldata.split("\\s*\n\\s*"));
		
		List<String> messages = Arrays.asList( modeldata.split(Pattern.quote("\\n")));
		//List<String> messages = modeldata.tokenize("\\n");
		System.out.println("Size:" + messages.size() + "messages\n"  + messages);
		//You can also use Character.LINE_SEPARATOR instead of \n.
		PerformanceEvalResult result = ClassifierProcessor.evaluatePerformance(predictiveModel, messages);
	    //model.put("evalParamName", new JSONObject(result.getGTMaster().get(0)).toString());
	    //System.out.println("ROC DATA JSON MAPtoString >>>\n" + new JSONObject(result.getRocData()).toString());

	    String evalParamVal ;
	    List<String> probList = null;
	    List<String> labList  = null;
		String[] arr = null;
	    StringBuffer response = new StringBuffer();  
	    
		for (int i = 0; i < result.getGTMaster().size() ; i++) {
		  	evalParamVal = result.getGTMaster().get(i); // intent's value such as temperature, conditions
		  	labList = result.getRocListDataElement(PerformanceEvalProcessor.PREFIX_GROUNDTRUTH+evalParamVal);
		  	probList = result.getRocListDataElement(PerformanceEvalProcessor.PREFIX_RESPONSE+evalParamVal);
			System.out.println("REST probList: \n" + probList);
		  	for (int j = 0; j < labList.size() ; j++) {
				response.append(labList.get(j) + "," + probList.get(j) + ","+ evalParamVal + "\n");
				System.out.println("labList.get(j): " + labList.get(j) + " probList.get(j)= " + probList.get(j));
		  	}		  	
		}
		System.out.println("REST Response: \n" + response);
		return response.toString();
		//return "home";
		//return "1,0.3\n1,0.7\n0,0.4";
	}
}
