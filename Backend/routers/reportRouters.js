const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');

// Body parsing middleware
router.use(express.json());

// Schema definition
const reportSchema = new mongoose.Schema({
  reportid: {
    type: Number,
    default: 0
  },
  userId: {
    type: Number,
  },
  filePath: {
    type: String,
  },
  testName: {
    type: String,
  },
  reportContent: {
    type: String,
  },
  confirmed: {
    type: Boolean,
    default: false
  },
  uploadTime: {
    type: Date,
    default: Date.now
  },
});

// Middleware to automatically increment reportid field
reportSchema.pre('save', async function(next) {
  try {
    // If this is a new report being created
    if (this.isNew) {
      // Find the highest existing reportid
      const highestReport = await Report.findOne({}, {}, { sort: { 'reportid' : -1 } });
      if (highestReport) {
        // Increment the reportid field by 1
        this.reportid = highestReport.reportid + 1;
      }
    }
    next();
  } catch (error) {
    next(error);
  }
});

const Report = mongoose.model('Report', reportSchema);

// Routes
router.get('/healtha/reports', async (req, res) => {
  try {
      // If query parameter `id` is provided, fetch one report by its ID
      if (req.query.id) {
          const report = await Report.findOne({ reportid: req.query.id }); // Change to findOne and use reportid
          if (!report) {
              return res.status(404).json({ error: 'Report not found' });
          }
          return res.status(200).json(report);
      }
      if (req.query.userId){
        const reports = await Report.find({ userId: parseInt(req.query.userId) });
        return res.status(200).json(reports);
      }
      // If query parameter `confirmed` is provided and set to false, fetch unconfirmed reports
      if (req.query.confirmed === 'false') {
        const reports = await Report.find({ confirmed: false });
        return res.status(200).json(reports);
      }
      // If no query parameters are provided, fetch all reports
      const reports = await Report.find();
      res.status(200).json(reports);
  } catch (error) {
      console.error('Error retrieving reports', error);
      res.status(500).json({ error: 'Internal server error' });
  }
});


router.post('/healtha/reports/:id/confirm', async (req, res) => {
  try {
    const reportId = req.params.id;
    const report = await Report.findOneAndUpdate({ reportid: reportId }, { confirmed: true }, { new: true });
    if (!report) {
      return res.status(404).json({ error: 'Report not found' });
    }
    res.status(200).json({ message: 'Report confirmed successfully', report });
  } catch (error) {
    console.error('Error confirming report', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});


router.post('/healtha/reports', async (req, res) => {
    try {
        const newReport = new Report({
            userId: parseInt(req.body.userId),
            filePath: req.body.filePath,
            reportContent: req.body.reportContent,
            confirmed: req.body.confirmed,
            testName: req.body.testName // Include the testName field
        });

        await newReport.save();
        res.status(201).json(newReport);
    } catch (err) {
        console.error('Error creating a new report', err);
        res.status(500).json({ error: 'Could not create a new report' });
    }
});

// PUT route to update the report content
router.put('/healtha/reports/:id', async (req, res) => {
  try {
    const reportId = req.params.id;
    const updatedReportContent = req.body.reportContent;
    
    const report = await Report.findOneAndUpdate(
      { reportid: reportId },
      { reportContent: updatedReportContent },
      { new: true }
    );

    if (!report) {
      return res.status(404).json({ error: 'Report not found' });
    }

    res.status(200).json({ message: 'Report updated successfully', report });
  } catch (error) {
    console.error('Error updating report', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;
