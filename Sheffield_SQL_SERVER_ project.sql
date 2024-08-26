
-- ====================================================================================
-- drop foreign keys
-- ====================================================================================
IF OBJECT_ID('FK_Viewer_Viewer', 'F') IS NOT NULL
     ALTER TABLE Viewer DROP CONSTRAINT FK_Viewer_Viewer;

IF OBJECT_ID('FK_Viewer_Viewing', 'F') IS NOT NULL
      ALTER TABLE Viewing DROP CONSTRAINT FK_Viewer_Viewing;

IF OBJECT_ID('FK_Platform_Viewing', 'F') IS NOT NULL
      ALTER TABLE Viewing DROP CONSTRAINT FK_Platform_Viewing;

IF OBJECT_ID('FK_Show_Viewing', 'F') IS NOT NULL
      ALTER TABLE Viewing DROP CONSTRAINT FK_Show_Viewing;

IF OBJECT_ID('FK_Show_ShowAward', 'F') IS NOT NULL
      ALTER TABLE ShowAward DROP CONSTRAINT FK_Show_ShowAward;

IF OBJECT_ID('FK_Award_ShowAward', 'F') IS NOT NULL
      ALTER TABLE ShowAward DROP CONSTRAINT FK_Award_ShowAward;

IF OBJECT_ID('FK_Show_Role', 'F') IS NOT NULL
      ALTER TABLE Role DROP CONSTRAINT FK_Show_Role;

IF OBJECT_ID('FK_Actor_Role', 'F') IS NOT NULL
      ALTER TABLE Role DROP CONSTRAINT FK_Actor_Role;

IF OBJECT_ID('FK_Genre_Show', 'F') IS NOT NULL
      ALTER TABLE Show DROP CONSTRAINT FK_Genre_Show;

IF OBJECT_ID('FK_Show_Director', 'F') IS NOT NULL
      ALTER TABLE Show DROP CONSTRAINT FK_Show_Director;

-- ====================================================================================
-- drop tables
-- ====================================================================================
DROP TABLE IF EXISTS Viewing;
DROP TABLE IF EXISTS Role;
DROP TABLE IF EXISTS ShowAward;
DROP TABLE IF EXISTS Show;
DROP TABLE IF EXISTS Award;
DROP TABLE IF EXISTS Genre;
DROP TABLE IF EXISTS Director;
DROP TABLE IF EXISTS Actor;
DROP TABLE IF EXISTS Viewer;
DROP TABLE IF EXISTS Platform;

-- ====================================================================================
-- create tables
-- ====================================================================================
CREATE TABLE Platform (
    PlatformID INT IDENTITY (1, 1) NOT NULL,
    PlatformName VARCHAR(50) NOT NULL,
    IsInternetBased BIT NOT NULL,
    CONSTRAINT PK_Platform PRIMARY KEY CLUSTERED (PlatformID ASC)
);

CREATE TABLE Viewer (
    ViewerID INT IDENTITY (1, 1) NOT NULL,
    FirstName VARCHAR(25) NOT NULL,
    MI CHAR(1) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender CHAR(1) NULL,
    BestFriendID INT NULL,
    CONSTRAINT PK_Viewer PRIMARY KEY CLUSTERED (ViewerID ASC)
);

CREATE TABLE Actor (
    ActorID INT IDENTITY (1, 1) NOT NULL,
    FirstName VARCHAR(25) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender CHAR(1) NULL,
    CONSTRAINT PK_Actor PRIMARY KEY CLUSTERED (ActorID ASC)
);

CREATE TABLE Role (
    ShowID INT NOT NULL,
    ActorID INT NOT NULL,
    CharacterName VARCHAR(50) NOT NULL,
    Salary INT NOT NULL,
    CONSTRAINT PK_Role PRIMARY KEY CLUSTERED (ShowID ASC, ActorID ASC)
);

CREATE TABLE Show (
    ShowID INT IDENTITY (1, 1) NOT NULL,
    Title VARCHAR(50) NOT NULL,
    DateReleased DATE NOT NULL,
    Description VARCHAR(250) NOT NULL,
    BoxOfficeEarnings DECIMAL(15,2) NOT NULL,
    IMDBRating INT NOT NULL,
    IsMovie BIT NOT NULL,
    GenreID INT NOT NULL,
    DirectorID INT NOT NULL,
    CONSTRAINT PK_Show PRIMARY KEY CLUSTERED (ShowID ASC)
);

CREATE TABLE Director (
    DirectorID INT IDENTITY(1, 1) NOT NULL,
    FirstName VARCHAR(25) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender CHAR(1) NULL,
    CONSTRAINT PK_Director PRIMARY KEY CLUSTERED (DirectorID ASC)
);

CREATE TABLE Viewing (
    ViewerID INT NOT NULL,
    PlatformID INT NOT NULL,
    ShowID INT NOT NULL,
    WatchDateTime DATETIME NOT NULL,
    ViewerRatingStars DECIMAL(3,2) NOT NULL,
    CONSTRAINT PK_Viewing PRIMARY KEY CLUSTERED (ViewerID ASC, PlatformID ASC, ShowID ASC)
);

CREATE TABLE Genre (
    GenreID INT IDENTITY(1, 1) NOT NULL,
    GenreDescription VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Genre PRIMARY KEY CLUSTERED (GenreID ASC)
);

CREATE TABLE Award (
    AwardID INT IDENTITY(1, 1) NOT NULL,
    Name VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Award PRIMARY KEY CLUSTERED (AwardID ASC)
);

CREATE TABLE ShowAward (
    ShowID INT NOT NULL,
    AwardID INT NOT NULL,
    YearWon INT NOT NULL,
    CONSTRAINT PK_ShowAward PRIMARY KEY CLUSTERED (ShowID ASC, AwardID ASC)
);

-- ====================================================================================
-- create foreign keys
-- ====================================================================================
ALTER TABLE Viewer
ADD CONSTRAINT FK_Viewer_Viewer
FOREIGN KEY (BestFriendID)
REFERENCES Viewer (ViewerID);

ALTER TABLE Viewing
ADD CONSTRAINT FK_Viewer_Viewing
FOREIGN KEY (ViewerID)
REFERENCES Viewer (ViewerID);

ALTER TABLE Viewing
ADD CONSTRAINT FK_Platform_Viewing
FOREIGN KEY (PlatformID)
REFERENCES Platform (PlatformID);

ALTER TABLE Viewing
ADD CONSTRAINT FK_Show_Viewing
FOREIGN KEY (ShowID)
REFERENCES Show (ShowID);

ALTER TABLE ShowAward
ADD CONSTRAINT FK_Show_ShowAward
FOREIGN KEY (ShowID)
REFERENCES Show (ShowID);

ALTER TABLE ShowAward
ADD CONSTRAINT FK_Award_ShowAward
FOREIGN KEY (AwardID)
REFERENCES Award (AwardID);

ALTER TABLE Role
ADD CONSTRAINT FK_Show_Role
FOREIGN KEY (ShowID)
REFERENCES Show (ShowID);

ALTER TABLE Role
ADD CONSTRAINT FK_Actor_Role
FOREIGN KEY (ActorID)
REFERENCES Actor (ActorID);

ALTER TABLE Show
ADD CONSTRAINT FK_Genre_Show
FOREIGN KEY (GenreID)
REFERENCES Genre (GenreID);

ALTER TABLE Show
ADD CONSTRAINT FK_Show_Director
FOREIGN KEY (DirectorID)
REFERENCES Director (DirectorID);

-- ====================================================================================
-- insert data
-- ====================================================================================
-- insert data into Director
INSERT INTO Director (FirstName, LastName, Gender) VALUES ('Steven', 'Spielberg', 'M');
INSERT INTO Director (FirstName, LastName, Gender) VALUES ('Martin', 'Scorsese', 'M');
INSERT INTO Director (FirstName, LastName, Gender) VALUES ('Christopher', 'Nolan', 'M');
INSERT INTO Director (FirstName, LastName, Gender) VALUES ('Quentin', 'Tarantino', 'M');
INSERT INTO Director (FirstName, LastName, Gender) VALUES ('Patty', 'Jenkins', 'F');
INSERT INTO Director (FirstName, LastName, Gender) VALUES ('Greta', 'Gerwig', 'F');

-- insert data into Genre
INSERT INTO Genre (GenreDescription) VALUES ('Action');
INSERT INTO Genre (GenreDescription) VALUES ('Drama');
INSERT INTO Genre (GenreDescription) VALUES ('Comedy');
INSERT INTO Genre (GenreDescription) VALUES ('Thriller');
INSERT INTO Genre (GenreDescription) VALUES ('Sci-Fi');
INSERT INTO Genre (GenreDescription) VALUES ('Fantasy');

-- Insert data into Show
INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating, IsMovie, GenreID, DirectorID) 
VALUES ('Avengers: Infinity War', '2018-04-27', 'Superheroes unite to fight Thanos.', 2048359754.00, 8, 1, 1, 1);

INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating, IsMovie, GenreID, DirectorID) 
VALUES ('Killers of the Flower Moon', '2023-10-20', 'A story of murder and conspiracy in 1920s Oklahoma.', 100000000.00, 8, 1, 2, 2);

INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating, IsMovie, GenreID, DirectorID) 
VALUES ('La La Land', '2016-12-25', 'A jazz musician and an aspiring actress fall in love.', 446486230.00, 8, 1, 3, 3);

INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating, IsMovie, GenreID, DirectorID) 
VALUES ('Six Underground', '2019-12-13', 'Six vigilantes fake their deaths and form a team to take down notorious criminals.', 150000000.00, 6, 1, 1, 4);

INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating, IsMovie, GenreID, DirectorID) 
VALUES ('Terminator 3: Rise of the Machines', '2003-07-02', 'The war against the machines continues.', 433371112.00, 6, 1, 5, 5);

INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating, IsMovie, GenreID, DirectorID) 
VALUES ('Formula One', '2023-01-01', 'A retired Formula 1 driver returns to the track.', 50000000.00, 7, 1, 6, 6);


-- Insert data into Platform
INSERT INTO Platform (PlatformName, IsInternetBased) VALUES ('Netflix', 1);
INSERT INTO Platform (PlatformName, IsInternetBased) VALUES ('Hulu', 1);
INSERT INTO Platform (PlatformName, IsInternetBased) VALUES ('Amazon Prime', 1);
INSERT INTO Platform (PlatformName, IsInternetBased) VALUES ('Disney+', 1);
INSERT INTO Platform (PlatformName, IsInternetBased) VALUES ('HBO Max', 1);
INSERT INTO Platform (PlatformName, IsInternetBased) VALUES ('Cable TV', 0);

-- Insert data into Viewer
INSERT INTO Viewer (FirstName, MI, LastName, Gender, BestFriendID) VALUES ('John', 'A', 'Doe', 'M', NULL);
INSERT INTO Viewer (FirstName, MI, LastName, Gender, BestFriendID) VALUES ('Jane', 'B', 'Smith', 'F', NULL);
INSERT INTO Viewer (FirstName, MI, LastName, Gender, BestFriendID) VALUES ('Emily', 'C', 'Johnson', 'F', NULL);
INSERT INTO Viewer (FirstName, MI, LastName, Gender, BestFriendID) VALUES ('Michael', 'D', 'Brown', 'M', NULL);
INSERT INTO Viewer (FirstName, MI, LastName, Gender, BestFriendID) VALUES ('Sarah', 'E', 'Williams', 'F', NULL);
INSERT INTO Viewer (FirstName, MI, LastName, Gender, BestFriendID) VALUES ('David', 'F', 'Jones', 'M', NULL);

-- Update BestFriendID for Viewer
UPDATE Viewer SET BestFriendID = 2 WHERE ViewerID = 1;
UPDATE Viewer SET BestFriendID = 1 WHERE ViewerID = 2;
UPDATE Viewer SET BestFriendID = 1 WHERE ViewerID = 3;
UPDATE Viewer SET BestFriendID = 4 WHERE ViewerID = 5;
UPDATE Viewer SET BestFriendID = 6 WHERE ViewerID = 4;

-- Insert data into Actor
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Robert', 'Downey Jr.', 'M');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Leonardo', 'DiCaprio', 'M');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Emma', 'Stone', 'F');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Ryan', 'Reynolds', 'M');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Arnold', 'Schwarzenegger', 'M');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Brad', 'Pitt', 'M');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Jim', 'Carrey', 'M');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Will', 'Smith', 'M');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Denzel', 'Washington', 'M');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Tom', 'Hanks', 'M');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Cameron', 'Diaz', 'F');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Margot', 'Robbie', 'F');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Dwayne', 'Johnson', 'M');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Daniel', 'Craig', 'M');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Jack', 'Nicholson', 'M');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Johnny', 'Depp', 'M');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Keanu', 'Reeves', 'M');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Harrison', 'Ford', 'M');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Sandra', 'Bullock', 'F');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Tom', 'Cruise', 'M');
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Adam', 'Sandler', 'M');

-- Insert data into Role
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (1, 1, 'Iron Man', 75000000); -- Robert Downey Jr. in Avengers: Infinity War
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (2, 2, 'Ernest Burkhart', 30000000); -- Leonardo DiCaprio in Killers of the Flower Moon
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (3, 3, 'Mia', 26000000); -- Emma Stone in La La Land
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (4, 4, 'One/Magnet S. Johnson', 27000000); -- Ryan Reynolds in Six Underground
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (5, 5, 'The Terminator', 29000000); -- Arnold Schwarzenegger in Terminator 3
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (6, 6, 'Formula 1 Driver', 30000000); -- Brad Pitt in Formula One
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (1, 7, 'Carl Allen', 30000000); -- Jim Carrey in Yes Man
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (2, 8, 'Peter', 35000000); -- Will Smith in Emancipation
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (3, 8, 'Richard Williams', 40000000); -- Will Smith in King Richard
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (4, 9, 'Joe Deacon', 40000000); -- Denzel Washington in The Little Things
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (5, 10, 'Captain John Miller', 40000000); -- Tom Hanks in Saving Private Ryan
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (6, 11, 'Elizabeth Halsey', 42000000); -- Cameron Diaz in Bad Teacher
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (1, 12, 'Barbie', 50000000); -- Margot Robbie in Barbie
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (2, 13, 'Callum Drift', 50000000); -- Dwayne Johnson in Red One
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (3, 14, 'Benoit Blanc', 50000000); -- Daniel Craig in Glass Onion: A Knives Out Mystery
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (4, 15, 'The Joker', 50000000); -- Joaquin Phoenix in The Joker
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (5, 16, 'Jack Sparrow', 55000000); -- Johnny Depp in Pirates of the Carribean
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (6, 17, 'Neo', 83300000); -- Keanu Reeves in The Matrix
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (1, 18, 'Indiana Jones', 65000000); -- Harrison Ford in Indiana Jones and the Temple of Doom
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (2, 19, 'Dr. Ryan Stone', 70000000); -- Sandra Bullock in Gravity
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (3, 20, 'Pete "Maverick" Mitchell', 100000000); -- Tom Cruise in Top Gun: Maverick
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (4, 21, 'Various Characters', 62500000); -- Adam Sandler in Jack and Jill

-- Insert data into Viewing
INSERT INTO Viewing (ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (1, 1, 1, '2023-01-01 12:00:00', 4.5);
INSERT INTO Viewing (ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (2, 2, 2, '2023-01-02 14:00:00', 4.0);
INSERT INTO Viewing (ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (3, 3, 3, '2023-01-03 16:00:00', 3.5);
INSERT INTO Viewing (ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (4, 4, 4, '2023-01-04 18:00:00', 5.0);
INSERT INTO Viewing (ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (5, 5, 5, '2023-01-05 20:00:00', 4.5);
INSERT INTO Viewing (ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (6, 6, 6, '2023-01-06 22:00:00', 4.0);

-- insert data into Award
INSERT INTO Award (Name) VALUES ('Best Picture');
INSERT INTO Award (Name) VALUES ('Best Director');
INSERT INTO Award (Name) VALUES ('Best Actor');
INSERT INTO Award (Name) VALUES ('Best Actress');
INSERT INTO Award (Name) VALUES ('Best Screenplay');
INSERT INTO Award (Name) VALUES ('Best Cinematography');

-- insert data into ShowAward
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (1, 3, 2018); -- Avengers: Infinity War wins Best Actor
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (3, 4, 2017); -- La La Land wins Best Actress
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (5, 6, 2004); -- Terminator 3 wins Best Cinematography
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (6, 2, 2023); -- Formula One wins Best Director
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (2, 1, 2023); -- Killers of the Flower Moon wins Best Picture
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (4, 5, 2019); -- Six Underground wins Best Screenplay

-- Select statements
SELECT * FROM Platform pl
SELECT * FROM Viewer vi
SELECT * FROM Viewing vg
SELECT * FROM Award aw
SELECT * FROM Actor ac
SELECT * FROM Role ro
SELECT * FROM Show sh
SELECT * FROM ShowAward shaw
SELECT * FROM Director di
SELECT * FROM Genre ge




-- List all Actor IDs with names, the movie they played in, and the IMDB rating of that movie.
-- Order by Last Name, First Name, then the IMDB rating of the Movie. 

select ac.ActorID, ac.FirstName, ac.LastName, sh.Title, sh.IMDBRating
From Actor ac
LEFT OUTER JOIN Role r
on ac.ActorID = r.ActorID
left outer join Show sh
on r.ShowID = sh.ShowID
order by LastName, FirstName, IMDBRating


--What are the top streaming platforms for the viewers?
SELECT v.ViewerID, v.PlatformID, p.PlatformName, COUNT(ViewerID) AS NumShowsWatched
FROM Viewing v
INNER JOIN Platform p ON v.PlatformID = p.PlatformID
Where
p.IsInternetBased = 1
GROUP BY v.ViewerID, v.PlatformID, p.PlatformName;



-- List all directors and the number of movies they have directed.
-- Order by the number of movies in descending order. 

SELECT D.FirstName, D.LastName, COUNT(S.ShowID) AS NumMoviesDirected
FROM Director AS D
INNER JOIN Show AS S
ON D.DirectorID = S.DirectorID
GROUP BY D.FirstName, D.LastName
ORDER BY NumMoviesDirected DESC;



-- List all genres with the number of movies in each genre.
-- Order by GenreDescription.

SELECT G.GenreDescription, COUNT(S.ShowID) AS NumMovies
FROM Genre AS G
LEFT OUTER JOIN Show AS S
ON G.GenreID = S.GenreID
GROUP BY G.GenreDescription
ORDER BY G.GenreDescription


-- List all actors and the total salary they have earned from all movies.
-- Order by total salary in descending order.

SELECT A.FirstName, A.LastName, SUM(R.Salary) AS TotalSalary
FROM Actor AS A
INNER JOIN Role AS R
ON A.ActorID = R.ActorID
GROUP BY A.FirstName, A.LastName
ORDER BY TotalSalary DESC;


-- What are the movies that are directed by Christopher Nolan and their release date
--list them in the order of the date on which it is released
-- find the average box office earnings of his movies as AvgBoxEarn
-- find the average IMDB rating of his movies as AvgIMDB

SELECT s.Title,s.DateReleased  FROM Show s
INNER JOIN Director d ON s.DirectorID = d.DirectorID
WHERE d.FirstName LIKE '%Christopher%' AND d.LastName LIKE '%Nolan%'
GROUP BY s.Title, s.DateReleased
ORDER BY s.DateReleased ASC

SELECT AVG(s.BoxOfficeEarnings) AS AvgBoxEarn FROM Show s
INNER JOIN Director d ON s.DirectorID = d.DirectorID
WHERE d.FirstName LIKE '%Christopher%' AND d.LastName LIKE '%Nolan%';

SELECT AVG(s.IMDBRating) AS AvgIMDB FROM Show s
INNER JOIN Director d ON s.DirectorID = d.DirectorID
WHERE d.FirstName LIKE '%Christopher%' AND d.LastName LIKE '%Nolan%';

-- 
--
--What are the movies that feature actors with a salary greater than $50,000 and their release date?
--List them in the order of the date on which they are released.
--Find the average salary of these actors as AvgSalary.
--Find the total salary paid to these actors as TotalSalary.

SELECT s.Title, s.DateReleased FROM Show s
INNER JOIN Role r ON s.ShowID = r.ShowID
INNER JOIN Actor a ON r.ActorID = a.ActorID
WHERE r.Salary > 50000
GROUP BY s.Title, s.DateReleased
ORDER BY s.DateReleased ASC;

SELECT AVG(r.Salary) AS AvgSalary FROM Role r
INNER JOIN Actor a ON r.ActorID = a.ActorID
WHERE r.Salary > 50000;

SELECT SUM(r.Salary) AS TotalSalary FROM Role r
INNER JOIN Actor a ON r.ActorID = a.ActorID
WHERE r.Salary > 50000;

-- List all movies with box office earnings greater than $100,000, their release date, and director's name. Order by highest box office earnings also, Calculate their average and total box office earnings.

SELECT s.Title, s.DateReleased,  d.FirstName + ' ' + d.LastName AS DirectorName,  s.BoxOfficeEarnings FROM  Show s
INNER JOIN  Director d ON s.DirectorID = d.DirectorID
WHERE s.BoxOfficeEarnings > 100000
ORDER BY s.BoxOfficeEarnings DESC;

SELECT  AVG(s.BoxOfficeEarnings) AS AvgBoxEarn FROM Show s
WHERE s.BoxOfficeEarnings > 100000;

SELECT  SUM(s.BoxOfficeEarnings) AS TotalBoxEarn FROM  Show s
WHERE  s.BoxOfficeEarnings > 100000;

-- 
-- List all movies released in the last 5 years, their release date, and IMDB rating. Order by highest IMDB rating. Calculate the average IMDB rating and the total number of these movies.

SELECT  s.Title,  s.DateReleased,  s.IMDBRating FROM  Show s
WHERE  YEAR(s.DateReleased) >= YEAR(GETDATE()) - 5
ORDER BY  s.IMDBRating DESC;

SELECT  AVG(s.IMDBRating) AS AvgIMDBRating FROM  Show s
WHERE YEAR(s.DateReleased) >= YEAR(GETDATE()) - 5;

SELECT  COUNT(*) AS TotalMovies FROM Show s
WHERE YEAR(s.DateReleased) >= YEAR(GETDATE()) - 5;


-- List all movies in the "Action" genre, their release date, and director's name. Order by release date (newest first) & Calculate the average and total box office earnings.

SELECT  s.Title, s.DateReleased, d.FirstName + ' ' + d.LastName AS DirectorName,  s.BoxOfficeEarnings FROM  Show s
INNER JOIN  Director d ON s.DirectorID = d.DirectorID
INNER JOIN  Genre g ON s.GenreID = g.GenreID
WHERE  g.GenreDescription = 'Action'
ORDER BY s.DateReleased DESC;

SELECT  AVG(s.BoxOfficeEarnings) AS AvgBoxEarn FROM  Show s
INNER JOIN  Genre g ON s.GenreID = g.GenreID
WHERE g.GenreDescription = 'Action';

SELECT SUM(s.BoxOfficeEarnings) AS TotalBoxEarn FROM Show s
INNER JOIN  Genre g ON s.GenreID = g.GenreID
WHERE g.GenreDescription = 'Action';
