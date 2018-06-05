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
public class NLUProcessor implements PerformanceEvalProcessor {
  
  public static final String ROC_PROB_LIST = "evalProbList";
  public static final String ROC_LABEL_GT_LIST  = "labelGTList";
  
  public static final String ROC_SENTIMENT_PROB_LIST = "evalSentimentProbList";
  public static final String ROC_SENTIMENT_LABEL_GT_LIST = "labelSentimentGTList";
  
  public static final String ROC_EMOTION_ANGER_PROB_LIST = "evalEmotionAngerProbList";
  public static final String ROC_EMOTION_ANGER_LABEL_GT_LIST = "labelEmotionAngerGTList";

  public static final String ROC_EMOTION_DISGUST_PROB_LIST = "evalEmotionDisgustProbList";
  public static final String ROC_EMOTION_DISGUST_LABEL_GT_LIST = "labelEmotionDisgustGTList";

  public static final String ROC_EMOTION_FEAR_PROB_LIST = "evalEmotionFearProbList";
  public static final String ROC_EMOTION_FEAR_LABEL_GT_LIST = "labelEmotionFearGTList";

  public static final String ROC_EMOTION_JOY_PROB_LIST = "evalEmotionJoyProbList";
  public static final String ROC_EMOTION_JOY_LABEL_GT_LIST = "labelEmotionJoyGTList";

  public static final String ROC_EMOTION_SADNESS_PROB_LIST = "evalEmotionSadnessProbList";
  public static final String ROC_EMOTION_SADNESS_LABEL_GT_LIST = "labelEmotionSadnessGTList";

  public static PerformanceEvalResult evaluatePerformance(PredictiveModel predictiveModel, String message ){
  
		//String message = FileManager.parseJSONFile(serverFile);
		String response;
    	PerformanceEvalResult result = new PerformanceEvalResult();
    	populateGroundTruth(predictiveModel,result);

    	JSONObject obj = new JSONObject(message);
		String input = retrieveInput(predictiveModel, obj);
		if (input == null || input.equals("") ) {
			System.out.println("NLU Input Model format is not correct!");
			return result;
		}

		System.out.println("NLU inputURL/TEXT :: \n"+ input);
		response = WatsonServiceManager.sendMessagesToPredictiveService(input,predictiveModel);  
		System.out.println("evaluatePerformanceJSON NLU RESPONSE WT :: \n"+ response);
    	populateResponseProbabilityNLU(message,response,result,predictiveModel.getServiceConfig());
    	return result;

	}

	
	private static String retrieveInput(PredictiveModel predictiveModel, JSONObject obj) {
		String input = obj.getString(PredictiveModel.INPUT_URL);  // extractTag
		if (input != null && !input.equals("") ) { // Input is URL
			predictiveModel.setInputType(PredictiveModel.INPUT_URL);
			System.out.println("NLU input URL :: \n"+ input);
		} else {   // Input is TEXT OR HTML
			input = obj.getString(PredictiveModel.INPUT_TEXT);  // extractTag
			System.out.println("NLU inputURL IS TEXT OR HTML ");
			if (input != null  && !input.equals("") ) { // Input is TEXT
				predictiveModel.setInputType(PredictiveModel.INPUT_TEXT);
				System.out.println("NLU input TEXT :: \n"+ input);
			} else {  // INPUT IS HTML
				input = obj.getString(PredictiveModel.INPUT_HTML);  // extractTag
				predictiveModel.setInputType(PredictiveModel.INPUT_HTML);
			}
		}
		return input;
	}

  
  	private static void populateGroundTruth(PredictiveModel predictiveModel, PerformanceEvalResult result) {
  		String[] columns;
  		if (predictiveModel.getServiceName().equalsIgnoreCase(PredictiveModel.SERVICE_NLU) ) {
  			columns = PredictiveModel.NLU_GT_MASTER.split(",");   // message split in columns
  			for(int i=0;i<columns.length;i++){   
  	  			result.addToGTMaster(columns[i]);
  			}
  			
 	    } 
	    System.out.println("Artifact NLU GT " + result.getGTMaster());
  	}
  	
  	private static void populateResponseProbabilityNLU(String request,String response,PerformanceEvalResult result,String serviceConfig) {
	  System.out.println("Inside populateResponseProbabilityNLU ");
  	  
	  JSONObject objRes = new JSONObject(response);
	  JSONObject objReq = new JSONObject(request);
	  JSONArray arrRes;
	  JSONArray arrReq;
	  String evalParamName;
	  Map<String,List<String>> rocData = new HashMap<String,List<String>>();
	  
	  for (int i = 0; i < result.getGTMaster().size() ; i++) {
		evalParamName = result.getGTMaster().get(i);     // Concepts, Keywords, Entities, categories

		initRocData(rocData);
		
		arrReq = objReq.getJSONArray(evalParamName);
		arrRes = objRes.getJSONArray(evalParamName);
		
		System.out.println("#########  evalParamName REQ #### " + evalParamName + " arrReq.length()= " + arrReq.length() + " arrRes.length() = " + arrRes.length() );   
		
		processNLUResponse(arrRes, arrReq, evalParamName, rocData);  // populate rocData
		processNLUGT(arrRes, arrReq, evalParamName, rocData);  // populate rocData
		
	  	result.addRocDataElement(CONFIG_ + serviceConfig + "_" + PREFIX_GROUNDTRUTH+evalParamName, new JSONArray(rocData.get(ROC_LABEL_GT_LIST)).toString());
	  	result.addRocDataElement(CONFIG_ + serviceConfig + "_" + PREFIX_RESPONSE+evalParamName, new JSONArray(rocData.get(ROC_PROB_LIST)).toString());
	    System.out.println("**** evalParamName RES ***** " + evalParamName + "\n ROC labelGTList.size() " + rocData.get(ROC_LABEL_GT_LIST).size() + "\n" + rocData.get(ROC_LABEL_GT_LIST) + "\n ROC evalProbList.size() " + rocData.get(ROC_PROB_LIST).size() + "\n" + rocData.get(ROC_PROB_LIST));
	  	
	  	result.addRocListDataElement(PREFIX_GROUNDTRUTH+evalParamName, rocData.get(ROC_LABEL_GT_LIST));
	  	result.addRocListDataElement(PREFIX_RESPONSE+evalParamName, rocData.get(ROC_PROB_LIST));
	    
		// Added for Sentiment 
		addSentimentsRocData(result, evalParamName, rocData,serviceConfig);
		// End Added for Sentiment		
	  	//System.out.println("NLU population labelGTList :: "+ labelGTList + "\nevalProbList = " + evalProbList);
	  }
	  // Add Sentiment intermediate GT list "entities-sentiment", "keywords-sentiment"
	  result.getGTMaster().addAll(result.getGTMasterIntermediate());
  }
  	
	private static void addSentimentsRocData(PerformanceEvalResult result, String evalParamName, Map<String, List<String>> rocData, String serviceConfig) {
		if (evalParamName.equals(PredictiveModel.NLU_EVALPARAM_ENTITIES) || evalParamName.equals(PredictiveModel.NLU_EVALPARAM_KEYWORDS) ) {  // Added Sentiment probability also
    		result.addRocDataElement(CONFIG_ + serviceConfig + "_" + PREFIX_GROUNDTRUTH+evalParamName+"-"+ PredictiveModel.NLU_SENTIMENT , new JSONArray(rocData.get(ROC_SENTIMENT_LABEL_GT_LIST)).toString());
    	  	result.addRocDataElement(CONFIG_ + serviceConfig + "_" + PREFIX_RESPONSE+evalParamName+"-"+ PredictiveModel.NLU_SENTIMENT, new JSONArray(rocData.get(ROC_SENTIMENT_PROB_LIST)).toString());

    		result.addRocDataElement(CONFIG_ + serviceConfig + "_" + PREFIX_GROUNDTRUTH+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_ANGER , new JSONArray(rocData.get(ROC_EMOTION_ANGER_LABEL_GT_LIST)).toString());
    	  	result.addRocDataElement(CONFIG_ + serviceConfig + "_" + PREFIX_RESPONSE+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_ANGER, new JSONArray(rocData.get(ROC_EMOTION_ANGER_PROB_LIST)).toString());

    		result.addRocDataElement(CONFIG_ + serviceConfig + "_" + PREFIX_GROUNDTRUTH+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_DISGUST , new JSONArray(rocData.get(ROC_EMOTION_DISGUST_LABEL_GT_LIST)).toString());
    	  	result.addRocDataElement(CONFIG_ + serviceConfig + "_" + PREFIX_RESPONSE+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_DISGUST, new JSONArray(rocData.get(ROC_EMOTION_DISGUST_PROB_LIST)).toString());

    		result.addRocDataElement(CONFIG_ + serviceConfig + "_" + PREFIX_GROUNDTRUTH+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_FEAR , new JSONArray(rocData.get(ROC_EMOTION_FEAR_LABEL_GT_LIST)).toString());
    	  	result.addRocDataElement(CONFIG_ + serviceConfig + "_" + PREFIX_RESPONSE+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_FEAR, new JSONArray(rocData.get(ROC_EMOTION_FEAR_PROB_LIST)).toString());

    		result.addRocDataElement(CONFIG_ + serviceConfig + "_" + PREFIX_GROUNDTRUTH+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_JOY , new JSONArray(rocData.get(ROC_EMOTION_JOY_LABEL_GT_LIST)).toString());
    	  	result.addRocDataElement(CONFIG_ + serviceConfig + "_" + PREFIX_RESPONSE+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_JOY, new JSONArray(rocData.get(ROC_EMOTION_JOY_PROB_LIST)).toString());

    		result.addRocDataElement(CONFIG_ + serviceConfig + "_" + PREFIX_GROUNDTRUTH+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_SADNESS , new JSONArray(rocData.get(ROC_EMOTION_SADNESS_LABEL_GT_LIST)).toString());
    	  	result.addRocDataElement(CONFIG_ + serviceConfig + "_" + PREFIX_RESPONSE+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_SADNESS, new JSONArray(rocData.get(ROC_EMOTION_SADNESS_PROB_LIST)).toString());

    	  	// Data List
    		result.addRocListDataElement(PREFIX_GROUNDTRUTH+evalParamName+"-"+ PredictiveModel.NLU_SENTIMENT , rocData.get(ROC_SENTIMENT_LABEL_GT_LIST));
    	  	result.addRocListDataElement(PREFIX_RESPONSE+evalParamName+"-"+ PredictiveModel.NLU_SENTIMENT, rocData.get(ROC_SENTIMENT_PROB_LIST));

    		result.addRocListDataElement(PREFIX_GROUNDTRUTH+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_ANGER , rocData.get(ROC_EMOTION_ANGER_LABEL_GT_LIST));
    	  	result.addRocListDataElement(PREFIX_RESPONSE+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_ANGER, rocData.get(ROC_EMOTION_ANGER_PROB_LIST));

    		result.addRocListDataElement(PREFIX_GROUNDTRUTH+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_DISGUST , rocData.get(ROC_EMOTION_DISGUST_LABEL_GT_LIST));
    	  	result.addRocListDataElement(PREFIX_RESPONSE+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_DISGUST, rocData.get(ROC_EMOTION_DISGUST_PROB_LIST));

    		result.addRocListDataElement(PREFIX_GROUNDTRUTH+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_FEAR , rocData.get(ROC_EMOTION_FEAR_LABEL_GT_LIST));
    	  	result.addRocListDataElement(PREFIX_RESPONSE+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_FEAR, rocData.get(ROC_EMOTION_FEAR_PROB_LIST));

    		result.addRocListDataElement(PREFIX_GROUNDTRUTH+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_JOY , rocData.get(ROC_EMOTION_JOY_LABEL_GT_LIST));
    	  	result.addRocListDataElement(PREFIX_RESPONSE+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_JOY, rocData.get(ROC_EMOTION_JOY_PROB_LIST));

    		result.addRocListDataElement(PREFIX_GROUNDTRUTH+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_SADNESS , rocData.get(ROC_EMOTION_SADNESS_LABEL_GT_LIST));
    	  	result.addRocListDataElement(PREFIX_RESPONSE+evalParamName+"-"+ PredictiveModel.NLU_EMOTION_SADNESS, rocData.get(ROC_EMOTION_SADNESS_PROB_LIST));
    	  	
    	  	result.getGTMasterIntermediate().add(evalParamName+"-"+ PredictiveModel.NLU_SENTIMENT);
    	  	
    	  	result.getGTMasterIntermediate().add(evalParamName+"-"+ PredictiveModel.NLU_EMOTION_ANGER);
    	  	result.getGTMasterIntermediate().add(evalParamName+"-"+ PredictiveModel.NLU_EMOTION_DISGUST);
    	  	result.getGTMasterIntermediate().add(evalParamName+"-"+ PredictiveModel.NLU_EMOTION_FEAR);
    	  	result.getGTMasterIntermediate().add(evalParamName+"-"+ PredictiveModel.NLU_EMOTION_JOY);
    	  	result.getGTMasterIntermediate().add(evalParamName+"-"+ PredictiveModel.NLU_EMOTION_SADNESS);

    	    System.out.println(" ROC labelSentimentGTList.size() " + rocData.get(ROC_SENTIMENT_LABEL_GT_LIST).size() + "\n" + rocData.get(ROC_SENTIMENT_LABEL_GT_LIST) + "\n ROC evalSentimentProbList.size() " + rocData.get(ROC_SENTIMENT_PROB_LIST).size() + "\n" + rocData.get(ROC_SENTIMENT_PROB_LIST));
		}
	}

  	
	private static void initRocData(Map<String,List<String>> rocData ) {
	  rocData.put(ROC_PROB_LIST,new ArrayList<String>());
	  rocData.put(ROC_LABEL_GT_LIST,new ArrayList<String>());
	  rocData.put(ROC_SENTIMENT_PROB_LIST,new ArrayList<String>());
	  rocData.put(ROC_SENTIMENT_LABEL_GT_LIST,new ArrayList<String>());
	  rocData.put(ROC_EMOTION_ANGER_PROB_LIST,new ArrayList<String>());
	  rocData.put(ROC_EMOTION_ANGER_LABEL_GT_LIST,new ArrayList<String>());
	  rocData.put(ROC_EMOTION_DISGUST_PROB_LIST,new ArrayList<String>());
	  rocData.put(ROC_EMOTION_DISGUST_LABEL_GT_LIST,new ArrayList<String>());
	  rocData.put(ROC_EMOTION_FEAR_PROB_LIST,new ArrayList<String>());
	  rocData.put(ROC_EMOTION_FEAR_LABEL_GT_LIST,new ArrayList<String>());
	  rocData.put(ROC_EMOTION_JOY_PROB_LIST,new ArrayList<String>());
	  rocData.put(ROC_EMOTION_JOY_LABEL_GT_LIST,new ArrayList<String>());
	  rocData.put(ROC_EMOTION_SADNESS_PROB_LIST,new ArrayList<String>());
	  rocData.put(ROC_EMOTION_SADNESS_LABEL_GT_LIST,new ArrayList<String>());
	}

	
	
	private static void processNLUGT(JSONArray arrRes, JSONArray arrReq, String evalParamName, Map<String,List<String>> rocData) {
		String evalText;
		String type;
		Map<String, String> element;
		for (int j = 0; j < arrReq.length(); j++)    // GT Exist for Each Text but Probability not returned. 
		{
			if (evalParamName.equals(PredictiveModel.NLU_EVALPARAM_CATEGORIES)) {  
				evalText = arrReq.getJSONObject(j).getString(PredictiveModel.NLU_LABEL); 
			} else if (evalParamName.equals(PredictiveModel.NLU_EVALPARAM_RELATIONS)) {  
				evalText = arrReq.getJSONObject(j).getString(PredictiveModel.NLU_SENTENCE); 
			} else {
				evalText = arrReq.getJSONObject(j).getString(PredictiveModel.NLU_TEXT);  //  Concepts, Keywords, Entities
			}

			element = new HashMap<String,String>();
			if (evalParamName.equals(PredictiveModel.NLU_EVALPARAM_ENTITIES)) {  
				type = arrReq.getJSONObject(j).getString(PredictiveModel.NLU_TYPE); //  Entities
				element.put(PredictiveModel.NLU_TEXT, evalText);
				element.put(PredictiveModel.NLU_TYPE,type);
			} else if (evalParamName.equals(PredictiveModel.NLU_EVALPARAM_RELATIONS)) {  
				type = arrReq.getJSONObject(j).getString(PredictiveModel.NLU_TYPE); //  Entities
				element.put(PredictiveModel.NLU_SENTENCE, evalText);
				element.put(PredictiveModel.NLU_TYPE,type);
			} else {   //  Concepts, Keywords, Categories
				if (evalParamName.equals(PredictiveModel.NLU_EVALPARAM_CATEGORIES)) {  
					element.put(PredictiveModel.NLU_LABEL, evalText);
				} else {
					element.put(PredictiveModel.NLU_TEXT, evalText);
				}
			}
			
			if (!isContains(arrRes,element)  ) {    // GT Exist in arrRes already added
				rocData.get(ROC_LABEL_GT_LIST).add(GROUNDTRUTH);
				rocData.get(ROC_PROB_LIST).add(PROBABILITY_ZERO); // NO RES probability from Predictive Model
    			
				// Added for Sentiment, Emotion Iterate GT Req but no Response exist
    			if (evalParamName.equals(PredictiveModel.NLU_EVALPARAM_ENTITIES) || evalParamName.equals(PredictiveModel.NLU_EVALPARAM_KEYWORDS) ) {  // Added Sentiment probability also
    				processSubParametersGT(arrReq, rocData, j);
    			
    			}
    			// End Added for Sentiment			
			} 
			
		    
		}  // end for j
	}


	private static void processSubParametersGT(JSONArray arrReq, Map<String, List<String>> rocData, int j) {
		double probSentiment;
		double probAnger;
		double probDisgust;
		double probFear;
		double probJoy;
		double probSadness;
		probSentiment = arrReq.getJSONObject(j).getJSONObject(PredictiveModel.NLU_SENTIMENT).getDouble(PredictiveModel.PROBABILITY_SCORE);
		if ( probSentiment != 0) {
			rocData.get(ROC_SENTIMENT_LABEL_GT_LIST).add(GROUNDTRUTH);
			rocData.get(ROC_SENTIMENT_PROB_LIST).add(PROBABILITY_ZERO);
		}

		probAnger = arrReq.getJSONObject(j).getJSONObject(PredictiveModel.NLU_EMOTION).getDouble(PredictiveModel.PROBABILITY_ANGER);
		if ( probAnger != 0) {
			rocData.get(ROC_EMOTION_ANGER_LABEL_GT_LIST).add(GROUNDTRUTH);
			rocData.get(ROC_EMOTION_ANGER_PROB_LIST).add(PROBABILITY_ZERO);
		}

		probDisgust = arrReq.getJSONObject(j).getJSONObject(PredictiveModel.NLU_EMOTION).getDouble(PredictiveModel.PROBABILITY_DISGUST);
		if ( probDisgust != 0) {
			rocData.get(ROC_EMOTION_DISGUST_LABEL_GT_LIST).add(GROUNDTRUTH);
			rocData.get(ROC_EMOTION_DISGUST_PROB_LIST).add(PROBABILITY_ZERO);
		}

		probFear = arrReq.getJSONObject(j).getJSONObject(PredictiveModel.NLU_EMOTION).getDouble(PredictiveModel.PROBABILITY_FEAR);
		if ( probFear != 0) {
			rocData.get(ROC_EMOTION_FEAR_LABEL_GT_LIST).add(GROUNDTRUTH);
			rocData.get(ROC_EMOTION_FEAR_PROB_LIST).add(PROBABILITY_ZERO);
		}

		probJoy = arrReq.getJSONObject(j).getJSONObject(PredictiveModel.NLU_EMOTION).getDouble(PredictiveModel.PROBABILITY_JOY);
		if ( probJoy != 0) {
			rocData.get(ROC_EMOTION_JOY_LABEL_GT_LIST).add(GROUNDTRUTH);
			rocData.get(ROC_EMOTION_JOY_PROB_LIST).add(PROBABILITY_ZERO);
		}

		probSadness = arrReq.getJSONObject(j).getJSONObject(PredictiveModel.NLU_EMOTION).getDouble(PredictiveModel.PROBABILITY_SADNESS);
		if ( probSadness != 0) {
			rocData.get(ROC_EMOTION_SADNESS_LABEL_GT_LIST).add(GROUNDTRUTH);
			rocData.get(ROC_EMOTION_SADNESS_PROB_LIST).add(PROBABILITY_ZERO);
		}
	}


	private static void processNLUResponse(JSONArray arrRes, JSONArray arrReq, String evalParamName,Map<String,List<String>> rocData) {
		double probability;
		
		String evalText;
		String type;
		Map<String,String> element;

		for (int j = 0; j < arrRes.length(); j++)    // RES probability exist Exist for Each Text 
		{
			if (evalParamName.equals(PredictiveModel.NLU_EVALPARAM_CATEGORIES)) {  
				evalText = arrRes.getJSONObject(j).getString(PredictiveModel.NLU_LABEL); 
				probability = arrRes.getJSONObject(j).getDouble(PredictiveModel.PROBABILITY_SCORE);
			} else if (evalParamName.equals(PredictiveModel.NLU_EVALPARAM_RELATIONS)) {  
				evalText = arrRes.getJSONObject(j).getString(PredictiveModel.NLU_SENTENCE); 
				probability = arrRes.getJSONObject(j).getDouble(PredictiveModel.PROBABILITY_SCORE);
			} else {
				evalText = arrRes.getJSONObject(j).getString(PredictiveModel.NLU_TEXT); //  Concepts, Keywords, Entities
				probability = arrRes.getJSONObject(j).getDouble(PredictiveModel.PROBABILITY_RELEVANCE);
			}
			rocData.get(ROC_PROB_LIST).add(String.valueOf(probability));
			
			element = new HashMap<String,String>();
			if (evalParamName.equals(PredictiveModel.NLU_EVALPARAM_ENTITIES)) {  
				type = arrRes.getJSONObject(j).getString(PredictiveModel.NLU_TYPE); //  Entities
				element.put(PredictiveModel.NLU_TEXT, evalText);
				element.put(PredictiveModel.NLU_TYPE,type);
			} else if (evalParamName.equals(PredictiveModel.NLU_EVALPARAM_RELATIONS)) {  
				type = arrRes.getJSONObject(j).getString(PredictiveModel.NLU_TYPE); //  Entities
				element.put(PredictiveModel.NLU_SENTENCE, evalText);
				element.put(PredictiveModel.NLU_TYPE,type);
			} else {   //  Concepts, Keywords, Categories
				if (evalParamName.equals(PredictiveModel.NLU_EVALPARAM_CATEGORIES)) {  
					element.put(PredictiveModel.NLU_LABEL, evalText);
				} else {
					element.put(PredictiveModel.NLU_TEXT, evalText);
				}
			}
			
			// Added for Sentiment, Emotion Iterate Response
			
			if (evalParamName.equals(PredictiveModel.NLU_EVALPARAM_ENTITIES) || evalParamName.equals(PredictiveModel.NLU_EVALPARAM_KEYWORDS) ) {  // Add Sentiment probability also
				System.out.println("evalText in SENT EMO : " + evalText);
				processSubParameters(arrRes, arrReq, rocData, element, j);
			}
			// End Added for Sentiment
			
			if ( isContains(arrReq,element) ) {    // GT Exist in arrReq
				rocData.get(ROC_LABEL_GT_LIST).add(GROUNDTRUTH);
			}  else {                            // GT NOT Exist                                                                
				rocData.get(ROC_LABEL_GT_LIST).add(GROUNDTRUTH_ZERO);
			    //System.out.println("NLU Model NO GT Item for Response: " + evalText );
	    	}
			
		    //System.out.println("NLU Model Response Item: " + " propertyName=  " + evalParamName + "|| probability= " + probability );

		}  // end for j
	}


	private static void processSubParameters(JSONArray arrRes, JSONArray arrReq, Map<String, List<String>> rocData,
			Map<String, String> element, int j) {
		double probSentiment;
		double probAnger;
		double probDisgust;
		double probFear;
		double probJoy;
		double probSadness;
		double matchedProbIndicator;
		probSentiment = arrRes.getJSONObject(j).getJSONObject(PredictiveModel.NLU_SENTIMENT).getDouble(PredictiveModel.PROBABILITY_SCORE);
		matchedProbIndicator = containsMatchedProbability (arrReq,element,probSentiment,PredictiveModel.NLU_SENTIMENT,PredictiveModel.PROBABILITY_SCORE); 
		if ( matchedProbIndicator == 0 ) {           // GT Exist in arrReq
			rocData.get(ROC_SENTIMENT_LABEL_GT_LIST).add(GROUNDTRUTH_ZERO);
			rocData.get(ROC_SENTIMENT_PROB_LIST).add(String.valueOf(Math.abs(probSentiment)));
		}  else if ( matchedProbIndicator == 1 ) {     // GT as per Prob sign Exist in arrReq
			rocData.get(ROC_SENTIMENT_LABEL_GT_LIST).add(GROUNDTRUTH);
			rocData.get(ROC_SENTIMENT_PROB_LIST).add(String.valueOf(Math.abs(probSentiment)));
		} else {                            // return -1 .. GT Exist. Prob not matched to GT sign                                                                
			rocData.get(ROC_SENTIMENT_LABEL_GT_LIST).add(GROUNDTRUTH);
			rocData.get(ROC_SENTIMENT_PROB_LIST).add(PROBABILITY_ZERO);
		}

		probAnger = arrRes.getJSONObject(j).getJSONObject(PredictiveModel.NLU_EMOTION).getDouble(PredictiveModel.PROBABILITY_ANGER);
		matchedProbIndicator = containsMatchedProbability (arrReq,element,probAnger,PredictiveModel.NLU_EMOTION,PredictiveModel.PROBABILITY_ANGER); 
		if ( matchedProbIndicator == 0 ) {           // GT Exist in arrReq
			rocData.get(ROC_EMOTION_ANGER_LABEL_GT_LIST).add(GROUNDTRUTH_ZERO);
			rocData.get(ROC_EMOTION_ANGER_PROB_LIST).add(String.valueOf(Math.abs(probAnger)));
		}  else if ( matchedProbIndicator == 1 ) {     // GT as per Prob sign Exist in arrReq
			rocData.get(ROC_EMOTION_ANGER_LABEL_GT_LIST).add(GROUNDTRUTH);
			rocData.get(ROC_EMOTION_ANGER_PROB_LIST).add(String.valueOf(Math.abs(probAnger)));
		} else {                            // return -1 .. GT Exist. Prob not matched to GT sign                                                                
			rocData.get(ROC_EMOTION_ANGER_LABEL_GT_LIST).add(GROUNDTRUTH);
			rocData.get(ROC_EMOTION_ANGER_PROB_LIST).add(PROBABILITY_ZERO);
		}
		
		probDisgust = arrRes.getJSONObject(j).getJSONObject(PredictiveModel.NLU_EMOTION).getDouble(PredictiveModel.PROBABILITY_DISGUST);
		matchedProbIndicator = containsMatchedProbability (arrReq,element,probDisgust,PredictiveModel.NLU_EMOTION,PredictiveModel.PROBABILITY_DISGUST); 
		if ( matchedProbIndicator == 0 ) {           // GT Exist in arrReq
			rocData.get(ROC_EMOTION_DISGUST_LABEL_GT_LIST).add(GROUNDTRUTH_ZERO);
			rocData.get(ROC_EMOTION_DISGUST_PROB_LIST).add(String.valueOf(Math.abs(probDisgust)));
		}  else if ( matchedProbIndicator == 1 ) {     // GT as per Prob sign Exist in arrReq
			rocData.get(ROC_EMOTION_DISGUST_LABEL_GT_LIST).add(GROUNDTRUTH);
			rocData.get(ROC_EMOTION_DISGUST_PROB_LIST).add(String.valueOf(Math.abs(probDisgust)));
		} else {                            // return -1 .. GT Exist. Prob not matched to GT sign                                                                
			rocData.get(ROC_EMOTION_DISGUST_LABEL_GT_LIST).add(GROUNDTRUTH);
			rocData.get(ROC_EMOTION_DISGUST_PROB_LIST).add(PROBABILITY_ZERO);
		}
		
		probFear = arrRes.getJSONObject(j).getJSONObject(PredictiveModel.NLU_EMOTION).getDouble(PredictiveModel.PROBABILITY_FEAR);
		matchedProbIndicator = containsMatchedProbability (arrReq,element,probFear,PredictiveModel.NLU_EMOTION,PredictiveModel.PROBABILITY_FEAR); 
		if ( matchedProbIndicator == 0 ) {           // GT Exist in arrReq
			rocData.get(ROC_EMOTION_FEAR_LABEL_GT_LIST).add(GROUNDTRUTH_ZERO);
			rocData.get(ROC_EMOTION_FEAR_PROB_LIST).add(String.valueOf(Math.abs(probFear)));
		}  else if ( matchedProbIndicator == 1 ) {     // GT as per Prob sign Exist in arrReq
			rocData.get(ROC_EMOTION_FEAR_LABEL_GT_LIST).add(GROUNDTRUTH);
			rocData.get(ROC_EMOTION_FEAR_PROB_LIST).add(String.valueOf(Math.abs(probFear)));
		} else {                            // return -1 .. GT Exist. Prob not matched to GT sign                                                                
			rocData.get(ROC_EMOTION_FEAR_LABEL_GT_LIST).add(GROUNDTRUTH);
			rocData.get(ROC_EMOTION_FEAR_PROB_LIST).add(PROBABILITY_ZERO);
		}
		
		probJoy = arrRes.getJSONObject(j).getJSONObject(PredictiveModel.NLU_EMOTION).getDouble(PredictiveModel.PROBABILITY_JOY);
		matchedProbIndicator = containsMatchedProbability (arrReq,element,probJoy,PredictiveModel.NLU_EMOTION,PredictiveModel.PROBABILITY_JOY); 
		if ( matchedProbIndicator == 0 ) {           // GT Exist in arrReq
			rocData.get(ROC_EMOTION_JOY_LABEL_GT_LIST).add(GROUNDTRUTH_ZERO);
			rocData.get(ROC_EMOTION_JOY_PROB_LIST).add(String.valueOf(Math.abs(probJoy)));
		}  else if ( matchedProbIndicator == 1 ) {     // GT as per Prob sign Exist in arrReq
			rocData.get(ROC_EMOTION_JOY_LABEL_GT_LIST).add(GROUNDTRUTH);
			rocData.get(ROC_EMOTION_JOY_PROB_LIST).add(String.valueOf(Math.abs(probJoy)));
		} else {                            // return -1 .. GT Exist. Prob not matched to GT sign                                                                
			rocData.get(ROC_EMOTION_JOY_LABEL_GT_LIST).add(GROUNDTRUTH);
			rocData.get(ROC_EMOTION_JOY_PROB_LIST).add(PROBABILITY_ZERO);
		}
		
		probSadness = arrRes.getJSONObject(j).getJSONObject(PredictiveModel.NLU_EMOTION).getDouble(PredictiveModel.PROBABILITY_SADNESS);
		matchedProbIndicator = containsMatchedProbability (arrReq,element,probSadness,PredictiveModel.NLU_EMOTION,PredictiveModel.PROBABILITY_SADNESS); 
		if ( matchedProbIndicator == 0 ) {           // GT Exist in arrReq
			rocData.get(ROC_EMOTION_SADNESS_LABEL_GT_LIST).add(GROUNDTRUTH_ZERO);
			rocData.get(ROC_EMOTION_SADNESS_PROB_LIST).add(String.valueOf(Math.abs(probSadness)));
		}  else if ( matchedProbIndicator == 1 ) {     // GT as per Prob sign Exist in arrReq
			rocData.get(ROC_EMOTION_SADNESS_LABEL_GT_LIST).add(GROUNDTRUTH);
			rocData.get(ROC_EMOTION_SADNESS_PROB_LIST).add(String.valueOf(Math.abs(probSadness)));
		} else {                            // return -1 .. GT Exist. Prob not matched to GT sign                                                                
			rocData.get(ROC_EMOTION_SADNESS_LABEL_GT_LIST).add(GROUNDTRUTH);
			rocData.get(ROC_EMOTION_SADNESS_PROB_LIST).add(PROBABILITY_ZERO);
		}
	}

  	private static boolean isContains (JSONArray container,Map<String,String> element)  {
     	boolean isElementFound = false;
    	Object[] items = element.keySet().toArray(); 
		for (int i = 0; i < container.length(); i++)    // Iterate Container 
		{   isElementFound = true;
			for (int j = 0; j < items.length; j++)    // For Each element items Key 
			{
				if ( !container.getJSONObject(i).getString((String)items[j]).equalsIgnoreCase(element.get((String)items[j]))  ) {
					isElementFound = false;
				}
			}
			if (isElementFound) {  // element found 
				break;
			}
		}    	
		return isElementFound;
    }  	

  	
  	private static double containsMatchedProbability (JSONArray container,Map<String,String> element,double score,String matchEvalParam,String matchProbKey)  {
     	boolean isElementFound = false;
     	double containerScore = 0;
    	Object[] items = element.keySet().toArray();
 		for (int i = 0; i < container.length(); i++)    // Iterate Container 
		{   isElementFound = true;
			for (int j = 0; j < items.length; j++)    // For Each element items Key 
			{
				if ( !container.getJSONObject(i).getString((String)items[j]).equalsIgnoreCase(element.get((String)items[j]))  ) {
					isElementFound = false;
				}
			}
			if (isElementFound) {  // element found 
				//containerScore = container.getJSONObject(i).getJSONObject("sentiment").getDouble(PredictiveModel.PROBABILITY_SCORE);
				containerScore = container.getJSONObject(i).getJSONObject(matchEvalParam).getDouble(matchProbKey);

				if (containerScore == 0 ) { // GT sentiment 0 found
					return 0;  // 0
				} else	if ((containerScore > 0 && score >= 0) || (containerScore < 0 && score <= 0) ) { // prob sentiment sign same as GT sign
					return 1;  // GT is correct as per Probability
				} else	if ((containerScore > 0 && score <= 0) || (containerScore < 0 && score >= 0) ) { // sentiment found incorrectly
					return -1;  // GT is not correct as per Probability. Set Prob to Zero 0
				}
				System.out.println("containerScore= " + containerScore);
				break;
			}
		}    	
		return containerScore;
    }  	
  
}
