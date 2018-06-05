<!DOCTYPE HTML>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<HTML lang="en">

<HEAD><META 
content="IE=11.0000" http-equiv="X-UA-Compatible">
 
<META charset="UTF-8"> 
<TITLE>ROC Analysis: Web-based Calculator for ROC 
Curves 2222</TITLE> 

<STYLE type="text/css">
body, td     { font-family: Arial, Helvetica, sans-serif; font-size: 10pt; }
td           { border-style: none; padding: 0; vertical-align: top; }
.small       { font-family: Arial, Helvetica, sans-serif; font-size: 9pt; }
.big         { font-family: Arial, Helvetica, sans-serif; font-size: 12pt; }
.reallybig   { font-family: Arial, Helvetica, sans-serif; font-size: 24pt; }
button       { font-family: Arial, Helvetica, sans-serif; font-size: 11pt; }
textarea     { margin: 0; }
.blue        { color: #002790; }
.dataio      { font-family: Courier, monospace; font-size: 10pt; }
ol           { padding-left: 25px; margin-top: 0; }
li           { padding-top: 10pt; }
</STYLE>
 

<script src="<c:url value="/resources/js/jroc-limits.js" />"></script> 
<script src="<c:url value="/resources/js/jroc.js" />"></script> 

 
<SCRIPT type="text/javascript">

// ----------  DECLARE GLOBAL VARIABLES  ----------

var xROC = "", yROC = "";  // Strings containing points for fitted ROC curve
var xEmp = "", yEmp = "";  // Strings containing points for empirical ROC curve
var xUpp = "", yUpp = "";  // Strings containing points for 95% CI upper limit
var xLow = "", yLow = "";  // Strings containing points for 95% CI lower limit

// References to DOM elements
var numCatsField;
var dataFormatRadio1;
var dataFormatRadio2;
var dataFormatRadio3;
var dataFormatRadio4;
var dataFormatRadio5;
var inputField;
var outputField;
var summaryField;
var plotDataField;
var fittedCheckbox;
var empiricCheckbox;
var sampleDataHidden1;
var sampleDataHidden2;
var sampleDataHidden3;
var sampleDataHidden4;
var sampleDataHidden5;



// ----------  PAGE INITIALIZATION  ----------

function initPage() {
	// Get DOM element references
	numCatsField     = document.getElementById("numCatsField");
	dataFormatRadio1 = document.getElementById("dataFormatRadio1");
	dataFormatRadio2 = document.getElementById("dataFormatRadio2");
	dataFormatRadio3 = document.getElementById("dataFormatRadio3");
	dataFormatRadio4 = document.getElementById("dataFormatRadio4");
	dataFormatRadio5 = document.getElementById("dataFormatRadio5");
	inputField       = document.getElementById("inputField");
	outputField      = document.getElementById("outputField");
	summaryField     = document.getElementById("summaryField");
	plotDataField    = document.getElementById("plotDataField");
	fittedCheckbox   = document.getElementById("fittedCheckbox");
	empiricCheckbox  = document.getElementById("empiricCheckbox");
	sampleDataHidden1= document.getElementById("sampleDataHidden1");
	sampleDataHidden2= document.getElementById("sampleDataHidden2");
	sampleDataHidden3= document.getElementById("sampleDataHidden3");
	sampleDataHidden4= document.getElementById("sampleDataHidden4");
	sampleDataHidden5= document.getElementById("sampleDataHidden5");
	// Clear plot area
	clearPlot();
	
	//var labels1 = ${ROCDATA} ;
    //alert("ROCDATA = "+ labels1);
	
	//alert(inputField.value);
	alert("INITPAGE = ");
	
	runProgram();
	
	
	
	}

// ----------  MAIN ACTION METHODS  ----------

function pasteSampleData() {
	var inputField = document.getElementById("inputField");
	var fmt = getDataFormat();
	if (fmt == 1) {
		inputField.value = sampleData1.value;
		numCatsInput.value = "5";
		}
	else if (fmt == 2) {
		inputField.value = sampleData2.value;
		numCatsInput.value = "3";
		}
	else if (fmt == 3) {
		inputField.value = sampleData3.value;
		numCatsInput.value = "6";
		}
	else if (fmt == 4) {
		inputField.value = sampleData4.value;
		numCatsInput.value = "6";
		}
	else if (fmt == 5) {
		inputField.value = sampleData5.value;
		numCatsInput.value = "";
		}
	}

function runProgram() {
	// Check number of categories and data format
	/*
	var n = parseInt(numCatsInput.value);
	if (isNaN(n)) n = 0;
	var fmt = getDataFormat();
	if ((n < 2) && (fmt != 5)) {
		alert("Please enter the number of rating categories.");
		return;
		}
	if (inputField.value == "") {
		alert("Please enter or paste data into input field.");
		return;
		}
	if (fmt == 5) {  // Force number of categories to be blank for format 5
		numCatsInput.value = "";
		}
		
	*/
	
	var fmt = 5;  // 5
	var n = 0 ;   // 0
	alert("INSIDE RUNProgram CH");
	
	/*
	var labels1 = ${ROCDATA} ;
	alert("ROCDATA = "+ labels1);
	
	alert("RUN ROCProgram inputField= "+inputField.value);
	alert("RUN ROCProgram fmt= "+fmt);
	*/
	
	// Execute ROC Java plugin
	var JROCFITi = jroc_api(n, inputField.value, fmt);
	outputField.value = JROCFITi.outputMessage;
	// Clear plot data
	xROC = "";
	yROC = "";
	xEmp = "";
	yEmp = "";
	xUpp = "";
	yUpp = "";
	xLow = "";
	yLow = "";
	// Test for parsing errors and degenerate cases
	if (JROCFITi.degeneracyType == -1) {
		clearPlot();
		summaryField.value = "";
		return;
		}
	alert("RUN ROCProgram 1");

	// Get data points for plotting
	if (JROCFITi.degeneracyType == 0) {
		xLow = "0.0 " + JROCFITi.xLow + " 1.0";
		yLow = "0.0 " + JROCFITi.yLow + " 1.0";
		xUpp = "0.0 " + JROCFITi.xUpp + " 1.0";
		yUpp = "0.0 " + JROCFITi.yUpp + " 1.0";
		xROC = "0.0 " + JROCFITi.xROC + " 1.0";
		yROC = "0.0 " + JROCFITi.yROC + " 1.0";
		}
	else {
		// Force plotting of empirical ROC curve
		if (fittedCheckbox.checked) fittedCheckbox.checked = false;
		empiricCheckbox.checked = true;
		}
	xEmp = JROCFITi.xtROC;
	yEmp = JROCFITi.ytROC;
	updatePlot();
	// Make results summary
	var s = "";
	if (fmt != 5) {
		var tPos = JROCFITi.truePos;
		var tNeg = JROCFITi.trueNeg;
		var fPos = JROCFITi.falsePos;
		var fNeg = JROCFITi.falseNeg;
		s += "Number of Cases:   " + (tPos + tNeg + fPos + fNeg) + "\n";
		s += "Number Correct:    " + (tPos + tNeg) + "\n";
		s += "Accuracy:          " + Math.round(1000*(tPos + tNeg)/(tPos + tNeg + fPos + fNeg))/10 + "%\n";
		s += "Sensitivity:       " + Math.round(1000*tPos/(tPos + fNeg))/10 + "%\n";
		s += "Specificity:       " + Math.round(1000*tNeg/(tNeg + fPos))/10 + "%\n";
		s += "Pos Cases Missed:  " + fNeg + "\n";
		s += "Neg Cases Missed:  " + fPos + "\n";
		s += "\n";
		}
	else {
		var numPos = JROCFITi.numPos;
		var numNeg = JROCFITi.numNeg;
		s += "Total Cases:       " + (numPos + numNeg) + "\n";
		s += "Positive Cases:    " + numPos + "\n";
		s += "Negative Cases:    " + numNeg + "\n";
		s += "\n";
		}
	if ((fmt == 1) || (fmt == 3)) {
		s += "(A rating of " + (Math.floor(n/2) + 1) + " or greater is considered positive.)\n\n";
		}
	if (JROCFITi.degeneracyType == 0) {
		s += "Fitted ROC Area:   " + Math.round(1000*JROCFITi.rocFitArea)/1000 + "\n";
		}
	else {
		s += "Fitted ROC Area:   degenerate\n";
		}
	if (fmt != 5) {
		s += "Empiric ROC Area:  " + Math.round(1000*JROCFITi.rocTrapezArea)/1000 + "\n";
		}
	if (fmt == 5) {
		if (JROCFITi.allIntegerFlag) {
			s += "\nCaution: Data Format 5 (for continuous data) was used even though all data were integers.\n";
			}
		}
	summaryField.value = s;
	}

function clearPlot() {
	simpleplot("plotCanvas", "", "", 0, "none", "none", false);
	}

function updatePlot() {
	clearPlot();
	plotDataField.value = "";
	if (fittedCheckbox.checked) {
		if (xROC != "") {
			simpleplot("plotCanvas", xUpp, yUpp, 0, "", "gray", true);
			simpleplot("plotCanvas", xROC, yROC, 3, "red", "blue", true);
			simpleplot("plotCanvas", xLow, yLow, 0, "", "gray", true);
			plotDataField.value = fittedDataPoints();
			}
		}
	if (empiricCheckbox.checked) {
		if (xEmp != "") {
			var lineColor = "";
			if (!fittedCheckbox.checked) lineColor = "green";
			simpleplot("plotCanvas", xEmp, yEmp, 3, "black", lineColor, true);
			if (!fittedCheckbox.checked) {
				plotDataField.value = empiricalDataPoints();
				}
			}
		else {  // If not data, uncheck the checkbox
			empiricCheckbox.checked = false;
			}
		}
	}

// ----------  METHOD FOR TRIGGERING WEB COUNTER  ----------

// ----------  MISCELLANEOUS UTILITY METHODS  ----------

function getDataFormat() {
	if (dataFormatRadio1.checked) return (1);
	else if (dataFormatRadio2.checked) return (2);
	else if (dataFormatRadio3.checked) return (3);
	else if (dataFormatRadio4.checked) return (4);
	else if (dataFormatRadio5.checked) return (5);
	else return (0);
	}

function fittedDataPoints() {
	var s = "FPF   \tTPF   \tLower \tUpper\n";
	var a1 = xROC.split(" ");
	var a2 = yROC.split(" ");
	var a3 = yLow.split(" ");
	var a4 = yUpp.split(" ");
	for (var i = 0; i < a1.length; i++) {
		s += formatPoint(a1[i]) + "\t" + formatPoint(a2[i]) + "\t" +
			formatPoint(a3[i]) + "\t" + formatPoint(a4[i]) + "\n";
		}
	return (s);
	}

function empiricalDataPoints() {
	var s = "FPF   \tTPF\n";
	var a1 = xEmp.split(" ");
	var a2 = yEmp.split(" ");
	for (var i = 0; i < a1.length; i++) {
		s += formatPoint(a1[i]) + "\t" + formatPoint(a2[i]) + "\n";
		}
	return (s);
	}

function formatPoint(s) {
	var r = (Math.round(s*10000)/10000) + "";
	if (r.indexOf(".") == -1) r += ".";
	if (r.charAt(0) == '.') r = "0" + r;
	while (r.length < 6) r += "0";
	return (r);
	}

</SCRIPT>
 
<SCRIPT type="text/javascript">
var mailPart2 = "jhmuuui.edu";
var mailPart1 = "jeng";
var ema = mailPart1 + "@" + mailPart2;
</SCRIPT>
 
<META name="GENERATOR" content="MSHTML 11.00.9600.18639"></HEAD> 
<BODY style="background-color: white;" onload="initPage()"><!--==========   Set up outside border   ==========--> 

	<form:form name="UploadForm"  action="uploadfile" method="POST" enctype="multipart/form-data" >
	    <div class="form-group">
	    <br>
	<select>
	   <option value="Conversation">Conversation</option>
	   <option value="NLC">NLC</option>
	   <option value="NLU">NLU</option>
	</select>
	    <br>
  <input type="radio" name="artifact" value="Intents" checked>Intents   
  <input type="radio" name="artifact" value="Entities">Entities<br>
	    
	        <label>File input</label>
	        <input type="file" name="file"/>
	        <button type="submit" id="upload">Evaluate Model Performance</button>
	        
	    </div>

	<div class="starter-template">
			Model Performance Message 787878<br> ${message}  <br> ${message1}
		</div>
		
<br>ROC CURVE <br>

<DIV style="padding: 15px; border: 2px solid rgb(246, 198, 14); border-image: none; width: 820px;"><!--==========   Title material   ==========--> 
<TABLE style="border-collapse: collapse;">
  <TBODY>
  <TR>
    <TD style="width: 570px;">
      <DIV class="reallybig">
      <B class="blue">ROC Analysis</B></DIV>
      <DIV class="big" style="padding-top: 10px;"><B class="blue">Web-based 
      Calculator for ROC Curves</B></DIV>
      
      </TD>
    <TD style="vertical-align: top;">		</TD></TR></TBODY></TABLE><!--==========   Explanatory material   ==========--> 
<TABLE style="margin-top: 30px; border-collapse: collapse;">
  <TBODY>
  <TR>
    <TD style="width: 50%; padding-right: 10px;">
     </TD>
    <TD style="width: 50%; padding-left: 10px;"> </TD></TR></TBODY></TABLE>
<HR style="border: 1px solid rgb(246, 198, 14); border-image: none; margin-top: 20px;">
<!--==========   Data format   ==========--> 
<TABLE style="margin-top: 20px; border-collapse: collapse;">
  <TBODY>
  <TR>
    <TD 
      style="padding-top: 6px; padding-bottom: 6px; vertical-align: middle;">
      
      <INPUT name="dataFormat" id="dataFormatRadio1" type="radio" checked=""> Format 1 &nbsp;			 
      <INPUT name="dataFormat" id="dataFormatRadio2" type="radio"> Format 2 &nbsp;			 
      <INPUT name="dataFormat" id="dataFormatRadio3" type="radio"> Format 3 &nbsp;			 
      <INPUT name="dataFormat" id="dataFormatRadio4" 
      type="radio"> Format 4 &nbsp;			 <INPUT name="dataFormat" id="dataFormatRadio5" 
      type="radio"> Format 5 &nbsp;		 
     </TD>
    <TD style="text-align: center; vertical-align: middle;"> </TD></TR><!--==========   Number of rating categories   ==========-->
	 
  <TR>
    <TD 
      style="padding-top: 6px; padding-bottom: 6px; vertical-align: middle;">
      <B><INPUT id="numCatsInput" type="text" size="2" maxlength="2">&nbsp;&nbsp; 
		 </TD>
    <TD style="text-align: center; vertical-align: middle;"> </TD></TR></TBODY></TABLE><!--==========   Program data input and result output fields   ==========--> 
<TABLE style="margin-top: 14px; border-collapse: collapse;">
  <TBODY>
  <TR>
    <TD style="padding-right: 6px;">
    </TD>
    <TD style="padding-left: 6px;"><B>Program Output:</B>&nbsp; </TD></TR>
  <TR>
    <TD 
style="padding-right: 6px;"><TEXTAREA class="dataio" id="inputField" rows="20" cols="30">${ROCDATA}</TEXTAREA></TD>
    <TD 
style="padding-left: 6px;"><TEXTAREA class="dataio" id="outputField" rows="20" cols="65" readonly=""></TEXTAREA></TD></TR></TBODY></TABLE><!--==========   ROC plot, result summary, and listing of data points   ==========--> 
<TABLE style="margin-top: 10px; border-collapse: collapse;">
  <TBODY>
  <TR>
    <TD></TD>
    <TD style="text-align: center;"><B>ROC Curve</B></TD>
    <TD style="padding-left: 12px;"><B>Summary Statistics:</B></TD>
    <TD style="padding-left: 6px;"><B>Points for Plotting:</B>&nbsp; <SPAN 
      class="small">(copy &amp; paste to Excel)</SPAN></TD></TR>
  <TR>
    <TD></TD>
    <TD><CANVAS width="210" height="210" id="plotCanvas"></CANVAS></TD>
    <TD style="padding-left: 12px;" rowspan="2"><TEXTAREA class="dataio" id="summaryField" rows="15" cols="27" readonly=""></TEXTAREA></TD>
    <TD style="padding-left: 6px;" rowspan="2"><TEXTAREA class="dataio" id="plotDataField" rows="15" cols="34" readonly=""></TEXTAREA></TD></TR>
  <TR>
    <TD></TD>
    <TD></TD></TR></TBODY></TABLE>
    
&nbsp;<BR><!--==========   ROC plot type selectors   ==========--> <B>ROC Curve 
Type:</B>&nbsp;&nbsp;<INPUT id="fittedCheckbox" onclick="updatePlot()" type="checkbox" 
checked="">Fitted&nbsp;&nbsp; <INPUT id="empiricCheckbox" onclick="updatePlot()" 
type="checkbox">Empirical<BR><BR><B>Key for the ROC Plot</B><BR><U>RED symbols 
and BLUE line</U>:&nbsp; Fitted ROC curve.<BR><U>GRAY lines</U>:&nbsp; 95% 
confidence interval of the fitted ROC curve.<BR><U>BLACK symbols ± GREEN 
line</U>:&nbsp; Points making up the empirical ROC curve (does not apply to 
Format 5).<BR><!--==========   Endnotes   ==========--> 
<HR style="border: 1px solid rgb(246, 198, 14); border-image: none; margin-top: 20px;">

<TABLE style="border-collapse: collapse;">
  <TBODY>
  <TR>
    <TD style="width: 50%; padding-right: 10px;">
    </TD>
    <TD style="width: 50%; padding-left: 10px;">
   	 </TD></TR></TBODY></TABLE><!--==========   Define sample data   ==========--> 
<INPUT id="sampleData1" type="hidden" value="0 1&#10;0 1&#10;0 1&#10;0 1&#10;0 1&#10;0 1&#10;0 1&#10;0 1&#10;0 1&#10;0 1&#10;0 1&#10;0 2&#10;0 2&#10;0 2&#10;0 2&#10;0 2&#10;0 2&#10;0 2&#10;0 2&#10;0 2&#10;0 3&#10;0 3&#10;0 3&#10;0 4&#10;0 5&#10;1 1&#10;1 2&#10;1 2&#10;1 3&#10;1 3&#10;1 3&#10;1 4&#10;1 4&#10;1 4&#10;1 4&#10;1 4&#10;1 4&#10;1 4&#10;1 4&#10;1 4&#10;1 5&#10;1 5&#10;1 5&#10;1 5&#10;1 5&#10;1 5&#10;1 5&#10;1 5&#10;1 5&#10;1 5&#10;"> 
<INPUT id="sampleData2" type="hidden" value="0 none        0 none        3&#10;0 none        0 none        3&#10;0 none        0 none        3&#10;0 none        0 none        3&#10;0 none        0 none        3&#10;0 none        0 none        3&#10;0 none        0 none        3&#10;0 none        0 none        3&#10;0 none        0 none        3&#10;0 none        0 none        3&#10;0 none        0 none        3&#10;0 none        0 none        3&#10;0 none        0 none        3&#10;0 none        0 none        3&#10;0 none        0 none        3&#10;0 none        0 none        3&#10;0 none        0 none        3&#10;0 none        0 none        2&#10;0 none        0 none        2&#10;0 none        0 none        2&#10;0 none        0 none        2&#10;0 none        0 none        2&#10;0 none        0 none        2&#10;0 none        0 none        2&#10;0 none        0 none        2&#10;0 none        0 none        2&#10;0 none        0 none        1&#10;0 none        0 none        1&#10;0 none        0 none        1&#10;0 none        0 none        1&#10;0 none        0 none        1&#10;0 none        0 none        1&#10;0 none        1 humerus     1&#10;0 none        1 radius      1&#10;0 none        1 ulna        1&#10;0 none        1 carpal      1&#10;0 none        1 metacarpal  2&#10;0 none        1 femur       2&#10;0 none        1 tibia       2&#10;0 none        1 fibula      3&#10;1 humerus     0 none        3&#10;1 radius      0 none        3&#10;1 ulna        0 none        2&#10;1 carpal      0 none        2&#10;1 metacarpal  0 none        2&#10;1 femur       0 none        2&#10;1 tibia       0 none        1&#10;1 fibula      0 none        1&#10;1 tarsal      0 none        1&#10;1 metatarsal  0 none        1&#10;1 pelvis      1 pelvis      1&#10;1 rib         1 rib         1&#10;1 clavicle    1 clavicle    1&#10;1 scapula     1 scapula     1&#10;1 humerus     1 humerus     1&#10;1 radius      1 radius      1&#10;1 ulna        1 ulna        2&#10;1 carpal      1 carpal      2&#10;1 metacarpal  1 metacarpal  2&#10;1 femur       1 femur       2&#10;1 tibia       1 tibia       2&#10;1 fibula      1 fibula      2&#10;1 tarsal      1 tarsal      2&#10;1 metatarsal  1 metatarsal  2&#10;1 pelvis      1 pelvis      2&#10;1 rib         1 rib         3&#10;1 clavicle    1 clavicle    3&#10;1 scapula     1 scapula     3&#10;1 humerus     1 humerus     3&#10;1 radius      1 radius      3&#10;1 ulna        1 ulna        3&#10;1 carpal      1 carpal      3&#10;1 metacarpal  1 metacarpal  3&#10;1 femur       1 femur       3&#10;1 tibia       1 tibia       3&#10;1 fibula      1 fibula      3&#10;1 tarsal      1 tarsal      3&#10;1 metatarsal  1 metatarsal  3&#10;1 pelvis      1 pelvis      3&#10;1 rib         1 rib         3&#10;"> 
<INPUT id="sampleData3" type="hidden" value="206 140 30  34  32  33&#10;71  66  12  15  78  233&#10;"> 
<INPUT id="sampleData4" type="hidden" value="40     40&#10;1.0    1.0&#10;0.95   0.575&#10;0.85   0.35&#10;0.75   0.2&#10;0.6    0.1&#10;0.375  0.025&#10;"> 
<INPUT id="sampleData5" type="hidden" value="0 -0.037&#10;0  0.288&#10;0 -1.649&#10;0 -0.074&#10;0  0.833&#10;0 -2.019&#10;0  0.976&#10;0  0.561&#10;0  0.494&#10;0 -1.699&#10;0  0.981&#10;0  0.808&#10;0  0.044&#10;0 -1.107&#10;0  2.162&#10;0  0.090&#10;0  0.304&#10;0  0.153&#10;0 -0.234&#10;0 -0.681&#10;0 -0.332&#10;0 -1.554&#10;0  1.644&#10;0  0.482&#10;0  0.501&#10;0  0.457&#10;0 -0.155&#10;0 -1.101&#10;0  1.116&#10;0  0.002&#10;0  0.658&#10;0 -1.167&#10;0  1.277&#10;0  1.059&#10;0 -1.658&#10;0  2.614&#10;0  0.695&#10;0 -0.272&#10;0 -0.124&#10;0 -0.886&#10;0  1.769&#10;0  0.131&#10;0 -2.201&#10;0 -0.740&#10;0  1.513&#10;0 -1.201&#10;0 -1.687&#10;0 -0.442&#10;0  0.522&#10;0  0.694&#10;0 -0.696&#10;0  0.796&#10;0 -1.267&#10;0  1.973&#10;0  1.750&#10;0  2.056&#10;0  1.537&#10;0 -1.399&#10;0  1.302&#10;0  0.055&#10;0  0.656&#10;0 -0.211&#10;0  0.335&#10;0  1.078&#10;0 -0.234&#10;0 -0.460&#10;0 -0.680&#10;0 -0.006&#10;1  0.835&#10;1 -0.334&#10;1  1.172&#10;1  2.962&#10;1  1.001&#10;1  1.402&#10;1  0.829&#10;1  1.593&#10;1  2.861&#10;1 -0.653&#10;1  2.118&#10;1  0.361&#10;1  0.971&#10;1  1.812&#10;1  1.293&#10;1  1.534&#10;1  3.000&#10;1  0.365&#10;1  0.633&#10;1  2.002&#10;1  0.054&#10;1  4.353&#10;1  1.568&#10;1  1.163&#10;1 -0.777&#10;1  0.547&#10;1 -0.095&#10;1  0.830&#10;1  0.905&#10;1  1.297&#10;1  1.780&#10;1  2.602&#10;1  2.699&#10;1  1.807&#10;1  2.367&#10;1  0.052&#10;1  4.195&#10;1 -0.659&#10;1  3.030&#10;1  0.850&#10;1  2.062&#10;1  1.366&#10;1  4.850&#10;1  2.779&#10;1  2.282&#10;1  0.586&#10;1  0.976&#10;1  0.501&#10;1  0.620&#10;1  1.287&#10;1  1.457&#10;1  1.374&#10;1  1.015&#10;1  1.116&#10;1  0.321&#10;1  1.784&#10;1  4.680&#10;1  0.747&#10;1  0.948&#10;1  1.508&#10;1  0.378&#10;1  1.250&#10;1  0.225&#10;1  1.373&#10;1 -0.869&#10;1  0.817&#10;1  1.541&#10;1  1.123&#10;1  0.907&#10;1  0.210&#10;1  1.472&#10;1 -0.099&#10;1  2.951&#10;1  1.254&#10;1  0.789&#10;1  0.882&#10;1  0.554&#10;1  0.560&#10;1  1.273&#10;1 -0.207&#10;"> <!--==========   Close outside border   ==========--> 
</DIV>
<DIV style="margin-top: 5pt;">&nbsp;(Page last updated:  1111)</DIV>
	</form:form>
 <!--  End JavaScript code for page tracking  -->
 
 <SCRIPT type="text/javascript">
    //var labels1 = ${ROCDATA} ;
    //alert("ROCDATA = "+ labels1);
	
	//alert(inputField.value);
	alert("Call runProgram() = ");
	runProgram();
	
 
 </SCRIPT>
 
 
  </BODY></HTML>
