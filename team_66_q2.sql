WITH patient_stats AS (
    SELECT 
        p.ID,
        p.Full_name,
        COUNT(DISTINCT dep.ID) AS distinct_departments,
        COUNT(a.ID) AS total_appointments,
        COUNT(diag.ID) AS total_diagnoses,
        COALESCE(SUM(proc.Price), 0) AS total_spent
    FROM PATIENT p
    JOIN APPOINTMENT a ON a.Patient_ID = p.ID
    JOIN DOCTOR d ON a.Doctor_ID = d.ID
    JOIN DEPARTMENT dep ON d.Department_ID = dep.ID
    LEFT JOIN DIAGNOSIS diag ON diag.Appointment_ID = a.ID
    LEFT JOIN APPOINTMENT_PROCEDURE ap ON ap.Appointment_ID = a.ID
    LEFT JOIN "PROCEDURE" proc ON proc.ID = ap.Procedure_ID
    GROUP BY p.ID, p.Full_name
),
avg_spent AS (
    SELECT AVG(total_spent) AS avg_total_spent 
    FROM patient_stats
    WHERE total_spent > 0
)
SELECT 
    ps.ID AS patient_id,
    ps.Full_name,
    ps.distinct_departments,
    ps.total_appointments,
    ps.total_diagnoses,
    ps.total_spent
FROM patient_stats ps, avg_spent av
WHERE ps.distinct_departments >= 3
  AND ps.total_spent > av.avg_total_spent
ORDER BY ps.total_spent DESC, ps.total_appointments DESC, ps.Full_name ASC;
