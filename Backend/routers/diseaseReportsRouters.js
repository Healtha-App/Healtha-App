const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');

const reportSchema = new mongoose.Schema({
    ReportID: {
        type: Number,
        required: true
    },
    UserID: {
        type: Number,
        required: true
    },
    content: {
        type: String,
        required: true
    }
});

const DiseaseReport = mongoose.model('DiseaseReport', reportSchema);

router.get('/healtha/diseaseReports', async (req, res) => {
    try {
        const reports = await DiseaseReport.find();
        res.status(200).json(reports);
    } catch (error) {
        console.error('Error retrieving disease reports:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// GET disease report by ID
router.get('/healtha/diseaseReports/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const report = await DiseaseReport.findById(id);
        if (!report) {
            return res.status(404).json({ error: 'Disease report not found' });
        }
        res.status(200).json(report);
    } catch (error) {
        console.error('Error retrieving disease report by ID:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// POST a new disease report
router.post('/healtha/diseaseReports', async (req, res) => {
    try {
        const { ReportID, UserID, content } = req.body;
        const newReport = new DiseaseReport({ ReportID, UserID, content });
        await newReport.save();
        res.status(201).json(newReport);
    } catch (error) {
        console.error('Error creating new disease report:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// PUT update a disease report
router.put('/healtha/diseaseReports/:id', async (req, res) => {
    const { id } = req.params;
    const { ReportID, UserID, content } = req.body;
    try {
        const updatedReport = await DiseaseReport.findByIdAndUpdate(id, { ReportID, UserID, content }, { new: true });
        if (!updatedReport) {
            return res.status(404).json({ error: 'Disease report not found' });
        }
        res.status(200).json(updatedReport);
    } catch (error) {
        console.error('Error updating disease report:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// PATCH update a disease report
router.patch('/healtha/diseaseReports/:id', async (req, res) => {
    // PATCH logic here
});

// DELETE a disease report
router.delete('/healtha/diseaseReports/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const deletedReport = await DiseaseReport.findByIdAndDelete(id);
        if (!deletedReport) {
            return res.status(404).json({ error: 'Disease report not found' });
        }
        res.status(200).json(deletedReport);
    } catch (error) {
        console.error('Error deleting disease report:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

module.exports = router;