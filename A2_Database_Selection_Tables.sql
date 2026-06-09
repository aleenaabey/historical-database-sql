-- ==========================================================
-- FILE: A2_Database_Selection_Tables.sql
-- Project: STEM Historical Database System
-- Student Name: Aleena Abey
-- Description: This script performs a full selection of all 
-- tables in the database to verify the successful implementation 
-- of the 3NF schema and correct data insertion.
-- ==========================================================

USE stem_historical_db;

-- [Section 1: Lookup Tables]
SELECT * FROM countries;
SELECT * FROM ResearchFields;

-- [Section 2: Scientist Data]
SELECT * FROM scientists;
SELECT * FROM scientist_fields;

-- [Section 3: Event & Booking System]
SELECT * FROM rooms;
SELECT * FROM speakers;
SELECT * FROM events;
SELECT * FROM event_topics;
SELECT * FROM event_speakers;
SELECT * FROM tickets;