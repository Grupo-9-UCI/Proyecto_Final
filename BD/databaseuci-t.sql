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
  (
   ROW_ID               MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID           MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID              MEDIUMINT UNSIGNED NOT NULL,
   ADMITTIME            DATETIME NOT NULL,
   DISCHTIME            DATETIME NOT NULL,
   DEATHTIME            DATETIME,
   ADMISSION_TYPE       VARCHAR(50) NOT NULL,
   ADMISSION_LOCATION   VARCHAR(50) NOT NULL,
   DISCHARGE_LOCATION   VARCHAR(50) NOT NULL,
   INSURANCE            VARCHAR(255) NOT NULL,
   LANGUAGE             VARCHAR(10),
   RELIGION             VARCHAR(50),
   MARITAL_STATUS       VARCHAR(50),
   ETHNICITY            VARCHAR(200) NOT NULL,	
   EDREGTIME            DATETIME,
   EDOUTTIME            DATETIME,
   DIAGNOSIS            VARCHAR(255),	
   HOSPITAL_EXPIRE_FLAG TINYINT UNSIGNED NOT NULL,
   HAS_CHARTEVENTS_DATA TINYINT UNSIGNED NOT NULL,
   UNIQUE KEY           ADMISSIONS_HADM_ID (HADM_ID)	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "CALLOUT"                                                            */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS CALLOUT;
CREATE TABLE CALLOUT 
  (	
   ROW_ID                   MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID               MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID                  MEDIUMINT UNSIGNED NOT NULL,
   SUBMIT_WARDID            TINYINT UNSIGNED,
   SUBMIT_CAREUNIT          VARCHAR(15),	
   CURR_WARDID              TINYINT UNSIGNED,
   CURR_CAREUNIT            VARCHAR(15),	
   CALLOUT_WARDID           TINYINT UNSIGNED NOT NULL,
   CALLOUT_SERVICE          VARCHAR(10) NOT NULL,	
   REQUEST_TELE             TINYINT UNSIGNED NOT NULL,
   REQUEST_RESP             TINYINT UNSIGNED NOT NULL,
   REQUEST_CDIFF            TINYINT UNSIGNED NOT NULL,
   REQUEST_MRSA             TINYINT UNSIGNED NOT NULL,
   REQUEST_VRE              TINYINT UNSIGNED NOT NULL,
   CALLOUT_STATUS           VARCHAR(20) NOT NULL,	
   CALLOUT_OUTCOME          VARCHAR(20) NOT NULL,	
   DISCHARGE_WARDID         TINYINT UNSIGNED,
   ACKNOWLEDGE_STATUS       VARCHAR(20) NOT NULL,	
   CREATETIME               DATETIME NOT NULL,
   UPDATETIME               DATETIME NOT NULL,
   ACKNOWLEDGETIME          DATETIME,
   OUTCOMETIME              DATETIME NOT NULL,
   FIRSTRESERVATIONTIME     DATETIME,
   CURRENTRESERVATIONTIME   DATETIME
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "CAREGIVERS"                                                         */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS CAREGIVERS;
CREATE TABLE CAREGIVERS 
  (	
   ROW_ID       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   CGID         SMALLINT UNSIGNED NOT NULL,
   LABEL        VARCHAR(15),	
   DESCRIPTION  VARCHAR(30),	
   UNIQUE KEY   CAREGIVERS_CGID (CGID)	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "CHARTEEVENTS"                                                       */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS CHARTEVENTS;
CREATE TABLE CHARTEVENTS (	
   ROW_ID           INT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID       MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID          MEDIUMINT UNSIGNED,
   ICUSTAY_ID       MEDIUMINT UNSIGNED,
   ITEMID           MEDIUMINT UNSIGNED NOT NULL,
   CHARTTIME        DATETIME NOT NULL,
   STORETIME        DATETIME,
   CGID             SMALLINT UNSIGNED,
   VALUE            TEXT,	
   VALUENUM         DECIMAL(22, 10),
   VALUEUOM         VARCHAR(50),
   WARNING          TINYINT UNSIGNED,
   ERROR            TINYINT UNSIGNED,
   RESULTSTATUS     VARCHAR(50),	
   STOPPED          VARCHAR(50)	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "CPTEVENTS"                                                          */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS CPTEVENTS;
CREATE TABLE CPTEVENTS 
  (
   ROW_ID               MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID           MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID              MEDIUMINT UNSIGNED NOT NULL,
   COSTCENTER           VARCHAR(10) NOT NULL,
   CHARTDATE            DATETIME,
   CPT_CD               VARCHAR(10) NOT NULL,
   CPT_NUMBER           MEDIUMINT UNSIGNED,
   CPT_SUFFIX           VARCHAR(5),
   TICKET_ID_SEQ        SMALLINT UNSIGNED,
   SECTIONHEADER        VARCHAR(50),	
   SUBSECTIONHEADER     VARCHAR(255),	
   DESCRIPTION          VARCHAR(200)	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "D_CPT"                                                              */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS D_CPT;
CREATE TABLE D_CPT 
  (
   ROW_ID                   TINYINT UNSIGNED NOT NULL PRIMARY KEY,
   CATEGORY                 TINYINT UNSIGNED NOT NULL,
   SECTIONRANGE             VARCHAR(100) NOT NULL,	
   SECTIONHEADER            VARCHAR(50) NOT NULL,	
   SUBSECTIONRANGE          VARCHAR(100) NOT NULL,	
   SUBSECTIONHEADER         VARCHAR(255) NOT NULL,
   CODESUFFIX               VARCHAR(5),	
   MINCODEINSUBSECTION      MEDIUMINT UNSIGNED NOT NULL,
   MAXCODEINSUBSECTION      MEDIUMINT UNSIGNED NOT NULL,
   UNIQUE KEY               D_CPT_SUBSECTIONRANGE (SUBSECTIONRANGE),	
   UNIQUE KEY               D_CPT_MAXCODEINSUBSECTION (MAXCODEINSUBSECTION)	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "D_ICD_DIAGNOSES"                                                    */
/* ---------------------------------------------------------------------------------------*/   
DROP TABLE IF EXISTS D_ICD_DIAGNOSES;
CREATE TABLE D_ICD_DIAGNOSES 
  (	
   ROW_ID       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   ICD9_CODE    VARCHAR(10) NOT NULL,	
   SHORT_TITLE  VARCHAR(50) NOT NULL,	
   LONG_TITLE   VARCHAR(255) NOT NULL,	
   UNIQUE KEY   D_ICD_DIAGNOSES_ICD9_CODE (ICD9_CODE)	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "D_ICD_PROCEDURES"                                                   */
/* ---------------------------------------------------------------------------------------*/ 
DROP TABLE IF EXISTS D_ICD_PROCEDURES;
CREATE TABLE D_ICD_PROCEDURES 
  (	
   ROW_ID       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   ICD9_CODE    VARCHAR(10) NOT NULL,	
   SHORT_TITLE  VARCHAR(50) NOT NULL,	
   LONG_TITLE   VARCHAR(255) NOT NULL	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "D_ITEMS"                                                            */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS D_ITEMS;
CREATE TABLE D_ITEMS 
  (
   ROW_ID           MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   ITEMID           MEDIUMINT UNSIGNED NOT NULL,
   LABEL            VARCHAR(200),	
   ABBREVIATION     VARCHAR(100),	
   DBSOURCE         VARCHAR(20) NOT NULL,	
   LINKSTO          VARCHAR(50),	
   CATEGORY         VARCHAR(100),	
   UNITNAME         VARCHAR(100),	
   PARAM_TYPE       VARCHAR(30),	
   CONCEPTID        INT,	
   UNIQUE KEY       D_ITEMS_ITEMID (ITEMID)	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "D_LABITEMS"                                                         */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS D_LABITEMS;
CREATE TABLE D_LABITEMS 
  (	
   ROW_ID       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   ITEMID       SMALLINT UNSIGNED NOT NULL,
   LABEL        VARCHAR(100) NOT NULL,	
   FLUID        VARCHAR(100) NOT NULL,	
   CATEGORY     VARCHAR(100) NOT NULL,	
   LOINC_CODE   VARCHAR(100),	
   UNIQUE KEY   D_LABITEMS_ITEMID (ITEMID)	
  )
  CHARACTER SET = utf8mb4;
   
/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "DATETIMEEVENTS"                                                     */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS DATETIMEEVENTS;
CREATE TABLE DATETIMEEVENTS 
  (	
   ROW_ID           MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID       MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID          MEDIUMINT UNSIGNED,
   ICUSTAY_ID       MEDIUMINT UNSIGNED,
   ITEMID           MEDIUMINT UNSIGNED NOT NULL,
   CHARTTIME        DATETIME NOT NULL,
   STORETIME        DATETIME NOT NULL,
   CGID             SMALLINT UNSIGNED NOT NULL,
   VALUE            DATETIME,
   VALUEUOM         VARCHAR(50) NOT NULL,	
   WARNING          TINYINT UNSIGNED,
   ERROR            TINYINT UNSIGNED,
   RESULTSTATUS     VARCHAR(50),	
   STOPPED          VARCHAR(50)	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "DIAGNOSES_ICD"                                                      */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS DIAGNOSES_ICD;
CREATE TABLE DIAGNOSES_ICD 
  (	
   ROW_ID       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID   MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID      MEDIUMINT UNSIGNED NOT NULL,
   SEQ_NUM      TINYINT UNSIGNED,
   ICD9_CODE    VARCHAR(10)	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "DRGCODES"                                                           */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS DRGCODES;
CREATE TABLE DRGCODES 
  (	
   ROW_ID           MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID       MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID          MEDIUMINT UNSIGNED NOT NULL,
   DRG_TYPE         VARCHAR(20) NOT NULL,	
   DRG_CODE         VARCHAR(20) NOT NULL,	
   DESCRIPTION      VARCHAR(255),	
   DRG_SEVERITY     TINYINT UNSIGNED,
   DRG_MORTALITY    TINYINT UNSIGNED
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "ICUSTAYS"                                                           */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS ICUSTAYS;
CREATE TABLE ICUSTAYS 
  (	
   ROW_ID           MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID       MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID          MEDIUMINT UNSIGNED NOT NULL,
   ICUSTAY_ID       MEDIUMINT UNSIGNED NOT NULL,
   DBSOURCE         VARCHAR(20) NOT NULL,	
   FIRST_CAREUNIT   VARCHAR(20) NOT NULL,	
   LAST_CAREUNIT    VARCHAR(20) NOT NULL,	
   FIRST_WARDID     TINYINT UNSIGNED NOT NULL,
   LAST_WARDID      TINYINT UNSIGNED NOT NULL,
   INTIME           DATETIME NOT NULL,
   OUTTIME          DATETIME,
   LOS              DECIMAL(22, 10),
   UNIQUE KEY       ICUSTAYS_ICUSTAY_ID (ICUSTAY_ID)	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "INPUTEVENTS_CV"                                                     */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS INPUTEVENTS_CV;
CREATE TABLE INPUTEVENTS_CV 
  (	
   ROW_ID               INT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID           MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID              MEDIUMINT UNSIGNED,
   ICUSTAY_ID           MEDIUMINT UNSIGNED,
   CHARTTIME            DATETIME NOT NULL,
   ITEMID               SMALLINT UNSIGNED NOT NULL,
   AMOUNT               DECIMAL(22, 10),
   AMOUNTUOM            VARCHAR(30),	
   RATE                 DECIMAL(22, 10),
   RATEUOM              VARCHAR(30),	
   STORETIME            DATETIME NOT NULL,
   CGID                 SMALLINT UNSIGNED,
   ORDERID              MEDIUMINT UNSIGNED NOT NULL,
   LINKORDERID          MEDIUMINT UNSIGNED NOT NULL,
   STOPPED              VARCHAR(30),	
   NEWBOTTLE            TINYINT UNSIGNED DEFAULT NULL,
   ORIGINALAMOUNT       DECIMAL(22, 10),
   ORIGINALAMOUNTUOM    VARCHAR(30),	
   ORIGINALROUTE        VARCHAR(30),	
   ORIGINALRATE         DECIMAL(22, 10),
   ORIGINALRATEUOM      VARCHAR(30),	
   ORIGINALSITE         VARCHAR(30)	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "INPUTEVENTS_MV"                                                     */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS INPUTEVENTS_MV;
CREATE TABLE INPUTEVENTS_MV 
  (	
   ROW_ID                           MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID                       MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID                          MEDIUMINT UNSIGNED NOT NULL,
   ICUSTAY_ID                       MEDIUMINT UNSIGNED,
   STARTTIME                        DATETIME NOT NULL,
   ENDTIME                          DATETIME NOT NULL,
   ITEMID                           MEDIUMINT UNSIGNED NOT NULL,
   AMOUNT                           DECIMAL(22, 10) NOT NULL,
   AMOUNTUOM                        VARCHAR(30) NOT NULL,	
   RATE                             DECIMAL(22, 10),
   RATEUOM                          VARCHAR(30),	
   STORETIME                        DATETIME NOT NULL,
   CGID                             SMALLINT UNSIGNED NOT NULL,
   ORDERID                          MEDIUMINT UNSIGNED NOT NULL,
   LINKORDERID                      MEDIUMINT UNSIGNED NOT NULL,
   ORDERCATEGORYNAME                VARCHAR(100) NOT NULL,	
   SECONDARYORDERCATEGORYNAME       VARCHAR(100),	
   ORDERCOMPONENTTYPEDESCRIPTION    VARCHAR(60) NOT NULL,	
   ORDERCATEGORYDESCRIPTION         VARCHAR(50) NOT NULL,	
   PATIENTWEIGHT                    DECIMAL(22, 10) NOT NULL,
   TOTALAMOUNT                      DECIMAL(22, 10),
   TOTALAMOUNTUOM                   VARCHAR(255),	
   ISOPENBAG                        TINYINT UNSIGNED NOT NULL,
   CONTINUEINNEXTDEPT               TINYINT UNSIGNED NOT NULL,
   CANCELREASON                     TINYINT UNSIGNED NOT NULL,
   STATUSDESCRIPTION                VARCHAR(30) NOT NULL,	
   COMMENTS_EDITEDBY                VARCHAR(30),	
   COMMENTS_CANCELEDBY              VARCHAR(30),	
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
  (
   ROW_ID       INT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID   MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID      MEDIUMINT UNSIGNED,
   ITEMID       SMALLINT UNSIGNED NOT NULL,
   CHARTTIME    DATETIME NOT NULL,
   VALUE        VARCHAR(200),	
   VALUENUM     DECIMAL(22, 10),
   VALUEUOM     VARCHAR(20),	
   FLAG         VARCHAR(20)	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "MICROBIOLOGYEVENTS"                                                 */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS MICROBIOLOGYEVENTS;
CREATE TABLE MICROBIOLOGYEVENTS 
  (	
   ROW_ID               MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID           MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID              MEDIUMINT UNSIGNED,
   CHARTDATE            DATETIME NOT NULL,
   CHARTTIME            DATETIME,
   SPEC_ITEMID          MEDIUMINT UNSIGNED,
   SPEC_TYPE_DESC       VARCHAR(100) NOT NULL,	
   ORG_ITEMID           MEDIUMINT UNSIGNED,
   ORG_NAME             VARCHAR(100),	
   ISOLATE_NUM          TINYINT UNSIGNED,
   AB_ITEMID            MEDIUMINT UNSIGNED,
   AB_NAME              VARCHAR(30),	
   DILUTION_TEXT        VARCHAR(10),	
   DILUTION_COMPARISON  VARCHAR(20),	
   DILUTION_VALUE       SMALLINT UNSIGNED,
   INTERPRETATION       VARCHAR(5)	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "NOTEEVENTS"                                                         */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS NOTEEVENTS;
CREATE TABLE NOTEEVENTS 
  (	
   ROW_ID       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID   MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID      MEDIUMINT UNSIGNED,
   CHARTDATE    DATE NOT NULL,
   CHARTTIME    DATETIME,
   STORETIME    DATETIME,
   CATEGORY     VARCHAR(50) NOT NULL,	
   DESCRIPTION  VARCHAR(255) NOT NULL,	
   CGID         SMALLINT UNSIGNED,
   ISERROR      TINYINT UNSIGNED,
   TEXT         MEDIUMTEXT	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "OUTPUTEVENTS"                                                       */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS OUTPUTEVENTS;
CREATE TABLE OUTPUTEVENTS 
  (	
   ROW_ID       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID   MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID      MEDIUMINT UNSIGNED,
   ICUSTAY_ID   MEDIUMINT UNSIGNED,
   CHARTTIME    DATETIME NOT NULL,
   ITEMID       MEDIUMINT UNSIGNED NOT NULL,
   VALUE        DECIMAL(22, 10),
   VALUEUOM     VARCHAR(30),	
   STORETIME    DATETIME NOT NULL,
   CGID         SMALLINT UNSIGNED NOT NULL,
   STOPPED      VARCHAR(30),	
   NEWBOTTLE    CHAR(1),	
   ISERROR      TINYINT UNSIGNED	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "PATIENTS"                                                           */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS PATIENTS;
CREATE TABLE PATIENTS 
  (	
   ROW_ID       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID   MEDIUMINT UNSIGNED NOT NULL,
   GENDER       VARCHAR(5) NOT NULL,	
   DOB          DATETIME NOT NULL,
   DOD          DATETIME,
   DOD_HOSP     DATETIME,
   DOD_SSN      DATETIME,
   EXPIRE_FLAG  TINYINT UNSIGNED NOT NULL,
   UNIQUE KEY   PATIENTS_SUBJECT_ID (SUBJECT_ID)	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "PRESCRIPTIONS"                                                      */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS PRESCRIPTIONS;
CREATE TABLE PRESCRIPTIONS 
  (	
   ROW_ID               MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID           MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID              MEDIUMINT UNSIGNED NOT NULL,
   ICUSTAY_ID           MEDIUMINT UNSIGNED,
   STARTDATE            DATETIME,
   ENDDATE              DATETIME,
   DRUG_TYPE            VARCHAR(100) NOT NULL,	
   DRUG                 VARCHAR(100),	
   DRUG_NAME_POE        VARCHAR(100),	
   DRUG_NAME_GENERIC    VARCHAR(100),	
   FORMULARY_DRUG_CD    VARCHAR(120),	
   GSN                  VARCHAR(200),	
   NDC                  VARCHAR(120),	
   PROD_STRENGTH        VARCHAR(120),	
   DOSE_VAL_RX          VARCHAR(120),	
   DOSE_UNIT_RX         VARCHAR(120),	
   FORM_VAL_DISP        VARCHAR(120),	
   FORM_UNIT_DISP       VARCHAR(120),	
   ROUTE                VARCHAR(120)	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "PROCEDUREEVENTS_MV"                                                 */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS PROCEDUREEVENTS_MV;
CREATE TABLE PROCEDUREEVENTS_MV 
  (	
   ROW_ID                       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID                   MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID                      MEDIUMINT UNSIGNED NOT NULL,
   ICUSTAY_ID                   MEDIUMINT UNSIGNED,
   STARTTIME                    DATETIME NOT NULL,
   ENDTIME                      DATETIME NOT NULL,
   ITEMID                       MEDIUMINT UNSIGNED NOT NULL,
   VALUE                        DECIMAL(22, 10) NOT NULL,
   VALUEUOM                     VARCHAR(30) NOT NULL,	
   LOCATION                     VARCHAR(30),	
   LOCATIONCATEGORY             VARCHAR(30),	
   STORETIME                    DATETIME NOT NULL,
   CGID                         SMALLINT UNSIGNED NOT NULL,
   ORDERID                      MEDIUMINT UNSIGNED NOT NULL,
   LINKORDERID                  MEDIUMINT UNSIGNED NOT NULL,
   ORDERCATEGORYNAME            VARCHAR(100) NOT NULL,	
   SECONDARYORDERCATEGORYNAME   VARCHAR(100),	
   ORDERCATEGORYDESCRIPTION     VARCHAR(50) NOT NULL,	
   ISOPENBAG                    TINYINT UNSIGNED NOT NULL,
   CONTINUEINNEXTDEPT           TINYINT UNSIGNED NOT NULL,
   CANCELREASON                 TINYINT UNSIGNED NOT NULL,
   STATUSDESCRIPTION            VARCHAR(30) NOT NULL,	
   COMMENTS_EDITEDBY            VARCHAR(30),	
   COMMENTS_CANCELEDBY          VARCHAR(30),	
   COMMENTS_DATE                DATETIME,
   UNIQUE KEY                   PROCEDUREEVENTS_MV_ORDERID (ORDERID)	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "PROCEDURES_ICD"                                                     */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS PROCEDURES_ICD;
CREATE TABLE PROCEDURES_ICD 
  (
   ROW_ID       MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID   MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID      MEDIUMINT UNSIGNED NOT NULL,
   SEQ_NUM      TINYINT UNSIGNED NOT NULL,
   ICD9_CODE    VARCHAR(10) NOT NULL	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "SERVICES"                                                           */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS SERVICES;
CREATE TABLE SERVICES 
  (	
   ROW_ID           MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID       MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID          MEDIUMINT UNSIGNED NOT NULL,
   TRANSFERTIME     DATETIME NOT NULL,
   PREV_SERVICE     VARCHAR(20),	
   CURR_SERVICE     VARCHAR(20) NOT NULL	
  )
  CHARACTER SET = utf8mb4;

/* ---------------------------------------------------------------------------------------*/
/* Creación de tabla "TRANSFERS"                                                          */
/* ---------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS TRANSFERS;
CREATE TABLE TRANSFERS 
  (	
   ROW_ID           MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
   SUBJECT_ID       MEDIUMINT UNSIGNED NOT NULL,
   HADM_ID          MEDIUMINT UNSIGNED NOT NULL,
   ICUSTAY_ID       MEDIUMINT UNSIGNED,
   DBSOURCE         VARCHAR(20),	
   EVENTTYPE        VARCHAR(20),	
   PREV_CAREUNIT    VARCHAR(20),	
   CURR_CAREUNIT    VARCHAR(20),	
   PREV_WARDID      TINYINT UNSIGNED,
   CURR_WARDID      TINYINT UNSIGNED,
   INTIME           DATETIME,
   OUTTIME          DATETIME,
   LOS              DECIMAL(22, 10)
  )
  CHARACTER SET = utf8mb4;
