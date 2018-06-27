# Cognitive Model Evaluation

This code pattern details about the Watson Model Evaluation Workbench which provides user a platform to configure, execute and test user's cognitive model for tool's supported Watson cognitive services, prepare performance evaluation data and calculates performance statistics such as confusion matrix and ROC curve.
By the end of this code pattern reading, one will be able to:

To compare their different Watson cognitive service’s models and selecting the threshold and best-performing machine learning model.

User can configure their Watson cognitive service access details in workbench and input their model test data to workbench for service performance evaluation.

Workbench execute supported Watson cognitive services with their input model’s test data, prepare performance evaluation data, calculates performance statistics and present user with the following recommendations, curve and summary statistics:
o	Recommendations: 
	Optimal threshold and maximized F1Score for F1Score optimization
	Optimal threshold and maximized Accuracy for Accuracy optimization
Receiver Operating Characteristic (ROC) curve

## Architecture Diagram:
![](/Images/Reference_Architecture.png)

- Details
1. User uses the client device(mobile, tablets, etc.,) to access the application.
2. Client Invokes the URL. 
3. Parsing Input test data.
4. Invoke adapter which calls the Cognitive service models(NLC, NLU, etc.,)
5. Parsing the Cognitive(model) service configuration.
6. Connect to Cognitive model services.
7. Gets response from Cognitie services.
8. Compares Input data with cognitive model results and do performance evaluation(ROC Curve, etc.)
9. Performance analysis is shown on UI.
10. User consumes the performance analysis results.

[Watson Model Evaluation Workbench](https://workbenchmodelevalpattern.au-syd.mybluemix.net/) through the URL https://workbenchmodelevalpattern.au-syd.mybluemix.net/

# Included Components
1. Java Liberty Run Time
2. Java Stastical Libraries
3. Cognitive Services
 - Natural Language Classifier
 - Natural Language Understanding
 - Watson Assistant
 


# Featured Technologies

* [Liberty for Java](https://console.bluemix.net/docs/runtimes/liberty/index.html#liberty_runtime):
Develop, deploy, and scale Java web apps with ease. IBM WebSphere Liberty Profile is
a highly composable, ultra-fast, ultra-light profile of IBM WebSphere Application Server
designed for the cloud.

* J2EE: A secure Object-oriented programming language, used to build applications. IBM WebSphere Commerce platform is built on J2EE framework which includes (JSP, Java, Java Script, Struts, REST & Webservices, EJBs)

# Watch The Video








## Steps

## 1 - Pre-requisites
## 2 - Deploying Application on IBM Cloud
## 3 - Develop the models
## 4 - Running the application/Model Evaluation
## 5 - Analyze the Results


### 1 - Pre-requisites
* Clone the GIT repository.
* Have an IBM Cloud account. If NOT, you can create an account [here](https://console.bluemix.net/).

### 2 - Deploying Application on IBM Cloud
Two ways to Deploy:
* 2.1 Deploy using "Deploy to IBM Cloud" Button
* 2.2 Manual deploy to IBM Cloud
   * Clone the repository 
   * Follow the below steps to generate war file and deploy in IBM bluemix
 
  -2.1 Deploy to IBM Cloud using "Deploy to Cloud" Button.
Click `Deploy to IBM Cloud` button above to deploy the application to IBM Cloud. You would
be presented with a toolchain view and asked to "Deploy" the application. Go ahead and
click `Deploy` button. The application should get deployed. Ensure that the application
is started and that a service is created and bound to the application just deployed. <br/>
[![Deploy to IBM Cloud](https://bluemix.net/deploy/button.png)](https://bluemix.net/deploy?repository=https://github.com/IBM/model-evaluation-workbench.git)

##### 3.1.2 Deploy using Manual


#### 3.1 Deploy Java Liberty application to IBM Cloud
You can deploy the Java Liberty application using the `Deploy to IBM Cloud` button or
using manual steps.

Follow these steps to setup and run this developer pattern. The steps are described in detail below.


This project contains a simple servlet application.

[![Deploy to Bluemix](https://bluemix.net/deploy/button.png)](https://bluemix.net/deploy?repository=https://github.ibm.com/muralidhar-chavan/cognitive-model-evaluation-workbench.git)

## Running the application

This project can be built with [Apache Maven](http://maven.apache.org/). The project uses [Liberty Maven Plug-in][] to automatically download and install Liberty from the [Liberty repository](https://developer.ibm.com/wasdev/downloads/). Liberty Maven Plug-in is also used to create, configure, and run the application on the Liberty server. 

Use the following steps to run the application locally:

1. Execute full Maven build to create the `target/JavaHelloWorldApp.war` file:
    ```bash
    $ mvn clean install
    ```

2. Download and install Liberty, then use it to run the built application from step 1:
    ```bash
    $ mvn liberty:run-server
    ```

    Once the server is running, the application will be available under [http://localhost:9080/JavaHelloWorldApp](http://localhost:9080/JavaHelloWorldApp).

Use the following command to run the built application in Bluemix:
    ```bash
    $ cf push <appname> -p target/JavaHelloWorldApp.war
    ```
## Developing and Deploying using Eclipse

IBM® Eclipse Tools for Bluemix® provides plug-ins that can be installed into an existing Eclipse environment to assist in integrating the developer's integrated development environment (IDE) with Bluemix.

1. Download and install  [IBM Eclipse Tools for Bluemix](https://developer.ibm.com/wasdev/downloads/#asset/tools-IBM_Eclipse_Tools_for_Bluemix).

2. Import this sample into Eclipse using `File` -> `Import` -> `Maven` -> `Existing Maven Projects` option.

3. Create a Liberty server definition:
  - In the `Servers` view right-click -> `New` -> `Server`
  - Select `IBM` -> `WebSphere Application Server Liberty`
  - Choose `Install from an archive or a repository`
  - Enter a destination path (/Users/username/liberty)
  - Choose `WAS Liberty with Java EE 7 Web Profile`
  - Continue the wizard with default options to Finish

4. Run your application locally on Liberty:
  - Right click on the `JavaHelloWorldApp` sample and select `Run As` -> `Run on Server` option
  - Find and select the localhost Liberty server and press `Finish`
  - In a few seconds, your application should be running at http://localhost:9080/JavaHelloWorldApp/

5. Create a Bluemix server definition:
  - In the `Servers` view, right-click -> `New` -> `Server`
  - Select `IBM` -> `IBM Bluemix` and follow the steps in the wizard.\
  - Enter your credentials and click `Next`
  - Select your `org` and `space` and click `Finish`

6. Run your application on Bluemix:
  - Right click on the `JavaHelloWorldApp` sample and select `Run As` -> `Run on Server` option
  - Find and select the `IBM Bluemix` and press `Finish`
  - A wizard will guide you with the deployment options. Be sure to choose a unique `Name` for your application
  - In a few minutes, your application should be running at the URL you chose.

## Next Step

# 3. Develop the Models:

Develop the Sample Natural Language Classifier which we will use for Model Evaluation.

###### 3.1 Create NLC service instance
- Step1: Click [here](https://console.bluemix.net/catalog/services/natural-language-classifier)
to create NLU service
- Step2: Below screen is displayed
  <br/><img src="Images/NLC_CreateDefault.png" alt="NLC_CreateDefault" width="640" border="10" /><br/><br/>
- Step3: Edit the field "Service name:" to say NLC_Model_Eval and leave the other settings default.
  Click `Create` and then take a note of the credentials as below:
  <br/><img src="Images/NLC_Credentials.png" alt="NLUCreateEdit" width="640" border="10" /><br/><br/>
- Step4: NLU service instance should get created.
  <br/><img src="Images/ NLC_Models_Screen.png" alt=" NLC_Models_Screen" width="640" border="10" /><br/><br/>
- Step5: Create another Classifier as below screenshot.
- Step6: Upload the available training data if already exists in csv format.
  <br/><img src="Images/NLC1_Upload Training_dataset.png" alt="NLC1_Upload_Training_Data" width="640" border="10" /><br/><br/>


# Model Service Configurations

Administrator needs to configure the supported Watson Service's access/authentication details in Watson Model Evaluation Workbench application.

The Watson Service's access details need to be configured as application's user defined variables in Bluemix console as below, 
```
e.g.,
  NLC_USERNAME_CONFIG_1 = <username>
  NLC_PASSWORD_CONFIG_1 = <password>
  NLC_CLASSIFIER_ID_CONFIG_1 = < classifier_id>
```
If User needs to configure multiple Classifier service then CONFIG_2 or CONFIG_3, etc. can be configured as Bluemix user defined variables as below:
```
  NLC_USERNAME_CONFIG_2 = <username>
  NLC_PASSWORD_CONFIG_2 = <password>
  NLC_CLASSIFIER_ID_CONFIG_2 = < classifier_id>
```

Application Dashboard screen provides users an option to select the Watson service configuration (e.g. "CONFIG 1", "CONFIG 2" etc.) to choose their choice of Watson service against which they want to evaluate their ML model.

- Watson Service Configuration
![](/Images/NLC_Service_Configuration1.png)

- Watson Model Evaluation Workbench: Dashboard
![](/Images/Dashboard1.png)

Ready to learn how to interact with a database? Check out this [Sample and tutorial](https://github.com/IBM-Bluemix/get-started-java) to help you get started with a Java EE app, REST API and a database.

## Liberty App Accelerator

For help generating other Liberty samples checkout the Liberty App Accelerator at [wasdev.net/accelerate](http://wasdev.net/accelerate)

[Liberty Maven Plug-in]: https://github.com/WASdev/ci.maven
