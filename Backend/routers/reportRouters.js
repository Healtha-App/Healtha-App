const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');

// Schema definition
const reportSchema = new mongoose.Schema({
    userid: {
        type: Number,
        required: true
    },
    reportId: {
        type: String,
        default: mongoose.Types.ObjectId,
        required: true
    },
    content: {
        type: String,
        required: true
    },
});

const Report = mongoose.model('Report', reportSchema);

// Routes
router.get('/healtha/reports', async (req, res) => {
    try {
        const reports = await Report.find();
        res.status(200).json(reports);
    } catch (error) {
        console.error('Error retrieving reports', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

router.post('/healtha/reports', async (req, res) => {
    try {
        const newReport = new Report({
            userid: req.body.userid,
            content: req.body.content
        });

        await newReport.save();
        res.status(201).json(newReport);
    } catch (err) {
        console.error('Error creating a new report', err);
        res.status(500).json({ error: 'Could not create a new report' });
    }
});

// Other routes (PUT, DELETE) remain the same

module.exports = router;
