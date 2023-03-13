#Importo las librerías necesarias
from typing import Union
from fastapi import FastAPI
import numpy as np
import pandas as pd
from pandasql import sqldf
# creación de una aplicacion FastAPI
app = FastAPI()

#**************Carta de presentación**************
@app.get("/")
def presentacion():
    return "Proyecto Grupal 01 - Ramon Acevedo, Jose Manuel Bracho Navarro, Carlos Vargas sanchez y Carlos Alexis Farias Gallardo. Bienvenidos a nuestra API"

@app.get("/contacto")
def contacto():
    return "Email: racevedog7@gmail.com; josemanuelbrachonavarro@gmail.com; carlosvargassanchez24@gmail.com; cfarias.gallardo7@gmail.com; / Github: jbracho03"
# ***************QUERIS*******************
