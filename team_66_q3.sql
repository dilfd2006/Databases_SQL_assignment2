SELECT 
    a2.ID,
    p.Full_name AS patient_name,
    d.Full_name AS doctor_name,
    a2.Date,
    a2.Time,
    COUNT(a1.ID) AS earlier_appointments
FROM APPOINTMENT a2
JOIN PATIENT p ON p.ID = a2.Patient_ID
JOIN DOCTOR d ON d.ID = a2.Doctor_ID
JOIN APPOINTMENT a1 
    ON a1.Patient_ID = a2.Patient_ID
   AND a1.Date < a2.Date
GROUP BY a2.ID, p.Full_name, d.Full_name, a2.Date, a2.Time
HAVING COUNT(a1.ID) >= 3
ORDER BY p.Full_name ASC, a2.Date ASC, a2.Time ASC;
