const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');

// Define the schema for the patient login
const patientLoginSchema = new mongoose.Schema({
  email: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true
  },
});

// Create a model for the patient login schema
const PatientLogin = mongoose.model('PatientLogin', patientLoginSchema);

// Define route to handle patient login
router.post('/healtha/patient-login', async (req, res) => {
try {
const { email, password } = req.body;

// Check if the email already exists in the database
const existingUser = await PatientLogin.findOne({ email });

if (existingUser) {
// If the email already exists, return an error
return res.status(400).json({ error: 'Email already exists' });
}

// Create a new patient login document
const newPatientLogin = new PatientLogin({ email, password });
await newPatientLogin.save();

res.status(201).json({ message: 'Patient login created successfully' });
} catch (err) {
console.error('Error creating patient login', err);
res.status(500).json({ error: 'Internal server error' });
}
});

module.exports = router;
