const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
const multer = require('multer');
const { uploadToS3 } = require('../utils/s3');

const storage = multer.memoryStorage();
const upload = multer({ storage: storage });


const loggedUsersSchema = new mongoose.Schema({
    userid: {
        type: String, // or whatever type is appropriate
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
    loggingTime: {
        type: Date,
        default: Date.now
    },
    avatar: {
        type: String,
        required: false,
        default: ""
    }
});

const LoggedUser = mongoose.model('LoggedUser', loggedUsersSchema);


router.get('/healtha/loggedusers', async (req, res) => {
    try {
        const loggedUsers = await LoggedUser.find();
        res.status(200).json(loggedUsers);
    } catch (error) {
        console.error('Error retrieving logged users', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

router.post('/healtha/loggedusers', async (req, res) => {
    try {
        const { userid, username, password } = req.body;

        // Validate that the required fields are present
        if (!userid || !username || !password) {
            return res.status(400).json({ error: 'UserId, username, and password are required fields' });
        }

        // Create a new logged user instance
        const newLoggedUser = new LoggedUser({ userid, username, password });

        // Save the new logged user to the database
        await newLoggedUser.save();

        res.status(201).json(newLoggedUser);
    } catch (err) {
        console.error('Error creating a new logged user', err);
        res.status(500).json({ error: 'Could not create a new logged user' });
    }
});

router.put('/healtha/loggedusers/:id', upload.single('avatar'), async (req, res) => {
    try {
        const { id } = req.params;
        const { userid, username, password } = req.body;
        let avatar = req.file

        // Validate that the required fields are present
        if (!userid || !username || !password) {
            return res.status(400).json({ error: 'UserId, username, and password are required fields' });
        }

        if (avatar) {
            avatar = await uploadToS3(avatar);
        } else {
            avatar = "";
        }

        // Find and update the logged user in the database
        const updatedLoggedUser = await LoggedUser.findOneAndUpdate(
            { _id: id },
            { userid, username, password, avatar },
            { new: true }
        );

        if (!updatedLoggedUser) {
            return res.status(404).json({ error: 'Logged user not found' });
        }

        res.status(200).json(updatedLoggedUser);
    } catch (err) {
        console.error('Error updating a logged user', err);
        res.status(500).json({ error: 'Could not update logged user' });
    }
});

router.delete('/healtha/loggedusers/:id', async (req, res) => {
    try {
        const { id } = req.params;

        // Find and delete the logged user in the database
        const deletedLoggedUser = await LoggedUser.findOneAndDelete({ _id: id });

        if (!deletedLoggedUser) {
            return res.status(404).json({ error: 'Logged user not found' });
        }

        res.status(200).json(deletedLoggedUser);
    } catch (err) {
        console.error('Error deleting a logged user', err);
        res.status(500).json({ error: 'Could not delete logged user' });
    }
});

module.exports = router;