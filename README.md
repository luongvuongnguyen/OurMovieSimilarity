# OurMovieSimilarity
OurMovieSimilarity (OMS) is the crowdsourcing platform for collecting the cognitive similarity from users.

## Introduction
The OMS was built based on Java Web Application and Model-View-Controller model combine with the MySQL server. OMS is run by KEL (Knowledge Engineering Labotary) at Chung-Ang University. By using OMS, you will help us develop new experimental tools and interfaces for data exploration. OMS system is non-commercial. 

## Publication related to OMS dataset
Luong Vuong Nguyen, O-Joun Lee, Hoang Long Nguyen, Sojung An, Jason J. Jung, and Yue-Shan Chang. Crowdsourcing System for Measuring Cognitive Similarity in Recommendation System. In Proceeding of the ISSAT International Conference on Data Science in Business, Finance, and Industry (DSBFI 2019), pp. 109-113, Danang, Vietnam; July 03-05, 2019. https://www.issatconferences.org/Abstracts/dsbfi/Content_dsbfi/content_dsbfi_19/109.html

Luong Vuong Nguyen and Jason J. Jung.rowdsourcing Platform for Collecting Cognitive Feedbacks from Users: A Case Study on Movie Recommender System. In Springer Series in Reliability Engineering Book Series, Springer. https://doi.org/10.1007/978-3-030-43412-0_9

Luong Vuong Nguyen, Minsung Hong, Jason J. Jung, and Bongsoo Sohn. Cognitive Similarity-Based Collaborative Filtering Recommendation System. Applied Sciences-Basel. https://doi.org/10.3390/app10124183

Luong Vuong Nguyen, Tri-Hai Nguyen, and Jason J. Jung. Content-Based Collaborative Filtering using Word Embedding: A Case Study on Movie Recommendation. In Proceedings of ACM SIGAPP 11st International Conference on Research in Adaptive and Convergent Systems (RACS 2020), pp. 101–106, ACM, Gwangju, Seoul, South Korea, October 13-16, 2020. https://doi.org/10.1145/3400286.3418253

## How to run OMS
### Requirements
```
IDE Netbean 12
MySQL 8.0 
Java 8.0
Apache Tomcat 8
```
### Setup and Run
1. Install IDE (Netbean 12)
2. Install MySQL 8.0
```
-e MYSQL_ROOT_PASSWORD=password \
-e MYSQL_DATABASE=movie \
-e MYSQL_USER=root \
-e MYSQL_PASSWORD=ke@cau \
run oms_dataset.sql 
```
3. Create project in Netbean (set port 8084)
4. Run platform in browser
* http://localhost:8084/ourmoviesimilarity
* Try online version: http://recsys.cau.ac.kr:8084/ourmoviesimilarity

## Contact
Email: nguyenluongvuong@gmail.com