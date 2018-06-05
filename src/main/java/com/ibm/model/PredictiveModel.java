package com.ibm.model;

public class PredictiveModel {

	public static final String SERVICE_CONVERSATION = "CONVERSATION";
	public static final String SERVICE_NLC = "NLC";
	public static final String SERVICE_NLU = "NLU";

	public static final String CONVERSATION_EVALPARAM_INTENTS = "Intents";
	public static final String EVALTAG_INTENTS = "intents";
	public static final String EVALTAG_INTENT = "intent";
	
	public static final String PROBABILITY_CONFIDENCE = "confidence";
	public static final String PROBABILITY_RELEVANCE = "relevance";
	public static final String PROBABILITY_SCORE = "score";
	public static final String PROBABILITY_ANGER  = "anger";
	public static final String PROBABILITY_DISGUST  = "disgust";
	public static final String PROBABILITY_FEAR  = "fear";
	public static final String PROBABILITY_JOY  = "joy";
	public static final String PROBABILITY_SADNESS  = "sadness";
	

	public static final String NLC_EVALPARAM_CLASSESS = "classes";
	public static final String EVALTAG_CLASSESS = "classes";
	public static final String EVALTAG_CLASS = "class_name";

	public static final String INPUT_URL = "input_url";
	public static final String INPUT_TEXT = "input_text";
	public static final String INPUT_HTML = "input_html";

	public static final String NLU_GT_MASTER = "concepts,keywords,entities,categories,relations";   
	public static final String NLU_EVALPARAM_CATEGORIES = "categories";
	public static final String NLU_EVALPARAM_ENTITIES = "entities";
	public static final String NLU_EVALPARAM_KEYWORDS = "keywords";
	public static final String NLU_EVALPARAM_RELATIONS = "relations";
	
	public static final String NLU_TEXT      = "text";
	public static final String NLU_TYPE      = "type";
	public static final String NLU_LABEL     = "label";
	public static final String NLU_SENTENCE  = "sentence";

	public static final String NLU_SENTIMENT = "sentiment";
	public static final String NLU_EMOTION = "emotion";
	public static final String NLU_EMOTION_ANGER = "emotion:anger";
	public static final String NLU_EMOTION_DISGUST = "emotion:disgust";
	public static final String NLU_EMOTION_FEAR = "emotion:fear";
	public static final String NLU_EMOTION_JOY = "emotion:joy";
	public static final String NLU_EMOTION_SADNESS = "emotion:sadness";

	
	private String serviceName ; // CONVERSATION, NLC, NLU
	private String evalParam ; // Intents, Entities
	private String serviceConfig ; // Intents, Entities
	private String inputType ; // Intents, Entities

	
	public String toString() {
		return serviceName;
	}


	public String getServiceName() {
		return serviceName;
	}


	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}


	public String getEvalParam() {
		return evalParam;
	}


	public void setEvalParam(String evalParam) {
		this.evalParam = evalParam;
	}


	public String getServiceConfig() {
		return serviceConfig;
	}


	public void setServiceConfig(String serviceConfig) {
		this.serviceConfig = serviceConfig;
	}


	public String getInputType() {
		return inputType;
	}


	public void setInputType(String inputType) {
		this.inputType = inputType;
	}
}