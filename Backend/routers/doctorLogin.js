const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');

// Define the schema for the doctor login
const doctorLoginSchema = new mongoose.Schema({
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

// Create a model for the doctor login schema
const DoctorLogin = mongoose.model('DoctorLogin', doctorLoginSchema);

// Define route to handle doctor login
router.post('/healtha/doctor-login', async (req, res) => {
  try {
    const { email, password } = req.body;

    // Check if the email already exists in the database
    const existingDoctor = await DoctorLogin.findOne({ email });

    if (existingDoctor) {
      // If the email already exists, return an error
      return res.status(400).json({ error: 'Email already exists' });
    }

    // Create a new doctor login document
    const newDoctorLogin = new DoctorLogin({ email, password });
    await newDoctorLogin.save();

    res.status(201).json({ message: 'Doctor login created successfully' });
  } catch (err) {
    console.error('Error creating doctor login', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;
