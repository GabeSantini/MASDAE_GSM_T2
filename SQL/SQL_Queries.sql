-- Simple query
    -- List all companies in Europe
    SELECT Name, Country, Industry
    FROM Company
    WHERE Region = 'Europe';

-- Aggregate
    -- Count of companies per region
    SELECT Region, COUNT(*) AS Company_Count
    FROM Company
    GROUP BY Region;

-- Inner join/outer join
    -- INNER JOIN: List all risks and their associated sub-risk names
    SELECT R.Name AS Risk, SR.Name AS Sub_Risk
    FROM Risk R
    INNER JOIN Sub_Risk SR ON R.Sub_Risk_ID = SR.ID;

    -- LEFT JOIN: Show all sub-risks even if no risk is linked
    SELECT SR.Name AS Sub_Risk, R.Name AS Risk
    FROM Sub_Risk SR
    LEFT JOIN Risk R ON SR.ID = R.Sub_Risk_ID;

-- Nested query
    -- Get company names where the company has a risk tolerance value above 25
    SELECT Name
    FROM Company
    WHERE ID IN (
        SELECT Company_ID
        FROM Risk_Register
        WHERE ID IN (
            SELECT Register_ID
            FROM Appetite
            WHERE Tolerance_Val > 25
        )
    );

-- Correlated query
    -- Find all controls with an effectiveness score higher than the average of their register
    SELECT C1.Description, C1.Effectiveness_Score
    FROM Controls C1
    WHERE C1.Effectiveness_Score > (
        SELECT AVG(C2.Effectiveness_Score)
        FROM Controls C2
        WHERE C2.Register_ID = C1.Register_ID
    );

-- >=ALL/>ANY/Exists/Not Exists
    -- > ALL: Find control(s) with effectiveness score higher than all others
    SELECT Description
    FROM Controls
    WHERE Effectiveness_Score > ALL (
        SELECT Effectiveness_Score
        FROM Controls
        WHERE ID != Controls.ID
    );

    -- EXISTS: Get users who have conducted at least one assessment
    SELECT Name, Email
    FROM User_Account UA
    WHERE EXISTS (
        SELECT 1
        FROM Assessments A
        WHERE A.User_ID = UA.ID
    );

    -- NOT EXISTS: Companies that have not had any assessments
    SELECT C.Name
    FROM Company C
    WHERE NOT EXISTS (
        SELECT 1
        FROM Assessment_Company_Impact ACI
        WHERE ACI.Company_ID = C.ID
    );

-- Set operations (Union)
    -- Union of all risk names and control descriptions
    SELECT Name AS Item FROM Risk
    UNION
    SELECT Description FROM Controls;

-- Subqueries in Select and From
    -- Subquery in SELECT: Get control descriptions with their register's average effectiveness
    SELECT 
        Description,
        Effectiveness_Score,
        (SELECT AVG(C2.Effectiveness_Score)
        FROM Controls C2
        WHERE C2.Register_ID = C1.Register_ID) AS Avg_Effectiveness
    FROM Controls C1;

    -- Subquery in FROM: Get average control score per register and list it with register ID
    SELECT RegisterStats.Register_ID, RegisterStats.AvgScore
    FROM (
        SELECT Register_ID, AVG(Effectiveness_Score) AS AvgScore
        FROM Controls
        GROUP BY Register_ID
    ) AS RegisterStats;


-- AUDIT------------------------------------------------------------------------------------------------------
-- Select all from Category table
SELECT * FROM Category;

-- Select all from Parent_Risk table
SELECT * FROM Parent_Risk;

-- Select all from Sub_Risk table
SELECT * FROM Sub_Risk;

-- Select all from Risk table
SELECT * FROM Risk;

-- Select all from Appetite table
SELECT * FROM Appetite;

-- Select all from Controls table
SELECT * FROM Controls;

-- Select all from Risk_Register table
SELECT * FROM Risk_Register;

-- Select all from User_Account table
SELECT * FROM User_Account;

-- Select all from Client_Employee table
SELECT * FROM Client_Employee;

-- Select all from Company table
SELECT * FROM Company;

-- Select all from Assessments table
SELECT * FROM Assessments;

-- Select all from Control_Parent_Reach table
SELECT * FROM Control_Parent_Reach;

-- Select all from Control_Sub_Risk_Reach table
SELECT * FROM Control_Sub_Risk_Reach;

-- Select all from Control_Risk_Reach table
SELECT * FROM Control_Risk_Reach;

-- Select all from Assessment_Parent_Impact table
SELECT * FROM Assessment_Parent_Impact;

-- Select all from Assessment_Sub_Risk_Impact table
SELECT * FROM Assessment_Sub_Risk_Impact;

-- Select all from Assessment_Risk_Impact table
SELECT * FROM Assessment_Risk_Impact;

-- Select all from Assessment_Control_Impact table
SELECT * FROM Assessment_Control_Impact;

-- Select all from Assessment_Company_Impact table
SELECT * FROM Assessment_Company_Impact;
