// Clinic Management System - MongoDB prescriptions collection
// Usage:
//   mongosh "mongodb://root:<password>@<host>:27017/prescriptions?authSource=admin" < scripts/prescriptions_mongodb_seed.js
//
// Or inside mongosh:
//   load("/Users/hugoroca/repositories/java-database-capstone/scripts/prescriptions_mongodb_seed.js")

use("prescriptions");

// Recreate collection (optional — comment out if you want to keep existing data)
db.prescriptions.drop();
db.createCollection("prescriptions");

db.prescriptions.insertOne({
  _id: ObjectId("6807dd712725f013281e7224"),
  patientName: "Ella Moore",
  appointmentId: NumberLong(74),
  medication: "Aspirin",
  dosage: "300mg",
  doctorNotes: "Take 1 tablet after meals.",
  _class: "com.project.back_end.models.Prescription",
});

print("prescriptions collection created with 1 document.");
printjson(db.prescriptions.findOne({ _id: ObjectId("6807dd712725f013281e7224") }));
