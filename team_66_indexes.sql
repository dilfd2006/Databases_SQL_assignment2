CREATE INDEX idx_app_pat_doc_stat_date_time ON APPOINTMENT (Patient_ID, Doctor_ID, Status, Date, Time);
CREATE INDEX idx_doct_dep ON DOCTOR(Department_ID);
CREATE INDEX idx_app_proc_app_proc ON APPOINTMENT_PROCEDURE (Appointment_ID, Procedure_ID);
CREATE INDEX idx_diag_app ON DIAGNOSIS (Appointment_ID);