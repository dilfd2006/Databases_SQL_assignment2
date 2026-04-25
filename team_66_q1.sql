SELECT 
    d.ID,
    d.Full_name,
    dep.Name,
    COUNT(a.ID) AS total_appointments,
    COUNT(CASE WHEN LOWER(a.Status) = 'completed' THEN 1 END) AS completed_appointments,
    COUNT(CASE WHEN LOWER(a.Status) = 'cancelled' THEN 1 END) AS cancelled_appointments
FROM DOCTOR d
JOIN DEPARTMENT dep ON d.Department_ID = dep.ID
JOIN APPOINTMENT a ON a.Doctor_ID = d.ID
GROUP BY d.ID, d.Full_name, dep.Name
HAVING COUNT(a.ID) > 20
ORDER BY total_appointments DESC, d.Full_name ASC;
