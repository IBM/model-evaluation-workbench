/*
 * Copyright 2017 IBM Corp. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 */
package com.ibm.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.json.JSONArray;
import org.json.JSONObject;

import com.ibm.model.ModelResponse;
import com.ibm.model.PerformanceEvalResult;
import com.ibm.model.PredictiveModel;
import com.ibm.watson.developer_cloud.conversation.v1.ConversationService;

/**
 * Integration test for the {@link ConversationService}.
 */
public class ClassifierProcessor implements PerformanceEvalProcessor {
  
  private static final String QUESTION = "QUESTION";
  public static PerformanceEvalResult evaluatePerformance(PredictiveModel predictiveModel, List<String> messages){

		PerformanceEvalResult result = new PerformanceEvalResult();
		//List<String> messages = FileManager.parseCSVFile(serverFile);
	    String response;
	    String[] columns; 
	    ModelResponse modelResponse ;
	    for (int i = 0; i < messages.size() ; i++)
		{
	    	columns = messages.get(i).split(",");   // message split in columns
	    	modelResponse = new ModelResponse();
	    	populateGroundTruthCSV(columns, result, modelResponse);

	    	response = WatsonServiceManager.sendMessagesToPredictiveService(columns[0],predictiveModel);   // 1st Column is Test Question. || 2nd columns onwards are Ground Truth (GT)
	    	populateResponseProbability(response, predictiveModel, modelResponse);
	    	result.addModelResponse(modelResponse);
            System.out.println("RESPONSE WT :: \n"+response);
		}
	    generateROC(result,predictiveModel.getServiceConfig());
	    return result;
	}

  
  private static void populateGroundTruthCSV(String[] columns, PerformanceEvalResult result, ModelResponse modelResponse) {
		for(int i=0;i<columns.length;i++){   
	    	  if (i== 0) {  // 1st item in the message is Question rest artifact GT intent
	    		modelResponse.addModelResponseElement(QUESTION,columns[i]); 
	    	  } else {   // 1st item in the message is Question rest artifact GT intent
	      		if (!result.containsGTMaster(columns[i])) {
	          		result.addToGTMaster(columns[i]);
	      		}
	    		modelResponse.addModelResponseElement(PREFIX_GROUNDTRUTH+columns[i],GROUNDTRUTH); 
	          }
	        System.out.println("Artifact GT " + columns[i]);
	      }
		
  }

  
	private static void populateResponseProbability(String response, PredictiveModel predictiveModel,ModelResponse modelResponse) {
  		String evalParamKey = PredictiveModel.EVALTAG_INTENTS;
  		String evalParamItemKey = PredictiveModel.EVALTAG_INTENT;
  		String probabilityKey = PredictiveModel.PROBABILITY_CONFIDENCE;
	  
	  if (predictiveModel.getServiceName().equalsIgnoreCase(PredictiveModel.SERVICE_CONVERSATION)) {
		  if (predictiveModel.getEvalParam().equalsIgnoreCase(PredictiveModel.CONVERSATION_EVALPARAM_INTENTS)) {
			  evalParamKey = PredictiveModel.EVALTAG_INTENTS;
			  evalParamItemKey = PredictiveModel.EVALTAG_INTENT;
			  probabilityKey = PredictiveModel.PROBABILITY_CONFIDENCE;
		  } 
	  } else if (predictiveModel.getServiceName().equalsIgnoreCase(PredictiveModel.SERVICE_NLC)) {
		  if (predictiveModel.getEvalParam().equalsIgnoreCase(PredictiveModel.NLC_EVALPARAM_CLASSESS)) {
			  evalParamKey = PredictiveModel.EVALTAG_CLASSESS;
			  evalParamItemKey = PredictiveModel.EVALTAG_CLASS;
			  probabilityKey = PredictiveModel.PROBABILITY_CONFIDENCE;
		  } 
	  }

      System.out.println("Inside evalParamKey " + evalParamKey);
	  
	  JSONObject obj = new JSONObject(response);
	  String evalParamName = "";
	  double confidence ;
			  
	  JSONArray arr = obj.getJSONArray(evalParamKey);  // extractTag
	  for (int i = 0; i < arr.length(); i++)
	  {
		evalParamName = arr.getJSONObject(i).getString(evalParamItemKey);
	    confidence = arr.getJSONObject(i).getDouble(probabilityKey);
		modelResponse.addModelResponseElement(PREFIX_RESPONSE+evalParamName,String.valueOf(confidence)); 
	    System.out.println("Model Response Item: " + " propertyName=  " + evalParamName + "|| confidence= " + confidence );
	  }
  }

	  // generate ROC curve
	  private static void generateROC(PerformanceEvalResult result,String serviceConfig)  {
		  ModelResponse modelResponse ;
		  //List<String> roc
		  String evalParamVal;
		  List<String> evalProbList ;  // confidence, relevance, score
		  List<String> labelGTList;
		  
		  for (int i = 0; i < result.getGTMaster().size() ; i++) {
		  	evalParamVal = result.getGTMaster().get(i); // intent's value such as temparature, conditions
			evalProbList = new ArrayList<String>();  // confidence, relevance, score
			labelGTList = new ArrayList<String>();

		  	System.out.println("RESPONSE GROUND TRUTH :: "+ result.getGTMaster().get(i) );

		  	for (int j = 0; j < result.getModelResponseList().size() ; j++) {
		    	modelResponse = result.getModelResponseList().get(j);
		    	if(modelResponse.containes(PREFIX_GROUNDTRUTH+evalParamVal)) {  // GT exist
		    		labelGTList.add(GROUNDTRUTH);
		    		if(modelResponse.containes(PREFIX_RESPONSE+evalParamVal)) {  // RES probability exist
		    			evalProbList.add(modelResponse.getModelResponseElement(PREFIX_RESPONSE+evalParamVal));
			    	} else {                                                                                            
		    			evalProbList.add(PROBABILITY_ZERO); // NO RES probability from Predictive Model
			    	}
		    	} else  if(modelResponse.containes(PREFIX_RESPONSE+evalParamVal)) {  // RES probability exist BUT Ground Truth does not contain's intent  
	    			evalProbList.add(modelResponse.getModelResponseElement(PREFIX_RESPONSE+evalParamVal));
		    		labelGTList.add(GROUNDTRUTH_ZERO);
		    		
		    	}
		    }  // end for j
		  	result.addRocDataElement(CONFIG_ + serviceConfig + "_" + PREFIX_GROUNDTRUTH+evalParamVal, new JSONArray(labelGTList).toString());
		  	result.addRocDataElement(CONFIG_ + serviceConfig + "_" + PREFIX_RESPONSE+evalParamVal, new JSONArray(evalProbList).toString());

		  	result.addRocListDataElement(PREFIX_GROUNDTRUTH+evalParamVal,labelGTList);
		  	result.addRocListDataElement(PREFIX_RESPONSE+evalParamVal,evalProbList);

		  	System.out.println("labelGTList :: "+ labelGTList + "\nevalProbList = " + evalProbList);
		  }  // end for i	
	  }

}