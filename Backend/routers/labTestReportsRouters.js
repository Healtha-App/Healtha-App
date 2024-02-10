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

const LabTestReport = mongoose.model('LabTestReport', reportSchema);

router.get('/healtha/labTestReports', async (req, res) => {
    try {
        const reports = await LabTestReport.find();
        res.status(200).json(reports);
    } catch (error) {
        console.error('Error retrieving lab test reports:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// GET lab test report by ID
router.get('/healtha/labTestReports/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const report = await LabTestReport.findById(id);
        if (!report) {
            return res.status(404).json({ error: 'Lab test report not found' });
        }
        res.status(200).json(report);
    } catch (error) {
        console.error('Error retrieving lab test report by ID:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// POST a new lab test report
router.post('/healtha/labTestReports', async (req, res) => {
    try {
        const { ReportID, UserID, content } = req.body;
        const newReport = new LabTestReport({ ReportID, UserID, content });
        await newReport.save();
        res.status(201).json(newReport);
    } catch (error) {
        console.error('Error creating new lab test report:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// PUT update a lab test report
router.put('/healtha/labTestReports/:id', async (req, res) => {
    const { id } = req.params;
    const { ReportID, UserID, content } = req.body;
    try {
        const updatedReport = await LabTestReport.findByIdAndUpdate(id, { ReportID, UserID, content }, { new: true });
        if (!updatedReport) {
            return res.status(404).json({ error: 'Lab test report not found' });
        }
        res.status(200).json(updatedReport);
    } catch (error) {
        console.error('Error updating lab test report:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});


// DELETE a lab test report
router.delete('/healtha/labTestReports/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const deletedReport = await LabTestReport.findByIdAndDelete(id);
        if (!deletedReport) {
            return res.status(404).json({ error: 'Lab test report not found' });
        }
        res.status(200).json(deletedReport);
    } catch (error) {
        console.error('Error deleting lab test report:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

module.exports = router;
