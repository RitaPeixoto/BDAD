DROP TABLE IF EXISTS Team;
CREATE TABLE Team(
	Name TEXT PRIMARY KEY,
	Country TEXT NOT NULL
);
DROP TABLE IF EXISTS Aircraft;
CREATE TABLE Aircraft(
	Model TEXT PRIMARY KEY,
	Horsepower INTEGER,
	Topseed REAL,
	Width REAL,
    Height REAL,
    Weight REAL 
);
DROP TABLE IF EXISTS Pilot;
CREATE TABLE Pilot(
	Num INTEGER PRIMARY KEY,
	Firstname TEXT,
    Surname TEXT,
    Nationality TEXT,
    Birthday DATE,
    Name TEXT REFERENCES Team,
    Model TEXT REFERENCES Aircraft
);
DROP TABLE IF EXISTS Race;
CREATE TABLE Race(
	Location TEXT,
	Edition INTEGER,
    Country TEXT,
    Date DATE UNIQUE,-- primeira restrição
    Gates INTEGER,
    Eliminations INTEGER,
    PRIMARY KEY (Location,Edition)
);
CREATE TABLE Participation (
	Num INTEGER REFERENCES Pilot,
	Location TEXT, 
	Edition INTEGER,
	Trainingtime REAL CHECK (Trainingtime > 0 AND Trainingpos <> 'N'),-- terceira restrição
	Trainingpos INTEGER CHECK (Trainingpos > 1),-- segunda/terceira restrição
	Trainingpenalty REAL CHECK (Trainingpenalty > 0 AND Trainingpos <> 'N'),-- terceira restrição
	Qualificationtime REAL CHECK (Qualificationtime > 0 AND Qualificationpos <> 'N'),-- terceira restrição
	Qualificationpos INTEGER CHECK (Qualificationpos > 1),-- segunda/terceira restrição
	Qualificationpenalty REAL CHECK (Qualificationpenalty > 0 AND Qualificationpos <> 'N'),-- terceira restrição
	Eliminationtime REAL CHECK (Eliminationtime > 0 AND Eliminationpos <> 'N'),-- terceira restrição
	Eliminationpos INTEGER CHECK (Eliminationpos > 1),-- segunda/terceira restrição
	Eliminationpenalty REAL CHECK (Eliminationpenalty > 0 AND Eliminationpos <> 'N'),-- terceira restrição
	PRIMARY KEY (Num, Location, Edition),
	FOREIGN KEY (Location, Edition) REFERENCES Race,
	CHECK (Trainingpos <> 'N' OR Qualificationpos <> 'N' OR Eliminationpos <> 'N' )-- quarta restrição
);
CREATE TABLE Duel (
	Numpilot1 INTEGER REFERENCES Pilot,
	Numpilot2 INTEGER REFERENCES Pilot,
	Location TEXT, 
	Edition INTEGER,
	Dueltype TEXT,
	Timepilot1 REAL CHECK (Timepilot1 > 0),-- terceira restrição
	Timepilot2 REAL CHECK (Timepilot2 > 0),-- terceira restrição
	Penaltypilot1 REAL CHECK (Penaltypilot1 > 0),  
	Penaltypilot2 REAL CHECK (Penaltypilot2 > 0),
	PRIMARY KEY (Numpilot1, Numpilot2, Location, Edition),
	FOREIGN KEY (Location, Edition) REFERENCES Race
);


