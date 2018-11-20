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


import java.util.logging.Level;
import java.util.logging.Logger;

import com.ibm.model.PredictiveModel;
import com.ibm.watson.developer_cloud.conversation.v1.ConversationService;
import com.ibm.watson.developer_cloud.conversation.v1.model.MessageRequest;
import com.ibm.watson.developer_cloud.conversation.v1.model.MessageResponse;
import com.ibm.watson.developer_cloud.natural_language_classifier.v1.NaturalLanguageClassifier;
import com.ibm.watson.developer_cloud.natural_language_classifier.v1.model.Classification;
import com.ibm.watson.developer_cloud.natural_language_classifier.v1.model.ClassifyOptions;
import com.ibm.watson.developer_cloud.natural_language_understanding.v1.NaturalLanguageUnderstanding;
import com.ibm.watson.developer_cloud.natural_language_understanding.v1.model.AnalysisResults;
import com.ibm.watson.developer_cloud.natural_language_understanding.v1.model.AnalyzeOptions;
import com.ibm.watson.developer_cloud.natural_language_understanding.v1.model.CategoriesOptions;
import com.ibm.watson.developer_cloud.natural_language_understanding.v1.model.ConceptsOptions;
import com.ibm.watson.developer_cloud.natural_language_understanding.v1.model.EntitiesOptions;
import com.ibm.watson.developer_cloud.natural_language_understanding.v1.model.Features;
import com.ibm.watson.developer_cloud.natural_language_understanding.v1.model.KeywordsOptions;
import com.ibm.watson.developer_cloud.natural_language_understanding.v1.model.RelationsOptions;
import com.ibm.watson.developer_cloud.service.security.IamOptions;

/**
 * Integration test for the {@link ConversationService}.
 */
public class WatsonServiceManager {

  //private static ConversationService service;

  private static final String workspaceIdLocal = "13b6d6f7-da64-4af8-8b98-06399daa6f13"; // workbench workspace
  //private static String workspaceId = "d3a9ca6c-a3b9-4124-83e9-4b1615d3d598";   // Car Dashboard

  private static final String usernameConversationLocal = "3a48aa4c-a8e9-4460-b5a2-6ebb81ec742a";
  private static final String passwordConversationLocal =  "X2o8qRqbtIBO";

  private static final String usernameNLCLocal = "f291af61-42d9-4b3e-820a-d0f227ea8b63";
  private static final String passwordNLCLocal =  "0AP8thJeabDH";
  private static final String classifierIdNLCLocal =  "359f3fx202-nlc-33536";

  private static final String usernameNLULocal = "d67d295f-e1e3-4359-a36c-a573b3a0e53e";
  private static final String passwordNLULocal =  "LbadhhQ4lwwr";

  private static final String CONFIG = "_CONFIG_" ; // workbench workspace
  private static Logger logger = Logger.getLogger("workbenchlogger");



  public static String sendMessagesToPredictiveService(String message,PredictiveModel predictiveModel)  {
	  if (predictiveModel.getServiceName().equals(PredictiveModel.SERVICE_CONVERSATION)) {
		  return sendMessagesToConversation(message,predictiveModel.getServiceConfig());
	  } else if (predictiveModel.getServiceName().equals(PredictiveModel.SERVICE_NLC)) {
		  return sendMessagesToNLC(message,predictiveModel.getServiceConfig());
	  } else if (predictiveModel.getServiceName().equals(PredictiveModel.SERVICE_NLU)) {
		  return sendMessagesToNLU(message,predictiveModel.getServiceConfig(),predictiveModel.getInputType());
	  } else {
		  return sendMessagesToConversation(message,predictiveModel.getServiceConfig());
	  }
  }

  /**
   * send messages.
   *
   * @throws InterruptedException the interrupted exception
   */
  public static String sendMessagesToConversation(String message,String config)  {

	System.out.println("MESSAGE :: " + message + " CONFIG >> " + config);

	String workspaceId = System.getenv("CONVERSATION_WORKSPACE_ID"+CONFIG+config);
	String usernameConversation = System.getenv("CONVERSATION_USERNAME"+CONFIG+config);
	String passwordConversation =  System.getenv("CONVERSATION_PASSWORD"+CONFIG+config);

	logger.logp(Level.INFO, "WatsonServiceManager", "sendMessagesToConversation", "Bluemix Environment variables:!!! " );
    logger.logp(Level.WARNING, "WatsonServiceManager", "sendMessagesToConversation", "workspaceId =  " + workspaceId );

    if (workspaceId == null) {
    	logger.logp(Level.INFO, "WatsonServiceManager", "sendMessagesToConversation", "NON Bluemix Environment variables ??? " );
    	workspaceId = workspaceIdLocal ;
    	usernameConversation = usernameConversationLocal;
    	passwordConversation = passwordConversationLocal ;
    }

	ConversationService service = new ConversationService(ConversationService.VERSION_DATE_2017_02_03);  //2017-05-26
	//ConversationService service = new ConversationService("2017-05-26");  //2017-05-26
    service.setUsernameAndPassword(usernameConversation, passwordConversation);
    MessageRequest request = null;
    MessageResponse response = null;

   // request = new MessageRequest.Builder().inputText(message).alternateIntents(true).context(context).build();
    System.out.println("MESSAGE :: " + message);
    request = new MessageRequest.Builder().inputText(message).build();
    response = service.message(workspaceId, request).execute();
    //System.out.println(response);
    return response.toString();
  }


  /**
   * send messages.
   *
   * @throws InterruptedException the interrupted exception
   */
  public static String sendMessagesToNLC(String message,String config)  {
	System.out.println("NLC MESSAGE :: " + message + " CONFIG >> " + config);

	String usernameNLC = System.getenv("NLC_USERNAME"+CONFIG+config);
	String passwordNLC =  System.getenv("NLC_PASSWORD"+CONFIG+config);
	String classifierIdNLC =  System.getenv("NLC_CLASSIFIER_ID"+CONFIG+config);
	String apiKey = System.getenv("NLC_API_KEY"+CONFIG+config);
	String nlcURL = "https://gateway.watsonplatform.net/natural-language-classifier/api";

	logger.logp(Level.INFO, "WatsonServiceManager", "sendMessagesToNLC", "Bluemix Environment variables:!!! " );
    logger.logp(Level.WARNING, "WatsonServiceManager", "sendMessagesToNLC", "workspaceId =  " + classifierIdNLC );

    if (classifierIdNLC == null) {
    	logger.logp(Level.INFO, "WatsonServiceManager", "sendMessagesToNLC", "NON Bluemix Environment variables ??? " );
    	usernameNLC = usernameNLCLocal ;
    	passwordNLC = passwordNLCLocal;
    	classifierIdNLC = classifierIdNLCLocal ;
    }

    IamOptions options = new IamOptions.Builder().apiKey(apiKey).build();

    NaturalLanguageClassifier service = new NaturalLanguageClassifier(options);
    service.setEndPoint(nlcURL);


	ClassifyOptions classifyOptions = new ClassifyOptions.Builder().classifierId(classifierIdNLC).text(message).build();


	Classification classification = service.classify(classifyOptions).execute();
	//System.out.println(classification);

    return classification.toString();
  }


  /**
   * send messages.
   *
   * @throws InterruptedException the interrupted exception
   */
  public static String sendMessagesToNLU(String message,String config,String inputType)  {
	  System.out.println("NLU CONFIG >> " + config + " inputType = " + inputType);
	  String usernameNLU = System.getenv("NLU_USERNAME"+CONFIG+config);
	  String passwordNLU =  System.getenv("NLU_PASSWORD"+CONFIG+config);

		logger.logp(Level.INFO, "WatsonServiceManager", "sendMessagesToNLU", "Bluemix Environment variables:!!! " );
	    logger.logp(Level.WARNING, "WatsonServiceManager", "sendMessagesToNLU", "usernameNLU =  " + usernameNLU );

	    if (usernameNLU == null) {
	    	logger.logp(Level.INFO, "WatsonServiceManager", "sendMessagesToNLU", "NON Bluemix Environment variables ??? " );
	    	usernameNLU = usernameNLULocal ;
	    	passwordNLU = passwordNLULocal;
	    }

	  NaturalLanguageUnderstanding service = new NaturalLanguageUnderstanding(
			  NaturalLanguageUnderstanding.VERSION_DATE_2017_02_27,usernameNLU,passwordNLU);

	  /*
	  String text = "IBM is an American multinational technology " +

	  "company headquartered in Armonk, New York, " +
	  "United States, with operations in over 170 countries."; */

      //String url = "www.wsj.com/news/markets";

// PARAMETERS
		EntitiesOptions entitiesOptions = new EntitiesOptions.Builder()
				  .emotion(true)
				  .sentiment(true)
				  .limit(50)
				  .build();

		KeywordsOptions keywordsOptions = new KeywordsOptions.Builder()
		  .emotion(true)
		  .sentiment(true)
		  .limit(30)
		  .build();

		CategoriesOptions categories = new CategoriesOptions();

		ConceptsOptions concepts= new ConceptsOptions.Builder()
				  .limit(40)
				  .build();

		RelationsOptions relations = new RelationsOptions.Builder()
				  .build();

		Features features = new Features.Builder()
		  .entities(entitiesOptions)
		  .keywords(keywordsOptions)
		  .categories(categories)
		  .concepts(concepts)
		  .relations(relations)
		  .build();

		AnalyzeOptions parameters ;

		if (inputType.equalsIgnoreCase(PredictiveModel.INPUT_URL)) {
			parameters = new AnalyzeOptions.Builder()
					  .url(message)
					  .features(features)
					  .build();
		} else if (inputType.equalsIgnoreCase(PredictiveModel.INPUT_TEXT)) {
			parameters = new AnalyzeOptions.Builder()
					  .text(message)
					  .features(features)
					  .build();
		} else if (inputType.equalsIgnoreCase(PredictiveModel.INPUT_HTML)) {
			parameters = new AnalyzeOptions.Builder()
					  .html(message)
					  .features(features)
					  .build();
		} else {
			parameters = new AnalyzeOptions.Builder()
					  .url(message)
					  .features(features)
					  .build();
		}

	// PARAMETERS
	AnalysisResults response = service.analyze(parameters).execute();
			//System.out.println("NLU Response \n" + response);
	return response.toString();
  }

}
