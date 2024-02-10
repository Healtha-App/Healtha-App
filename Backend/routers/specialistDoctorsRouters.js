const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
  

const specialistDoctorSchema = new mongoose.Schema({
    userid: {
        type: String,
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
    fullName: String,
    dateOfBirth: Date,
    gender: String,
    contactInformation: String,
    address: String,
    specialization: String,
    qualification: String,
    experience: String,
    availabilitySchedule: String,
});

const SpecialistDoctor = mongoose.model('SpecialistDoctor', specialistDoctorSchema);

//routers

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
        const newSpecialistDoctor = new SpecialistDoctor(req.body);
        await newSpecialistDoctor.save();
        res.status(201).json(newSpecialistDoctor);
    } catch (err) {
        console.error('Error creating a new specialist doctor', err);
        res.status(500).json({ error: 'Could not create a new specialist doctor' });
    }
});

router.put('/healtha/specialistdoctors/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const updatedSpecialistDoctor = await SpecialistDoctor.findByIdAndUpdate(id, req.body, { new: true });

        if (!updatedSpecialistDoctor) {
            return res.status(404).json({ error: 'Specialist doctor not found' });
        }

        res.status(200).json(updatedSpecialistDoctor);
    } catch (err) {
        console.error('Error updating a specialist doctor', err);
        res.status(500).json({ error: 'Could not update specialist doctor' });
    }
});

router.delete('/healtha/specialistdoctors/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const deletedSpecialistDoctor = await SpecialistDoctor.findByIdAndDelete(id);

        if (!deletedSpecialistDoctor) {
            return res.status(404).json({ error: 'Specialist doctor not found' });
        }

        res.status(200).json(deletedSpecialistDoctor);
    } catch (err) {
        console.error('Error deleting a specialist doctor', err);
        res.status(500).json({ error: 'Could not delete specialist doctor' });
    }
});


module.exports = router;