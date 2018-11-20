# Performance Evaluation of Machine Learning Models

Machine learning(ML) models are algorithms that are trained for a particular set of data. E.g. y = mx + c is an algorithm, whereas y = 2x + 3 is a model. You provide input to a model and it gives a response.
Cognitive systems are not programmed and they perform as per the data on which they are trained on; to sense, predict, infer, and in some ways, think, using artificial intelligence and machine learning algorithms.


In machine learning world numerous models are being created for achieving a specific task. With so many models available, how can one decide which model to use? Which model is performing better? What are the various performance parameters for different models? This code pattern shows you a way to compare Watson Cognitive services models so as to decide which model performs better for a particular set of data. It provides user a platform to configure models, provide input data, execute and prepare performance evaluation statistics such as [confusion matrix](https://en.wikipedia.org/wiki/Confusion_matrix) and [ROC curve](https://en.wikipedia.org/wiki/Receiver_operating_characteristic).


After going through this code pattern, you should be able to:
- Create and deploy Watson services models
- Configure model evaluation workbench to compare specific models and provide and test data.
- Understand model evaluation parameters and know which model best suits your needs.

## Flow

![](images/Reference_Architecture.png)

1. User launches the application.
2. Cloud authenticates the request and redirects it to the application.
3. Parses input data provided for evaluating the models.
4. Invokes adapter which calls cognitive services like Natural Language Classifier, Natural Language Understanding, etc.
5. Parses the cognitive model services configuration.
6. Connects to cognitive services.
7. Gets response from cognitive services.
8. Compares the expected result with actual result and does performance evaluation.
9. Performance results are sent back to client devices
10. Performance analysis is shown on UI

## Included Components
* [Java Liberty Runtime](https://console.bluemix.net/docs/runtimes/liberty/index.html#liberty_runtime) - Develop, deploy, and scale Java web apps with ease. IBM WebSphere Liberty Profile is a highly composable, ultra-fast, ultra-light profile of IBM WebSphere Application Server designed for the cloud.
* [Natural Language Classifier(NLC)](https://console.bluemix.net/catalog/services/natural-language-classifier) - The Natural Language Classifier service applies cognitive computing techniques to return the best matching classes for a sentence or phrase.
* [IBM Cloud Object Storage](https://console.bluemix.net/catalog/services/cloud-object-storage): An IBM Cloud service that provides an unstructured/structured cloud data store to build and deliver cost effective apps and services with high reliability and fast speed to market.

## Featured Technologies

* [Java](https://www.ibm.com/support/knowledgecenter/en/SSYKE2_8.0.0/welcome/welcome_javasdk_version.html): The Java programming language is a high-level, object-oriented language. When written, a Java program is compiled into bytecode. The bytecode is interpreted at run time by a platform-specific Java component
* [Artificial Intilligence](https://www.computerworld.com/article/2906336/emerging-technology/what-is-artificial-intelligence.html): Intelligence demonstrated by machines, in contrast to the natural intelligence displayed by humans.

## Watch The Video

[Demo](https://youtu.be/VkgqjqBnvWo)



## Steps
Follow these steps to setup and run this code pattern. The steps are described in detail below.
1. [Pre-requisites](#1-pre-requisites)
2. [Create the Cognitive models](#2-create-the-cognitive-models)
3. [Deploy the application to the IBM Cloud](#3-deploy-the-application-to-ibm-cloud)
4. [Deploy the application to local machine](#4-deploy-the-application-to-local-machine)
5. [Run the application](#5-run-the-application)
6. [Analyse the results](#6-analyse-the-results)



## 1. Pre-requisites
- IBM Cloud account: You must have IBM Cloud account to work with this code pattern. If you do not have an IBM Cloud account, you can create a one month free trail account [here](https://console.bluemix.net/).



## 2. Create the Cognitive models

For this pattern to demonstrate, we would be creating & using Natural Language Classifier(NLC) models.
This code pattern requires at least two NLC models to compare and evaluate. So, we will create two classifier models in one NLC service instance.

### 2.1 Create NLC service instances:

- Follow the instructions from the given [link](https://console.bluemix.net/docs/services/natural-language-classifier/getting-started.html#natural-language-classifier) to create and train the NLC models.
- While you are training the first model, Use `NLC_TrainngDataset1.csv` file from `../src/main/data/NLC_TrainngDataset1.csv`.
- While you are training the second model, Use `NLC_TrainngDataset2.csv` file from `../src/main/data/NLC_TrainngDataset2.csv`.
- Copy API Key, Url and classifier_id/model_id and save it in a text file. These credentials are required in later steps.

Now, we have created and trained two models in one NLC service instance.


## 3. Deploy the application to IBM Cloud

The application can be deployed on IBM Cloud or locally. Execute Step 3 for deploying on IBM Cloud or Step 4 to deploy locally.

* Maven should be installed. If not installed, you can download maven from [here](https://maven.apache.org/download.cgi). You can refer to the installation instructions [here](https://maven.apache.org/install.html).
* Install [IBM Cloud CLI](https://console.bluemix.net/docs/cli/reference/ibmcloud/download_cli.html#install_use) if not already done
* Login to IBM Cloud using CLI using the below command. Ensure that the target points to the region and space where you are running and deploying this code pattern.

     ```
     bx login
     ```

* open command prompt. Change directory to location where you want to download project files. Go to that directory.
* run one of the below commands to clone the repository

     ```
     git clone git@github.com:IBM/model-evaluation-workbench.git
     ```

     or

     ```
     git clone https://github.com/IBM/model-evaluation-workbench.git
     ```

* Change directory to model-evaluation-workbench
* run the command

    ```
    mvn clean install
    ```

* This should create the file `workbenchModelEval.war` under `target` folder
* Open the manifest.yml file and update values as explained below
  * For each classifier, update `NLC_API_KEY_CONFIG_x`, `NLC_CLASSIFIER_ID_CONFIG_x` with API Key and Classifier Id respectively. For first classifier, `x` is replaces with `1` and for second classifier, `x` is replaced with `2`.
  * Update value against `NLC_URL`

* Before pushing the application, set the target organization and space using the below command:

     ```
     bx target --cf
     ```

* Push the application to IBM Cloud using the command:

     ```
     bx cf push <Application_Name>
     ```

* The application should get deployed successfully. If not check the logs to determine the error and fix it.

![](images/bxPush.png)

- Open IBM Cloud Console, Under Dashboard you should see the above deployed application running. Click on the application.

![](images/CloudDeployRunningApp.png)

- Click on `Visit App URL` link to launch the application.

![](images/Model_LaunchScreen.png)


## 4. Deploy the application to local machine

The application can be deployed on IBM Cloud or locally. Execute Step 3 for deploying on IBM Cloud or Step 4 to deploy locally.

### 4.1 Clone git repository
* open command prompt. Change directory to location where you want to download project files. Go to that directory.
* run the below command to clone the repository
   ```
   git clone git@github.com:IBM/model-evaluation-workbench.git
   ```

* Change directory to model-evaluation-workbench

### 4.2 Deploy to local machine
- If eclipse is not installed on your local machine then install Eclipse following instructions provided in this [link](https://www.eclipse.org/downloads/)
- After the installation, launch Eclipse
- In the eclipse menu, click `file` and then click `import`
- Under import wizard, expand `General` folder and select `Existing Project into Workspace`.
- Click `Next` and browse to the cloned project folder.
- Click the `Finish` button.
- Setup Liberty server in eclipse as per this [Link](https://www.ibm.com/blogs/bluemix/2016/05/liberty-and-eclipse-create-server-p10/)
- Application needs to access models to send requests to and get responses from them. Access details of these models have to be provided in server config (server.env) file of liberty server. A sample server.env file snapshot is as in below image. You will need to provide the credentials of the models. You can access NLC credentials as described in section `Create NLC service instance`

![](images/Local_Serv_Cred.png)

- Start the Liberty Server

![](images/LibertySrvStart.png)

- Right Click on the Liberty Server created above, Click on the `Add and Remove`
- Under Add and Remove wizard, from the available section move `ModelEvaluationWorkbench` to configured section.
- Click on Finish.
- Model Evaluation application should be started.
- In Eclipse, under Console tab, you will see default_host link similar to http://localhost:9091/ModelEvaluationWorkbench/.

Click on that link to launch the application.

![](images/LocalMachineAppStart.png)


## 5. Run the Application

We created two models using Natural Language Classifier. Now, we would evaluate which model is performing better when compared to each other.

- On the application home page click on `NLC` box
- Under `Attribute` select `Classes`

![](images/Model_NLC_Evaluate.png)

- Select `MODEL 1` and `MODEL 2` checkboxes
- Two browse buttons will be available since we have selected two models. Click on each browse button and select the file `src/main/data/NLC_TruthFile.csv` from your git repo. The same file is selected for both browse buttons because this file is the actual results file which needs to be compared with both the model results.

![](images/Model_Upload_TruthFile.png)

- Click on Evaluate Performance button.

![](images/Model_Evaluate_Button.png)

The application invokes both the NLC services, gets responses and displays various evaluation parameters.

## 6. Analyse the results

The result shows a lot of statistical data for model performance evaluation. It is suggested that you become familiar with these [terminologies](https://console.bluemix.net/docs/services/watson-knowledge-studio/evaluate-ml.html#evaluate-ml)

Results of running the two NLC models using the truth file enables the application to check how the results from each of the models are faring.

The below screenshot shows various parameters such as `F1Score Optimization` and `Accuracy Optimization` and also provides `Model Rating`

![](images/Model_Analysis1.png)

The application also shows ROC chart, for both the models, for various parameters

![](images/Model_Analysis2.png)

In this case we can see that Model 1 fares better compared to model 2. Users can analyse various performance parameters and can take approriate decision.


## 6. Links
- [Artificial Intelligence](https://www.ibm.com/services/artificial-intelligence)
- [Analyzing machine learning model performance](https://console.bluemix.net/docs/services/watson-knowledge-studio/evaluate-ml.html#evaluate-ml)


## 7. Learn More
- [Natural Language Classifier](https://console.bluemix.net/catalog/services/natural-language-classifier).
- [Natural Language Understanding](https://console.bluemix.net/catalog/services/natural-language-understanding)
- [Watson Assistant](https://console.bluemix.net/catalog/services/watson-assistant-formerly-conversation)

## 8. License
[Apache 2.0](LICENSE)
