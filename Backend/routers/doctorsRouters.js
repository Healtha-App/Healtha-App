const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');

// Define Doctors schema
const sectionSchema2 = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    specialization: {
        type: String,
        required: true
    },
    location: String,
});

const DoctorsSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    sections: {
        type: [sectionSchema2],
        required: true
    }
});

// Create Doctor model
const Doctor = mongoose.model('Doctor', DoctorsSchema, 'Doctors');

// GET all Doctors
router.get('/healtha/doctors', async (req, res) => {
    try {
        const doctors = await Doctor.find();
        res.status(200).json(doctors);
    } catch (error) {
        console.error('Error retrieving doctors:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// GET doctors by ID 
router.get('/healtha/doctors/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const doctor = await Doctor.findById(id);
        if (!doctor) {
            return res.status(404).json({ error: 'Doctor not found' });
        }
        res.status(200).json(doctor);
    } catch (error) {
        console.error('Error retrieving doctor by ID:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// POST new doctor
router.post('/healtha/doctors', async (req, res) => {
    try {
        const doctor = await Doctor.create(req.body);
        res.status(201).json(doctor);
    } catch (error) {
        console.error('Error creating doctor:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// PUT update doctor by ID
router.put('/healtha/doctors/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const doctor = await Doctor.findByIdAndUpdate(id, req.body, { new: true });
        if (!doctor) {
            return res.status(404).json({ error: 'Doctor not found' });
        }
        res.status(200).json(doctor);
    } catch (error) {
        console.error('Error updating doctor:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// DELETE method to delete a doctor by ID
router.delete('/healtha/doctors/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const doctor = await Doctor.findByIdAndDelete(id);
        if (!doctor) {
            return res.status(404).json({ error: 'Doctor not found' });
        }
        res.status(200).json(doctor);
    } catch (error) {
        console.error('Error deleting doctor:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// PATCH method to partially update a doctor by ID
router.patch('/healtha/doctors/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const doctor = await Doctor.findByIdAndUpdate(id, req.body, { new: true });
        if (!doctor) {
            return res.status(404).json({ error: 'Doctor not found' });
        }
        res.status(200).json(doctor);
    } catch (error) {
        console.error('Error updating doctor:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

module.exports = router;
