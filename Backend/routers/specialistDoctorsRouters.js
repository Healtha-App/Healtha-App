const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');

// Schema definition
const specialistDoctorSchema = new mongoose.Schema({
    userid: {
        type: Number,
        required: true
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
    gender: String,
    contactInformation: String,
    specialization: String,
});

const SpecialistDoctor = mongoose.model('SpecialistDoctor', specialistDoctorSchema);

// User ID counter schema
const counterSchema = new mongoose.Schema({
    _id: { type: String, required: true },
    sequence_value: { type: Number, default: 0 }
});

const Counter = mongoose.model('Counter', counterSchema);

// Routes
router.get('/healtha/specialistdoctors', async (req, res) => {
    try {
        const specialistDoctors = await SpecialistDoctor.find();
        res.status(200).json(specialistDoctors);
    } catch (error) {
        console.error('Error retrieving specialist doctors', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

router.post('/healtha/specialistdoctors', async (req, res) => {
    try {
        const counter = await Counter.findOneAndUpdate(
            { _id: 'userid' },
            { $inc: { sequence_value: 1 } },
            { new: true, upsert: true }
        );

        const newSpecialistDoctor = new SpecialistDoctor({
            userid: counter.sequence_value,
            username: req.body.username,
            password: req.body.password,
            email: req.body.email,
            gender: req.body.gender,
            contactInformation: req.body.contactInformation,
            specialization: req.body.specialization
        });

        await newSpecialistDoctor.save();
        res.status(201).json(newSpecialistDoctor);
    } catch (err) {
        console.error('Error creating a new specialist doctor', err);
        res.status(500).json({ error: 'Could not create a new specialist doctor' });
    }
});

// Other routes (PUT, DELETE) remain the same

module.exports = router;
