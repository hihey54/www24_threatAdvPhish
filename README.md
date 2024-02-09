# Overview
This repo contains the resources of the paper "“Are Adversarial Phishing Webpages a Threat in Reality?” Understanding the Users’ Perception of Adversarial Webpages" accepted to the Security track of [TheWebConf'24](https://www2024.thewebconf.org/).

If you use any of our resources, you are kindly invited to cite our paper:

```
@inproceedings{yuan2024are,
  title={{““Are Adversarial Phishing Webpages a Threat in Reality?” Understanding the Users’ Perception of Adversarial Webpages}},
  author={Yuan, Ying and Hao, Qingying and Apruzzese, Giovanni and Conti, Mauro and Wang, Gang},
  booktitle={ACM International World Wide Web Conference (TheWebConf)},
  year={2024}
}
```

## Organization
This repository includes three main folders:

* **ML-PWD**: This folder includes the implementation of our custom ML-based phishing website detector and scripts for generating APW-Lab webpages.  
* **experimental_webpages**: This folder contains all webpages (i.e., unperturbed phishing, legitimate, APW-Lab and APW-Wild) we used in our user study.
* **analysis**: This folder contains the components needed to replicate all analysis. This includes the codebook, a script for calculating cohen's kappa value, linear regression model and mixed-effect logistic regression model.

## Contents
We explain the documents in the order of the list above, i.e., ML-PWD, experimental_webpages and analysis.
### ML-PWD
This folder includes three *.ipynb* files, one subfolder, 5 *.json* files, two *.py* and one *requirements.txt* file:
* *datasets*, which is a folders containing the dataset proposed in paper *Building standard offline anti-phishing dataset for
benchmarking* (we just show the source of three phishing webpages, the full dataset can be downloaded from the link proposed in their paper).
* *feature_extraction.ipynb*, which is a notebook file extracting features from HTML source of webpages.
* *RF-PWD.ipynb*, which is a notebook containing machine learning model selection, the custom ML-PWD described in our paper, as well as the prediction for our APW-Lab samples.
* *apw_lab_generation.ipynb*, which is a notebook stating how we generate APW-Lab webpages.
* *extractor.py*, which is from [SpacePhish](https://github.com/hihey54/acsac22_spacephish), to extract features from HTML source of webpages.
* *util.py*, which is a script providing functions for the building of ML-PWD and the generation of APW-Lab samples.
* *full_feature.json*, which is the feature set extracted from the dataset proposed in paper *Building standard offline anti-phishing dataset for
benchmarking*, to build the custom ML-PWD.
* *addfootimg_use.json, addbackimg_use.json, addtypos_use.json and repass_use.json*, which are the features extracted from APW-Lab webpages.
* *requirements.txt*, which is a txt file specifying which Python libraries were needed to build the custom ML-PWD and generate APW-Lab webpages.
  
### experimental_webpages

This folder includes four subfolders:
* *apw_lab*, which is a folder containing *all* APW-Lab webpages we generated for 15 brands.
* *apw_wild*, which is a folder containing adversarial phishing webpages in the wild, taken from [Real Attackers Don't Compute Gradients](https://real-gradients.github.io/).
* *benign_webpages*, which is a folder including the legitimate webpages of 15 brands decribed in our paper.
* *unperturbed_phish*, which is a folder containing corresponding ubperturbed phishing webpages of 15 brands.
### analysis
This is a folder contains 4 files:
* *codebook.pdf*, which is a pdf file we built based on user's responses for open-form questions.
* *codebook_kappa.ipynb*, which is a script to calculate two coder's cohen's kappa value.
* *linear_regression_model.r*, which is a R script for analyzing the impact of demographic factors on user's detection rate.
* *mixed_effect_logistic_regression_model.r*, which is a R script for analyzing the relationship between webpage's type and user's accuracy.

## Instructions
Let's explain how to use our artifact.

1. **Download dataset, and install requirements**. We recommend creating a visual enviroment for this purpose (Miniconda works well). The *datasets* subforlder in *ML-PWD* should be replaced.
2. **Extarct features and build custom ML-PWD**. Running *feature_extraction.ipynb* file extracting features and build RF-based phishing website detector by excuting *RF-PWD.ipynb*.
3. **Generate APW-Lab**. Generating APW-Lab webpages by running *apw_lab_generation.ipynb*, then extract features by *feature_extraction.ipynb* , and input them to RF-PWD to test whether they can evade the detection.
4. **Publish the survey**. Publish the survey to collect users judgement for legitimate, unperturbed phishing, APW-Lab and APW-Wild wepages.
5. **Coding response**. Two coders code the reponses based on *codebook.pdf*, and calculate the cohen's kappa value by *codebook_kappa.ipynb* to check the realible of the codebook.
6. **Regression analysis**. Using *linear_regression_model.r* file to analyze the imapct of demographich factors on user's detection rate. And, using *mixed_effect_logistic_regression_model.r* to analyze whether user's detection rate are affected by webpage's type, users familiarity and the frequency of website visits.
   

