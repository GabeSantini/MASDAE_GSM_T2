// use lib
db.dropDatabase()


db.Companies.insertMany([
  { _id: 1, Name: "TechCorp", Country: "USA", Region: "North America", Industry: "Technology", Specialization: "Software Development" },
  { _id: 2, Name: "MediCare", Country: "UK", Region: "Europe", Industry: "Healthcare", Specialization: "Pharmaceuticals" },
  { _id: 3, Name: "EcoEnergy", Country: "Germany", Region: "Europe", Industry: "Energy", Specialization: "Renewable Sources" },
  { _id: 4, Name: "FinTrust", Country: "Canada", Region: "North America", Industry: "Finance", Specialization: "Investment Banking" },
  { _id: 5, Name: "AutoDrive", Country: "Japan", Region: "Asia", Industry: "Automobile", Specialization: "Electric Vehicles" }
])


db.Risk_Register.insertMany([
  { _id: 1, Company_ID: 1 },
  { _id: 2, Company_ID: 2 },
  { _id: 3, Company_ID: 3 },
  { _id: 4, Company_ID: 4 },
  { _id: 5, Company_ID: 5 }
])

db.Category.insertMany([
  { _id: 1, Name: "Operational",  Description: "Risks related to operational failures" },
  { _id: 2, Name: "Financial",  Description: "Risks affecting financial stability" },
  { _id: 3, Name: "Reputational",  Description: "Risks impacting public perception" },
  { _id: 4, Name: "Compliance",  Description: "Regulatory and legal risks" },
  { _id: 5, Name: "Strategic",  Description: "Risks affecting long-term business goals" }
  ])
  
  db.Parent_Risk.insertMany([
    { _id: 1, Name: "Data Breach", Description: "Risk of sensitive data exposure", Category_ID: 1, Register_ID: 1 },
    { _id: 2, Name: "Market Volatility", Description: "Unstable market conditions", Category_ID: 2, Register_ID: 2 },
    { _id: 3, Name: "Brand Damage", Description: "Negative publicity or scandal", Category_ID: 3, Register_ID: 3 },
    { _id: 4, Name: "Regulatory Non-compliance", Description: "Failure to comply with laws", Category_ID: 4, Register_ID: 4 },
    { _id: 5, Name: "Business Disruption", Description: "Unexpected disruptions in operations", Category_ID: 5, Register_ID: 5 }
  ])
  
  db.Sub_Risk.insertMany([
    { _id: 1, Name: "Hacking Attempt", Description: "Unauthorized access to systems", Parent_Risk_ID: 1, Register_ID: 1 },
    { _id: 2, Name: "Stock Crash", Description: "Sudden drop in stock prices", Parent_Risk_ID: 2, Register_ID: 2 },
    { _id: 3, Name: "Social Media Backlash", Description: "Negative social media coverage", Parent_Risk_ID: 3, Register_ID: 3 },
    { _id: 4, Name: "Missed Reporting Deadlines", Description: "Failure to report on time", Parent_Risk_ID: 4, Register_ID: 4 },
    { _id: 5, Name: "Natural Disasters", Description: "Floods, earthquakes impacting business", Parent_Risk_ID: 5, Register_ID: 5 }
  ])
  
  db.Appetite.insertMany([
  { _id: 1, Name: "Low", Tolerance_Val: 10.0, Acceptance_Value: 5.0, Register_ID: 1 },
  { _id: 2, Name: "Medium", Tolerance_Val: 20.0, Acceptance_Value: 10.0, Register_ID: 2 },
  { _id: 3, Name: "High", Tolerance_Val: 30.0, Acceptance_Value: 15.0, Register_ID: 3 },
  { _id: 4, Name: "Very High", Tolerance_Val: 40.0, Acceptance_Value: 20.0, Register_ID: 4 },
  { _id: 5, Name: "Extreme", Tolerance_Val: 50.0, Acceptance_Value: 25.0, Register_ID: 5 }
])

db.Risk.insertMany([
  { _id: 1, Name: "Phishing Attack", Description: "Email-based hacking attempt", Sub_Risk_ID: 1, Appetite_ID: 1, Register_ID: 1 },
  { _id: 2, Name: "Economic Downturn", Description: "Long-term economic slowdown", Sub_Risk_ID: 2, Appetite_ID: 2, Register_ID: 2 },
  { _id: 3, Name: "Fake News", Description: "Misinformation damaging reputation", Sub_Risk_ID: 3, Appetite_ID: 3, Register_ID: 3 },
  { _id: 4, Name: "Tax Evasion", Description: "Failure to pay necessary taxes", Sub_Risk_ID: 4, Appetite_ID: 4, Register_ID: 4 },
  { _id: 5, Name: "Factory Shutdown", Description: "Temporary closure of operations", Sub_Risk_ID: 5, Appetite_ID: 5, Register_ID: 5 }
])

db.Controls.insertMany([
  { _id: 1, Description: "Firewall Protection", Effectiveness_Score: 85.5, Register_ID: 1 },
  { _id: 2, Description: "Diversified Investments", Effectiveness_Score: 75.0, Register_ID: 2 },
  { _id: 3, Description: "Public Relations Strategy", Effectiveness_Score: 80.0, Register_ID: 3 },
  { _id: 4, Description: "Legal Compliance Training", Effectiveness_Score: 90.0, Register_ID: 4 },
  { _id: 5, Description: "Backup Power Generators", Effectiveness_Score: 88.5, Register_ID: 5 }
])

db.User_Account.insertMany([
  { _id: 1, Name: "Alice Johnson", Email: "alice@example.com", Region: "North America", Country: "USA" },
  { _id: 2, Name: "Bob Smith", Email: "bob@example.com", Region: "Europe", Country: "UK" },
  { _id: 3, Name: "Charlie Tan", Email: "charlie@example.com", Region: "Asia", Country: "Singapore" },
  { _id: 4, Name: "Diana Lopez", Email: "diana@example.com", Region: "South America", Country: "Brazil" },
  { _id: 5, Name: "Ethan Wang", Email: "ethan@example.com", Region: "Australia", Country: "Australia" }
])

db.Client_Employee.insertMany([
  { User_ID: 1, Company_ID: 1 },
  { User_ID: 2, Company_ID: 2 },
  { User_ID: 3, Company_ID: 3 },
  { User_ID: 4, Company_ID: 4 },
  { User_ID: 5, Company_ID: 5 }
])

db.Assessments.insertMany([
  { _id: 1, User_ID: 1, Description: "Security Audit for TechCorp", Region: "North America", Industry: "Technology" },
  { _id: 2, User_ID: 2, Description: "Financial Risk Review for MediCare", Region: "Europe", Industry: "Healthcare" },
  { _id: 3, User_ID: 3, Description: "Reputation Analysis for EcoEnergy", Region: "Europe", Industry: "Energy" },
  { _id: 4, User_ID: 4, Description: "Compliance Check for FinTrust", Region: "North America", Industry: "Finance" },
  { _id: 5, User_ID: 5, Description: "Operational Risk Evaluation for AutoDrive", Region: "Asia", Industry: "Automobile" }
])

db.Control_Parent_Reach.insertMany([
  { Control_ID: 1, Parent_ID: 1 },
  { Control_ID: 2, Parent_ID: 2 },
  { Control_ID: 3, Parent_ID: 3 },
  { Control_ID: 4, Parent_ID: 4 },
  { Control_ID: 5, Parent_ID: 5 }
])

db.Control_Sub_Risk_Reach.insertMany([
  { Control_ID: 1, Sub_Risk_ID: 1 },
  { Control_ID: 2, Sub_Risk_ID: 2 },
  { Control_ID: 3, Sub_Risk_ID: 3 },
  { Control_ID: 4, Sub_Risk_ID: 4 },
  { Control_ID: 5, Sub_Risk_ID: 5 }
])

db.Control_Risk_Reach.insertMany([
  { Control_ID: 1, Risk_ID: 1 },
  { Control_ID: 2, Risk_ID: 2 },
  { Control_ID: 3, Risk_ID: 3 },
  { Control_ID: 4, Risk_ID: 4 },
  { Control_ID: 5, Risk_ID: 5 }
])

db.Assessment_Parent_Impact.insertMany([
  { Assessment_ID: 1, Parent_Risk_ID: 1 },
  { Assessment_ID: 2, Parent_Risk_ID: 2 },
  { Assessment_ID: 3, Parent_Risk_ID: 3 },
  { Assessment_ID: 4, Parent_Risk_ID: 4 },
  { Assessment_ID: 5, Parent_Risk_ID: 5 }
])

db.Assessment_Sub_Risk_Impact.insertMany([
  { Assessment_ID: 1, Sub_Risk_ID: 1 },
  { Assessment_ID: 2, Sub_Risk_ID: 2 },
  { Assessment_ID: 3, Sub_Risk_ID: 3 },
  { Assessment_ID: 4, Sub_Risk_ID: 4 },
  { Assessment_ID: 5, Sub_Risk_ID: 5 }
])

db.Assessment_Risk_Impact.insertMany([
  { Assessment_ID: 1, Risk_ID: 1 },
  { Assessment_ID: 2, Risk_ID: 2 },
  { Assessment_ID: 3, Risk_ID: 3 },
  { Assessment_ID: 4, Risk_ID: 4 },
  { Assessment_ID: 5, Risk_ID: 5 }
])

db.Assessment_Control_Impact.insertMany([
  { Assessment_ID: 1, Control_ID: 1 },
  { Assessment_ID: 2, Control_ID: 2 },
  { Assessment_ID: 3, Control_ID: 3 },
  { Assessment_ID: 4, Control_ID: 4 },
  { Assessment_ID: 5, Control_ID: 5 }
])

db.Assessment_Company_Impact.insertMany([
  { Assessment_ID: 1, Company_ID: 1 },
  { Assessment_ID: 2, Company_ID: 2 },
  { Assessment_ID: 3, Company_ID: 3 },
  { Assessment_ID: 4, Company_ID: 4 },
  { Assessment_ID: 5, Company_ID: 5 }
])
