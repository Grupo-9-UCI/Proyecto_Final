/* ---------------------------------------------------------------------------------------*/
/* Creación de esquema de BD "databaseuci"                                                */
/* ---------------------------------------------------------------------------------------*/
CREATE SCHEMA IF NOT EXISTS databaseuci COLLATE utf8mb4_0900_ai_ci;

USE databaseuci;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "ADMISSIONS"                                                         */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS ADMISSIONS;
CREATE TABLE ADMISSIONS 
  (	-- rows=58976
   ROW_ID               MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID           MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID              MEDIUMINT UNSIGNED NOT NULL,
   ADMITTIME            DATETIME NOT NULL,
   DISCHTIME            DATETIME NOT NULL,
   DEATHTIME            DATETIME,
   ADMISSION_TYPE       VARCHAR(50) NOT NULL,	-- max=9
   ADMISSION_LOCATION   VARCHAR(50) NOT NULL,	-- max=25
   DISCHARGE_LOCATION   VARCHAR(50) NOT NULL,	-- max=25
   INSURANCE            VARCHAR(255) NOT NULL,	-- max=10
   LANGUAGE             VARCHAR(10),	-- max=4
   RELIGION             VARCHAR(50),	-- max=22
   MARITAL_STATUS       VARCHAR(50),	-- max=17
   ETHNICITY            VARCHAR(200) NOT NULL,	-- max=56
   EDREGTIME            DATETIME,
   EDOUTTIME            DATETIME,
   DIAGNOSIS            VARCHAR(255),	-- max=189
   HOSPITAL_EXPIRE_FLAG TINYINT UNSIGNED NOT NULL,
   HAS_CHARTEVENTS_DATA TINYINT UNSIGNED NOT NULL,
   UNIQUE KEY           ADMISSIONS_HADM_ID (HADM_ID)	-- nvals=58976
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "CALLOUT"                                                            */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS CALLOUT;
CREATE TABLE CALLOUT 
  (	-- rows=34499
   ROW_ID                   MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID               MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID                  MEDIUMINT UNSIGNED NOT NULL,
   SUBMIT_WARDID            TINYINT UNSIGNED,
   SUBMIT_CAREUNIT          VARCHAR(15),	-- max=5
   CURR_WARDID              TINYINT UNSIGNED,
   CURR_CAREUNIT            VARCHAR(15),	-- max=5
   CALLOUT_WARDID           TINYINT UNSIGNED NOT NULL,
   CALLOUT_SERVICE          VARCHAR(10) NOT NULL,	-- max=5
   REQUEST_TELE             TINYINT UNSIGNED NOT NULL,
   REQUEST_RESP             TINYINT UNSIGNED NOT NULL,
   REQUEST_CDIFF            TINYINT UNSIGNED NOT NULL,
   REQUEST_MRSA             TINYINT UNSIGNED NOT NULL,
   REQUEST_VRE              TINYINT UNSIGNED NOT NULL,
   CALLOUT_STATUS           VARCHAR(20) NOT NULL,	-- max=8
   CALLOUT_OUTCOME          VARCHAR(20) NOT NULL,	-- max=10
   DISCHARGE_WARDID         TINYINT UNSIGNED,
   ACKNOWLEDGE_STATUS       VARCHAR(20) NOT NULL,	-- max=14
   CREATETIME               DATETIME NOT NULL,
   UPDATETIME               DATETIME NOT NULL,
   ACKNOWLEDGETIME          DATETIME,
   OUTCOMETIME              DATETIME NOT NULL,
   FIRSTRESERVATIONTIME     DATETIME,
   CURRENTRESERVATIONTIME   DATETIME
--   UNIQUE KEY               CALLOUT_CURRENTRESERVATIONTIME (CURRENTRESERVATIONTIME)	-- nvals=1164
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "CAREGIVERS"                                                         */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS CAREGIVERS;
CREATE TABLE CAREGIVERS 
  (	-- rows=7567
   ROW_ID       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   CGID         SMALLINT UNSIGNED NOT NULL,
   LABEL        VARCHAR(15),	-- max=6
   DESCRIPTION  VARCHAR(30),	-- max=21
   UNIQUE KEY   CAREGIVERS_CGID (CGID)	-- nvals=7567
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "CHARTEEVENTS"                                                       */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS CHARTEVENTS;
CREATE TABLE CHARTEVENTS (	-- rows=263201375
   ROW_ID           INT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID       MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID          MEDIUMINT UNSIGNED,
   ICUSTAY_ID       MEDIUMINT UNSIGNED,
   ITEMID           MEDIUMINT UNSIGNED NOT NULL,
   CHARTTIME        DATETIME NOT NULL,
   STORETIME        DATETIME,
   CGID             SMALLINT UNSIGNED,
   VALUE            TEXT,	-- max=91
   VALUENUM         DECIMAL(22, 10),
   VALUEUOM         VARCHAR(50),	-- max=17
   WARNING          TINYINT UNSIGNED,
   ERROR            TINYINT UNSIGNED,
   RESULTSTATUS     VARCHAR(50),	-- max=6
   STOPPED          VARCHAR(50)	-- max=8
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "CPTEVENTS"                                                          */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS CPTEVENTS;
CREATE TABLE CPTEVENTS 
  (	-- rows=573146
   ROW_ID               MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID           MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID              MEDIUMINT UNSIGNED NOT NULL,
   COSTCENTER           VARCHAR(10) NOT NULL,	-- max=4
   CHARTDATE            DATETIME,
   CPT_CD               VARCHAR(10) NOT NULL,	-- max=5
   CPT_NUMBER           MEDIUMINT UNSIGNED,
   CPT_SUFFIX           VARCHAR(5),	-- max=1
   TICKET_ID_SEQ        SMALLINT UNSIGNED,
   SECTIONHEADER        VARCHAR(50),	-- max=25
   SUBSECTIONHEADER     VARCHAR(255),	-- max=169
   DESCRIPTION          VARCHAR(200)	-- max=30
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "D_CPT"                                                              */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS D_CPT;
CREATE TABLE D_CPT 
  (	-- rows=134
   ROW_ID                   TINYINT UNSIGNED NOT NULL PRIMARY KEY,
   CATEGORY                 TINYINT UNSIGNED NOT NULL,
   SECTIONRANGE             VARCHAR(100) NOT NULL,	-- max=37
   SECTIONHEADER            VARCHAR(50) NOT NULL,	-- max=25
   SUBSECTIONRANGE          VARCHAR(100) NOT NULL,	-- max=11
   SUBSECTIONHEADER         VARCHAR(255) NOT NULL,	-- max=169
   CODESUFFIX               VARCHAR(5),	-- max=1
   MINCODEINSUBSECTION      MEDIUMINT UNSIGNED NOT NULL,
   MAXCODEINSUBSECTION      MEDIUMINT UNSIGNED NOT NULL,
   UNIQUE KEY               D_CPT_SUBSECTIONRANGE (SUBSECTIONRANGE),	-- nvals=134
   UNIQUE KEY               D_CPT_MAXCODEINSUBSECTION (MAXCODEINSUBSECTION)	-- nvals=134
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "D_ICD_DIAGNOSES"                                                    */
/* ---------------------------------------------------------------------------------------*/   
DROP TABLE IF EXISTS D_ICD_DIAGNOSES;
CREATE TABLE D_ICD_DIAGNOSES 
  (	-- rows=14567
   ROW_ID       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   ICD9_CODE    VARCHAR(10) NOT NULL,	-- max=5
   SHORT_TITLE  VARCHAR(50) NOT NULL,	-- max=24
   LONG_TITLE   VARCHAR(255) NOT NULL,	-- max=222
   UNIQUE KEY   D_ICD_DIAGNOSES_ICD9_CODE (ICD9_CODE)	-- nvals=14567
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "D_ICD_PROCEDURES"                                                   */
/* ---------------------------------------------------------------------------------------*/ 
DROP TABLE IF EXISTS D_ICD_PROCEDURES;
CREATE TABLE D_ICD_PROCEDURES 
  (	-- rows=3882
   ROW_ID       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   ICD9_CODE    VARCHAR(10) NOT NULL,	-- max=4
   SHORT_TITLE  VARCHAR(50) NOT NULL,	-- max=24
   LONG_TITLE   VARCHAR(255) NOT NULL,	-- max=163
   UNIQUE KEY   D_ICD_PROCEDURES_ICD9_CODE (ICD9_CODE),	-- nvals=3882
   UNIQUE KEY   D_ICD_PROCEDURES_SHORT_TITLE (SHORT_TITLE)	-- nvals=3882
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "D_ITEMS"                                                            */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS D_ITEMS;
CREATE TABLE D_ITEMS 
  (	-- rows=12478
   ROW_ID           MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   ITEMID           MEDIUMINT UNSIGNED NOT NULL,
   LABEL            VARCHAR(200),	-- max=95
   ABBREVIATION     VARCHAR(100),	-- max=50
   DBSOURCE         VARCHAR(20) NOT NULL,	-- max=10
   LINKSTO          VARCHAR(50),	-- max=18
   CATEGORY         VARCHAR(100),	-- max=27
   UNITNAME         VARCHAR(100),	-- max=19
   PARAM_TYPE       VARCHAR(30),	-- max=16
   CONCEPTID        INT,	-- max=0
   UNIQUE KEY       D_ITEMS_ITEMID (ITEMID)	-- nvals=12478
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "D_LABITEMS"                                                         */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS D_LABITEMS;
CREATE TABLE D_LABITEMS 
  (	-- rows=755
   ROW_ID       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   ITEMID       SMALLINT UNSIGNED NOT NULL,
   LABEL        VARCHAR(100) NOT NULL,	-- max=36
   FLUID        VARCHAR(100) NOT NULL,	-- max=25
   CATEGORY     VARCHAR(100) NOT NULL,	-- max=10
   LOINC_CODE   VARCHAR(100),	-- max=7
   UNIQUE KEY   D_LABITEMS_ITEMID (ITEMID)	-- nvals=755
  )
  CHARACTER SET = utf8mb4;
   
/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "DATETIMEEVENTS"                                                     */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS DATETIMEEVENTS;
CREATE TABLE DATETIMEEVENTS 
  (	-- rows=4486049
   ROW_ID           MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID       MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID          MEDIUMINT UNSIGNED,
   ICUSTAY_ID       MEDIUMINT UNSIGNED,
   ITEMID           MEDIUMINT UNSIGNED NOT NULL,
   CHARTTIME        DATETIME NOT NULL,
   STORETIME        DATETIME NOT NULL,
   CGID             SMALLINT UNSIGNED NOT NULL,
   VALUE            DATETIME,
   VALUEUOM         VARCHAR(50) NOT NULL,	-- max=13
   WARNING          TINYINT UNSIGNED,
   ERROR            TINYINT UNSIGNED,
   RESULTSTATUS     VARCHAR(50),	-- max=0
   STOPPED          VARCHAR(50)	-- max=8
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "DIAGNOSES_ICD"                                                      */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS DIAGNOSES_ICD;
CREATE TABLE DIAGNOSES_ICD 
  (	-- rows=651047
   ROW_ID       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID   MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID      MEDIUMINT UNSIGNED NOT NULL,
   SEQ_NUM      TINYINT UNSIGNED,
   ICD9_CODE    VARCHAR(10)	-- max=5
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "DRGCODES"                                                           */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS DRGCODES;
CREATE TABLE DRGCODES 
  (	-- rows=125557
   ROW_ID           MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID       MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID          MEDIUMINT UNSIGNED NOT NULL,
   DRG_TYPE         VARCHAR(20) NOT NULL,	-- max=4
   DRG_CODE         VARCHAR(20) NOT NULL,	-- max=4
   DESCRIPTION      VARCHAR(255),	-- max=193
   DRG_SEVERITY     TINYINT UNSIGNED,
   DRG_MORTALITY    TINYINT UNSIGNED
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "ICUSTAYS"                                                           */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS ICUSTAYS;
CREATE TABLE ICUSTAYS 
  (	-- rows=61532
   ROW_ID           MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID       MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID          MEDIUMINT UNSIGNED NOT NULL,
   ICUSTAY_ID       MEDIUMINT UNSIGNED NOT NULL,
   DBSOURCE         VARCHAR(20) NOT NULL,	-- max=10
   FIRST_CAREUNIT   VARCHAR(20) NOT NULL,	-- max=5
   LAST_CAREUNIT    VARCHAR(20) NOT NULL,	-- max=5
   FIRST_WARDID     TINYINT UNSIGNED NOT NULL,
   LAST_WARDID      TINYINT UNSIGNED NOT NULL,
   INTIME           DATETIME NOT NULL,
   OUTTIME          DATETIME,
   LOS              DECIMAL(22, 10),
   UNIQUE KEY       ICUSTAYS_ICUSTAY_ID (ICUSTAY_ID)	-- nvals=61532
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "INPUTEVENTS_CV"                                                     */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS INPUTEVENTS_CV;
CREATE TABLE INPUTEVENTS_CV 
  (	-- rows=17528894
   ROW_ID               INT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID           MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID              MEDIUMINT UNSIGNED,
   ICUSTAY_ID           MEDIUMINT UNSIGNED,
   CHARTTIME            DATETIME NOT NULL,
   ITEMID               SMALLINT UNSIGNED NOT NULL,
   AMOUNT               DECIMAL(22, 10),
   AMOUNTUOM            VARCHAR(30),	-- max=3
   RATE                 DECIMAL(22, 10),
   RATEUOM              VARCHAR(30),	-- max=8
   STORETIME            DATETIME NOT NULL,
   CGID                 SMALLINT UNSIGNED,
   ORDERID              MEDIUMINT UNSIGNED NOT NULL,
   LINKORDERID          MEDIUMINT UNSIGNED NOT NULL,
   STOPPED              VARCHAR(30),	-- max=8
   NEWBOTTLE            TINYINT UNSIGNED DEFAULT NULL,
   ORIGINALAMOUNT       DECIMAL(22, 10),
   ORIGINALAMOUNTUOM    VARCHAR(30),	-- max=3
   ORIGINALROUTE        VARCHAR(30),	-- max=20
   ORIGINALRATE         DECIMAL(22, 10),
   ORIGINALRATEUOM      VARCHAR(30),	-- max=5
   ORIGINALSITE         VARCHAR(30)	-- max=20
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "INPUTEVENTS_MV"                                                     */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS INPUTEVENTS_MV;
CREATE TABLE INPUTEVENTS_MV 
  (	-- rows=3618991
   ROW_ID                           MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID                       MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID                          MEDIUMINT UNSIGNED NOT NULL,
   ICUSTAY_ID                       MEDIUMINT UNSIGNED,
   STARTTIME                        DATETIME NOT NULL,
   ENDTIME                          DATETIME NOT NULL,
   ITEMID                           MEDIUMINT UNSIGNED NOT NULL,
   AMOUNT                           DECIMAL(22, 10) NOT NULL,
   AMOUNTUOM                        VARCHAR(30) NOT NULL,	-- max=19
   RATE                             DECIMAL(22, 10),
   RATEUOM                          VARCHAR(30),	-- max=12
   STORETIME                        DATETIME NOT NULL,
   CGID                             SMALLINT UNSIGNED NOT NULL,
   ORDERID                          MEDIUMINT UNSIGNED NOT NULL,
   LINKORDERID                      MEDIUMINT UNSIGNED NOT NULL,
   ORDERCATEGORYNAME                VARCHAR(100) NOT NULL,	-- max=24
   SECONDARYORDERCATEGORYNAME       VARCHAR(100),	-- max=24
   ORDERCOMPONENTTYPEDESCRIPTION    VARCHAR(60) NOT NULL,	-- max=57
   ORDERCATEGORYDESCRIPTION         VARCHAR(50) NOT NULL,	-- max=14
   PATIENTWEIGHT                    DECIMAL(22, 10) NOT NULL,
   TOTALAMOUNT                      DECIMAL(22, 10),
   TOTALAMOUNTUOM                   VARCHAR(255),	-- max=2
   ISOPENBAG                        TINYINT UNSIGNED NOT NULL,
   CONTINUEINNEXTDEPT               TINYINT UNSIGNED NOT NULL,
   CANCELREASON                     TINYINT UNSIGNED NOT NULL,
   STATUSDESCRIPTION                VARCHAR(30) NOT NULL,	-- max=15
   COMMENTS_EDITEDBY                VARCHAR(30),	-- max=15
   COMMENTS_CANCELEDBY              VARCHAR(30),	-- max=15
   COMMENTS_DATE                    DATETIME,
   ORIGINALAMOUNT                   DECIMAL(22, 10) NOT NULL,
   ORIGINALRATE                     DECIMAL(22, 10) NOT NULL
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "LABEVENTS"                                                          */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS LABEVENTS;
CREATE TABLE LABEVENTS 
  (	-- rows=27872575
   ROW_ID       INT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID   MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID      MEDIUMINT UNSIGNED,
   ITEMID       SMALLINT UNSIGNED NOT NULL,
   CHARTTIME    DATETIME NOT NULL,
   VALUE        VARCHAR(200),	-- max=100
   VALUENUM     DECIMAL(22, 10),
   VALUEUOM     VARCHAR(20),	-- max=10
   FLAG         VARCHAR(20)	-- max=8
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "MICROBIOLOGYEVENTS"                                                 */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS MICROBIOLOGYEVENTS;
CREATE TABLE MICROBIOLOGYEVENTS 
  (	-- rows=328446
   ROW_ID               MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID           MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID              MEDIUMINT UNSIGNED,
   CHARTDATE            DATETIME NOT NULL,
   CHARTTIME            DATETIME,
   SPEC_ITEMID          MEDIUMINT UNSIGNED,
   SPEC_TYPE_DESC       VARCHAR(100) NOT NULL,	-- max=56
   ORG_ITEMID           MEDIUMINT UNSIGNED,
   ORG_NAME             VARCHAR(100),	-- max=70
   ISOLATE_NUM          TINYINT UNSIGNED,
   AB_ITEMID            MEDIUMINT UNSIGNED,
   AB_NAME              VARCHAR(30),	-- max=20
   DILUTION_TEXT        VARCHAR(10),	-- max=6
   DILUTION_COMPARISON  VARCHAR(20),	-- max=2
   DILUTION_VALUE       SMALLINT UNSIGNED,
   INTERPRETATION       VARCHAR(5)	-- max=1
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "NOTEEVENTS"                                                         */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS NOTEEVENTS;
CREATE TABLE NOTEEVENTS 
  (	-- rows=2078705
   ROW_ID       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID   MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID      MEDIUMINT UNSIGNED,
   CHARTDATE    DATE NOT NULL,
   CHARTTIME    DATETIME,
   STORETIME    DATETIME,
   CATEGORY     VARCHAR(50) NOT NULL,	-- max=17
   DESCRIPTION  VARCHAR(255) NOT NULL,	-- max=80
   CGID         SMALLINT UNSIGNED,
   ISERROR      TINYINT UNSIGNED,
   TEXT         MEDIUMTEXT	-- max=55725
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "OUTPUTEVENTS"                                                       */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS OUTPUTEVENTS;
CREATE TABLE OUTPUTEVENTS 
  (	-- rows=4349339
   ROW_ID       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID   MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID      MEDIUMINT UNSIGNED,
   ICUSTAY_ID   MEDIUMINT UNSIGNED,
   CHARTTIME    DATETIME NOT NULL,
   ITEMID       MEDIUMINT UNSIGNED NOT NULL,
   VALUE        DECIMAL(22, 10),
   VALUEUOM     VARCHAR(30),	-- max=2
   STORETIME    DATETIME NOT NULL,
   CGID         SMALLINT UNSIGNED NOT NULL,
   STOPPED      VARCHAR(30),	-- max=0
   NEWBOTTLE    CHAR(1),	-- max=0
   ISERROR      TINYINT UNSIGNED	-- max=0
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "PATIENTS"                                                           */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS PATIENTS;
CREATE TABLE PATIENTS 
  (	-- rows=46520
   ROW_ID       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID   MEDIUMINT UNSIGNED NOT NULL,
   GENDER       VARCHAR(5) NOT NULL,	-- max=1
   DOB          DATETIME NOT NULL,
   DOD          DATETIME,
   DOD_HOSP     DATETIME,
   DOD_SSN      DATETIME,
   EXPIRE_FLAG  TINYINT UNSIGNED NOT NULL,
   UNIQUE KEY   PATIENTS_SUBJECT_ID (SUBJECT_ID)	-- nvals=46520
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "PRESCRIPTIONS"                                                      */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS PRESCRIPTIONS;
CREATE TABLE PRESCRIPTIONS 
  (	-- rows=4156848
   ROW_ID               MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID           MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID              MEDIUMINT UNSIGNED NOT NULL,
   ICUSTAY_ID           MEDIUMINT UNSIGNED,
   STARTDATE            DATETIME,
   ENDDATE              DATETIME,
   DRUG_TYPE            VARCHAR(100) NOT NULL,	-- max=8
   DRUG                 VARCHAR(100),	-- max=58
   DRUG_NAME_POE        VARCHAR(100),	-- max=58
   DRUG_NAME_GENERIC    VARCHAR(100),	-- max=49
   FORMULARY_DRUG_CD    VARCHAR(120),	-- max=17
   GSN                  VARCHAR(200),	-- max=125
   NDC                  VARCHAR(120),	-- max=11
   PROD_STRENGTH        VARCHAR(120),	-- max=60
   DOSE_VAL_RX          VARCHAR(120),	-- max=26
   DOSE_UNIT_RX         VARCHAR(120),	-- max=32
   FORM_VAL_DISP        VARCHAR(120),	-- max=47
   FORM_UNIT_DISP       VARCHAR(120),	-- max=13
   ROUTE                VARCHAR(120)	-- max=28
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "PROCEDUREEVENTS_MV"                                                 */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS PROCEDUREEVENTS_MV;
CREATE TABLE PROCEDUREEVENTS_MV 
  (	-- rows=258066
   ROW_ID                       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID                   MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID                      MEDIUMINT UNSIGNED NOT NULL,
   ICUSTAY_ID                   MEDIUMINT UNSIGNED,
   STARTTIME                    DATETIME NOT NULL,
   ENDTIME                      DATETIME NOT NULL,
   ITEMID                       MEDIUMINT UNSIGNED NOT NULL,
   VALUE                        DECIMAL(22, 10) NOT NULL,
   VALUEUOM                     VARCHAR(30) NOT NULL,	-- max=4
   LOCATION                     VARCHAR(30),	-- max=24
   LOCATIONCATEGORY             VARCHAR(30),	-- max=19
   STORETIME                    DATETIME NOT NULL,
   CGID                         SMALLINT UNSIGNED NOT NULL,
   ORDERID                      MEDIUMINT UNSIGNED NOT NULL,
   LINKORDERID                  MEDIUMINT UNSIGNED NOT NULL,
   ORDERCATEGORYNAME            VARCHAR(100) NOT NULL,	-- max=21
   SECONDARYORDERCATEGORYNAME   VARCHAR(100),	-- max=0
   ORDERCATEGORYDESCRIPTION     VARCHAR(50) NOT NULL,	-- max=12
   ISOPENBAG                    TINYINT UNSIGNED NOT NULL,
   CONTINUEINNEXTDEPT           TINYINT UNSIGNED NOT NULL,
   CANCELREASON                 TINYINT UNSIGNED NOT NULL,
   STATUSDESCRIPTION            VARCHAR(30) NOT NULL,	-- max=15
   COMMENTS_EDITEDBY            VARCHAR(30),	-- max=7
   COMMENTS_CANCELEDBY          VARCHAR(30),	-- max=17
   COMMENTS_DATE                DATETIME,
   UNIQUE KEY                   PROCEDUREEVENTS_MV_ORDERID (ORDERID)	-- nvals=258066
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "PROCEDURES_ICD"                                                     */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS PROCEDURES_ICD;
CREATE TABLE PROCEDURES_ICD 
  (	-- rows=240095
   ROW_ID       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID   MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID      MEDIUMINT UNSIGNED NOT NULL,
   SEQ_NUM      TINYINT UNSIGNED NOT NULL,
   ICD9_CODE    VARCHAR(10) NOT NULL	-- max=4
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "SERVICES"                                                           */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS SERVICES;
CREATE TABLE SERVICES 
  (	-- rows=73343
   ROW_ID           MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID       MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID          MEDIUMINT UNSIGNED NOT NULL,
   TRANSFERTIME     DATETIME NOT NULL,
   PREV_SERVICE     VARCHAR(20),	-- max=5
   CURR_SERVICE     VARCHAR(20) NOT NULL	-- max=5
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "TRANSFERS"                                                          */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS TRANSFERS;
CREATE TABLE TRANSFERS 
  (	-- rows=261897
   ROW_ID           MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID       MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID          MEDIUMINT UNSIGNED NOT NULL,
   ICUSTAY_ID       MEDIUMINT UNSIGNED,
   DBSOURCE         VARCHAR(20),	-- max=10
   EVENTTYPE        VARCHAR(20),	-- max=9
   PREV_CAREUNIT    VARCHAR(20),	-- max=5
   CURR_CAREUNIT    VARCHAR(20),	-- max=5
   PREV_WARDID      TINYINT UNSIGNED,
   CURR_WARDID      TINYINT UNSIGNED,
   INTIME           DATETIME,
   OUTTIME          DATETIME,
   LOS              DECIMAL(22, 10)
  )
  CHARACTER SET = utf8mb4;
