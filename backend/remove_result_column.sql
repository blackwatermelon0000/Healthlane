-- Remove result column from appointments table

ALTER TABLE appointments 
DROP COLUMN IF EXISTS result;

COMMENT ON TABLE appointments IS 'Appointments table without result/report functionality';
