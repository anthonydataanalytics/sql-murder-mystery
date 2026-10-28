SQL MURDER MYSTERY: Investigation Process and Findings

Case Overview

A murder occurred on January 15, 2018, in SQL City. My task was to use the available police database and SQL queries to investigate the case, follow the evidence, identify potential suspects, and ultimately determine who was responsible for the murder.

Rather than searching for the answer directly, I approached the case as a data investigation. I used the information provided in the crime report to identify witnesses, retrieve their statements, extract relevant clues, narrow down potential suspects, and verify the evidence until I could identify the murderer.


Step 1: Investigating the Crime Scene Report

I began by querying the crime scene report using the date, city, and type of crime provided in the case.
My objective was to retrieve the official police report and identify any available clues, particularly information about witnesses or descriptions of the suspect that could guide the next stage of the investigation.

SQL Query:

SELECT *
FROM crime_scene_report
where city = 'SQL City'
AND date = 20180115
AND type = 'murder'

Finding

The crime report revealed that there were two witnesses.

- The first witness lived at the last house on Northwestern Dr.
- The second witness was named Annabel and lived somewhere on Franklin Ave.

The information contained in the crime report gave me my first leads. Since the witnesses could provide additional information about what happened, I decided to locate their records in the person table.


Step 2: Identifying the Witnesses

Since the crime report provided descriptions of the witnesses' locations, I searched for their records in the person table.

I used the "IN" operator to filter the database based on the two addresses identified from the crime report.

SQL Query:

SELECT *
FROM person
WHERE address_street_name in ('Northwestern Dr', 'Franklin Ave')

Finding

The query returned the records of the two witnesses, including their personal IDs.

These unique IDs were important because they could be used to connect the witnesses' information to their corresponding records in the interview table.

This gave me a clear path to the next stage of the investigation: retrieving the witnesses' statements.


Step 3: Retrieving the Witness Interviews

The crime report indicated that the two witnesses had information relevant to the investigation. Therefore, I searched for their interview records to understand what each witness had seen or heard.

I joined the person and interview tables using the witnesses' unique IDs.

SQL Query:

SELECT *
FROM person p
JOIN interview i
on p.id = i.person_id
WHERE p.address_street_name in ('Northwestern Dr', 'Franklin Ave')

Finding

The initial result contained multiple records associated with individuals who had similar or identical names. Therefore, I needed to narrow the results further.

I used the date of the crime as an additional filter to ensure that I was retrieving the interviews related to the January 15, 2018 incident rather than unrelated records.

This allowed me to isolate the relevant statements from the two witnesses.


Step 4: Analysing the Witness Statements

At this stage, my main objective was to understand exactly what the witnesses had reported and determine whether their statements contained information that could be used to identify the murderer.

SQL Query:

SELECT *
FROM person p
JOIN interview i
on p.id = i.person_id
join facebook_event_checkin fec
on i.person_id = fec.person_id
WHERE p.address_street_name in ('Northwestern Dr', 'Franklin Ave')
and date = 20180115

I also connected the person, interview, and facebook_event_checkin tables. This allowed me to compare information across the tables and further narrow the investigation to the date of the crime.

Key Evidence

One of the witnesses provided a particularly useful description of the suspect.

According to the witness:

- The suspect had a bag with a membership number beginning with "48Z".
- The suspect entered a vehicle with a license plate containing "H42W".

This was a significant breakthrough because these details were specific enough to become conditions that I could search for in other tables within the database.

The second witness also provided information, but the available evidence from that statement was not sufficient to establish a strong connection to a specific suspect. Therefore, I focused my investigation on the more actionable clues provided by the first witness.


Step 5: Using the Membership Information to Identify Suspects

The witness's statement provided a specific membership number pattern and information about the suspect's membership status.

I therefore searched the relevant table for records matching the membership number beginning with "48Z" and filtered the results using the appropriate membership status.

SQL Query:

SELECT *
FROM get_fit_now_member
WHERE id like ('48Z%')
And membership_status = 'gold'

Finding

The query narrowed the results down to two potential suspects.

I used the "LIKE" operator to identify membership numbers matching the ""48Z%"" pattern and applied the relevant condition for the suspect's Gold membership status.

At this point, the investigation had moved from a large population of records to just two potential suspects.

However, identifying two suspects was not enough. I needed additional evidence to determine which of them was actually connected to the murder.


Step 6: Identifying the Actual Murderer

With two potential suspects identified, I needed to investigate their records further and determine which suspect had a direct connection to the crime.

SQL Query:

SELECT *
FROM interview
where person_id = 67318 OR person_id = 28819

Finding

The results showed that one of the two suspects had been interviewed.

During the interview, the suspect confessed and stated that he had been hired by a wealthy woman.

This provided the critical piece of evidence needed to distinguish the actual murderer from the other potential suspect.

The evidence therefore pointed to Jeremy Bowers as the person who committed the murder.


Investigation Summary

The investigation followed a logical sequence of evidence discovery:

Crime Report
↓
Identify the Two Witnesses
↓
Locate Witnesses in the Person Table
↓
Retrieve Their Interview Records
↓
Analyse Witness Statements
↓
Extract Membership Number and Vehicle Clues
↓
Search Database Using the Clues
↓
Narrow Down to Two Suspects
↓
Investigate Suspects' Records
↓
Identify the Suspect Who Confessed
↓
Jeremy Bowers


Conclusion

I approached this murder investigation as a data-driven problem rather than attempting to identify the murderer directly. I started with the information available in the crime scene report and progressively followed each clue through the database.

The crime report led me to the two witnesses. I then used their addresses to locate their records in the person table and used their unique IDs to retrieve their interview statements. One of the witness statements provided specific clues about the suspect's membership number and vehicle.

I used these clues to search and filter the relevant database records, which reduced the number of possible suspects to two. I then investigated these individuals further and discovered that Jeremy Bowers had been interviewed and confessed to being hired by a wealthy woman.

Therefore, based on the evidence uncovered through the SQL investigation, Jeremy Bowers was identified as the murderer.

Key SQL Concepts Demonstrated

During the investigation, I applied several SQL concepts, including:

- "SELECT" and "FROM"
- "WHERE"
- "AND"
- "IN"
- "LIKE"
- Filtering and pattern matching
- Table "JOIN"s
- Using unique IDs to connect related tables
- Date-based filtering
- Logical reasoning and sequential investigation
- Extracting and interpreting information from relational databases

This project demonstrated how SQL can be used not only to retrieve data, but also to investigate a problem, connect evidence across multiple tables, identify patterns, eliminate possibilities, and arrive at a data-supported conclusion.