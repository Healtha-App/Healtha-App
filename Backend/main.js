const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const dotenv = require('dotenv');

// Load environment variables from .env file
dotenv.config();

const app = express();
const port = 4000;

// Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Connect to MongoDB
mongoose.connect(process.env.MONGODB_URI)
    .then(() => {
        console.log('Connected to MongoDB');

        // Routes
        const specialistDoctorsRoutes = require('./routers/specialistDoctorsRouters');
        const labDoctorsRouters = require('./routers/labDoctorsRouters');
        const patientsRoutes = require('./routers/patientsRoutes');
        const labsEncyclopediaRouters = require('./routers/labsEncyclopediaRouters');
        const diseasesEncyclopediaRouters = require('./routers/diseasesEncyclopediaRouters');
        const diseaseReportsRouters = require('./routers/diseaseReportsRouters');
        const labTestReportsRouters = require('./routers/labTestReportsRouters');
        const loggedUsersRouters = require('./routers/loggedUsersRouters');
        const reportRouters = require('./routers/reportRouters');
        const patientLoginRouter = require('./routers/patientLogin');

        // Use routes
        app.use('/api', specialistDoctorsRoutes);
        app.use('/api', labDoctorsRouters);
        app.use('/api', patientsRoutes);
        app.use('/api', loggedUsersRouters);
        app.use('/api', labsEncyclopediaRouters);
        app.use('/api', diseasesEncyclopediaRouters);
        app.use('/api', diseaseReportsRouters);
        app.use('/api', labTestReportsRouters);
        app.use('/api', reportRouters);
        app.use('/api', patientLoginRouter);

        // Start the server
        app.listen(port, () => {
            console.log(`Server is running on port ${port}`);
        });
    })
    .catch((error) => {
        console.error('Error connecting to MongoDB:', error.message);
    });

module.exports = app;
