/*
Find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of the postings requiring the skill
*/

-- 1. Look at the skills to job relationship

WITH remote_job_skills AS (-- CTE Begin
    SELECT 
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN 
        job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE 
        job_postings.job_work_from_home = True AND
        job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
) --CTE End

SELECT 
    skills.skill_id,
    skills AS skill_name,
    skill_count --from CTE
FROM remote_job_skills
INNER JOIN
    skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5

/* 
The table in itself shows connection between job X to a list of skills (a,b,c)
We then use inner join to create a table that shows for each given job in 'job_postings_fact' a matching skill data point
COUNT(*) used together with skill_id to count the number of rows having a certain skill

*/