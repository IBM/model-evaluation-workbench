<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html lang="en">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /> 

<style>

body {
  font: 10px sans-serif;
}

.axis path,
.axis line {
  fill: none;
  stroke: #000;
  shape-rendering: crispEdges;
}

.tess {
  fill: none;
  stroke: aliceblue;
  stroke-width: 0px;
  opacity: 0.5;
}

.line {
  fill: none;
  stroke: steelblue;
  stroke-width: 1.5px;
}
    
.dot {
    fill: none;
}

.vors :hover circle {
  fill: red;
}
   
.vors :hover text {
	opacity: 1;
}   
    
.hidetext {
    opacity: 0;
}
    
  
html {
  min-width: 1040px;
}

body {
  background: #fcfcfa;
  color: #333;
  margin: 1em auto 4em auto;
  position: relative;
  width: 960px;
}    
    
header {

width: 160px;
position: fixed;
float: left;
margin-left: -160px;

}
</style>


<c:url value="/resources/css/main.css" var="jstlCss" />
<link href="${jstlCss}" rel="stylesheet" />

</head>
<body>

	<nav class="navbar navbar-inverse">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">Workbench ML Model Evaluation</a>
			</div>
		</div>
	</nav>

	<div class="container">

	<!-- /.container -->

	<form:form name="UploadForm"  action="uploadfile" method="POST" enctype="multipart/form-data"   accept-charset=utf-8>
	    <div class="form-group">
	    <br>
	Service:&nbsp;&nbsp;
	 <select name="serviceName" >
	   <option value="CONVERSATION">Conversation</option>
	   <option value="NLC">NLC</option>
	   <option value="NLU">NLU</option>
	</select>

	    &nbsp;&nbsp;
  <input type="radio" name="evalParam" value="Intents" checked>Intents   
  <input type="radio" name="evalParam" value="Entities">Entities
    <input type="radio" name="evalParam" value="Classes" >Classes   
	&nbsp;&nbsp;
	Service Configuration:&nbsp;&nbsp;
	 <select name="config" >
	   <option value="1">CONFIG 1</option>
	   <option value="2">CONFIG 2</option>
	   <option value="3">CONFIG 3</option>
	</select>


<br><br>	    
	        <label>File input</label>
	        <input type="file" name="file"/>
	        <button type="submit" id="upload">Evaluate Model Performance</button>
	        
	    </div>
	    <br>
	    <c:if test="${not empty GTMasterList}">
			<b>ROC CURVE generate for --></b>
			<select name="evalParamName" id="evalParamName" >
				
			<c:forEach var="listValue" items="${GTMasterList}">
				 <option value="${listValue}">${listValue}</option>
			</c:forEach>
			</select>
	        <input type="button" name="genroc" value="Show" onclick="onRocGenerate();"/>

		</c:if>
	
	</form:form>
	<br>
	<div class="starter-template">
			Model Performance Message 666<br> ${message}  <br> ${message1}
		</div>

<!-- Placed at the end of the document so the pages load faster -->
 
<script src="<c:url value="/resources/js/d3.v3.min.js" />"></script> 

<!-- 
<script src="<c:url value="/resources/js/jquery.js" />"></script>    
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script> 
<script src="<c:url value="/resources/js/bootstrap-filestyle.min.js"/>"></script>
<script src="<c:url value="/resources/js/plugins.js"/>"></script>
<script src="<c:url value="/resources/jss/jquery.autocomplete.js"/>"></script>
-->

<p id="roc"></p>    



<script>


var margin = {top: 20, right: 20, bottom: 30, left: 50},
    width = 640 - margin.left - margin.right,
    height = 520 - margin.top - margin.bottom;

var x = d3.scale.linear()
    .domain([0, 1])
    .range([0, width]);

var y = d3.scale.linear()
    .domain([0, 1])
    .range([height, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");

var line = d3.svg.line()
    .x(function(d) { return x(d.fpr); })
    .y(function(d) { return y(d.tpr); })
    .interpolate("linear");

var voronoi = d3.geom.voronoi()
		.x(function(d){ return x(d.fpr);})
		.y(function(d){ return y(d.tpr);})
	    .clipExtent([[-2, -2], [width + 2, height + 2]]);

var svg = d3.select("p#roc").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis);

  svg.append("g")
      .attr("class", "y axis")
      .call(yAxis)
   ;    
    
svg.append("text")
    .attr("class", "x label")
    .attr("text-anchor", "end")
    .attr("x", width)
    .attr("y", height - 6)
    .text("False Positive Fraction");
    
svg.append("text")
    .attr("class", "y label")
    .attr("text-anchor", "end")
    .attr("y", 6)
    .attr("dy", ".75em")
    .attr("transform", "rotate(-90)")
    .text("True Positive Fraction");    
    
draw(svg,"conditions" );


document.getElementById("evalParamName").onchange = function(){
    alert("onChange= " +this.value);
    draw(svg,this.value);
};

function onRocGenerate(){
//alert("Inside onRocGenerate ");
var rocparamval = document.getElementById("evalParamName").value;  
//alert(rocparamval);
draw(svg,rocparamval);

}
   
function draw(svg,evalparam){

//alert("eVal = "+ evalparam);
    
var map = ${ROCDataMap} ; 

//alert("map evalparam Label =  "+ map['RS_' + evalparam]);

var slabels = map['GT_' + evalparam];
var smark = map['RS_' + evalparam]; 

//var labels = JSON.parse("[" + slabels + "]");
//var mark = JSON.parse("[" + smark + "]"); 

var labels = JSON.parse(slabels);
var mark = JSON.parse(smark); 

alert("mark = "+mark);
alert("labels = "+ labels);
 
var markSort = mark.slice(0).sort();

var labSort = [];    
var oneDex = [];
var zeroDex = [];
for(var i = 0; i < markSort.length; i++){
    var cranker = labels[mark.indexOf(markSort[i])]
    labSort.push(cranker);   
    if(cranker == 1){
        oneDex.push(i);
    } else {
        zeroDex.push(i);
    }
}
    
var data = [];    
for(var i =0; i<markSort.length; i++){
    data.push({"tpr": calcTPR(oneDex, markSort, markSort[i]),
     "fpr": calcFPR(zeroDex, markSort, markSort[i]),
              "cut": markSort[i]});
}
 
var tess = voronoi(data);

for(var i = 0; i < data.length; i++){
	
	data[i].vtess = tess[i];
	
} 

svg.selectAll("path.line").remove();

  svg.append("path")
      .attr("class", "line")
      .attr("d", line(data));

  var cells = svg.append("g").attr("class", "vors").selectAll("g");
  
  cell = cells.data(data);
  cell.exit().remove();
	
    var cellEnter = cell.enter().append("g");
	
    cellEnter.append("circle")
    	.attr("class", "dot")
   	 	.attr("r", 3.5)
		.attr("cx", function(d) { return x(d.fpr); })
		.attr("cy", function(d) { return y(d.tpr); })
   	 	;
	
    cellEnter.append("path")
        .attr("class", "tess")
        ;
       
    cell.select("path").attr("d", function(d) { return "M" + d.vtess.join("L") + "Z"; });   
	
	cellEnter.append("text").attr("class", "hidetext")
	    .attr("x", function(d) { return x(d.fpr) + 10; })
	    .attr("y", function(d) { return y(d.tpr) + 10; })
	    .text(function(d) { return "cutoff: " + Math.round(d.cut*10)/10 ;  });

}    
    
function calcTPR(oneDex, markSort, m){
    
    var TPR = 0;
    for(var i = 0; i < oneDex.length; i++){
       if(markSort[oneDex[i]] >= m) {
           TPR = TPR + (1/oneDex.length);
       }
    }
    return TPR;
        
}
    
function calcFPR(zeroDex, markSort, m){
    
    var FPR = 0;
    for(var i = 0; i < zeroDex.length; i++){
       if(markSort[zeroDex[i]] >= m) {
           FPR = FPR + (1/zeroDex.length);
       }
    }
    return FPR;
        
}        


</script>
<br>
ROC CURVE END 2222
	</div>

</body>

</html>
