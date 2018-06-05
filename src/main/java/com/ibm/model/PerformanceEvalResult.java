package com.ibm.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerformanceEvalResult {
	private List<String> GTMaster = new ArrayList<String>();  // ["GT_INTENT1", "GT_INTENT2"]
	private List<String> GTMasterIntermediate = new ArrayList<String>();  // ["GT_INTENT1", "GT_INTENT2"]

	private List<ModelResponse> modelResponseList = new ArrayList<ModelResponse>();  // [modelResponse1, modelResponse2]
	//private ModelResponse modelResponse = new ModelResponse(); // Map: "QUESTION", "GT_INTENT1", "GT_INTENT2", "RES_INTENT1", "RES_INTENT3"
	private Map<String,String> rocData = new HashMap<String,String>();
	private Map<String,List<String>> rocListData = new HashMap<String,List<String>>();

	
	public List<String> getGTMaster() {
		return GTMaster;
	}
	public void addToGTMaster(String value) {
		GTMaster.add(value);
	}
	public void removeFromGTMaster(String value) {
		GTMaster.remove(value);
	}
	public boolean containsGTMaster(String value) {
		return GTMaster.contains(value);
	}

	public List<String> getGTMasterIntermediate() {
		return GTMasterIntermediate;
	}
	public void addToGTMasterIntermediate(String value) {
		GTMasterIntermediate.add(value);
	}

	// Model Response List
	public ModelResponse getModelResponse(int index) {
		return modelResponseList.get(index);
	}
	
	public void addModelResponse(ModelResponse modelResponse) {
		modelResponseList.add(modelResponse);
	}
	public void removeModelResponse(int index) {
		modelResponseList.remove(index);
	}
	// End Model Response List

	public Map<String,String> getRocData() {
		return rocData;
	}
	
	public String getRocDataElement(String key) {
		return rocData.get(key);
	}

	public void addRocListDataElement(String key, List<String> value) {
		rocListData.put(key, value);
	}
	public List<String> getRocListDataElement(String key) {
		return rocListData.get(key);
	}
	
	public Map<String,List<String>> getRocListData() {
		return rocListData;
	}
	public void addRocDataElement(String key, String value) {
		rocData.put(key, value);
	}
	
	public List<ModelResponse> getModelResponseList() {
		return modelResponseList;
	}

}