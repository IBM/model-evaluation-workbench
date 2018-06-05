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
import java.util.List;

import com.ibm.model.PerformanceEvalResult;
import com.ibm.model.PredictiveModel;

public interface PerformanceEvalProcessor {
	  public static final String GROUNDTRUTH      = "1";
	  public static final String GROUNDTRUTH_ZERO = "0";
	  public static final String PROBABILITY_ZERO = "0";

	  public static final String PREFIX_GROUNDTRUTH = "GT_";
	  public static final String PREFIX_RESPONSE = "RS_";

	  public static final String REST_PREFIX_GROUNDTRUTH = "REST_GT_";
	  public static final String REST_PREFIX_RESPONSE = "REST_RS_";
	  public static final String CONFIG_ = "CONFIG_" ; // workbench workspace
	  
  	public static PerformanceEvalResult evaluatePerformance (PredictiveModel predictiveModel, File serverFile) {
	    PerformanceEvalResult result;
	    List<String> messages = null;
	    if (predictiveModel.getServiceName().equalsIgnoreCase(PredictiveModel.SERVICE_CONVERSATION) || predictiveModel.getServiceName().equalsIgnoreCase(PredictiveModel.SERVICE_NLC) ) {
	    	messages = FileManager.parseCSVFile(serverFile);
	    	result = ClassifierProcessor.evaluatePerformance(predictiveModel,messages);
	    } else  if (predictiveModel.getServiceName().equalsIgnoreCase(PredictiveModel.SERVICE_NLU) ) {
	    	String message = FileManager.parseJSONFile(serverFile);
	    	result =NLUProcessor.evaluatePerformance(predictiveModel, message);
	    } else { // NLC or Conversation
	    	messages = FileManager.parseCSVFile(serverFile);
	    	result = ClassifierProcessor.evaluatePerformance(predictiveModel,messages);
	    }
    	//System.out.println("NLU RESPONSE WT :: \n"+ WatsonServiceManager.sendMessagesToNLU("Test"));
		return result;
	}
}
