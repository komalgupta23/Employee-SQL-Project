# Employee-SQL-Project

📊 Employee Data Analytics: 150+ SQL Case Studies
This repository contains a comprehensive SQL analysis of a large-scale employee dataset (150,000+ records). The project focuses on extracting HR insights, auditing data quality, and performing complex financial calculations using MySQL.

🚀 Project Overview
The objective of this project was to transform raw employee data into actionable business intelligence. I have written and optimized over 150 queries to solve various business problems related to salary distribution, performance benchmarking, and organizational structure.

🛠️ Tech Stack
    - Database: MySQL
    - Key SQL Concepts: * Data Cleaning (NULL handling, Duplicate removal).
          - Advanced Joins & Subqueries.
          - Window Functions (DENSE_RANK, ROW_NUMBER, PARTITION BY).
          - Data Transformation (CASE Statements, ALTER, UPDATE).

📁 Repository Structure
    - SQL_Queries.sql: The main file containing all 150+ queries.
    - Screenshots/: A folder containing query results and execution proofs.
    - Project_Presentation.pdf: A detailed report/presentation of the findings.

💡 Key Analysis & Insights

1. Data Integrity & Cleaning :  Ensured 100% data reliability by performing:
      - NULL Audits: Checked all 8 columns for missing data using aggregate case logic.
      - Duplicate Cleansing: Identified and managed duplicate entries across all major fields.
      - Schema Evolution: Normalized the table by splitting the Name field into First_Name and Last_Name and renaming columns for better readability.

2. Salary & Compensation Intelligence
      - Categorized employees into High, Medium, and Low salary brackets using conditional logic.
      - Identified top earners in each company and city using advanced ranking functions.
      - Benchmarked company-level average salaries against the global average to identify high-paying organizations.

3. Workforce Performance
      - Analyzed employee ratings to identify top-performing departments and job titles like 'Production Engineer'.
      - Calculated the ratio of Full-time employees to Interns to assess workforce stability.

🔧 How to Use
1. Clone this repository.
2. Import the .sql files into your MySQL Workbench.
3. Run the schema modification queries first to set up the environment.
