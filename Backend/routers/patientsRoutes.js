const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');



// Define the schema for the patient
const patientSchema = new mongoose.Schema({
    userid: {
        type: Number, // Change type to Number for userid
    },
    username: {
        type: String,
        required: true
    },
    password: {
        type: String,
        required: true
    },
   
    email: String,
    dateOfBirth: Date,
    gender: String,
    contactInformation: String,
});

// Define a schema for the counter
const counterSchema = new mongoose.Schema({
    _id: { type: String, required: true },
    sequence_value: { type: Number, default: 0 }
});

// Create a model for the counter schema with a different name
const SequenceCounter = mongoose.model('SequenceCounter', counterSchema);

// Define a pre-save hook to auto-generate userid
patientSchema.pre('save', async function(next) {
    const doc = this;
    try {
        // Find the counter document for 'userid'
        const counter = await SequenceCounter.findOneAndUpdate(
            { _id: 'userid' },
            { $inc: { sequence_value: 1 } },
            { new: true, upsert: true }
        );

        // Set the userid to the incremented value
        doc.userid = counter.sequence_value;
        next();
    } catch (err) {
        next(err);
    }
});

const Patient = mongoose.model('Patient', patientSchema);

// Routes (remaining routes remain the same)
router.get('/healtha/patients', async (req, res) => {
    try {
        const patients = await Patient.find();
        res.status(200).json(patients);
    } catch (error) {
        console.error('Error retrieving patients', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

router.post('/healtha/patients', async (req, res) => {
    try {
        const newPatient = new Patient(req.body);
        await newPatient.save();
        res.status(201).json(newPatient);
    } catch (err) {
        console.error('Error creating a new patient', err);
        res.status(500).json({ error: 'Could not create a new patient' });
    }
});

router.put('/healtha/patients/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const updatedPatient = await Patient.findByIdAndUpdate(id, req.body, { new: true });

        if (!updatedPatient) {
            return res.status(404).json({ error: 'Patient not found' });
        }

        res.status(200).json(updatedPatient);
    } catch (err) {
        console.error('Error updating a patient', err);
        res.status(500).json({ error: 'Could not update patient' });
    }
});

router.delete('/healtha/patients/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const deletedPatient = await Patient.findByIdAndDelete(id);

        if (!deletedPatient) {
            return res.status(404).json({ error: 'Patient not found' });
        }

        res.status(200).json(deletedPatient);
    } catch (err) {
        console.error('Error deleting a patient', err);
        res.status(500).json({ error: 'Could not delete patient' });
    }
});

module.exports = router;
