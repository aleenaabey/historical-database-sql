-- ==========================================================
-- FILE 1: DATABASE STRUCTURE (DDL)
-- DESCRIPTION: Sets up the 3NF schema for STEM figures and events.
-- ==========================================================

-- Start fresh by dropping the database if it already exists
DROP DATABASE IF EXISTS stem_historical_db;
CREATE DATABASE stem_historical_db;
USE stem_historical_db;

-- --------------------------------------------------------
-- 3NF NORMALIZATION: SEPARATED ATTRIBUTES
-- Breaking down the Excel data into individual entities 
-- to remove redundancy.
-- --------------------------------------------------------

-- Table for distinct countries to avoid text repetition
CREATE TABLE countries (
    COUNTRY_ID INT PRIMARY KEY,
    COUNTRY_NAME VARCHAR(100) NOT NULL UNIQUE
);

-- Main table for historical figure biographies
CREATE TABLE scientists (
    SCIENTIST_ID INT PRIMARY KEY,           -- Unique identifier for each figure
    FULL_NAME VARCHAR(150) NOT NULL,        -- Full name as per the Excel source
    BIRTH_YEAR INT,                         -- Year of birth
    DEATH_YEAR INT NULL,                    -- Year of death (NULL allowed for living figures)
    COUNTRY_ID INT,                         -- Foreign key referencing the 'countries' table
    DESCRIPTION TEXT,                       -- Detailed biographical summary
    
    -- Ensuring data integrity by linking to the parent country table
    CONSTRAINT fk_scientist_country 
    FOREIGN KEY (COUNTRY_ID) REFERENCES countries(COUNTRY_ID)
);

-- Table for STEM disciplines and research fields
CREATE TABLE ResearchFields (
    FIELD_ID INT PRIMARY KEY,
    FIELD_NAME VARCHAR(100) NOT NULL UNIQUE
);


-- TABLE: rooms (Now using a Foreign Key instead of ENUM)
CREATE TABLE rooms (
    ROOM_ID INT PRIMARY KEY,
    ROOM_NAME VARCHAR(100) NOT NULL,
    ROOM_TYPE VARCHAR(50) NOT NULL,
    CAPACITY INT NOT NULL
);


-- SPEAKERS: Stores details for guest lecturers
CREATE TABLE speakers (
    SPEAKER_ID INT PRIMARY KEY,
    NAME VARCHAR(150) NOT NULL,
    BIO TEXT,
    CONTACT_INFO VARCHAR(100)
);

-- --------------------------------------------------------
-- PART 3: RELATIONSHIP MAPPING (JUNCTION TABLES)
-- --------------------------------------------------------

-- Links scientists to their specific fields of study
CREATE TABLE scientist_fields (
    SCIENTIST_ID INT,
    FIELD_ID INT,
    PRIMARY KEY (SCIENTIST_ID, FIELD_ID),
    FOREIGN KEY (SCIENTIST_ID) REFERENCES scientists(SCIENTIST_ID) ON DELETE CASCADE,
    FOREIGN KEY (FIELD_ID) REFERENCES ResearchFields(FIELD_ID) ON DELETE CASCADE
);

-- EVENTS: The main booking table
CREATE TABLE events (
    EVENT_ID INT PRIMARY KEY,
    TITLE VARCHAR(200) NOT NULL,
    EVENT_DATE DATETIME NOT NULL, -- Renamed from EVENT_NAME to EVENT_DATE for clarity
    ROOM_ID INT,
    REQUIRES_TICKETS BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (ROOM_ID) REFERENCES rooms(ROOM_ID)
);

-- Linking events to specific historical figures (Topics)
CREATE TABLE event_topics (
    EVENT_ID INT,
    SCIENTIST_ID INT,
    PRIMARY KEY (EVENT_ID, SCIENTIST_ID),
    FOREIGN KEY (EVENT_ID) REFERENCES events(EVENT_ID) ON DELETE CASCADE,
    FOREIGN KEY (SCIENTIST_ID) REFERENCES scientists(SCIENTIST_ID) ON DELETE CASCADE
);

-- Linking speakers to events
CREATE TABLE event_speakers (
    EVENT_ID INT,
    SPEAKER_ID INT,
    PRIMARY KEY (EVENT_ID, SPEAKER_ID),
    FOREIGN KEY (EVENT_ID) REFERENCES events(EVENT_ID) ON DELETE CASCADE,
    FOREIGN KEY (SPEAKER_ID) REFERENCES speakers(SPEAKER_ID) ON DELETE CASCADE
);

-- TICKETS: Handling price and availability for bookings
CREATE TABLE tickets (
    TICKET_ID INT PRIMARY KEY,
    EVENT_ID INT,
    TICKET_TYPE VARCHAR(50),
    PRICE DECIMAL(10,2),
    QUANTITY INT,
    FOREIGN KEY (EVENT_ID) REFERENCES events(EVENT_ID) ON DELETE CASCADE
);