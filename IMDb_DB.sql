CREATE DATABASE IMDb_db

USE IMDb_db

CREATE TABLE Directors(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(255) NOT NULL
)

CREATE TABLE Movies(
	Id INT PRIMARY KEY IDENTITY,
	Tittle NVARCHAR(255) NOT NULL,
	Duration INT NOT NULL,
	IMDbRating FLOAT NOT NULL,
	DirectorId INT FOREIGN KEY REFERENCES Directors(Id)
)

CREATE TABLE Actors(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(255) NOT NULL
)

CREATE TABLE MovieActors(
	Id INT PRIMARY KEY IDENTITY,
	MovieId INT FOREIGN KEY REFERENCES Movies(Id),
	ActorId INT FOREIGN KEY REFERENCES Actors(Id)
)

CREATE TABLE Genres(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(255) NOT NULL 
)

CREATE TABLE MovieGenres(
	Id INT PRIMARY KEY IDENTITY,
	MovieId INT FOREIGN KEY REFERENCES Movies(Id),
	GenreId INT FOREIGN KEY REFERENCES Genres(Id)
)

SELECT Movies.Tittle, Movies.IMDbRating, Genres.[Name] AS 'GenreName', Directors.[Name] AS 'DirectorName', Actors.[Name] AS 'ActorName'
FROM Movies
JOIN MovieGenres
ON Movies.Id = MovieGenres.MovieId
JOIN Genres
ON MovieGenres.GenreId = Genres.Id
JOIN MovieActors
ON Movies.Id = MovieActors.MovieId
JOIN Actors
ON MovieActors.ActorId = Actors.Id
JOIN Directors
ON DirectorId = Directors.Id
WHERE Movies.IMDbRating > 6

SELECT Movies.Tittle, Movies.IMDbRating, Genres.[Name] AS 'GenreName'
FROM Movies 
JOIN MovieGenres
ON Movies.Id = MovieGenres.MovieId
JOIN Genres
ON MovieGenres.GenreId = Genres.Id
WHERE Genres.[Name] LIKE '%a%';


SELECT Movies.Tittle, Movies.IMDbRating, Genres.[Name] AS 'GenreName'
FROM Movies
JOIN MovieGenres
ON Movies.Id = MovieGenres.MovieId
JOIN Genres
ON MovieGenres.GenreId = Genres.Id
WHERE LEN(Movies.Tittle) > 10 AND Movies.Tittle LIKE '%t'


Select Movies.Tittle, Movies.IMDbRating, Genres.[Name] AS 'GenreName', Directors.[Name] AS 'DirectorName', Actors.[Name] AS 'ActorName'
FROM Movies
JOIN MovieGenres
ON Movies.Id = MovieGenres.MovieId
JOIN Genres
ON MovieGenres.GenreId = Genres.Id
JOIN MovieActors
ON Movies.Id = MovieActors.MovieId
JOIN Actors
ON MovieActors.ActorId = Actors.Id
JOIN Directors
ON DirectorId = Directors.Id
WHERE Movies.IMDbRating > (SELECT AVG(Movies.IMDbRating) FROM Movies)
ORDER BY Movies.IMDbRating DESC
