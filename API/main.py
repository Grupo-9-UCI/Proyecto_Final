from fastapi import FastAPI, Query
from statistics import mode
import pandas as pd
import pymysql

app = FastAPI()


@app.get("/")
async def api_def():
    """
    Descripción de la API
    
    Parameters
    ----------
    NA
    
    Returns
    -------
    NA
    """
    
    return {'API de servicios de consulta para la Unidad de Cuidados Intensivos - UCI'}


@app.get("/galt/")
async def get_avg_disch_time(year : int = Query(gt=2100, lt=2203), month : int = Query(gt=0, lt=12)):
    """
    Obtiene el tiempo promedio (días) de estadía de los pacientes en la UCI con alta médica por año-mes.
    
    Parameters
    ----------
    year : int
        Año de admisión.
    month : int
        Mes de admisión.
    
    Returns
    -------
    int
        Días promedio de permanencia en la UCI
    """
    con = pymysql.connect(
          host='database-proyecto-final.cpjrl88bhdul.us-east-1.rds.amazonaws.com',
          database='databaseuci',
          user='admin',
          password='datascience'
          )

    sql_query = ''' SELECT  ROUND(AVG(TIMESTAMPDIFF(DAY, ADMITTIME, DISCHTIME)),1)
                      FROM  ADMISSIONS 
                     WHERE  YEAR(ADMITTIME) = {} AND MONTH(ADMITTIME) = {}
                '''.format(year, month)
    cursor = con.cursor()
    cursor.execute(sql_query)
    t_prom = cursor.fetchone()
    if t_prom[0] == None:
        d_prom = 0
    else:
        d_prom = t_prom[0]

    cursor.close()
    con.close()
    
    return {'El tiempo promedio de estadía (días) de pacientes con alta médica es' : d_prom}


@app.get("/gadt/")
async def get_avg_death_time(year : int = Query(gt=2100, lt=2203), month : int = Query(gt=0, lt=12)):
    """
    Obtiene el tiempo promedio (días) de estadía de los pacientes en la UCI fallecidos por año-mes.
    
    Parameters
    ----------
    year : int
        Año de admisión.
    month : int
        Mes de admisión.
    
    Returns
    -------
    int
        Días promedio de permanencia en la UCI
    """
    con = pymysql.connect(
          host='database-proyecto-final.cpjrl88bhdul.us-east-1.rds.amazonaws.com',
          database='databaseuci',
          user='admin',
          password='datascience'
          )

    sql_query = ''' SELECT  ROUND(AVG(TIMESTAMPDIFF(DAY, ADMITTIME, DEATHTIME)),1)
                      FROM  ADMISSIONS 
                     WHERE  YEAR(ADMITTIME) = {} AND MONTH(ADMITTIME) = {}
                '''.format(year, month)
    cursor = con.cursor()
    cursor.execute(sql_query)
    t_prom = cursor.fetchone()
    if t_prom[0] == None:
        d_prom = 0
    else:
        d_prom = t_prom[0]

    cursor.close()
    con.close()
    
    return {'El tiempo promedio de estadía (días) de pacientes fallecidos es' : d_prom}


@app.get("/grdt/")
async def get_rate_death(year : int = Query(gt=2100, lt=2203)):
    """
    Obtiene la tasa de mortalidad por año.
    
    Parameters
    ----------
    year : int
        Año de admisión.
    
    Returns
    -------
    float
        Tasa de mortalidad por año.
    """
    con = pymysql.connect(
          host='database-proyecto-final.cpjrl88bhdul.us-east-1.rds.amazonaws.com',
          database='databaseuci',
          user='admin',
          password='datascience'
          )

    d_vacia = '0000-00-00'
    sql_query = ''' SELECT  COUNT(*)
                    FROM  ADMISSIONS
                    WHERE  DEATHTIME != {} AND YEAR(ADMITTIME) = {}
                '''.format(d_vacia, year)
    cursor = con.cursor()
    cursor.execute(sql_query)
    n_fall = cursor.fetchone()
    if n_fall[0] == None:
        num_f = 0
    else:
        num_f = n_fall[0]

    sql_query = ''' SELECT  COUNT(*)
                    FROM  ADMISSIONS
                    WHERE  YEAR(ADMITTIME) = {}
                '''.format(year)
    cursor = con.cursor()
    cursor.execute(sql_query)
    n_tot = cursor.fetchone()
    if n_tot[0] == None:
        num_t = 0
    else:
        num_t = n_tot[0]
    t_mort = round(((num_f*100)/num_t),2)

    cursor.close()
    con.close()
    
    return {'La tasa (%) de mortalidad es' : t_mort}
