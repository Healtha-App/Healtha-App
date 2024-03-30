const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');

// Body parsing middleware
router.use(express.json());

// Schema definition
const reportSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId, // Changed to ObjectId for referencing users
        ref: 'User', // Assuming there's a 'User' collection for user details
        required: true
    },
    filePath: {
        type: String,
        required: true
    },
    confirmed: {
        type: Boolean,
        default: false // Default to false, indicating report is not confirmed initially
    },
    uploadTime: {
        type: Date,
        default: Date.now // Default to current timestamp
    }
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
            userId: req.body.userId,
            filePath: req.body.filePath
            // 'confirmed' and 'uploadTime' will use default values
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
