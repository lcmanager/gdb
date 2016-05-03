---
-- #%L
-- Game Database
-- %%
-- Copyright (C) 2016 - 2016 LCManager Group
-- %%
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
-- 
--      http://www.apache.org/licenses/LICENSE-2.0
-- 
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-- #L%
---


-- This SQL file is executed by Spring when it initializes the JDBC
-- connections. It should be used to create necesasary tables and so on.


	--------------------
	-- Table Creation --
	--------------------

-- Create table 'User'.
CREATE TABLE IF NOT EXISTS User (
	username VARCHAR(50) NOT NULL,
	password VARCHAR(100) NOT NULL,
	enabled BOOLEAN DEFAULT TRUE NOT NULL,
	PRIMARY KEY (username)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;

-- Create table 'User_Authority'.
CREATE TABLE IF NOT EXISTS User_Authority (
	username VARCHAR(50) NOT NULL,
	authority VARCHAR(50) NOT NULL,
	PRIMARY KEY (username, authority),
	FOREIGN KEY (username) REFERENCES User(username)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;

-- Create table 'Processor'.
CREATE TABLE IF NOT EXISTS Processor (
	id INT NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (id)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;

-- Create table 'Graphics'.
CREATE TABLE IF NOT EXISTS Graphics (
	id INT NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (id)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;

-- Create table 'Developer'.
CREATE TABLE IF NOT EXISTS Developer (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(128) NOT NULL UNIQUE,
	PRIMARY KEY (id)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;

-- Create table 'Publisher'.
CREATE TABLE IF NOT EXISTS Publisher (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(128) NOT NULL UNIQUE,
	PRIMARY KEY (id)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;

-- Create table 'Genre'.
CREATE TABLE IF NOT EXISTS Genre (
	id INT NOT NULL,
	description VARCHAR(128) NOT NULL UNIQUE,
	PRIMARY KEY (id)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;

-- Create table 'Screenshot'.
CREATE TABLE IF NOT EXISTS Screenshot (
	id INT NOT NULL AUTO_INCREMENT,
	thumbnail VARCHAR(2083) NULL,
	image VARCHAR(2083) NOT NULL,
	PRIMARY KEY (id)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;

-- Create table 'Category'.
CREATE TABLE IF NOT EXISTS Category (
	id INT NOT NULL,
	description VARCHAR(128) NOT NULL UNIQUE,
	PRIMARY KEY (id)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;

-- Create table 'Requirement'.
CREATE TABLE IF NOT EXISTS Requirement (
	id INT NOT NULL AUTO_INCREMENT,
	processorId INT NULL,
	graphicsId INT NULL,
	osFamily INT NULL,
	memory INT NULL,
	storage INT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (processorId) REFERENCES Processor(id),
	FOREIGN KEY (graphicsId) REFERENCES Graphics(id)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;

-- Create table 'OperatingSystem'.
CREATE TABLE IF NOT EXISTS OperatingSystem (
	id INT NOT NULL AUTO_INCREMENT,
	developerId INT NOT NULL,
	osFamily INT NOT NULL,
	name VARCHAR(128) NOT NULL,
	versionName VARCHAR(128) NULL,
	versionMajor INT NOT NULL,
	versionMinor INT NULL,
	versionBugfx INT NULL,
	versionBuild INT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (developerId) REFERENCES Developer(id)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;

-- Create table 'Requirement_OperatingSystem'.
CREATE TABLE IF NOT EXISTS Requirement_OperatingSystem (
	requirementId INT NOT NULL,
	operatingSystemId INT NOT NULL,
	PRIMARY KEY (requirementId, operatingSystemId),
	FOREIGN KEY (requirementId) REFERENCES Requirement(id),
	FOREIGN KEY (operatingSystemId) REFERENCES OperatingSystem(id)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;

-- Create table 'Game'.
CREATE TABLE IF NOT EXISTS Game (
	id INT NOT NULL,
	name VARCHAR(128) NOT NULL,
	requiredAge INT NOT NULL DEFAULT "0",
	description TEXT NULL,
	headerImage VARCHAR(2083) NULL,
	website VARCHAR(2083) NULL,
	metacriticScore INT NULL,
	metacriticUrl VARCHAR(2083) NULL,
	releaseDate DATE NULL,
	backgroundImage VARCHAR(2083) NULL,
	PRIMARY KEY (id)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;

-- Create table 'Game_Developer'.
CREATE TABLE IF NOT EXISTS Game_Developer (
	gameId INT NOT NULL,
	developerId INT NOT NULL,
	PRIMARY KEY (gameId, developerId),
	FOREIGN KEY (gameId) REFERENCES Game(id),
	FOREIGN KEY (developerId) REFERENCES Developer(id)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;

-- Create table 'Game_Publisher'.
CREATE TABLE IF NOT EXISTS Game_Publisher (
	gameId INT NOT NULL,
	publisherId INT NOT NULL,
	PRIMARY KEY (gameId, publisherId),
	FOREIGN KEY (gameId) REFERENCES Game(id),
	FOREIGN KEY (publisherId) REFERENCES Publisher(id)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;

-- Create table 'Game_OsFamily'.
CREATE TABLE IF NOT EXISTS Game_OsFamily (
	gameId INT NOT NULL,
	osFamily INT NOT NULL,
	PRIMARY KEY (gameId, osFamily),
	FOREIGN KEY (gameId) REFERENCES Game(id)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;

-- Create table 'Game_Genre'.
CREATE TABLE IF NOT EXISTS Game_Genre (
	gameId INT NOT NULL,
	genreId INT NOT NULL,
	PRIMARY KEY (gameId, genreId),
	FOREIGN KEY (gameId) REFERENCES Game(id),
	FOREIGN KEY (genreId) REFERENCES Genre(id)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;

-- Create table 'Game_Category'.
CREATE TABLE IF NOT EXISTS Game_Category (
	gameId INT NOT NULL,
	categoryId INT NOT NULL,
	PRIMARY KEY (gameId, categoryId),
	FOREIGN KEY (gameId) REFERENCES Game(id),
	FOREIGN KEY (categoryId) REFERENCES Category(id)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;

-- Create table 'Game_Screenshot'.
CREATE TABLE IF NOT EXISTS Game_Screenshot (
	gameId INT NOT NULL,
	screenshotId INT NOT NULL,
	PRIMARY KEY (gameId, screenshotId),
	FOREIGN KEY (gameId) REFERENCES Game(id),
	FOREIGN KEY (screenshotId) REFERENCES Screenshot(id)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;

-- Create table 'Game_Requirement'.
CREATE TABLE IF NOT EXISTS Game_Requirement (
	gameId INT NOT NULL,
	osFamily INT NOT NULL,
	requirementId INT NOT NULL,
	reqType INT NOT NULL,
	PRIMARY KEY (gameId, osFamily, reqType),
	FOREIGN KEY (gameId) REFERENCES Game(id),
	FOREIGN KEY (requirementId) REFERENCES Requirement(id)
) CHARACTER SET utf8 COLLATE utf8_bin ENGINE InnoDB;


	-------------------
	-- View Creation --
	-------------------

CREATE OR REPLACE VIEW View_Game AS
	SELECT
		1					AS one,

		Ga.id				AS gameId,
		Ga.name				AS gameName,
		Ga.requiredAge		AS gameRequiredAge,
		Ga.description		AS gameDescription,
		Ga.headerImage		AS gameHeaderImage,
		Ga.website			AS gameWebsite,
		Ga.metacriticScore	AS gameMetacriticScore,
		Ga.metacriticUrl	AS gameMetacriticUrl,
		Ga.releaseDate		AS gameReleaseDate,
		Ga.backgroundImage	AS gameBackgroundImage,

		GaSc.gameId			AS gameScreenshotGameId,
		Sc.id				AS gameScreenshotId,
		Sc.thumbnail		AS gameScreenshotThumbnail,
		Sc.image			AS gameScreenshotImage,

		GaGe.gameId			AS gameGenreGameId,
		Ge.id				AS gameGenreId,
		Ge.description		AS gameGenreDescription,

		GaCa.gameId			AS gameCategoryGameId,
		Ca.id				AS gameCategoryId,
		Ca.description		AS gameCategoryDescription,

		GaPu.gameId			AS gamePublisherGameId,
		Pu.id				AS gamePublisherId,
		Pu.name				AS gamePublisherName,

		GaDe.gameId			AS gameDeveloperGameId,
		De.id				AS gameDeveloperId,
		De.name				AS gameDeveloperName,

		GaOs.gameId			AS gameOsFamilyGameId,
		GaOs.osFamily		AS gameOsFamily,

		GaRe.gameId			AS requirementGameId,
		GaRe.reqType		AS requirementType,
		Re.id				AS requirementId,
		Re.osFamily			AS requirementOsFamily,
		Re.memory			AS requirementMemory,
		Re.storage			AS requirementStorage,

		ReOp.requirementId	AS requirementOperatingSystemRequirementId,
		Op.id				AS requirementOperatingSystemId,
		Op.osFamily			AS requirementOperatingSystemFamily,
		Op.name				AS requirementOperatingSystemName,
		Op.versionName		AS requirementOperatingSystemVersionName,
		Op.versionMajor		AS requirementOperatingSystemVersionMajor,
		Op.versionMinor		AS requirementOperatingSystemVersionMinor,
		Op.versionBugfx		AS requirementOperatingSystemVersionBugfx,
		Op.versionBuild		AS requirementOperatingSystemVersionBuild,
		Df.id				AS requirementOperatingSystemDeveloperId,
		Df.name				AS requirementOperatingSystemDeveloperName,

		Pr.id				AS requirementProcessorId,

		Gr.id				AS requirementGraphicsId
	FROM
		Game AS Ga
	-- Screenshot
	LEFT JOIN Game_Screenshot	AS GaSc	ON Ga.id = GaSc.gameId
	LEFT JOIN Screenshot		AS Sc	ON Sc.id = GaSc.screenshotId
	-- Genre
	LEFT JOIN Game_Genre		AS GaGe	ON Ga.id = GaGe.gameId
	LEFT JOIN Genre				AS Ge	ON Ge.id = GaGe.genreId
	-- Category
	LEFT JOIN Game_Category		AS GaCa	ON Ga.id = GaCa.gameId
	LEFT JOIN Category			AS Ca	ON Ca.id = GaCa.categoryId
	-- Publisher
	LEFT JOIN Game_Publisher	AS GaPu	ON Ga.id = GaPu.gameId
	LEFT JOIN Publisher			AS Pu	ON Pu.id = GaPu.publisherId
	-- Developer
	LEFT JOIN Game_Developer	AS GaDe	ON Ga.id = GaDe.gameId
	LEFT JOIN Developer			AS De	ON De.id = GaDe.developerId
	-- OsFamily
	LEFT JOIN Game_OsFamily		AS GaOs	ON Ga.id = GaOs.gameId
	-- Requirement
	LEFT JOIN Game_Requirement	AS GaRe	ON Ga.id = GaRe.gameId
	LEFT JOIN Requirement		AS Re	ON Re.id = GaRe.requirementId
	-- Requirement: Operating System
	LEFT JOIN Requirement_OperatingSystem
								AS ReOp	ON Re.id = ReOp.requirementId
	LEFT JOIN OperatingSystem	AS Op	ON Op.id = ReOp.operatingSystemId
	-- Requirement: Developer
	LEFT JOIN Developer			AS Df	ON Df.id = Op.developerId
	-- Requirement: Processor
	LEFT JOIN Processor			AS Pr	ON Pr.id = Re.processorId
	-- Requirement: Graphics
	LEFT JOIN Graphics			AS Gr	ON Gr.id = Re.graphicsId
;