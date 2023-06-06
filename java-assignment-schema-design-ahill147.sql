
CREATE TABLE location (
    id SERIAL PRIMARY KEY,
    city CHARACTER VARYING NOT NULL,
    state CHARACTER VARYING NOT NULL,
    country CHARACTER VARYING NOT NULL
);

CREATE TABLE person (
    id SERIAL PRIMARY KEY,
    firstName CHARACTER VARYING NOT NULL,
    lastName CHARACTER VARYING NOT NULL,
    age INTEGER,
    location_id INTEGER REFERENCES location(id)
);

CREATE TABLE interest (
    id SERIAL PRIMARY KEY,
    title CHARACTER VARYING NOT NULL
);

CREATE TABLE person_interest (
    person_id INTEGER REFERENCES person(id),
    interest_id INTEGER REFERENCES interest(id),
    PRIMARY KEY (person_id, interest_id)
);


INSERT INTO location(city, state, country) VALUES ('Nashville', 'Tennessee', 'United States'), 
	('Memphis', 'Tennessee', 'United States'), ('Phoenix', 'Arizona', 'United States'),
	('Denver', 'Colorado', 'United States');


INSERT INTO person(firstName, lastName, age, location_id) VALUES ('Chickie', 'Ourtic', 21, 1),
	('Hilton', 'O''Hanley', 37, 1), ('Barbe', 'Purver', 50, 3), ('Reeta', 'Sammons', 34, 2), ('Abbott', 'Fisbburne', 49, 1),
	('Winnie', 'Whines', 19, 4), ('Samantha', 'Leese', 35, 2), ('Edouard', 'Lorimer', 29, 1), ('Mattheus', 'Shaplin', 27, 3), 
	('Donnell', 'Corney', 25, 3), ('Wallis', 'Kauschke', 28, 3), ('Melva', 'Lanham', 20, 2), ('Amelina', 'McNirlan', 22, 4),
	('Courtney', 'Holley', 22, 1),('Sigismond', 'Vala', 21, 4),('Jacquelynn', 'Halfacre', 24, 2),('Alanna', 'Spino', 25, 3), 
	('Isa', 'Slight', 32, 1), ('Kakalina', 'Renne', 26, 3);


INSERT INTO interest(title) VALUES ('Programming'), ('Gaming'), ('Computers'), ('Music'), ('Movies'), ('Cooking'), ('Sports');


INSERT INTO person_interest(person_id, interest_id) VALUES (1,1), (1,2), (1,6), (2,1), (2,7), (2,4), (3,1), (3,3), (3,4), (4,1), (4,2),
	(4,7), (5,6), (5,3), (5,4), (6,2), (6,7), (7,1), (7,3), (8,2), (8,4), (9,5), (9,6), (10,7), (10,5), (11,1), (11,2), (11,5),
	(12,1), (12,4), (12,5), (13,2), (13,3), (13,7), (14,2), (14,4), (14,6), (15,1), (15,5), (15,7), (16,2), (16,3), (16,4), (17,1),
	(17,3), (17,5), (17,7), (18,2), (18,4), (18,6), (19,1), (19,2), (19,3), (19,4), (19,5), (19,6), (19,7);


UPDATE person SET age = age + 1 WHERE id IN (1, 4, 5, 6, 8, 12, 14, 18);

-- 10 a:
DELETE FROM Person_Interest
WHERE person_id IN (
  SELECT id FROM Person
  WHERE firstName = 'Hilton' AND lastName = 'O''Hanley'
  OR firstName = 'Alanna' AND lastName = 'Spino'
);

-- 10 b:
DELETE FROM person
WHERE firstName = 'Hilton' AND lastName = 'O''Hanley'
OR firstName = 'Alanna' AND lastName = 'Spino';


-- 11 a:
SELECT firstName, lastName FROM person;

-- 11 b:
SELECT firstName, lastName, city, state FROM person
JOIN location ON person.location_id = location.id
WHERE city = 'Nashville' AND state = 'Tennessee';

-- 11 c:
SELECT location.city, COUNT(*) as count FROM person
JOIN location on person.location_id = location.id GROUP BY location.city;

-- 11 d:
SELECT interest.title, COUNT(*) as count FROM person_interest
JOIN interest ON person_interest.interest_id = interest.id
GROUP BY interest.title;

-- 11 e:
SELECT firstName, lastName, city, state, interest.title FROM person
JOIN location ON person.location_id = location.id
JOIN person_interest ON person.id = person_interest.person_id
JOIN interest ON person_interest.interest_id = interest.id
WHERE city = 'Nashville' AND state = 'Tennessee' AND interest.title = 'Programming';

-- 11 f: (Bonus):
SELECT
	CASE
	WHEN age >= 20 AND age < 30 THEN '20-29'
	WHEN age >= 30 AND age < 40 THEN '30-39'
	WHEN age >= 40 AND age <= 50 THEN '40-50'
	END as range,
	COUNT(*) as count
FROM person GROUP BY range;



