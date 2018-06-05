package com.ibm.model;

import java.util.HashMap;
import java.util.Map;

public class ModelResponse {
	private Map<String,String> modelResponse = new HashMap<String,String>(); // Map: "QUESTION", "GT_INTENT1", "GT_INTENT2", "RES_INTENT1", "RES_INTENT3"

	// Model Response 
	public String getModelResponseElement(String key) {
		return modelResponse.get(key);
	}
	// Model Response 
	public boolean containes(String key) {
		return modelResponse.containsKey(key);
	}
	public void addModelResponseElement(String key, String value) {
		modelResponse.put(key, value);
	}
	public void removeModelResponseElement(String key) {
		modelResponse.remove(key);
	}
	// End Model Response 
	public Map<String, String> getModelResponse() {
		return modelResponse;
	}
	public void setModelResponse(Map<String, String> modelResponse) {
		this.modelResponse = modelResponse;
	}
	public String toString() {
		return modelResponse.toString();
	}
}