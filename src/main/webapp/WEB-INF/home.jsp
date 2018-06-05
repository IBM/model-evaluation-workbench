<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Watson Model Evaluation Workbench 2</title>
</head>
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


</style>
<body onload="loadDashboard()">
<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="js/d3.v3.min.js"></script>
<script src="rocChart.js"></script>
<link rel="stylesheet" type="text/css" href="js/bootstrap-3.3.7-dist/css/bootstrap.min.css"></link>
<link rel="stylesheet" type="text/css" href="css/select.css"></link>
<link href="css/admin.css" rel="stylesheet">
<link href="css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<div id="wrapper">
             
  <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <!-- Top Menu Items -->
            <ul class="nav navbar-right top-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> John Smith <b class="caret"></b></a>
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
                        <a href="dashboard"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
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
                            <img src="img/IBM-logo-blue.png" style="width:10%;"alt='Logo' />Watson Model Evaluation Workbench <small>Introduction</small>
                        </h1>
                       
                    </div>
                </div>
            <div class="row">
                    <div class="col-lg-12">
                    
                     <p>The Watson Model Evaluation Workbench provide users a platform to configure, execute and test user's cognitive model for tool's supported Watson cognitive services, prepare performance evaluation data and calculates performance statistics such as confusion matrix and ROC curve.</p>
                    </div>
            </div>  
            <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-bar-chart-o fa-fw"></i>  <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne"> Details </a></h3>
                            </div>
                             <div id="collapseOne" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div class="row">
                                   <ol class="list-group">
				                        <li class="list-group-item"> 
				                         <p> <b> Watson Model Evaluation Workbench for model performance evaluation </b>
                                                   <p> Cognitive systems are not programmed and they perform as per the data on which they are trained on; to sense, predict, infer, and in some ways, think, using artificial intelligence and machine learning algorithms. </p>
                                                   <p> IBM Watson Model Evaluation Workbench provide performance evaluation of machine learning models. It provides end to end solution by providing option to configure, execute & test user's cognitive model for the supported Watson cognitive service, prepare performance evaluation data and display model performance statistics. <p>
                                                   <p> In Watson Model Evaluation Workbench, User can upload the Test data with the ground truth for their supported Watson cognitive service and it will execute the corresponding Watson cognitive service, prepare evaluation data and display performance statistics such as confusion matrix and roc charts.</p>
                                                   <p>These statistics can be used for fine tuning model's parameters and selecting the best-performing model.</p>
                                            </p>
                                        </li>
                                      <li class="list-group-item"> 
				                         <p> <b>Receiver Operating Characteristic (ROC) Curve </b>
                                                   <p> The ROC curve provide a means of comparison between classification models. The ROC curve shows false positive rate (1-specificity) on X-axis,  against true positive rate (sensitivity) on Y-axis. If curve climb quickly toward the top-left corner then it means the model correctly predicted the cases. The diagonal line is for a random prediction by the model. </p>
                                                 </p>
                                        </li>
                                      <li class="list-group-item"> 
				                         <p> <b>Area Under the Curve (AUC) </b>
                                                   <p> Area under receiver operating characteristic (ROC) curve is often used as a measure of quality of the classification models. A random classifier has an area under the curve of 0.5, while AUC for a perfect classifier is equal to 1. The change in the probability (e.g. confidence) cut-off threshold has impact on machine learning model performance. For best performance, the ROC curve will reach the upper left corner of the plot and the probability threshold close to upper left will yield best performance for cognitive model. </p>
                                                 </p>
                                        </li>
                                    <li class="list-group-item"> 
				                         <p> <b>Confusion Matrix</b>
                                                   <p> A confusion matrix shows the number of correct and incorrect predictions made by the classification model compared to the actual outcomes (target value) in the data. Following parameters are shown in the confusion matrix.  </p>
                                                   <p>Accuracy: the proportion of the total number of predictions that were correct.</p>
                                                   <p> Positive Predictive Value or Precision: the proportion of positive cases that were correctly identified.</p>
                                                   <p>Negative Predictive Value: the proportion of negative cases that were correctly identified. </p>
                                                   <p>Sensitivity or Recall: the proportion of actual positive cases which are correctly identified. </p>
                                                   <p>Specificity: the proportion of actual negative cases which are correctly identified. </p>
                                                 </p>
                                        </li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            
            
            
        <div>
            
            <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-bar-chart-o fa-fw"></i> <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo"> Watson Service's Configuration in Application </a></h3>
                            </div>
                            <div id="collapseTwo" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div class="row">
                                   <ol class="list-group">
                                       <li class="list-group-item">
                                           <p> <b>Watson Service's Configuration:</b><br>
                                                  Administrator need to configure the supported Watson Service's access/authentication details in Watson Model Evaluation Workbench application. 
                                                  <br>The Watson Service's access details need to be configured as application's user defined variables in Bluemix as below. <br>e.g.<br> 
                                                  &nbsp;&nbsp;CONVERSATION_WORKSPACE_ID_CONFIG_1 = &lt;workspaceid&gt; <br>
	  											  &nbsp;&nbsp;CONVERSATION_USERNAME_CONFIG_1     = &lt;username &gt; <br>
	  											  &nbsp;&nbsp;CONVERSATION_PASSWORD_CONFIG_1     = &lt; password&gt;<br>
											</p>
											<p>
											If User need to configure multiple CONVERSATION service then CONFIG_2 or CONFIG_3 can be configured as Bluemix user defined variables as below:<br>
												  &nbsp;&nbsp;CONVERSATION_WORKSPACE_ID_CONFIG_2 = &lt;workspaceid&gt;<br>
	  											  &nbsp;&nbsp;CONVERSATION_USERNAME_CONFIG_2     = &lt;username &gt;<br>
	  											  &nbsp;&nbsp;CONVERSATION_PASSWORD_CONFIG_2     = &lt; password&gt;<br>	
	  										</p>
	  										<p>
	  										Application Dashboard screen provide user an option to select the watson service configuration (e.g. "CONFIG 1", "CONFIG 2" etc.) to choose their choice of Watson service against which they want to evaluate their ML model.
                                           </p>
                                        </li>

				                        <li class="list-group-item">
                                           <p> <b> IBM Watson Conversation(Intent): </b>
                                                    Model Test Data format: Collect the intents and examples into a CSV file in required format for each line in the file is as follows:&lt;example&gt;,&lt;intent&gt;
                                            </p>
                                        </li>
                                       <li class="list-group-item">
                                           <p> <b>IBM Watson NLC (class);</b>
                                                  Model Test Data format: Collect the classes and examples into a CSV file in required format for each line in the file is as follows:&lt;example&gt;,&lt;class&gt;

                                           </p>
                                        </li>
                                       <li class="list-group-item">
                                           <p> <b>IBM Watson NLU:</b>
                                                  Collect the concepts, keywords and entities model test examples into a json file as below format. 
<small> <br/> 
{                                                  <br/>
  "input_url": "https://www.wsj.com/news/markets", <br/>
  "concepts": [                                    <br/>
    {                                              <br/>
      "text": "Wells Fargo",                       <br/>
    }                                              <br/>
   ],                                              <br/>
  "entities": [                                    <br/>
    {                                              <br/>
      "text": "The Wall Street Journal",           <br/>
    }                                              <br/>
  ],                                               <br/>
  "keywords": [                                    <br/>
    {                                              <br/>
      "text": "Wall Street Journal",               <br/>
    }                                              <br/>
  ]                                                <br/>
}                                                  <br/>
                                       </small>
                                       </li>
                                       

                                       
                                    </ol>
   
                              </div>
                          </div>
                    </div>
                </div>
            </div>
      </div>      
           

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
