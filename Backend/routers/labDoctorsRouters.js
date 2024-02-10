const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');

const labDoctorSchema = new mongoose.Schema({
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
    labSpecialization: String,
    qualification: String,
    experience: String,
    availabilitySchedule: String,
});

const LabDoctor = mongoose.model('LabDoctor', labDoctorSchema);




router.get('/healtha/labdoctors', async (req, res) => {
    try {
        const labDoctors = await LabDoctor.find();
        res.status(200).json(labDoctors);
    } catch (error) {
        console.error('Error retrieving lab doctors', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

router.post('/healtha/labdoctors', async (req, res) => {
    try {
        const newLabDoctor = new LabDoctor(req.body);
        await newLabDoctor.save();
        res.status(201).json(newLabDoctor);
    } catch (err) {
        console.error('Error creating a new lab doctor', err);
        res.status(500).json({ error: 'Could not create a new lab doctor' });
    }
});

router.put('/healtha/labdoctors/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const updatedLabDoctor = await LabDoctor.findByIdAndUpdate(id, req.body, { new: true });

        if (!updatedLabDoctor) {
            return res.status(404).json({ error: 'Lab doctor not found' });
        }

        res.status(200).json(updatedLabDoctor);
    } catch (err) {
        console.error('Error updating a lab doctor', err);
        res.status(500).json({ error: 'Could not update lab doctor' });
    }
});

router.delete('/healtha/labdoctors/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const deletedLabDoctor = await LabDoctor.findByIdAndDelete(id);

        if (!deletedLabDoctor) {
            return res.status(404).json({ error: 'Lab doctor not found' });
        }

        res.status(200).json(deletedLabDoctor);
    } catch (err) {
        console.error('Error deleting a lab doctor', err);
        res.status(500).json({ error: 'Could not delete lab doctor' });
    }
});

module.exports = router;