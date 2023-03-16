
USE databaseuci;

/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "ADMISSIONS"                                                     */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE ADMISSIONS
  ADD INDEX ADMISSIONS_IDX01 (SUBJECT_ID, HADM_ID),
  ADD INDEX ADMISSIONS_IDX02 (ADMITTIME, DISCHTIME, DEATHTIME),
  ADD INDEX ADMISSIONS_IDX03 (ADMISSION_TYPE);

/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "CALLOUT"                                                        */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE CALLOUT
  ADD INDEX CALLOUT_IDX01 (SUBJECT_ID, HADM_ID),
  ADD INDEX CALLOUT_IDX02 (CURR_CAREUNIT),
  ADD INDEX CALLOUT_IDX03 (CALLOUT_SERVICE),
  ADD INDEX CALLOUT_IDX04 (CURR_WARDID, CALLOUT_WARDID, DISCHARGE_WARDID),
  ADD INDEX CALLOUT_IDX05 (CALLOUT_STATUS, CALLOUT_OUTCOME),
  ADD INDEX CALLOUT_IDX06 (CREATETIME, UPDATETIME, ACKNOWLEDGETIME, OUTCOMETIME);

/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "CAREGIVERS"                                                     */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE CAREGIVERS
  ADD INDEX CAREGIVERS_IDX01 (CGID, LABEL);

/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "CHARTEEEVENTS"                                                  */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE CHARTEVENTS 
  ADD INDEX CHARTEVENTS_idx01 (SUBJECT_ID, HADM_ID, ICUSTAY_ID),
  ADD INDEX CHARTEVENTS_idx02 (ITEMID),
  ADD INDEX CHARTEVENTS_idx03 (CHARTTIME, STORETIME),
  ADD INDEX CHARTEVENTS_idx04 (CGID);
  
/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "CPTEVENTS"                                                      */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE CPTEVENTS
  ADD INDEX CPTEVENTS_idx01 (SUBJECT_ID, HADM_ID),
  ADD INDEX CPTEVENTS_idx02  (CPT_CD, TICKET_ID_SEQ);

/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "D_ICD_DIAGNOSES"                                                */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE D_ICD_DIAGNOSES
  ADD INDEX D_ICD_DIAG_idx02 (SHORT_TITLE);

/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "D_ITEMS"                                                        */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE D_ITEMS
  ADD INDEX D_ITEMS_idx02 (LABEL(200), DBSOURCE),
  ADD INDEX D_ITEMS_idx03 (CATEGORY);
  
/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "D_LABITEMS"                                                     */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE D_LABITEMS
  ADD INDEX D_LABITEMS_idx02 (LABEL, FLUID, CATEGORY),
  ADD INDEX D_LABITEMS_idx03 (LOINC_CODE);

/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "DATETIMEEVENTS"                                                 */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE DATETIMEEVENTS
  ADD INDEX DATETIMEEVENTS_idx01 (SUBJECT_ID, HADM_ID, ICUSTAY_ID),
  ADD INDEX DATETIMEEVENTS_idx02 (ITEMID),
  ADD INDEX DATETIMEEVENTS_idx03 (CHARTTIME),
  ADD INDEX DATETIMEEVENTS_idx04 (CGID),
  ADD INDEX DATETIMEEVENTS_idx05 (VALUE);

/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "DIAGNOSES_ICD"                                                  */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE DIAGNOSES_ICD 
  ADD INDEX DIAGNOSES_ICD_idx01 (SUBJECT_ID, HADM_ID),
  ADD INDEX DIAGNOSES_ICD_idx02 (ICD9_CODE, SEQ_NUM);
  
/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "DRGCODES"                                                       */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE DRGCODES
  ADD INDEX DRGCODES_idx01 (SUBJECT_ID, HADM_ID),
  ADD INDEX DRGCODES_idx02 (DRG_CODE, DRG_TYPE),
  ADD INDEX DRGCODES_idx03 (DESCRIPTION(255), DRG_SEVERITY);
  
/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "ICUSTAYS"                                                       */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE ICUSTAYS
  ADD INDEX ICUSTAYS_idx01 (SUBJECT_ID, HADM_ID),
  ADD INDEX ICUSTAYS_idx02 (ICUSTAY_ID, DBSOURCE),
  ADD INDEX ICUSTAYS_idx03 (LOS),
  ADD INDEX ICUSTAYS_idx04 (FIRST_CAREUNIT),
  ADD INDEX ICUSTAYS_idx05 (LAST_CAREUNIT);

/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "INPUTEVENTS_CV"                                                 */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE INPUTEVENTS_CV
  ADD INDEX INPUTEVENTS_CV_idx01 (SUBJECT_ID, HADM_ID),
  ADD INDEX INPUTEVENTS_CV_idx03 (CHARTTIME, STORETIME),
  ADD INDEX INPUTEVENTS_CV_idx04 (ITEMID),
  ADD INDEX INPUTEVENTS_CV_idx05 (RATE),
  ADD INDEX INPUTEVENTS_CV_idx06 (AMOUNT),
  ADD INDEX INPUTEVENTS_CV_idx07 (CGID),
  ADD INDEX INPUTEVENTS_CV_idx08 (LINKORDERID, ORDERID);

/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "INPUTEVENTS_MV"                                                 */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE INPUTEVENTS_MV
  ADD INDEX INPUTEVENTS_MV_idx01 (SUBJECT_ID, HADM_ID),
  ADD INDEX INPUTEVENTS_MV_idx02 (ICUSTAY_ID),
  ADD INDEX INPUTEVENTS_MV_idx03 (ENDTIME, STARTTIME),
  ADD INDEX INPUTEVENTS_MV_idx04 (ITEMID),
  ADD INDEX INPUTEVENTS_MV_idx05 (RATE),
  ADD INDEX INPUTEVENTS_MV_idx06 (AMOUNT),
  ADD INDEX INPUTEVENTS_MV_idx07 (CGID),
  ADD INDEX INPUTEVENTS_MV_idx08 (LINKORDERID, ORDERID);

/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "LABEVENTS"                                                      */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE LABEVENTS 
  ADD INDEX LABEVENTS_idx01 (SUBJECT_ID, HADM_ID),
  ADD INDEX LABEVENTS_idx02 (ITEMID),
  ADD INDEX LABEVENTS_idx03 (CHARTTIME),
  ADD INDEX LABEVENTS_idx04 (VALUE(200), VALUENUM);
  
/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "MICROBIOLOGYEVENTS"                                             */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE MICROBIOLOGYEVENTS 
  ADD INDEX MICROBIOLOGYEVENTS_idx01 (SUBJECT_ID, HADM_ID),
  ADD INDEX MICROBIOLOGYEVENTS_idx02 (CHARTDATE, CHARTTIME),
  ADD INDEX MICROBIOLOGYEVENTS_idx03 (SPEC_ITEMID, ORG_ITEMID, AB_ITEMID);
  
/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "NOTEEVENTS"                                                     */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE NOTEEVENTS
  ADD INDEX NOTEEVENTS_idx01 (SUBJECT_ID, HADM_ID),
  ADD INDEX NOTEEVENTS_idx02 (CHARTDATE),
  ADD INDEX NOTEEVENTS_idx03 (CGID),
  ADD INDEX NOTEEVENTS_idx05 (CATEGORY, DESCRIPTION);
  
/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "OUTPUTEVENTS"                                                   */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE OUTPUTEVENTS
  ADD INDEX OUTPUTEVENTS_idx01 (SUBJECT_ID, HADM_ID),
  ADD INDEX OUTPUTEVENTS_idx02 (ICUSTAY_ID),
  ADD INDEX OUTPUTEVENTS_idx03 (CHARTTIME, STORETIME),
  ADD INDEX OUTPUTEVENTS_idx04 (ITEMID),
  ADD INDEX OUTPUTEVENTS_idx05 (VALUE),
  ADD INDEX OUTPUTEVENTS_idx06 (CGID);

/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "PATIENTS"                                                       */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE PATIENTS
  ADD INDEX PATIENTS_idx01 (EXPIRE_FLAG);

/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "PRESCRIPTIONS"                                                  */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE PRESCRIPTIONS
  ADD INDEX PRESCRIPTIONS_idx01 (SUBJECT_ID, HADM_ID),
  ADD INDEX PRESCRIPTIONS_idx02 (ICUSTAY_ID),
  ADD INDEX PRESCRIPTIONS_idx03 (DRUG_TYPE),
  ADD INDEX PRESCRIPTIONS_idx04 (DRUG),
  ADD INDEX PRESCRIPTIONS_idx05 (STARTDATE, ENDDATE);

/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "PROCEDURES_MV"                                                  */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE PROCEDUREEVENTS_MV
  ADD INDEX PROCEDUREEVENTS_MV_idx01 (SUBJECT_ID, HADM_ID),
  ADD INDEX PROCEDUREEVENTS_MV_idx02 (ICUSTAY_ID),
  ADD INDEX PROCEDUREEVENTS_MV_idx03 (ITEMID),
  ADD INDEX PROCEDUREEVENTS_MV_idx04 (CGID),
  ADD INDEX PROCEDUREEVENTS_MV_idx05 (ORDERCATEGORYNAME);

/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "PROCEDURES_ICD"                                                 */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE PROCEDURES_ICD
  ADD INDEX PROCEDURES_ICD_idx01 (SUBJECT_ID, HADM_ID),
  ADD INDEX PROCEDURES_ICD_idx02 (ICD9_CODE, SEQ_NUM);

/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "SERVICES"                                                       */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE SERVICES
  ADD INDEX SERVICES_idx01 (SUBJECT_ID, HADM_ID),
  ADD INDEX SERVICES_idx02 (TRANSFERTIME),
  ADD INDEX SERVICES_idx03 (CURR_SERVICE, PREV_SERVICE);

/* ---------------------------------------------------------------------------------------*/
/* Indices para la tabla "TRANSFERS"                                                      */
/* ---------------------------------------------------------------------------------------*/
ALTER TABLE TRANSFERS
  ADD INDEX TRANSFERS_idx01 (SUBJECT_ID, HADM_ID),
  ADD INDEX TRANSFERS_idx02 (ICUSTAY_ID),
  ADD INDEX TRANSFERS_idx03 (CURR_CAREUNIT, PREV_CAREUNIT),
  ADD INDEX TRANSFERS_idx04 (INTIME, OUTTIME),
  ADD INDEX TRANSFERS_idx05 (LOS);
