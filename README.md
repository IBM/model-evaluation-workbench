# Model-Evaluation-Workbench


This code pattern details about the Watson Model Evaluation Workbench which provides user a platform to configure, execute and test user's cognitive model for tool's supported Watson cognitive services, prepare performance evaluation data and calculates performance statistics such as confusion matrix and ROC curve.
By the end of this code pattern reading, one will be able to:

To compare their different Watson cognitive service’s models and selecting the threshold and best-performing machine learning model.

User can configure their Watson cognitive service access details in workbench and input their model test data to workbench for service performance evaluation.

Workbench execute supported Watson cognitive services with their input model’s test data, prepare performance evaluation data, calculates performance statistics and present user with the following recommendations, curve and summary statistics:
o	Recommendations: 
	Optimal threshold and maximized F1Score for F1Score optimization
	Optimal threshold and maximized Accuracy for Accuracy optimization
Receiver Operating Characteristic (ROC) curve

## Architectural Diagram:
![](/Images/Reference_Architecture.png)

- Details
1. User launches the [Watson Model Evaluation Workbench](https://workbenchmodelevalpattern.au-syd.mybluemix.net/) through the URL https://workbenchmodelevalpattern.au-syd.mybluemix.net/
2. 

# Included Components
1. Java Liberty Run Time
2. Java Stastical Libraries
3. Cognitive Services(IBM Watson Conversation, NLC and NLU)


# Featured Technologies

Java Stastical Librabries

J2EE: A secure Object-oriented programming language, used to build applications. IBM WebSphere Commerce platform is built on J2EE framework which includes (JSP, Java, Java Script, Struts, REST & Webservices, EJBs)

# Watch The Video








# Steps

## Pre-requisites
* Clone the GIT repository
* 

Two ways to Deploy:
* Deploy to IBM cloud using "Deploy to Cloud" Button
* Manual deploy to IBM Cloud
   * Clone the repository 
   * Follow the below steps to generate war file and deploy in IBM bluemix


Follow these steps to setup and run this developer pattern. The steps are described in detail below.


# Java Hello World Sample

This project contains a simple servlet application.

[![Deploy to Bluemix](https://bluemix.net/deploy/button.png)](https://bluemix.net/deploy?repository=https://github.ibm.com/muralidhar-chavan/cognitive-model-evaluation-workbench.git)

## Running the application using the command-line

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

# Watson Service Configuration

Administrator needs to configure the supported Watson Service's access/authentication details in Watson Model Evaluation Workbench application.

The Watson Service's access details need to be configured as application's user defined variables in Bluemix console as below, 
```
e.g.,
  CONVERSATION_WORKSPACE_ID_CONFIG_1 = <workspaceid>
  CONVERSATION_USERNAME_CONFIG_1 = <username >
  CONVERSATION_PASSWORD_CONFIG_1 = < password>
```
If User needs to configure multiple CONVERSATION service then CONFIG_2 or CONFIG_3, etc. can be configured as Bluemix user defined variables as below:
```
CONVERSATION_WORKSPACE_ID_CONFIG_2 = <workspaceid>
CONVERSATION_USERNAME_CONFIG_2 = <username >
CONVERSATION_PASSWORD_CONFIG_2 = < password>
```

Application Dashboard screen provides users an option to select the Watson service configuration (e.g. "CONFIG 1", "CONFIG 2" etc.) to choose their choice of Watson service against which they want to evaluate their ML model.

- Watson Service Configuration
![](/Images/Service_Configuration1.png)

- Watson Model Evaluation Workbench: Dashboard
![](/Images/Dashboard1.png)

Ready to learn how to interact with a database? Check out this [Sample and tutorial](https://github.com/IBM-Bluemix/get-started-java) to help you get started with a Java EE app, REST API and a database.

## Liberty App Accelerator

For help generating other Liberty samples checkout the Liberty App Accelerator at [wasdev.net/accelerate](http://wasdev.net/accelerate)

[Liberty Maven Plug-in]: https://github.com/WASdev/ci.maven
