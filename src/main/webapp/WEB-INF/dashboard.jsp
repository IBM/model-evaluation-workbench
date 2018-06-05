<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Watson Model Evaluation Workbench</title>

<style>

body {
    margin: 0;
    padding: 0;
    width: 100%;
    background-color: #e9e9e9;
    font-family: Tahoma, Helvetica, Arial, sans-serif;
}

h1, h2, h3, h4, h5 {
    margin: 0;
    padding: 0;
    font-weight: bold;
} 

#container {
    width: 1200px;
    margin: 0 auto;
    position: relative;
}
#container> div {
    width: 100%;
    background-color: #ffffff;
}
#logoContainer {
    float: left;
}
#logoContainer img {
    padding: 0 5px;
}
#logoContainer div {
    position: absolute;
    top: 0px;
    left: 145px;
}
#logoContainer div h2 {
    color: #0075c2;
}
#logoContainer div h4 {
    color: #0e948c;
}
#logoContainer div p {
    color: #719146;
    font-size: 12px;
    padding: 5px 0;
}

.node {
  cursor: pointer;
}

.node circle {
  fill: #fff;
  stroke: steelblue;
  stroke-width: 1.5px;
}

.node text {
  font: 10px sans-serif;
}

.link {
  fill: none;
  stroke: #ccc;
  stroke-width: 1.5px;
}

.found {
  fill: #ff4136;
  stroke: #ff4136;
}

.search {
  float: left;
  font: 10px sans-serif;
  width: 30%;
}

ul.select2-results {
 max-height: 100px;
}

.select2-container,
.select2-drop,
.select2-search,
.select2-search input {
  font: 10px sans-serif;
}

#block_container {
  display: inline;
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
  stroke: blue;
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
    

a:nth-child(even){background-color: #f2f2f2}
.footer {
  clear: both;
  position: absolute;
  z-index: 10;
  height: 3em;
  bottom: 0;
  margin-top: -3em;
  font: 7px sans-serif;
}

</style>

<link rel="stylesheet" type="text/css" href="js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/select.css">
<link href="css/admin.css" rel="stylesheet">
<link href="css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>

<body  <c:if test="${empty GTMasterList}"> onload="loadDashboard()" </c:if>  >
<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="js/d3.v3.min.js"></script>
<script src="rocChart.js"></script>

<div id="wrapper">
             
  <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <!-- Top Menu Items -->
            <ul class="nav navbar-right top-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i>  <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        
                        <li>
                            <a href="#"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                        </li>
                    </ul>
                </li>
            </ul>
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav side-nav">
                    <li class="active">
                        <a href="home"><i class="fa fa-fw fa-home"></i> Home</a>
                    </li>
                    <li >
                        <a href="dashboard"><i class="fa fa-fw fa-dashboard"></i>Dashboard</a>
                    </li>
          </div>
            <!-- /.navbar-collapse -->
     </nav>
     <div id="page-wrapper">

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            <img src="img/IBM-logo-blue.png" style="width:10%;"alt='Logo' />Watson Model Evaluation Workbench <small>Dashboard</small>
                        </h1>
                       
                    </div>
                </div>
	<form:form name="UploadForm" action="uploadfiles" modelAttribute="uploadForm" method="POST" enctype="multipart/form-data"   accept-charset=utf-8>
       <input type="hidden" id="serviceName" name="serviceName" value="" />

<!-- ROW -->
<div class="row" id="select_api">
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-comments fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="medium">NLC</div>
                                        
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="panel-footer">
                                    <span class="pull-left" onclick="return loadSelection('NLC')">Evaluate Model</span>
                                    <span class="pull-right" onclick="return loadSelection('NLC')"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-green">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-tasks fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="medium">Conversation</div>
                                        
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="panel-footer">
                                    <span class="pull-left" onclick="return loadSelection('Conversation')">Evaluate Model</span>
                                    <span class="pull-right" onclick="return loadSelection('Conversation')"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-yellow">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-bar-chart fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="medium">NLU</div>
                                        
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="panel-footer">
                                    <span class="pull-left" onclick="return loadSelection('NLU')">Evaluate Model</span>
                                    <span class="pull-right" onclick="return loadSelection('NLU')"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                   
                </div>
                <!-- /.row -->
 

<div id="sub_container_1">
<div class="row" >
                    <div class="col-lg-12" >
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-bar-chart-o fa-fw"></i> Evaluation Inputs</h3>
                            </div>
                            <div class="panel-body">
 
                                 <div class="row" id="attr">
                                    <div class="col-xs-5 col-sm-5"><label> <h5>Attribute: </label></div>
                                    <div class="col-xs-4 col-sm-2" >
                                      <a class="btn btn-default btn-select" onclick="return loadAttributeSelection()" >
                                      <input type="hidden" class="btn-select-input" id="" name="" value="" />
                                      <span class="btn-select-value" id="attr_span" >Select an Item</span>
                                      <span class='btn-select-arrow glyphicon glyphicon-chevron-down'></span>
                
                                     <ul id="attr_list">
                                      </ul>
                                     </a>
                                    </div>
                                </div>
 
                              <div class="row" id="config">
                                    <div class="col-xs-5 col-sm-5"><label> <h5>Model Configuration: </label></div>
                                    
                                    <div class="col-xs-4 col-sm-2" id="config_list">
                                    
                            <input type="hidden" id="evalParam" name="evalParam" value="" />
    					    <input type="hidden" id="config" name="config" value="" />
                                     
                                       <span class="checkbox">
                                         <label><input type="checkbox" name="model" value="1">MODEL 1</label>
                                       </span>
                                       <span class="checkbox">
                                         <label><input type="checkbox" name="model" value="2">MODEL 2</label>
                                       </span>
                                       <span class="checkbox">
                                         <label><input type="checkbox" name="model" value="3">MODEL 3</label>
                                       </span> 
                                       <span class="checkbox">
                                         <label><input type="checkbox" name="model" value="4">MODEL 4</label>
                                       </span> 
                                       <span class="checkbox">
                                         <label><input type="checkbox" name="model" value="5">MODEL 5</label>
                                       </span> 
                                </div>
                            </div>
                            
                            <div class="row">
                                      <div class="col-lg-12 col-md-6">
                                        <div class="col-xs-5 col-sm-5"><label><h5>Upload Model Evaluation Test Data:</label></div>
                                        <div class="fileinput fileinput-new col-xs-5 col-sm-5" data-provides="fileinput">
                                              <span class="btn btn-default btn-file">
                                             
										<table id="fileTable">
							                <tr>
							                    <td><input name="files[0]" type="file" /></td>
							                </tr>
							                <tr>
							                    <td><input name="files[1]" type="file" /></td>
							                </tr>
							            </table>
                                              </span>
                                        </div>
                                        </div>
                                        </div>
                                        <br>
                                       <div class="row"> 
                                       <div class="col-lg-1 col-md-1 col-md-offset-1">   
                                       </div>

                                       <div class="col-lg-2 col-md-2 col-md-offset-2">   
							                <input id="addFile" type="button" value="Add File" />
                                       </div>

                                       <div class="col-lg-2 col-md-2 col-md-offset-2">   
                                           <button type="submit" class="btn btn-info pull-right" id="evaluate_btn"  onclick="loadROC()" >Evaluate  Performance</button>
                                       </div>
                                </div>
                               </div>
                             </div>
                        </div>
                    </div>
                </div>


                
                <!-- /.row -->
       </form:form>         

<!-- end of Sub Container 1 -->

<div id="sub_container_2">

<!-- Ratings -->



<!--  NEW Dynamic Recommendation 1 Section -->

<div id="recModel1" class="row">
                <div class="col-lg-12">
                  <div class="panel panel-default">
                      <div class="panel-heading">
                           <a data-toggle="collapse" href="#collapse1"> <h3 class="panel-title"><i class="fa fa-long-arrow-right fa-fw"></i> Recommendation- MODEL 1</h3></a>
                      </div>
                      <br/>
                    <div id="collapse1" class="panel-collapse collapse">
                        <div class="panel-body">
                          <div class="row">
                            <table id="f1OptimisationTable" class="table table-bordered table-responsive table-striped">
                                    <thead>
                                      <tr>
                                        <th></th>
                                        <th>Optimal Threshold</th>
                                        <th>Maximised F1 Score</th>
                                        <th>True Positive Rate</th>
                                        <th>False Positive Rate</th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                      <tr>
                                       		<td><b>F1Score Optimization</td>
                                            <td><label id="bestThresholdF1Score[1]"></label></td>
                                            <td><label id="bestF1Score[1]"></td>
                                            <td><label id="bestTPRF1Score[1]"></td>
                                            <td><label id="bestFPRF1Score[1]"></td>
                                      </tr>
                                            </tbody>
                               </table>
                               <table id="accuracyOptimisationTable" class="table table-bordered table-responsive table-striped">
                                    <thead>
                                      <tr>
                                        <th></th>
                                        <th>Optimal Threshold</th>
                                        <th>Maximised Accuracy</th>
                                        <th>Correct Classification(%)</th>
                                        <th>Incorrect Classification(%)</th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                      <tr>
                                        	<td><b>Accuracy Optimization</td>
                                            <td><label id="bestThresholdAccuracy[1]"></label></td>
                                            <td><label id="bestAccuracy[1]"></label></td>
                                            <td><label id="bestAccuracyCorrect[1]"></label></td>
                                            <td><label id="bestAccuracyInCorrect[1]"></label></td>
                                      </tr>
                                      
                                    </tbody>
                               </table>
                        </div>
                         <div class="row">
                             <p id="modelRating[1]"><b>Model Rating : </b>
                             <p><small><0.5 poor, <0.7 fair, <0.85 good, >0.85 excellent</small></p>
                        </div>
                        </div>
                    </div>
				   </div>
				</div>

</div>

<!--  NEW Dynamic Recommendation Section 2 -->

<div  id="recModel2" class="row">
                <div class="col-lg-12">
                  <div class="panel panel-default">
                      <div class="panel-heading">
                           <a data-toggle="collapse" href="#collapse2"> <h3 class="panel-title"><i class="fa fa-long-arrow-right fa-fw"></i> Recommendation- MODEL 2</h3></a>
                      </div>
                      <br/>
                    <div id="collapse2" class="panel-collapse collapse">
                        <div class="panel-body">
                          <div class="row">
                            <table id="f1OptimisationTable" class="table table-bordered table-responsive table-striped">
                                    <thead>
                                      <tr>
                                        <th></th>
                                        <th>Optimal Threshold</th>
                                        <th>Maximised F1 Score</th>
                                        <th>True Positive Rate</th>
                                        <th>False Positive Rate</th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                      <tr>
	                                	   <td><b>F1Score Optimization</td>
                                           <td><label id="bestThresholdF1Score[2]"></label></td>
                                           <td><label id="bestF1Score[2]"></td>
                                           <td><label id="bestTPRF1Score[2]"></td>
                                           <td><label id="bestFPRF1Score[2]"></td>
                                      </tr>
                                            </tbody>
                               </table>
                               <table id="accuracyOptimisationTable" class="table table-bordered table-responsive table-striped">
                                    <thead>
                                      <tr>
                                        <th></th>
                                        <th>Optimal Threshold</th>
                                        <th>Maximised Accuracy</th>
                                        <th>Correct Classification(%)</th>
                                        <th>Incorrect Classification(%)</th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                      <tr>
                                        	<td><b>Accuracy Optimization</td>
                                            <td><label id="bestThresholdAccuracy[2]"></label></td>
                                            <td><label id="bestAccuracy[2]"></label></td>
                                            <td><label id="bestAccuracyCorrect[2]"></label></td>
                                            <td><label id="bestAccuracyInCorrect[2]"></label></td>
                                      </tr>
                                      
                                    </tbody>
                               </table>
                        </div>
                         <div class="row">
                             <p id="modelRating[2]"><b>Model Rating :</b>
                             <p><small><0.5 poor, <0.7 fair, <0.85 good, >0.85 excellent</small></p>
                        </div>
                        </div>
                    </div>
				   </div>
				</div>

</div>

<!--  NEW Dynamic Recommendation Section 3 -->

<div  id="recModel3" class="row">
                <div class="col-lg-12">
                  <div class="panel panel-default">
                      <div class="panel-heading">
                           <a data-toggle="collapse" href="#collapse3"> <h3 class="panel-title"><i class="fa fa-long-arrow-right fa-fw"></i> Recommendation- MODEL 3</h3></a>
                      </div>
                      <br/>
                    <div id="collapse3" class="panel-collapse collapse">
                        <div class="panel-body">
                          <div class="row">
                            <table id="f1OptimisationTable" class="table table-bordered table-responsive table-striped">
                                    <thead>
                                      <tr>
                                        <th></th>
                                        <th>Optimal Threshold</th>
                                        <th>Maximised F1 Score</th>
                                        <th>True Positive Rate</th>
                                        <th>False Positive Rate</th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                      <tr>
	                                	   <td><b>F1Score Optimization</td>
                                           <td><label id="bestThresholdF1Score[3]"></label></td>
                                           <td><label id="bestF1Score[3]"></td>
                                           <td><label id="bestTPRF1Score[3]"></td>
                                           <td><label id="bestFPRF1Score[3]"></td>
                                      </tr>
                                            </tbody>
                               </table>
                               <table id="accuracyOptimisationTable" class="table table-bordered table-responsive table-striped">
                                    <thead>
                                      <tr>
                                        <th></th>
                                        <th>Optimal Threshold</th>
                                        <th>Maximised Accuracy</th>
                                        <th>Correct Classification(%)</th>
                                        <th>Incorrect Classification(%)</th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                      <tr>
                                        	<td><b>Accuracy Optimization</td>
                                            <td><label id="bestThresholdAccuracy[3]"></label></td>
                                            <td><label id="bestAccuracy[3]"></label></td>
                                            <td><label id="bestAccuracyCorrect[3]"></label></td>
                                            <td><label id="bestAccuracyInCorrect[3]"></label></td>
                                      </tr>
                                      
                                    </tbody>
                               </table>
                        </div>
                         <div class="row">
                             <p id="modelRating[3]"><b>Model Rating : </b>
                             <p><small><0.5 poor, <0.7 fair, <0.85 good, >0.85 excellent</small></p>
                        </div>
                        </div>
                    </div>
				   </div>
				</div>

</div>

<!--  NEW Dynamic Recommendation Section 4 -->

<div  id="recModel4" class="row">
                <div class="col-lg-12">
                  <div class="panel panel-default">
                      <div class="panel-heading">
                           <a data-toggle="collapse" href="#collapse4"> <h3 class="panel-title"><i class="fa fa-long-arrow-right fa-fw"></i> Recommendation- MODEL 4</h3></a>
                      </div>
                      <br/>
                    <div id="collapse4" class="panel-collapse collapse">
                        <div class="panel-body">
                          <div class="row">
                            <table id="f1OptimisationTable" class="table table-bordered table-responsive table-striped">
                                    <thead>
                                      <tr>
                                        <th></th>
                                        <th>Optimal Threshold</th>
                                        <th>Maximised F1 Score</th>
                                        <th>True Positive Rate</th>
                                        <th>False Positive Rate</th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                      <tr>
	                                	   <td><b>F1Score Optimization</td>
                                           <td><label id="bestThresholdF1Score[4]"></label></td>
                                           <td><label id="bestF1Score[4]"></td>
                                           <td><label id="bestTPRF1Score[4]"></td>
                                           <td><label id="bestFPRF1Score[4]"></td>
                                      </tr>
                                            </tbody>
                               </table>
                               <table id="accuracyOptimisationTable" class="table table-bordered table-responsive table-striped">
                                    <thead>
                                      <tr>
                                        <th></th>
                                        <th>Optimal Threshold</th>
                                        <th>Maximised Accuracy</th>
                                        <th>Correct Classification(%)</th>
                                        <th>Incorrect Classification(%)</th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                      <tr>
	                                       <td><b>Accuracy Optimization</td>
                                           <td><label id="bestThresholdAccuracy[4]"></label></td>
                                           <td><label id="bestAccuracy[4]"></label></td>
                                           <td><label id="bestAccuracyCorrect[4]"></label></td>
                                           <td><label id="bestAccuracyInCorrect[4]"></label></td>
                                      </tr>
                                      
                                    </tbody>
                               </table>
                        </div>
                         <div class="row">
                             <p id="modelRating[4]"><b>Model Rating : </b>
                             <p><small><0.5 poor, <0.7 fair, <0.85 good, >0.85 excellent</small></p>
                        </div>
                        </div>
                    </div>
				   </div>
				</div>

</div>

<!--  NEW Dynamic Recommendation Section 5 -->

<div  id="recModel5" class="row">
                <div class="col-lg-12">
                  <div class="panel panel-default">
                      <div class="panel-heading">
                           <a data-toggle="collapse" href="#collapse5"> <h3 class="panel-title"><i class="fa fa-long-arrow-right fa-fw"></i> Recommendation- MODEL 5</h3></a>
                      </div>
                      <br/>
                    <div id="collapse5" class="panel-collapse collapse">
                        <div class="panel-body">
                          <div class="row">
                            <table id="f1OptimisationTable" class="table table-bordered table-responsive table-striped">
                                    <thead>
                                      <tr>
                                        <th></th>
                                        <th>Optimal Threshold</th>
                                        <th>Maximised F1 Score</th>
                                        <th>True Positive Rate</th>
                                        <th>False Positive Rate</th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                      <tr>
	                                	   <td><b>F1Score Optimization</td>
                                           <td><label id="bestThresholdF1Score[5]"></label></td>
                                           <td><label id="bestF1Score[5]"></td>
                                           <td><label id="bestTPRF1Score[5]"></td>
                                           <td><label id="bestFPRF1Score[5]"></td>
                                      </tr>
                                            </tbody>
                               </table>
                               <table id="accuracyOptimisationTable" class="table table-bordered table-responsive table-striped">
                                    <thead>
                                      <tr>
                                        <th></th>
                                        <th>Optimal Threshold</th>
                                        <th>Maximised Accuracy</th>
                                        <th>Correct Classification(%)</th>
                                        <th>Incorrect Classification(%)</th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                      <tr>
                                        	<td><b>Accuracy Optimization</td>
                                            <td><label id="bestThresholdAccuracy[5]"></label></td>
                                            <td><label id="bestAccuracy[5]"></label></td>
                                            <td><label id="bestAccuracyCorrect[5]"></label></td>
                                            <td><label id="bestAccuracyInCorrect[5]"></label></td>
                                      </tr>
                                      
                                    </tbody>
                               </table>
                        </div>
                         <div class="row">
                             <p id="modelRating[5]"><b>Model Rating : </b>
                             <p><small><0.5 poor, <0.7 fair, <0.85 good, >0.85 excellent</small></p>
                        </div>
                        </div>
                    </div>
				   </div>
				</div>

</div>

<!-- Recommendation End  -->

<!-- Graph parametres -->

<div class="row">
                    <div class="col-lg-8">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-long-arrow-right fa-fw"></i> ROC Chart</h3>
                            </div>
                            <br/>
                            
                            <div class="panel-body">
                              <div class="row">
                                <div class="col-lg-3 col-sm-1"><label> <h5>Parameters: </label></div>
                                  <div class="col-xs-4 col-sm-2">
                                    <a class="btn btn-default btn-select" onclick="return loadParamSelection()"  >
                                      <input type="hidden" class="btn-select-input" id="" name="" value="" />
                                      <span  id="selected_param_value" class="btn-select-value">Select an Item</span>
                                      <span class='btn-select-arrow glyphicon glyphicon-chevron-down'></span>
                
                					<c:if test="${not empty GTMasterList}">
										<ul id="evalParamNameUL">	
										<c:forEach var="listValue" items="${GTMasterList}" varStatus="loopCount">
										  <c:if test="${loopCount.count eq 1}">
         										<li class="selected" value="${listValue}" >${listValue}</li>
        								  </c:if>
										  <c:if test="${!(loopCount.count eq 1)}">
         										<li value="${listValue}" >${listValue}</li>
        								  </c:if>
										</c:forEach>
										</ul>
									</c:if>                
                                     </a>
                                  </div>
                            </div>
                            
                            <input type="hidden" id="evalParamName" name="evalParamName" >
                            
                                     <div id="roc"> </div>
                            </div>
</div>
</div>

                    <div class="col-lg-4">
                    
                    <!-- Dynamic Summary Statistics -->
                    
                        <!-- Summary Model 1  -->
                        
                        <div id="sumModel1" class="panel panel-default">
                            <div class="panel-heading">
                                <a data-toggle="collapse" href="#summarycollapse1"> <h3 class="panel-title"><i class="fa fa-clock-o fa-fw"></i> Summary Statistics-MODEL 1</h3></a>
                            </div>
                            <div id="summarycollapse1" class="panel-collapse collapse">
                            <div class="panel-body">
                             <div class="row">
                                <div class="col-lg-3 col-sm-1"><label> <h5>Threshold: </label></div>
                                  <div class="col-lg-1 col-sm-2">
                                    <a class="btn btn-default btn-select"  onclick="return recalculate()">
                                      <input type="hidden" class="btn-select-input" id="" name="" value="" />
                                      <span id="selected_threshold_value1" class="btn-select-value"></span>
                                      <span class='btn-select-arrow glyphicon glyphicon-chevron-down'></span>
                
                                      <ul id="thresholdUL1">
                                          <li id="T1" value="0.1">0.1</li>
                                          <li id="T2" value="0.2">0.2</li>
                                          <li id="T3" value="0.3">0.3</li>
                                          <li id="T4" value="0.4">0.4</li>
                                          <li id="T15" class="selected" value="0.5" >0.5</li>
                                          <li id="T6" value="0.6">0.6</li>
                     					  <li id="T7" value="0.7">0.7</li>
                                          <li id="T8" value="0.8">0.8</li>
                     					  <li id="T9" value="0.9">0.9</li>
                                       </ul>
                                       
                                     </a>
                                  </div>
                            </div>
                                <div class="list-group">
                                
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="numberofcases[1]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Number of Cases
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge"  id="numberofcorrect[1]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Number Correct
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge"  id="correctpos[1]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Correct Positive Cases
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge"  id="correctneg[1]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Correct Negative Cases
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="accuracy[1]"></span>
                                        <i class="fa fa-fw fa-check"></i> <font color=blue> <b>Accuracy</b></font>
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="sensitivity[1]"></span>
                                        <i class="fa fa-fw fa-thermometer"></i> Sensitivity
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="specificity[1]"></span>
                                        <i class="fa fa-fw fa-sticky-note"></i> Specificity
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="precision[1]"></span>
                                        <i class="fa fa-fw fa-sticky-note"></i> Precision
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="f1score[1]"></span>
                                        <i class="fa fa-fw fa-sticky-note"></i> <font color=blue><b>F1 Score</b></font>
                                    </a>

                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="numberofpositivemissed[1]"></span>
                                        <i class="fa fa-fw fa-plus"></i> Positive Cases Missed
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="numberofnegativemissed[1]"></span>
                                        <i class="fa fa-fw fa-minus"></i> Negative Cases Missed
                                    </a>

                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="empiricrocarea[1]"></span>
                                        <i class="fa fa-fw fa-area-chart"></i> Empiric ROC area
                                    </a>
                                     
                                </div>
                               
                            </div>
                        </div>
                    </div>
                    

  <!-- Summary Model 2  -->
                        <div id="sumModel2" class="panel panel-default">
                            <div class="panel-heading">
                                <a data-toggle="collapse" href="#summarycollapse2"> <h3 class="panel-title"><i class="fa fa-clock-o fa-fw"></i> Summary Statistics-MODEL2</h3></a>
                            </div>
                            <div id="summarycollapse2" class="panel-collapse collapse">
                            <div class="panel-body">
                             <div class="row">
                                <div class="col-lg-3 col-sm-1"><label> <h5>Threshold: </label></div>
                                  <div class="col-lg-1 col-sm-2">
                                    <a class="btn btn-default btn-select"  onclick="return recalculate()">
                                      <input type="hidden" class="btn-select-input" id="" name="" value="" />
                                      <span id="selected_threshold_value2" class="btn-select-value"></span>
                                      <span class='btn-select-arrow glyphicon glyphicon-chevron-down'></span>
                
                                      <ul id="thresholdUL2">
                                          <li id="T1" value="0.1">0.1</li>
                                          <li id="T2" value="0.2">0.2</li>
                                          <li id="T3" value="0.3">0.3</li>
                                          <li id="T4" value="0.4">0.4</li>
                                          <li id="T25" class="selected" value="0.5" >0.5</li>
                                          <li id="T6" value="0.6">0.6</li>
                     					  <li id="T7" value="0.7">0.7</li>
                                          <li id="T8" value="0.8">0.8</li>
                     					  <li id="T9" value="0.9">0.9</li>
                                       </ul>

                                     </a>
                                  </div>
                            </div>
                                <div class="list-group">

                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="numberofcases[2]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Number of Cases
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge"  id="numberofcorrect[2]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Number Correct
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge"  id="correctpos[2]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Correct Positive Cases
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge"  id="correctneg[2]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Correct Negative Cases
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="accuracy[2]"></span>
                                        <i class="fa fa-fw fa-check"></i> <font color=blue> <b>Accuracy</b></font>
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="sensitivity[2]"></span>
                                        <i class="fa fa-fw fa-thermometer"></i> Sensitivity
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="specificity[2]"></span>
                                        <i class="fa fa-fw fa-sticky-note"></i> Specificity
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="precision[2]"></span>
                                        <i class="fa fa-fw fa-sticky-note"></i> Precision
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="f1score[2]"></span>
                                        <i class="fa fa-fw fa-sticky-note"></i> <font color=blue><b>F1 Score</b></font>
                                    </a>

                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="numberofpositivemissed[2]"></span>
                                        <i class="fa fa-fw fa-plus"></i> Positive Cases Missed
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="numberofnegativemissed[2]"></span>
                                        <i class="fa fa-fw fa-minus"></i> Negative Cases Missed
                                    </a>

                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="empiricrocarea[2]"></span>
                                        <i class="fa fa-fw fa-area-chart"></i> Empiric ROC area
                                    </a>
                                     
                                </div>
                               
                            </div>
                        </div>
                    </div>
                        


  <!-- Summary Model 3  -->
                        <div id="sumModel3"  class="panel panel-default">
                            <div class="panel-heading">
                                <a data-toggle="collapse" href="#summarycollapse3"> <h3 class="panel-title"><i class="fa fa-clock-o fa-fw"></i> Summary Statistics-MODEL 3</h3></a>
                            </div>
                            <div id="summarycollapse3" class="panel-collapse collapse">
                            <div class="panel-body">
                             <div class="row">
                                <div class="col-lg-3 col-sm-1"><label> <h5>Threshold: </label></div>
                                  <div class="col-lg-1 col-sm-2">
                                    <a class="btn btn-default btn-select"  onclick="return recalculate()">
                                      <input type="hidden" class="btn-select-input" id="" name="" value="" />
                                      <span id="selected_threshold_value3" class="btn-select-value"></span>
                                      <span class='btn-select-arrow glyphicon glyphicon-chevron-down'></span>
                
                                      <ul id="thresholdUL3">
                                          <li id="T1" value="0.1">0.1</li>
                                          <li id="T2" value="0.2">0.2</li>
                                          <li id="T3" value="0.3">0.3</li>
                                          <li id="T4" value="0.4">0.4</li>
                                          <li id="T35" class="selected" value="0.5" >0.5</li>
                                          <li id="T6" value="0.6">0.6</li>
                     					  <li id="T7" value="0.7">0.7</li>
                                          <li id="T8" value="0.8">0.8</li>
                     					  <li id="T9" value="0.9">0.9</li>
                                       </ul>
                                       
                                     </a>
                                  </div>
                            </div>
                                <div class="list-group">
                                
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="numberofcases[3]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Number of Cases
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge"  id="numberofcorrect[3]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Number Correct
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge"  id="correctpos[3]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Correct Positive Cases
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge"  id="correctneg[3]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Correct Negative Cases
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="accuracy[3]"></span>
                                        <i class="fa fa-fw fa-check"></i> <font color=blue> <b>Accuracy</b></font>
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="sensitivity[3]"></span>
                                        <i class="fa fa-fw fa-thermometer"></i> Sensitivity
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="specificity[3]"></span>
                                        <i class="fa fa-fw fa-sticky-note"></i> Specificity
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="precision[3]"></span>
                                        <i class="fa fa-fw fa-sticky-note"></i> Precision
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="f1score[3]"></span>
                                        <i class="fa fa-fw fa-sticky-note"></i> <font color=blue><b>F1 Score</b></font>
                                    </a>

                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="numberofpositivemissed[3]"></span>
                                        <i class="fa fa-fw fa-plus"></i> Positive Cases Missed
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="numberofnegativemissed[3]"></span>
                                        <i class="fa fa-fw fa-minus"></i> Negative Cases Missed
                                    </a>

                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="empiricrocarea[3]"></span>
                                        <i class="fa fa-fw fa-area-chart"></i> Empiric ROC area
                                    </a>
                                     
                                </div>
                               
                            </div>
                        </div>
                    </div>



  <!-- Summary Model 4  -->
                        <div id="sumModel4"  class="panel panel-default">
                            <div class="panel-heading">
                                <a data-toggle="collapse" href="#summarycollapse4"> <h3 class="panel-title"><i class="fa fa-clock-o fa-fw"></i> Summary Statistics-MODEL 4</h3></a>
                            </div>
                            <div id="summarycollapse4" class="panel-collapse collapse">
                            <div class="panel-body">
                             <div class="row">
                                <div class="col-lg-3 col-sm-1"><label> <h5>Threshold: </label></div>
                                  <div class="col-lg-1 col-sm-2">
                                    <a class="btn btn-default btn-select"  onclick="return recalculate()">
                                      <input type="hidden" class="btn-select-input" id="" name="" value="" />
                                      <span id="selected_threshold_value4" class="btn-select-value"></span>
                                      <span class='btn-select-arrow glyphicon glyphicon-chevron-down'></span>
                
                                      <ul id="thresholdUL4">
                                          <li id="T1" value="0.1">0.1</li>
                                          <li id="T2" value="0.2">0.2</li>
                                          <li id="T3" value="0.3">0.3</li>
                                          <li id="T4" value="0.4">0.4</li>
                                          <li id="T45" class="selected" value="0.5" >0.5</li>
                                          <li id="T6" value="0.6">0.6</li>
                     					  <li id="T7" value="0.7">0.7</li>
                                          <li id="T8" value="0.8">0.8</li>
                     					  <li id="T9" value="0.9">0.9</li>
                                       </ul>
                                       
                                     </a>
                                  </div>
                            </div>
                                <div class="list-group">
                                
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="numberofcases[4]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Number of Cases
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge"  id="numberofcorrect[4]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Number Correct
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge"  id="correctpos[4]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Correct Positive Cases
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge"  id="correctneg[4]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Correct Negative Cases
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="accuracy[4]"></span>
                                        <i class="fa fa-fw fa-check"></i> <font color=blue> <b>Accuracy</b></font>
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="sensitivity[4]"></span>
                                        <i class="fa fa-fw fa-thermometer"></i> Sensitivity
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="specificity[4]"></span>
                                        <i class="fa fa-fw fa-sticky-note"></i> Specificity
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="precision[4]"></span>
                                        <i class="fa fa-fw fa-sticky-note"></i> Precision
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="f1score[4]"></span>
                                        <i class="fa fa-fw fa-sticky-note"></i> <font color=blue><b>F1 Score</b></font>
                                    </a>

                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="numberofpositivemissed[4]"></span>
                                        <i class="fa fa-fw fa-plus"></i> Positive Cases Missed
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="numberofnegativemissed[4]"></span>
                                        <i class="fa fa-fw fa-minus"></i> Negative Cases Missed
                                    </a>

                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="empiricrocarea[4]"></span>
                                        <i class="fa fa-fw fa-area-chart"></i> Empiric ROC area
                                    </a>
                                     
                                </div>
                               
                            </div>
                        </div>
                    </div>

  <!-- Summary Model 5  -->
                        <div id="sumModel5" class="panel panel-default">
                            <div class="panel-heading">
                                <a data-toggle="collapse" href="#summarycollapse5"> <h3 class="panel-title"><i class="fa fa-clock-o fa-fw"></i> Summary Statistics-MODEL 5</h3></a>
                            </div>
                            <div id="summarycollapse5" class="panel-collapse collapse">
                            <div class="panel-body">
                             <div class="row">
                                <div class="col-lg-3 col-sm-1"><label> <h5>Threshold: </label></div>
                                  <div class="col-lg-1 col-sm-2">
                                    <a class="btn btn-default btn-select"  onclick="return recalculate()">
                                      <input type="hidden" class="btn-select-input" id="" name="" value="" />
                                      <span id="selected_threshold_value5" class="btn-select-value"></span>
                                      <span class='btn-select-arrow glyphicon glyphicon-chevron-down'></span>
                
                                      <ul id="thresholdUL5">
                                          <li id="T1" value="0.1">0.1</li>
                                          <li id="T2" value="0.2">0.2</li>
                                          <li id="T3" value="0.3">0.3</li>
                                          <li id="T4" value="0.4">0.4</li>
                                          <li id="T55" class="selected" value="0.5" >0.5</li>
                                          <li id="T6" value="0.6">0.6</li>
                     					  <li id="T7" value="0.7">0.7</li>
                                          <li id="T8" value="0.8">0.8</li>
                     					  <li id="T9" value="0.9">0.9</li>
                                       </ul>
                                       
                                     </a>
                                  </div>
                            </div>
                                <div class="list-group">

                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="numberofcases[5]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Number of Cases
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge"  id="numberofcorrect[5]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Number Correct
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge"  id="correctpos[5]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Correct Positive Cases
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge"  id="correctneg[5]"></span>
                                        <i class="fa fa-fw fa-comment"></i> Correct Negative Cases
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="accuracy[5]"></span>
                                        <i class="fa fa-fw fa-check"></i> <font color=blue> <b>Accuracy</b></font>
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="sensitivity[5]"></span>
                                        <i class="fa fa-fw fa-thermometer"></i> Sensitivity
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="specificity[5]"></span>
                                        <i class="fa fa-fw fa-sticky-note"></i> Specificity
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="precision[5]"></span>
                                        <i class="fa fa-fw fa-sticky-note"></i> Precision
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="f1score[5]"></span>
                                        <i class="fa fa-fw fa-sticky-note"></i> <font color=blue><b>F1 Score</b></font>
                                    </a>

                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="numberofpositivemissed[5]"></span>
                                        <i class="fa fa-fw fa-plus"></i> Positive Cases Missed
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="numberofnegativemissed[5]"></span>
                                        <i class="fa fa-fw fa-minus"></i> Negative Cases Missed
                                    </a>

                                    <a href="#" class="list-group-item">
                                        <span class="badge" id="empiricrocarea[5]"></span>
                                        <i class="fa fa-fw fa-area-chart"></i> Empiric ROC area
                                    </a>
                                     
                                </div>
                               
                            </div>
                        </div>
                    </div>

<!-- End of Dynamic Summary -->
                        
                    </div>
                    
                    
</div>
</div>
<!-- End of Sub Container 2 -->

<div class="row">
<div class="panel-footer">
IBM India SI Labs 2017
</div>
</div>
                 </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

<!-- Javascript Functions -->
<script>
var apiNameGlobal="";

var mark=[];
var labels=[];
var markSort=[];
var labSort=[];

var markSortList=['','','','','',''];
var labSortList=['','','','','',''];

var dTPR=[];  
var dFPR=[];
var auc=0.0; 

var total=0;
var tp=0;
var fp=0;          // True Positive and False Positive cases
var tn=0;
var fn=0;          // True Negative and False Negative cases

var paramType="";     // Holds selected Parameter Type

var rocColor=["blue","violet","green","red","orange"];
var model=[];

function loadDashboard(){
 document.getElementById("sub_container_1").style.display="none";
 document.getElementById("sub_container_2").style.display="none";
 //document.getElementById("file").innerHTML="";
}

function loadSelection(apiName){
   apiNameGlobal=apiName;
   var out="";
   
   var conversation,nlc,nlu=[];
   conversation = document.getElementsByClassName("panel-green"); 
   nlc = document.getElementsByClassName("panel-primary"); 
   nlu = document.getElementsByClassName("panel-yellow"); 
   
   //document.getElementById("servicelabel").innerHTML = "Service Name: " + apiName;
   document.getElementById("serviceName").value = apiName;
   document.getElementById("config").value = "1";
   
   document.getElementById("sub_container_1").style.display="block";
    if(apiName=="Conversation"){
	   $('#attr_span').html("Intents");
   		$('#attr_list').html(out);

        document.getElementById("evalParam").value = "Intents";  
        document.getElementById("attr").style.display="block";
        
        conversation[0].style.boxShadow = "10px 20px 30px black"; 
        conversation[0].style.border = "1px"; 
        nlc[0].style.boxShadow = ""; 
        nlc[0].style.border = "";
        nlu[0].style.boxShadow = ""; 
        nlu[0].style.border = "";  
        
    }
    else if(apiName=="NLC"){
	   $('#attr_span').html("Classes");
   		$('#attr_list').html(out);

        document.getElementById("evalParam").value = "Classes";  
       document.getElementById("attr").style.display="block";
       
       nlc[0].style.boxShadow = "10px 20px 30px black"; 
       nlc[0].style.border = "1px"; 
       conversation[0].style.boxShadow = ""; 
       conversation[0].style.border = ""; 
       nlu[0].style.boxShadow = ""; 
       nlu[0].style.border = ""; 
       
    }
    else if(apiName=="NLU"){
       document.getElementById("evalParam").value = "Concepts";
       document.getElementById("attr").style.display="none";
       
       nlu[0].style.boxShadow = "10px 20px 30px black"; 
       nlu[0].style.border = "1px"; 
       conversation[0].style.boxShadow = ""; 
       conversation[0].style.border = ""; 
       nlc[0].style.boxShadow = ""; 
       nlc[0].style.border = "";
    }
   
    return true;
}

function loadConfigSelection(){
   $('#config_list li').on('click', function(){
   configType=($(this).text());
}); 
   return true;
}

function loadROC(){
    
     if ($("#config_list input:checkbox:checked").length > 0)
      {
       for(var i=0;i<$("#config_list input:checkbox:checked").length;i++){
           model[i]=$("#config_list input:checkbox:checked")[i].value;
       }
       }
     else
       {
   // none is checked
        }
     document.getElementById("sub_container_2").style.display="block";
     //drawRoc();
     //return true;
}

function loadParamSelection(){
   var prevVal=$('#selected_param_value').text();
   $('#evalParamNameUL li').on('click', function(){
   		paramType=($(this).text());
	}); 
    //alert("prevVal: "+ prevVal + " paramType: "+ paramType);
   if((paramType!=prevVal) && paramType.length>0){
   
     $('#thresholdUL1 li').removeClass('selected');
     $('#T15').addClass('selected');
     $('#selected_threshold_value1').html("0.5");

     $('#thresholdUL2 li').removeClass('selected');
     $('#T25').addClass('selected');
     $('#selected_threshold_value2').html("0.5");

     $('#thresholdUL3 li').removeClass('selected');
     $('#T35').addClass('selected');
     $('#selected_threshold_value3').html("0.5");

     $('#thresholdUL4 li').removeClass('selected');
     $('#T45').addClass('selected');
     $('#selected_threshold_value4').html("0.5");

     $('#thresholdUL5 li').removeClass('selected');
     $('#T55').addClass('selected');
     $('#selected_threshold_value5').html("0.5");
    
    }
    return true;
}

</script>

<script>
$(document).ready(function () {
    $(".btn-select").each(function (e) {
        var value = $(this).find("ul li.selected").html();
        if (value != undefined) {
            $(this).find(".btn-select-input").val(value);
            $(this).find(".btn-select-value").html(value);
        }
    });
});

$(document).on('click', '.btn-select', function (e) {
    e.preventDefault();
    var ul = $(this).find("ul");
    if ($(this).hasClass("active")) {
        if (ul.find("li").is(e.target)) {
            var target = $(e.target);
            target.addClass("selected").siblings().removeClass("selected");
            var value = target.html();
            $(this).find(".btn-select-input").val(value);
            $(this).find(".btn-select-value").html(value);
        }
        ul.hide();
        $(this).removeClass("active");
    }
    else {
        $('.btn-select').not(this).each(function () {
            $(this).removeClass("active").find("ul").hide();
        });
        ul.slideDown(300);
        $(this).addClass("active");
    }
});

$(document).on('click', function (e) {
    var target = $(e.target).closest(".btn-select");
    if (!target.length) {
        $(".btn-select").removeClass("active").find("ul").hide();
    }
});

// Multiple files upload
   $(document)
            .ready(
                    function() {
                        //add more file components if Add is clicked
                        $('#addFile')
                                .click(
                                        function() {
                                            var fileIndex = $('#fileTable tr')
                                                    .children().length;
                                            $('#fileTable')
                                                    .append(
                                                            '<tr><td>'
                                                                    + '   <input type="file" name="files['+ fileIndex +']" />'
                                                                    + '</td></tr>');
                                        });
 
                    });

// Multiple files upload




</script>
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
    .interpolate("linear");  // basis linear basis-open cardinal cardinal-open monotone

var voronoi = d3.geom.voronoi()
		.x(function(d){ return x(d.fpr);})
		.y(function(d){ return y(d.tpr);})
	    .clipExtent([[-2, -2], [width + 2, height + 2]]);
var svg = d3.select("#roc").append("svg")
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
    
<c:if test="${not empty GTMasterList}">
    //alert("not empty GT call ");
    var serviceName = "${serviceName}" ; 
   //alert(serviceName);
    loadSelection(serviceName);
	loadROC();
    var map = ${ROCDataMap} ;
    //alert("map "+map);
    
    var models =   ${models} ;
    //alert("models "+ models);
    //var modelconfig = JSON.parse("[" + models + "]");
    
    //alert(modelconfig);
    
    <c:forEach var="paramList" items="${GTMasterList}" end="0">
      var sParamVal = '<c:out value="${paramList}" />'   ; 
      //alert("sParamVal CHG 111 " + sParamVal);
      //draw(svg, map, sParamVal);
      
      $('#recModel1').hide();
      $('#sumModel1').hide();

      $('#recModel2').hide();
      $('#sumModel2').hide();

      $('#recModel3').hide();
      $('#sumModel3').hide();

      $('#recModel4').hide();
      $('#sumModel4').hide();

      $('#recModel5').hide();
      $('#sumModel5').hide();
      

      
      for(var i=0;i<models.length;i++){
    		draw(svg, map, sParamVal,models[i]);
    		$("#config_list input:checkbox")[models[i]-1].checked = true;
    		
           $('#recModel'+models[i]).show();
           $('#sumModel'+models[i]).show();
    		
    		
	  }
	</c:forEach>
 </c:if>




//Assign the value
$("#evalParamNameUL li").click(function(){
    $("#evalParamName").val($(this).attr("value"));
    var evalParameter = $(this).attr("value");
    svg.selectAll("path.line").remove();    // for multimodel
    //draw(svg, map, evalParameter);
     for(var i=0;i<models.length;i++){
    		draw(svg, map, evalParameter,models[i]);
	  }
    
});

//Assign the value

$("#thresholdUL1 li").click(function(){
    var thresholdVal = $(this).attr("value");
    displaySummaryStats(markSortList[1],labSortList[1],thresholdVal,1);
});

$("#thresholdUL2 li").click(function(){
    var thresholdVal = $(this).attr("value");
    displaySummaryStats(markSortList[2],labSortList[2],thresholdVal,2);

});

$("#thresholdUL3 li").click(function(){
    var thresholdVal = $(this).attr("value");
    displaySummaryStats(markSortList[3],labSortList[3],thresholdVal,3);

});

$("#thresholdUL4 li").click(function(){
    var thresholdVal = $(this).attr("value");
    displaySummaryStats(markSortList[4],labSortList[4],thresholdVal,4);

});

$("#thresholdUL5 li").click(function(){
    var thresholdVal = $(this).attr("value");
    displaySummaryStats(markSortList[5],labSortList[5],thresholdVal,5);

});

$("#configUL li").click(function(){
    $("#config").val($(this).attr("value"));
});

// Draw Function 

function draw(svg, map, evalparam,model){
	//var slabels = map['GT_' + evalparam];
	//var smark = map['RS_' + evalparam]; 
	//alert("model==" + model);
	var color = rocColor[model];
	//alert("color= " + color);
	
	
	var slabels = map['CONFIG_' + model + '_' + 'GT_' + evalparam];
	var smark = map['CONFIG_' + model + '_' + 'RS_' + evalparam]; 
	
	//alert("smark = "+smark);
	//alert("slabels = "+ slabels); 
	
	labels = JSON.parse(slabels);
	mark = JSON.parse(smark); 

	//alert("mark = "+mark);
	//alert("labels = "+ labels);    
	    
	total = labels.length;
	
	function compareNumbers(a, b)
	{
	    return a - b;
	}
	markSort = mark.slice(0).sort(compareNumbers);                               // changes
	
	labSort = [];    
	var oneDex = [];
	var zeroDex = [];
	for(var i = 0; i < markSort.length; i++){
	    var cranker = labels[mark.indexOf(markSort[i])] ;
	    labSort.push(cranker);   
	    if(parseInt(cranker) == 1){
	        oneDex.push(i);
	    } else {
	        zeroDex.push(i);
	    }
	}
	
	markSortList[model] = markSort;
	labSortList[model]  = labSort;

	displaySummaryStats(markSort,labSort,0.5,model);
	
	//alert("markSort " + markSort);
	//alert("labSort " + labSort);
	//alert("POS " + oneDex.length);
	//alert("NEG " + zeroDex.length);
	
	var bestThreshold = 0.0;
	//var minDistance = 2.0;
	
	var bestThresholdF1Score = 0;
	var bestF1Score = 0.0;
	var bestTPRF1Score = 0.0;
	var bestFPRF1Score = 0.0;
	
	var bestThresholdAccuracy = 0;
	var bestAccuracy = 0.0;
	var bestAccuracyIncorrect = 0.0;
	
	var tempTPR = 0;
	var tempFPR = 0;
	var tempF1Score = 0;
	var tempAccuracy = 0;
	
	var cutoff = 0;
	var rating = "Unknown"; 

for(var i =1; i<10; i++) {
    cutoff = i/10;
    
    //distance = calcDistance(tempFPR,tempTPR);
   	calculate(markSort,labSort,cutoff);
	tempF1Score = (2*tp)/((2*tp)+fp+fn);
	tempAccuracy = (tp+tn)/total;

/*
    if (distance <= minDistance ) {
		//alert("MinDistance= " + minDistance + " bestThreshold= " + cutoff);
     	minDistance = distance;
     	bestThreshold = cutoff;
    }
*/    
    if (tempF1Score >= bestF1Score ) {
     	bestF1Score = tempF1Score;
     	bestThresholdF1Score = cutoff;
     	//alert("bestF1Score= " + bestF1Score + " bestThresholdF1Score= " + bestThresholdF1Score);
    }
    if (tempAccuracy >= bestAccuracy ) {
     	bestAccuracy = tempAccuracy;
     	bestThresholdAccuracy = cutoff;
     	//alert("bestAccuracy= " + bestAccuracy + " bestThresholdAccuracy= " + bestThresholdAccuracy);
    }
}

	//bestThreshold = Math.round(bestThreshold*10)/10 ;
	
	bestThresholdAccuracy = Math.round(bestThresholdAccuracy*10)/10 ;
	bestAccuracyIncorrect = parseFloat((1-bestAccuracy)*100).toFixed(2);
	bestAccuracy = parseFloat(bestAccuracy*100).toFixed(2);

	bestThresholdF1Score = Math.round(bestThresholdF1Score*10)/10 ;
	bestF1Score = parseFloat(bestF1Score*100).toFixed(2);
	bestTPRF1Score = parseFloat(calcTPR(oneDex, labSort, markSort, bestThresholdF1Score)).toFixed(2);
   	bestFPRF1Score = parseFloat(calcFPR(oneDex, labSort, markSort, bestThresholdF1Score)).toFixed(2);

    //rating = calcRating(minDistance);
    //alert("Rating: " + rating);
		
	document.getElementById("bestThresholdF1Score[" + model +"]").innerHTML="<h5>" + bestThresholdF1Score + "</h5>"; 
	document.getElementById("bestF1Score[" + model +"]").innerHTML="<h5>" + bestF1Score + "%" +  "</h5>"; 
	document.getElementById("bestTPRF1Score[" + model +"]").innerHTML="<h5>" + bestTPRF1Score + "</h5>"; 
	document.getElementById("bestFPRF1Score[" + model +"]").innerHTML="<h5>" + bestFPRF1Score + "</h5>"; 

	document.getElementById("bestAccuracy[" + model +"]").innerHTML="<h5>" + bestAccuracy + "%"  + "</h5>"; 
	document.getElementById("bestThresholdAccuracy[" + model +"]").innerHTML="<h5>" + bestThresholdAccuracy + "</h5>"; 
	document.getElementById("bestAccuracyCorrect[" + model +"]").innerHTML="<h5>" + bestAccuracy + "%"  + "</h5>"; 
	document.getElementById("bestAccuracyInCorrect[" + model +"]").innerHTML="<h5>" + bestAccuracyIncorrect + "%"  + "</h5>"; 
	
	
	//document.getElementById("bestThreshold").innerHTML=bestThreshold; 
    //alert("Final MinDistance= " + minDistance + " bestThreshold= " + bestThreshold);
    //alert("Final bestAccuracy= " + bestAccuracy + " bestThresholdAccuracy= " + bestThresholdAccuracy);
    //alert("Final bestF1Score= " + bestF1Score + " bestThresholdF1Score= " + bestThresholdF1Score);

var data = [];
 
for(var i =0; i<markSort.length; i++) {
    data.push({"tpr": calcTPR(oneDex, labSort, markSort, markSort[i]),          // changes
     "fpr": calcFPR(oneDex, labSort, markSort, markSort[i]),                   // changes
     "cut": markSort[i]});
}
 
	var tess = voronoi(data);
	for(var i = 0; i < data.length; i++){
		data[i].vtess = tess[i];
		//alert("data[i].fpr=" + data[i].fpr);
		//alert("data[i].tpr=" + data[i].tpr);
	} 

//svg.selectAll("path.line").remove();    // for multimodel
  svg.append("path")
      .attr("class", "line")
      .attr("d", line(data))
      .style('stroke', color);
      
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
        .style('stroke', color);

    //cell.select("path").attr("d", function(d) { return "M" + d.vtess.join("L") + "Z"; });   
	
	cellEnter.append("text").attr("class", "hidetext")
	    .attr("x", function(d) { return x(d.fpr) + 10; })
	    .attr("y", function(d) { return y(d.tpr) + 10; })
	    .text(function(d) { return "Threshold: " + Math.round(d.cut*10)/10 ;  });


	function compareMapKeys(a, b)
	{
    	return a.fpr - b.fpr;
	}

	
	data = data.sort(compareMapKeys);
	/*
	for(var i = 0; i < data.length; i++){
		alert("datasort[i].fpr=" + data[i].fpr);
		alert("data[i].tpr=" + data[i].tpr);
	} 
   */
	auc=calcAUC(data);
	//alert("auc=" + auc);

	document.getElementById("empiricrocarea[" + model +"]").innerHTML=parseFloat(auc).toFixed(2);       

	document.getElementById("modelRating[" + model +"]").innerHTML="";
	
	if (auc > 0 && auc<=0.5){ 
		document.getElementById("modelRating[" + model +"]").innerHTML='<b>Model Rating : "Poor"';
	} else if (auc<=0.7 && auc> 0.5 ) {
		document.getElementById("modelRating[" + model +"]").innerHTML='<b>Model Rating : "Fair"';
	} else if(auc<=0.85 && auc> 0.7) {
		document.getElementById("modelRating[" + model +"]").innerHTML='<b>Model Rating : "Good"';
	} else if (auc>0.85) {
		document.getElementById("modelRating[" + model +"]").innerHTML='<b>Model Rating : "Excellent"';
	}

	
}    


function calcDistance(x,y){
    distance = Math.sqrt(x*x+(1-y)*(1-y)) ;
    return distance;
}

/*
function calcRating(minDistance)
{
  if ( minDistance >= 0.69) {    // 0.5
     rating = "Poor";  
  } else if ( minDistance >= 0.56 && minDistance < 0.69  ) {  // 0.4
     rating = "Weak";  
  } else if ( minDistance >= 0.42 && minDistance < 0.56  ) {  // 0.3
     rating = "Marginal";  
  } else if ( minDistance >= 0.28 && minDistance < 0.42  ) {  // 0.2
     rating = "Fair";  
  } else if ( minDistance >= 0.14 && minDistance < 0.28  ) {  // 0.1
     rating = "Good";
  } else if ( minDistance >= 0 && minDistance < 0.14  ) {  // 0
     rating = "Excellent"; 
  } 
    return rating;
}
*/
    
function calcTPR(oneDex,labSort,markSort, m){
    var TPR = 0;
	var TP = 0;
    for(var i = 0; i < markSort.length; i++){
       if ( (parseFloat(markSort[i]) >= parseFloat(m)) && (parseInt(labSort[i]) == 1)  ) {
           TP = TP + 1 ;
		   // alert("compare marks--> " + markSort[i] + " >=   " + m);
       }
    }
	TPR = (TP/oneDex.length);
	dTPR.push(TPR);
    return TPR;
}
    
function calcFPR(oneDex,labSort, markSort, m){
    var FPR = 0;
    var FP = 0;
    for(var i = 0; i < markSort.length; i++){
       if ( (parseFloat(markSort[i]) >= parseFloat(m)) && (parseInt(labSort[i]) == 0)  ) {
		   FP = FP + 1 ;
       }
    }
    FPR = (FP/oneDex.length);
    dFPR.push(FPR);
    return FPR;
} 


function calcAUC(data){
    var area = 0.0;
	for(var i = 0; i < data.length-1; i++){
		area += ( ( data[i+1].tpr + data[i].tpr ) / 2) * ( data[i+1].fpr - data[i].fpr);
	} 

    return area;
}  


function displaySummaryStats(markSortArg,labSortArg,cutoff,model){

   calculate(markSortArg,labSortArg,cutoff);
   //Fill number of correct cases
   document.getElementById("numberofcases[" + model +"]").innerHTML=tp+tn+fp+fn;       

   document.getElementById("numberofcorrect[" + model +"]").innerHTML=tp+tn;
   document.getElementById("correctpos[" + model +"]").innerHTML=tp;
   document.getElementById("correctneg[" + model +"]").innerHTML=tn;
   document.getElementById("accuracy[" + model +"]").innerHTML=parseFloat((((tp+tn)/total)*100)).toFixed(2)+"%";
   document.getElementById("sensitivity[" + model +"]").innerHTML=parseFloat(((tp/(tp+fn))*100)).toFixed(2)+"%";
   document.getElementById("specificity[" + model +"]").innerHTML=parseFloat(((tn/(tn+fp))*100)).toFixed(2)+"%";
   document.getElementById("precision[" + model +"]").innerHTML=parseFloat(((tp/(tp+fp))*100)).toFixed(2)+"%";
   document.getElementById("f1score[" + model +"]").innerHTML=parseFloat((((2*tp)/((2*tp)+fp+fn))*100)).toFixed(2)+"%";
   document.getElementById("numberofpositivemissed[" + model +"]").innerHTML=fn;
   document.getElementById("numberofnegativemissed[" + model +"]").innerHTML=fp;
} 


function calculate(mark,labels,cutoff){
	tp=0;
	fp=0;          
	tn=0;
	fn=0;   
  for(var i = 0; i < mark.length; i++){
     if ( parseFloat(mark[i]) >= parseFloat(cutoff)  ) {
          if (  parseInt(labels[i]) ==1 ) {
             tp+=1;
          } else {
             fp+=1;
          }
     } else if ( parseFloat(mark[i]) < parseFloat(cutoff)  ) {
          if (  parseInt(labels[i]) ==1 ) {
             fn+=1;
          } else {
             tn+=1;
          }
     }
  }
  
}      



</script>

</body>
</html>