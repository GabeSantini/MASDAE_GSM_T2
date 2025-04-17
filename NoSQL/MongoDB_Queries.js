// A simple query
    // Get all companies located in Europe:
    db.Companies.find({ Region: "Europe" }, { Name: 1, Country: 1, Industry: 1, _id: 0 });
// A more complex query
    // Get a list of risks along with their associated company names:
    db.Risk.aggregate([
        {
        $lookup: {
            from: "Risk_Register",
            localField: "Register_ID",
            foreignField: "_id",
            as: "Register"
        }
        },
        { $unwind: "$Register" },
        {
        $lookup: {
            from: "Companies",
            localField: "Register.Company_ID",
            foreignField: "_id",
            as: "Company"
        }
        },
        { $unwind: "$Company" },
        {
        $project: {
            Risk_Name: "$Name",
            Risk_Description: "$Description",
            Company: "$Company.Name",
            Industry: "$Company.Industry",
            _id: 0
        }
        }
    ]);
  
// An aggregate (or MapReduce)

    // Count the number of risks per risk appetite level:
    db.Risk.aggregate([
        {
        $lookup: {
            from: "Appetite",
            localField: "Appetite_ID",
            foreignField: "_id",
            as: "Appetite"
        }
        },
        { $unwind: "$Appetite" },
        {
        $group: {
            _id: "$Appetite.Name",
            Risk_Count: { $sum: 1 }
        }
        },
        { $sort: { Risk_Count: -1 } }
    ]);
    