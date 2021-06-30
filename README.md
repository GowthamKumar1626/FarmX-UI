<p align="center">
  <img src="./assets/images/appicon.png" />
</p>
<h1 align="center">FarmX</h1>
<p align = "center"><strong>AI Powered Assistant for Farmers</strong></p>

## Introduction
Food is the major source of life and Farmers are the backbone of society.

But, Are we giving utmost importance and support to agriculture and farming? A lot of Technological advancements and research using AI are happening every day related to agriculture, but most farmers have no access to them. In order to bridge the gap between Technology and Agriculture, we made **FarmX**.

## Technologies Used
- Flutter : For developing the mobile application
- Firebase : For data storage and authentication
- TFLite : For pest detection models 
- Google Cloud Platform : For Google Maps API
- Heroku : For ML model deployment  

## Features
- Supports Plant Disease detection for 14 different Plants with 26 Diseases and more focused diseases for 6 plants, trained using SOTA Deep Learning Models.
- Information Related to Crop Diseases such as causes and prevention.
- Region Based Crop Suggestion along with conditions.
- Fertilizer Suggestion Based on Soil Condition.
- Crop Recommendation Based on Environmental Factors+Soil Conditions.
- News Feed for knowledge sharing and understanding proven foreign agricultural practices from one another.
- Direct Selling option to remove middle-men exploitation.
- Provides Machinery for farming.
- Co - Farming which connects farmers and people (other than farmers).
- Posts tab where people can post and interact with other app users.

## Requirements

```
Flutter 2.2.2
Dart 2.13.3
```


## Installation

- Make sure to install flutter in your pc and check by running the below commands on command prompt to ensure everything is perfectly installed.
```
flutter doctor
```
- Follow the below instructions on command line to install and run the application. The following instructions are for VSCode, You are free to use any other application you may like
```
https://github.com/GowthamKumar1626/FarmX-UI.git
```
- To open and run using VSCODE from command line
```
code .
```
- To run the application ( Make Sure to have Andriod Virtual Machine or Your mobile connected via USB with Developer Mode turned On and permitted the PC to for USB Debugging)
```
flutter pub get
flutter run lib/main.dart
```

Note: This app currently supports only Android Devices.

### Video Demonstration

<!-- To know more about how the app works, checkout this [video](https://www.youtube.com/watch?v=XC-PgjO8dvA) -->

### Important Note

All the Deployment Related Code Can be found at [**Farmx-Model-Deployment-Repo**](https://github.com/madhucharan/FarmX_Model_Deployment)

### Team

- [Gowtham Kumar](https://github.com/GowthamKumar1626)
- [Pranathi](https://github.com/pranathi1106)
- [Charan](https://github.com/madhucharan)

### Overview of Second Phase
  - Changed the UI of the App.
  - Complete Authentication (Email, Google,Mobile Number,Anonymous) using blocs and providers.
  - Seperate TensorFlow models for each crop.
  - Co-Farming Feature implementation using Google Maps API from GCP. We used GCP in this phase.
  - Used Weather API and implemented.
  - Newsfeed Feature
  - Decreased error rate in TFLite models.
  - Interacted with village farmers and collected feedback.
  - Machinery Shop feature which has different farming tools.

### Future Work for this App
  - To interact with NGOs for farmer benifits
  - To provide seperate feature in newsfeed tab that provides all updates about Government Schemes for farmers.
  - To provide market price analysis of different crops.
  - To provide and focus on more diseases for different crops using OpenCV
  - To provide more fertilizer information and fertilizer shop feature which farmers get redirected to after finding the  pest.
  - Bussiness with farmer groups.
  - Complete Multi-Language Support.


### End Note
This project was made as a part of Google Solution Challenge 2021. Feel Free to suggest improvements and raise issues if any. Reach out to me at [LinkedIn](https://www.linkedin.com/in/gowtham-kumar-pillalamarri-a3b423bb/) to discuss further if needed.Our goal is to help farmers with the advanced technology in our society.
