-- ==========================================================
-- FILE 3: SQL QUERIES FOR REPORT
-- Project: Data Retrieval and Analysis
-- Student Name: [Aleena Abey]
-- Description: Solving the 10 requirements from the brief.
-- ==========================================================

USE stem_historical_db;

-- --------------------------------------------------------
-- 1. List all historical figures born in France
-- Analysis: I used an INNER JOIN to connect the scientists to 
-- the countries table to filter by the name 'France'.
-- --------------------------------------------------------
SELECT s.full_name
FROM scientists s
JOIN countries c ON s.country_id = c.country_id
WHERE c.country_name = 'France';


-- --------------------------------------------------------
-- 2. List all historical figures that contributed to Computing
-- Analysis: This requires a three-way join between scientists, 
-- researchfields, and the junction table scientist_fields.
-- --------------------------------------------------------
SELECT s.full_name
FROM scientists s
JOIN scientist_fields sf ON s.scientist_id = sf.scientist_id
JOIN ResearchFields rf ON sf.field_id = rf.field_id
WHERE rf.field_name = 'Computing';


-- --------------------------------------------------------
-- 3. List all historical figures that contributed to more than 1 field
-- Analysis: I used GROUP BY to aggregate the data by scientist 
-- and HAVING to filter for those with a count higher than one.
-- --------------------------------------------------------
SELECT s.full_name, COUNT(sf.field_id) AS total_fields
FROM scientists s
JOIN scientist_fields sf ON s.scientist_id = sf.scientist_id
GROUP BY s.scientist_id, s.full_name
HAVING total_fields > 1;


-- --------------------------------------------------------
-- 4. Mary Jackson’s death is incorrectly listed. Update this date to 2005
-- Analysis: This demonstrates a DML UPDATE command to correct 
-- a deliberate error in the source dataset.
-- --------------------------------------------------------
UPDATE scientists 
SET death_year = 2005 
WHERE scientist_id = 24;

-- Verification of update:
SELECT full_name, death_year FROM scientists WHERE full_name = 'Mary Jackson';


-- --------------------------------------------------------
-- 5. List all historical figures who died before they were 40
-- Analysis: I performed a mathematical subtraction between 
-- death_year and birth_year within the WHERE clause.
-- --------------------------------------------------------
SELECT full_name, (death_year - birth_year) AS age_at_death
FROM scientists
WHERE (death_year - birth_year) < 40;


-- --------------------------------------------------------
-- 6. Which countries have the most historical figures listed
-- Analysis: I used COUNT and GROUP BY on the countries table 
-- and sorted by DESC to show the highest frequency first.
-- --------------------------------------------------------
SELECT c.country_name, COUNT(s.scientist_id) AS figure_count
FROM countries c
LEFT JOIN scientists s ON c.country_id = s.country_id
GROUP BY c.country_name
ORDER BY figure_count DESC;


-- --------------------------------------------------------
-- 7. Are any historical figures still alive? If so who
-- Analysis: This query identifies records where the death_year 
-- column is empty (NULL), representing living figures.
-- --------------------------------------------------------
SELECT full_name 
FROM scientists 
WHERE death_year IS NULL;


-- --------------------------------------------------------
-- 8. Which historical figures worked for NASA
-- Analysis: I used the LIKE operator with wildcards (%) to 
-- search for the keyword 'NASA' inside the description text.
-- --------------------------------------------------------
SELECT full_name, description
FROM scientists
WHERE description LIKE '%NASA%';


-- --------------------------------------------------------
-- 9. Which historical figures worked with Einstein?
-- Analysis: Similar to query 8, I used a wildcard search to 
-- find any mentions of 'Einstein' in the biographical data.
-- --------------------------------------------------------
SELECT full_name, description
FROM scientists
WHERE description LIKE '%Einstein%';


-- --------------------------------------------------------
-- 10. Which countries have the most fields of research contributions
-- Analysis: This is the most complex query, joining three tables 
-- to count unique research disciplines per country.
-- --------------------------------------------------------
SELECT c.country_name, COUNT(sf.field_id) AS total_research_contributions
FROM countries c
JOIN scientists s ON c.country_id = s.country_id
JOIN scientist_fields sf ON s.scientist_id = sf.scientist_id
GROUP BY c.country_name
ORDER BY total_research_contributions DESC;

