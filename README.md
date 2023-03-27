# Proyecto Final - Unidad De Cuidados Intensivos

<center>
 <img src="Imagenes/Turquoise Simple Modern Linkedin Banner (1).png" > 
 </center>


## Contexto

La Unidad de Cuidados Intensivos (`UCI`) de un hospital cuenta con grandes volumenes de información de los pacientes que son atendidos en esta área en una infraestructura vulnerable, con mecanismos de seguridad e integridad débiles, dificultades de escalabilidad y limitada disponibilidad en tiempo real.

## Solución propuesta

La siguiente propuesta establece una arquitectura tecnólogica para el tratamiento de datos, robusta y escalable para soportar y apoyar la toma de decisiones del equipo médico directivo y operativo en el entorno de la recepción, registro, procesos y procedimientos realizados a pacientes que ingresan en la `UCI` de un hospital.

## Objetivos

El alcance considerado en esta primera etapa de la propuesta es proveer de herramientas que ayuden a: 

- Reducir el tiempo de estancia de los pacientes en la `UCI` mediante una mejor atención.
- Mejorar la selección de los pacientes que ingresan en la `UCI`, mediante la  priorización de su ingreso.
- Reducir la tasa de mortalidad, las tasas de infección e incrementar la satisfacción del paciente.

## Stack Tecnológico

- Python v 3.10.9
- Pandas v 1.5.2
- FastAPI v 0.92.0
- Jupyter Notebooks v 1.0.15
- Visual Studio Code v 1.76.0
- MySQL v 8.0.32
- AWS
- PowerBI v 2.114.864.0
- Trello

## Metodología de trabajo

Kanban (Trello) - metodología continua de gestión de flujos de trabajo.

## EDA - ETL

<center>
 <img src="Imagenes/Turquoise Simple Modern Linkedin Banner (2).png" > 
 </center>

El análisis de datos exploratorio de los diversos conjuntos de datos en la base de datos MIMIC III se hizo en conjunto con el proceso de  Extracción, transformación y carga (ETL). 


Para esta parte, se tomo  varios pasos para analizar la información básica del conjunto de datos y aplicó varios métodos para el preprocesamiento de datos.

Estos varios pasos incluyen:
- Leer todas las tablas de la base de datos en un dataframe correspondiente. 
- Visualizamos la informacion de los dataframes.
- Columnas Vacias: En principio se eliminó las columnas que tenian mas del 80% de registros nulos.
- Despues se analiza de manera exhaustiva si las columnas que tienen aun una mayoria de datos nulos lo usaremos o no para poder eliminarlos. 
- Reemplazar los valores nulos por ceros.



## Alcance

### API

Se implementa una interfase aplicativa abierta `API` para exponer servicios de consulta que pueden ser consumidos por la propia solución y cualquier otra que se autorice.

url: https://deta.space/discovery/r/ebjhw9xdtu48wjr7

#### Get average discharge time

```http
  GET /galt/?{year}&{month}
```
Obtiene el tiempo promedio de permanencia de los pacientes con alta en la UCI por mes.

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `year`    | `integer`| **Requerido**. Año a consultar {2100 - 2203} |
| `month`   | `integer`| **Requerido**. Mes a consultar {1 - 12} |

#### Get average death time

```http
  GET /gadt/?{year}&{month}
```
Obtiene el tiempo promedio de permanencia de los pacientes fallecidos en la UCI por mes.

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `year`    | `integer`| **Requerido**. Año a consultar {2100 - 2203} |
| `month`   | `integer`| **Requerido**. Mes a consultar {1 - 12} |

#### Get rate death

```http
  GET /grdt/?{year}
```
Obtiene la tasa de mortalidad por año. 

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `year`    | `integer`| **Requerido**. Año a consultar {2100 - 2203} |

#### Get rate readmmited  `** fuera de alcance en esta etapa`

```http
  GET /grad/?{year}&{month}
```
Obtener la tasa de reingresos a la UCI por mes.

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `year`    | `integer`| **Requerido**. Año a consultar {2100 - 2203} |
| `month`   | `integer`| **Requerido**. Mes a consultar {1 - 12} |

### KPI’s

- Uno de nuestros objetivos principales es mejorar la eficiencia en la unidad de cuidados intensivos. Para ello, nos enfocaremos en reducir el tiempo de permanencia de los pacientes en un 20% mensual en promedio, lo que permitirá optimizar el uso de los recursos y mejorar la calidad de atención.

- Además, buscaremos reducir la tasa de reingreso a UCI en un 20% mensual, lo que contribuirá a disminuir la carga de trabajo en el personal y a mejorar la recuperación de los pacientes.

- La tasa de IAAS también será una de las métricas que seguiremos de cerca, ya que nos permitirá evaluar la efectividad de las medidas preventivas y detectar   oportunidades de mejora para reducir la tasa de infección asociada a la salud.

- Finalmente, aunque reducir la tasa de infección y la tasa de mortalidad son objetivos importantes, en esta etapa nos enfocaremos en los objetivos mencionados anteriormente, que son más factibles de lograr en el corto plazo. `** fuera de alcance en esta etapa`


### Dashboard.

Mostrar gráficamente métricas y KPI’s para apoyar las decisiones de atención y mejora de servicios en la UCI.
- Estadísticas generales:  el número de pacientes, el número de admisiones, la duración promedio de la estadía, la tasa de mortalidad.

- Datos de pacientes: edad, género, diagnóstico, comorbilidades, tratamientos, medicamentos, resultados de laboratorio, imágenes médicas.

- Tendencias a lo largo del tiempo para las métricas:  
    - Tasa de admisiones. 
    - La duración de la estadía.
    - La tasa de mortalidad. 
    - El uso de diferentes tratamientos.
   
- Análisis de subconjuntos de pacientes según diferentes criterios, como la edad, el género, el diagnóstico.

- Análisis de supervivencia: mostrar curvas de supervivencia para diferentes grupos de pacientes según diferentes criterios, como la edad, el género, el diagnóstico.

- Visualizaciones de redes: mostrar las relaciones entre diferentes diagnósticos, comorbilidades, tratamientos.

- Explorar los datos de MIMIC III de manera más detallada, como filtros, gráficos interactivos.





## Automatización

Empleamos la plataforma `Apache-Airflow` para automatizar el flujo de procesos de adquisición, exploración, preprocesamiento, transformación y carga de datos al repositorio de MySQL desplegado en AWS-RDS.

En esta primera etapa este flujo inicia en el subsitema Linux de Windows local `WSL`, accediendo a los archivos `csv` desde una carpeta compartida y se ejecutan los procesos `dag` que toman estos archivos, hacen la conexión con MySQL y ejecutan la carga de datos.

Este flujo de procesos se escalará en siguientes etapas para que los archivos se alojen en el subsistema S3 de AWS para robustecer el proceso de cargas incrementales.

![image](https://user-images.githubusercontent.com/111448124/227803184-2dc7fe22-d3d3-4505-8a0a-9d2540f8c0b0.png)



## Modelo de Machine Learning





## Autores
:yellow_circle: **Carlos Farias** :yellow_circle:
- GitHub: [@CarlitosAlex](https://github.com/CarlitosAlex)
- Correo electronico:
- Linkedin:

:yellow_circle: **Carlos Vargas** :yellow_circle:
- GitHub: [@Cvargas24](https://github.com/Cvargas24)
- Correo electronico:
- Linkedin:

:yellow_circle: **Jose Manuel Bracho** :yellow_circle:
- GitHub: [@jbracho03](https://github.com/jbracho03)
- Correo electronico: josemanuelbrachonavarro@gmail.com
- Linkedin: www.linkedin.com/in/jose-manuel-bracho-navarro

:yellow_circle: **Ramon Acevedo** :yellow_circle:
- GitHub: [@racevedog](https://www.github.com/racevedog)
- Correo electronico:
- Linkedin:

## Github

https://github.com/Grupo-9-UCI/Proyecto_Final

