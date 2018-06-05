package com.ibm.model;

public class PerformanceStatistics {
	private int numberOfCases;  
	private int numberCorrect; 
	private String accuracy; 
	private String sensitivity; 
	private String specificity; 
	private String areaRoc;
	private int posCasesMissed;  
	private int negCasesMissed;  
	private int posCases;  
	private int negCases;
	
	public int getNumberOfCases() {
		return numberOfCases;
	}
	public void setNumberOfCases(int numberOfCases) {
		this.numberOfCases = numberOfCases;
	}
	public int getNumberCorrect() {
		return numberCorrect;
	}
	public void setNumberCorrect(int numberCorrect) {
		this.numberCorrect = numberCorrect;
	}
	public String getAccuracy() {
		return accuracy;
	}
	public void setAccuracy(String accuracy) {
		this.accuracy = accuracy;
	}
	public String getSensitivity() {
		return sensitivity;
	}
	public void setSensitivity(String sensitivity) {
		this.sensitivity = sensitivity;
	}
	public String getSpecificity() {
		return specificity;
	}
	public void setSpecificity(String specificity) {
		this.specificity = specificity;
	}
	public String getAreaRoc() {
		return areaRoc;
	}
	public void setAreaRoc(String areaRoc) {
		this.areaRoc = areaRoc;
	}
	public int getPosCasesMissed() {
		return posCasesMissed;
	}
	public void setPosCasesMissed(int posCasesMissed) {
		this.posCasesMissed = posCasesMissed;
	}
	public int getNegCasesMissed() {
		return negCasesMissed;
	}
	public void setNegCasesMissed(int negCasesMissed) {
		this.negCasesMissed = negCasesMissed;
	}
	public int getPosCases() {
		return posCases;
	}
	public void setPosCases(int posCases) {
		this.posCases = posCases;
	}
	public int getNegCases() {
		return negCases;
	}
	public void setNegCases(int negCases) {
		this.negCases = negCases;
	}  


}