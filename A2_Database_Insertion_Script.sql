-- ==========================================================
-- FILE 2: DATA INSERTION (DML)
-- Project: Populating the Normalized STEM Database
-- ==========================================================

USE stem_historical_db;

-- --------------------------------------------------------
-- PART 1: REFERENCE TABLES
-- --------------------------------------------------------

-- Seeding Countries from your Excel 'countries' tab
INSERT INTO countries (COUNTRY_ID, COUNTRY_NAME) VALUES 
(1, 'BRITAIN'),   -- ID for scientists from the UK
(2, 'EGYPT'),     -- ID for Hypatia
(3, 'FRANCE'),    -- ID for Châtelet, Germain, etc.
(4, 'GERMANY'),   -- ID for Noether, Noddack, etc.
(5, 'ITALY'),     -- ID for Maria Agnesi
(6, 'JAPAN'),     -- ID for Fumiko Yonezawa
(7, 'POLAND'),    -- ID for Marie Curie
(8, 'RUSSIA'),    -- ID for Lermontova, Kovalevskaya
(9, 'SERBIA'),    -- ID for Mileva Marić
(10, 'SWEDEN'),   -- ID for Brahe, Bruhn
(11, 'USA'),      -- ID for Hopper, Kwolek, NASA team
(12, 'IRAN');     -- ID for Maryam Mirzakhani

-- Seeding Research Fields from your Excel 'ResearchFields' tab
INSERT INTO ResearchFields (FIELD_ID, FIELD_NAME) VALUES 
(1, 'Mathematics'), (2, 'Computing'), (3, 'Physics'), 
(4, 'Biology'), (5, 'Chemistry'), (6, 'Astronomy'), (7, 'Engineering');

-- --------------------------------------------------------
-- PART 2: CORE ENTITY - SCIENTISTS
-- Data pulled from your main 'scientists' Excel sheets
-- --------------------------------------------------------

INSERT INTO scientists (SCIENTIST_ID, FULL_NAME, BIRTH_YEAR, DEATH_YEAR, COUNTRY_ID, DESCRIPTION) VALUES 
(1, 'Augusta Ada King (Lovelace)', 1815, 1852, 1, 'First published computer algorithm.'),
(2, 'Mary Cartwright', 1900, 1998, 1, 'Director of studies in Mathematics.'),
(3, 'Rosalind Franklin', 1920, 1958, 1, 'X-ray crystallography of DNA.'),
(4, 'Hertha Ayrton', 1854, 1923, 1, 'First female member of the IEE.'),
(5, 'Dorothy Hodgkin', 1910, 1994, 1, 'Nobel Prize in Chemistry.'),
(6, 'Hypatia Alexandria', 360, 415, 2, 'Earliest female mathematician.'),
(7, 'Émilie du Châtelet', 1706, 1749, 3, 'Translated Newton''s Principia.'),
(8, 'Marie-Sophie Germain', 1776, 1831, 3, 'Work on Number Theory.'),
(9, 'Irène Joliot-Curie', 1897, 1986, 3, 'Nobel Prize in Chemistry.'),
(10, 'Yvonne Choquet-Bruhat', 1923, NULL, 3, 'Dynamics in General Relativity.'),
(11, 'Emmy Noether', 1882, 1935, 4, 'Mathematical genius.'),
(12, 'Ida Noddack', 1896, 1978, 4, 'Discovery of rhenium.'),
(13, 'Maria Goeppert Mayer', 1906, 1972, 4, 'Nobel Prize in Physics.'),
(14, 'Maria Gaetana Agnesi', 1718, 1799, 5, 'Author of Analytical Institutions.'),
(15, 'Fumiko Yonezawa', 1938, 2019, 6, 'President of Physics Society of Japan.'),
(16, 'Marie Skłodowska Curie', 1867, 1934, 7, 'Theory of Radioactivity.'),
(17, 'Julia Lermontova', 1846, 1919, 8, 'First Russian female doctor in chemistry.'),
(18, 'Mileva Marić', 1875, 1948, 9, 'Serbian Physicist.'),
(19, 'Sophia Brahe', 1559, 1643, 10, 'Astronomy observations.'),
(20, 'Maria Christina Bruhn', 1732, 1808, 10, 'Invented safe artillery storage.'),
(21, 'Grace Hopper', 1906, 1992, 11, 'Pioneer of COBOL.'),
(22, 'Stephanie Kwolek', 1923, 2014, 11, 'Discovered Kevlar.'),
(23, 'Katherine Johnson', 1918, 2020, 11, 'NASA Orbital mechanics.'),
(24, 'Mary Jackson', 1921, 2005, 11, 'NASA Aerospace engineer.'),
(25, 'Sofya Kovalevskaya', 1850, 1891, 8, 'Modern Doctorate in Math.'),
(26, 'Maryam Mirzakhani', 1977, 2017, 12, 'First woman to win Fields Medal.');

-- --------------------------------------------------------
-- PART 3: RELATIONSHIPS & EVENTS
-- --------------------------------------------------------

-- Junction table mapping Scientists to Research Fields
-- Based on your Excel mapping for interdisciplinary work
INSERT INTO scientist_fields (SCIENTIST_ID, FIELD_ID) VALUES 
(1,1), (1,2),   -- Ada Lovelace: Math & Computing
(2,1),          -- Mary Cartwright: Math
(3,3), (3,4),   -- Rosalind Franklin: Physics & Biology
(4,7), (4,3),   -- Hertha Ayrton: Engineering & Physics
(5,4), (5,5),   -- Dorothy Hodgkin: Biology & Chemistry
(6,1), (6,6),   -- Hypatia: Math & Astronomy
(7,1), (7,3),   -- Émilie du Châtelet: Math & Physics
(8,1), (8,3),   -- Sophie Germain: Math & Physics
(9,5), (9,3),   -- Irène Joliot-Curie: Chemistry & Physics
(10,1),         -- Yvonne Choquet-Bruhat: Math
(11,3), (11,1), -- Emmy Noether: Physics & Math
(12,3), (12,5), -- Ida Noddack: Physics & Chemistry
(13,3),         -- Maria Goeppert Mayer: Physics
(14,3),         -- Maria Agnesi: Physics
(15,1), (15,3), -- Fumiko Yonezawa: Math & Physics
(16,2), (16,3), -- Marie Curie: Computing & Physics
(17,5),         -- Julia Lermontova: Chemistry
(18,1), (18,3), -- Mileva Marić: Math & Physics
(19,6), (19,5), -- Sophia Brahe: Astronomy & Chemistry
(20,5),         -- Maria Bruhn: Chemistry
(21,2),         -- Grace Hopper: Computing
(22,5),         -- Stephanie Kwolek: Chemistry
(23,1),         -- Katherine Johnson: Math
(24,1), (24,7), -- Mary Jackson: Math & Engineering
(25,1),         -- Sofya Kovalevskaya: Math
(26,1);         -- Maryam Mirzakhani: Math

-- Populating Venue Rooms
INSERT INTO rooms (ROOM_ID, ROOM_NAME, ROOM_TYPE, capacity) VALUES 
(1, 'Newton Lecture Theatre', 'Lecture room', 50),
(2, 'Lovelace Grand Hall', 'Event room', 120),
(3, 'Curie Seminar Room', 'Lecture room', 30);

-- Populating Guest Speakers
INSERT INTO speakers (SPEAKER_ID, NAME, BIO, CONTACT_INFO) VALUES 
(1, 'Dr. Sarah Smith', 'Expert in 19th century Mathematics', 's.smith@university.ac.uk'),
(2, 'Prof. Alan Brown', 'STEM History Researcher', 'a.brown@institute.org.'),
(3, 'Dr. Emily Wilson', 'Author of "Hidden Figures"', 'e.wilson@authors.com');

-- Creating the Events
INSERT INTO events (EVENT_ID, TITLE, EVENT_DATE, ROOM_ID, REQUIRES_TICKETS) VALUES 
(1, 'The Pioneers of Computing', '2026-06-15 14:00:00', 1, TRUE),  -- Paid entry event
(2, 'Women in Physics', '2026-06-20 10:00:00', 2, FALSE),         -- Free community event
(3, 'Chemistry Trailblazers', '2026-07-05 11:00:00', 3, TRUE),    -- Limited seating seminar
(4, 'Mathematical Minds', '2026-07-12 14:00:00', 1, FALSE);       -- Open lecture

-- Linking Events to Topics (Scientists) and Speakers
INSERT INTO event_topics (EVENT_ID, SCIENTIST_ID) VALUES 
(1,1), (1,21),  -- Computing event covers Lovelace and Hopper
(2,16),         -- Physics event covers Marie Curie
(3,5), (3,12),  -- Chemistry event covers Hodgkin and Noddack
(4,23);         -- Math event covers Katherine Johnson

INSERT INTO event_speakers (EVENT_ID, SPEAKER_ID) VALUES 
(1,1), -- Dr. Sarah Smith for Computing
(2,2), -- Prof. Alan Brown for Physics
(3,3), -- Dr. Emily Wilson for Chemistry
(4,1); -- Dr. Sarah Smith for Math

-- Issuing Tickets
INSERT INTO tickets (TICKET_ID, EVENT_ID, TICKET_TYPE, PRICE, QUANTITY) VALUES 
(1, 1, 'General Admission', 15.00, 4),  -- Standard rate for Event 1
(2, 1, 'Student', 10.00, 10),           -- Discounted rate for Event 1
(3, 3, 'Standard', 20.00, 30);          -- Fixed rate for Event 3