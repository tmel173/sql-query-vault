/*CREATE TABLE table_name(column1 data_type[constraints],column2 data_type[constraints],column3 data_type[constraints]);*/
CREATE TABLE Runners (
    runner_id	SERIAL PRIMARY KEY,
    first_name	VARCHAR(50) NOT NULL,
    last_name	VARCHAR(50) NOT NULL,
    gender	VARCHAR(1),
    birth_date	DATE NOT NULL
  );
  
CREATE TABLE Races (
    race_id	SERIAL		PRIMARY KEY,
    race_name	VARCHAR(100)    NOT NULL,
    location	VARCHAR(100),
    race_date	DATE		NOT NULL,
    distance_km	DECIMAL(5,2),
    surface_type VARCHAR(50),
    prize_money	DECIMAL(10,2)
  );
  
  CREATE TABLE Race_Results (
      result_id	SERIAL	PRIMARY KEY,
      race_id	INT REFERENCES Races(race_id) ON DELETE CASCADE,
      runner_id INT REFERENCES Runners(runner_id) ON DELETE CASCADE,
      finish_time TIME NOT NULL,
      position  INT,
      prize_won DECIMAL(10,2)
 );
 
 INSERT INTO Runners (first_name, last_name, gender, birth_date)
 VALUES
      ('Liam', 'Carter', 'M', '1995-04-12'),
      ('Noah', 'Fernandez', 'M', '1998-07-19'),
      ('Sophia', 'Mitchell', 'F', '1996-09-30'),
      ('Albert', 'Smith', 'M', '2000-02-25'),
      ('Ava', 'Robinson', 'F', '1997-06-14');
     
 INSERT INTO Races (race_name, location, race_date, distance_km, surface_type, prize_money)
 VALUES
     ('Sprint 100m', 'New York', '2024-03-15', 0.10, 'Track', 75000),
     ('Marathon', 'Los Angeles', '2025-04-10', 42.195, 'Road', 500000),
     ('Highland Trail Run', 'Edinburgh', '2025-05-22', 50.00, 'Trail', 100000),
     ('Desert Challenge', 'Dubai', '2025-06-05', 50.00, 'Trail', 200000),
     ('Ocean 5k', 'Miami', '2024-07-18', 5.00, 'Road', 25000);
     
 INSERT INTO Race_Results (race_id, runner_id, finish_time, position)
 VALUES
 (1,1,'00:00:08.45',1),
 (1,4,'00:00:10.00',2),
 (2,2,'01:45:30',1),
 (2,3,'01:46:45',2),
 (2,5,'02:02:00',3),
 (3,5,'00:37:01',1),
 (3,3,'00:38:50',2),
 (4,4,'03:35:20',1),
 (4,2,'03:40:10',2);
