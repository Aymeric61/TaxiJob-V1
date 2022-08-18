INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_taxi', 'Taxi', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_taxi', 'Taxi', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_taxi', 'Taxi', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('taxi','Taxi')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('taxi',0,'recruit','Stagiaire',20,'{}','{}'),
	('taxi',1,'recruit','Employé',40,'{}','{}'),
	('taxi',2,'recruit','Co-Patron',60,'{}','{}'),
	('taxi',3,'boss','Patron',100,'{}','{}')
;