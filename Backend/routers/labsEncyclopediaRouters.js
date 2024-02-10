const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');


const sectionSchema2 = new mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    content: {
        type: String,
        required: true
    }
});

// Define lab test schema
const labTestSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    sections: {
        type: [sectionSchema2],
        required: true
    }
});

// Create LabTest model
const LabTest = mongoose.model('LabTest', labTestSchema, 'lab-encyclopedia');

//get all lab tests
router.get('/healtha/lab-tests', async (req, res) => {
    try {
      const labTests = await LabTest.find();
      res.status(200).json(labTests);
    } catch (error) {
      console.error('Error retrieving lab tests:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });

//get lab tests by id 
router.get('/healtha/lab-tests/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const labTest = await LabTest.findById(id);
    if (!labTest) {
      return res.status(404).json({ error: 'Lab test not found' });
    }
    res.status(200).json(labTest);
  } catch (error) {
    console.error('Error retrieving lab test by ID:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.post('/healtha/lab-tests', async (req, res) => {
  try {
    const labTest = await LabTest.create(req.body);
    res.status(201).json(labTest);
  } catch (error) {
    console.error('Error creating lab test:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.put('/healtha/lab-tests/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const labTest = await LabTest.findByIdAndUpdate(id, req.body, { new: true });
    if (!labTest) {
      return res.status(404).json({ error: 'Lab test not found' });
    }
    res.status(200).json(labTest);
  } catch (error) {
    console.error('Error updating lab test:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// DELETE method to delete a lab test by ID
router.delete('/healtha/lab-tests/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const labTest = await LabTest.findByIdAndDelete(id);
    if (!labTest) {
      return res.status(404).json({ error: 'Lab test not found' });
    }
    res.status(200).json(labTest);
  } catch (error) {
    console.error('Error deleting lab test:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// PATCH method to partially update a lab test by ID
router.patch('/healtha/lab-tests/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const labTest = await LabTest.findByIdAndUpdate(id, req.body, { new: true });
    if (!labTest) {
      return res.status(404).json({ error: 'Lab test not found' });
    }
    res.status(200).json(labTest);
  } catch (error) {
    console.error('Error updating lab test:', error);
    res.status(500).json({ error: 'Internal server error' });
  }

});

module.exports = router;