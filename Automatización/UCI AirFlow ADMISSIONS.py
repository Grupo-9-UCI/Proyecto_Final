from datetime import timedelta
from datetime import datetime
import numpy as np
import pandas as pd

import pymysql
import requests

# The DAG object
from airflow import DAG

# Operators
from airflow.operators.python_operator import PythonOperator

def uci_etl():
    df = pd.read_csv('https://henry-proyecto-final.s3.amazonaws.com/dataset/ADMISSIONS.csv', encoding='UTF-8', delimiter=',', decimal='.')
    
    df = df.replace(np.nan, 0)
    
    con = pymysql.connect(
      host='database-proyecto-final.cpjrl88bhdul.us-east-1.rds.amazonaws.com',
      database='databaseuci',
      user='admin',
      password='datascience'
    )

    sql_insert = ''' INSERT 
                   INTO  ADMISSIONS
                         (row_id, subject_id, hadm_id, admittime, dischtime, deathtime, admission_type, admission_location, 
                          discharge_location, insurance, language, religion, marital_status, ethnicity, edregtime, 
                          edouttime, diagnosis, hospital_expire_flag, has_chartevents_data)
                 VALUES  (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) '''
    num_reng = 0
    cursor = con.cursor()
    for i in range(0, len(df)):
        row = int(df.loc[i, 'row_id'])
        subj = int(df.loc[i, 'subject_id'])
        hadm = int(df.loc[i, 'hadm_id'])
        adt = df.loc[i, 'admittime']
        dit = df.loc[i, 'dischtime']
        det = df.loc[i, 'deathtime']
        atm = df.loc[i, 'admission_type']
        alc = df.loc[i, 'admission_location']
        dlc = df.loc[i, 'discharge_location']
        ins = df.loc[i, 'insurance']
        lan = df.loc[i, 'language']
        rel = df.loc[i, 'religion']
        mas = df.loc[i, 'marital_status']
        etn = df.loc[i, 'ethnicity']
        edr = df.loc[i, 'edregtime']
        edo = df.loc[i, 'edouttime']
        dig = df.loc[i, 'diagnosis']
        hef = int(df.loc[i, 'hospital_expire_flag'])
        hcd = int(df.loc[i, 'has_chartevents_data'])
        reg_s = (row, subj, hadm, adt, dit, det, atm, alc, dlc, ins, lan, rel, mas, etn, edr, edo, dig, hef, hcd)
        cursor.execute(sql_insert, reg_s)
        num_reng += 1
        if num_reng == 100:
            con.commit()
            num_reng = 0

    con.commit()
    cursor.close()
    con.close()

with DAG(
    dag_id = 'UCI_Extract_Transform_Load',
    description = 'Carga de datos a BD UCI MySQL-AWS-RDS',
    start_date = datetime(2023, 3, 23),
    schedule_interval='*/10 * * * *',
    catchup = False
) as dag:

    t1 = PythonOperator(
        task_id='UCI_etl',
        python_callable=uci_etl
    )

t1