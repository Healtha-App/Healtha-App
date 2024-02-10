const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
  

// Define section schema
const sectionSchema = new mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    content: {
        type: String,
        required: true
    }
});

// Define disease schema
const diseaseSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    sections: {
        type: [sectionSchema],
        required: true
    }
});

// Create Disease model
const Disease = mongoose.model('Disease', diseaseSchema, 'disease-encyclopedia');

// GET method to retrieve all diseases
router.get('/healtha/disease', async (req, res) => {
    try {
        const diseases = await Disease.find();
        res.status(200).json(diseases);
    } catch (error) {
        console.error('Error retrieving diseases', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// GET method to retrieve disease by ID
router.get('/healtha/disease/:id', async (req, res) => {
    const { id } = req.params;

    try {
        const disease = await Disease.findById(id);
        if (!disease) {
            return res.status(404).json({ error: 'Disease not found' });
        }
        res.status(200).json(disease);
    } catch (error) {
        console.error('Error retrieving disease by ID', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// POST method to add a new disease
router.post('/healtha/disease', async (req, res) => {
    try {
        const { name, sections } = req.body;

        // Validate request body
        if (!name || !sections || !Array.isArray(sections)) {
            return res.status(400).json({ error: 'Invalid request body' });
        }

        // Create new disease
        const newDisease = new Disease({ name, sections });

        // Save disease to database
        await newDisease.save();

        res.status(201).json(newDisease);
    } catch (error) {
        console.error('Error creating a new disease', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

router.put('/healtha/disease/:id', async (req, res) => {
    const { id } = req.params;
    const { name, sections } = req.body;

    try {
        // Find disease by ID
        const disease = await Disease.findById(id);

        if (!disease) {
            return res.status(404).json({ error: 'Disease not found' });
        }

        // Update disease properties
        disease.name = name;
        disease.sections = sections;

        // Save updated disease to database
        await disease.save();

        res.status(200).json(disease);
    } catch (error) {
        console.error('Error updating disease', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// DELETE method to delete a disease by ID
router.delete('/healtha/disease/:id', async (req, res) => {
    const { id } = req.params;

    try {
        // Find and delete disease by ID
        const deletedDisease = await Disease.findByIdAndDelete(id);

        if (!deletedDisease) {
            return res.status(404).json({ error: 'Disease not found' });
        }

        res.status(200).json({ message: 'Disease deleted successfully' });
    } catch (error) {
        console.error('Error deleting disease', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});
//PATCH
router.patch('/healtha/disease/:id', async (req, res) => {
    const { id } = req.params;
    const { sections } = req.body;

    try {
        // Find disease by ID
        const disease = await Disease.findById(id);

        if (!disease) {
            return res.status(404).json({ error: 'Disease not found' });
        }

        // Update sections of disease
        disease.sections = sections;

        // Save updated disease to database
        await disease.save();

        res.status(200).json(disease);
    } catch (error) {
        console.error('Error updating disease sections', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

module.exports = router;