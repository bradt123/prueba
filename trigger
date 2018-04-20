CREATE FUNCTION trigger_function() RETURN trigger AS
==========================================================
CREATE TRIGGER trigger_name {BEFORE | AFTER | INSTEAD OF} {event [OR ...]}
   ON table_name
   [FOR [EACH] {ROW | STATEMENT}]
   EXECUTE PROCEDURE trigger_function
   ==========================================================
   CREATE TABLE employees(
   id int4 serial primary key,
   first_name varchar(40) NOT NULL,
   last_name varchar(40) NOT NULL
);
   ==========================================================
CREATE TABLE employee_audits (
   id int4 serial primary key,
   employee_id int4 NOT NULL,
   last_name varchar(40) NOT NULL,
   changed_on timestamp(6) NOT NULL
)
   ==========================================================
   CREATE OR REPLACE FUNCTION log_last_name_changes()
  RETURNS trigger AS
$BODY$
BEGIN
 IF NEW.last_name <> OLD.last_name THEN
 INSERT INTO employee_audits(employee_id,last_name,changed_on)
 VALUES(OLD.id,OLD.last_name,now());
 END IF;
 
 RETURN NEW;
END;
$BODY$
   ==========================================================
   CREATE TRIGGER last_name_changes
  BEFORE UPDATE
  ON employees
  FOR EACH ROW
  EXECUTE PROCEDURE log_last_name_changes();
   ==========================================================
   INSERT INTO employees (first_name, last_name)
VALUES ('John', 'Doe');
 
INSERT INTO employees (first_name, last_name)
VALUES ('Lily', 'Bush');
   ==========================================================
   SELECT * FROM employees
   ==========================================================
   UPDATE employees
SET last_name = 'Brown'
WHERE ID = 2;
   ==========================================================
