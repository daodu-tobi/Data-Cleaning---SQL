# Nashville Housing - Data Cleaning



https://www.kaggle.com/datasets/tmthyjames/nashville-housing-data/data


### Problem statement
 
The aim of this project is data cleaning, preparing the data and getting the data ready for analysis.


### Steps Followed

- Creation of database

- Loading of dataset into database

   Snapshot of dataset

   ![DataSet](https://github.com/user-attachments/assets/b9ec2752-757d-4c85-84c9-3050e3a73463)

- Extraction of date from the salesdate column containing datetime data type from the dataset 

    Created new column called Newdate for the extracted date


  Snapshot of Newdate Column

  ![NewDate](https://github.com/user-attachments/assets/b7a01d7c-8521-4df2-90a8-338ed1add8e0)

- Using a self join to populate property address where parcel address is the same but uniqueID is different

- Breaking down the property address into address and city and address

  Snapshot of New-address and New_city column

  ![New-Address](https://github.com/user-attachments/assets/aea49ba9-6b0c-43d8-a54d-1b6f732ac5ee)

- Breaking the ownersAddress into three parts using PARSENAME

  Snapshot of New Column
  ![OwnerAddress](https://github.com/user-attachments/assets/3211276c-bc15-4a73-adc3-6e92b3a52aa8)

    Please click link for full Project
  https://github.com/daodu-tobi/Data-Cleaning---SQL/blob/main/Data%20cleaning.sql
