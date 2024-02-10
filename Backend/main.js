const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const dotenv = require('dotenv');


const specialistDoctorsRoutes = require('./routers/specialistDoctorsRouters');
const labDoctorsRouters = require('./routers/labDoctorsRouters');
const patientsRoutes = require('./routers/patientsRoutes');
const labsEncyclopediaRouters = require('./routers/labsEncyclopediaRouters');
const diseasesEncyclopediaRouters = require('./routers/diseasesEncyclopediaRouters');
const diseaseReportsRouters = require('./routers/diseaseReportsRouters');
const labTestReportsRouters = require('./routers/labTestReportsRouters');
const loggedUsersRouters = require('./routers/loggedUsersRouters');

const app = express();

// Access environment variables
const uri = 'mongodb+srv://esraamaged:Healtha2024@healtha.omutrrl.mongodb.net/healtha?retryWrites=true&w=majority'
const port = 4000;

app.use(bodyParser.json());

// Connect to MongoDB
mongoose.connect(uri, { useUnifiedTopology: true })
    .then(() => {
        console.log('Connected to MongoDB');

        // Use the specialist doctor routes
        app.use('/api', specialistDoctorsRoutes);

        // Use the lab doctor routes
        app.use('/api', labDoctorsRouters);

        // Use the patient routes
        app.use('/api', patientsRoutes);

        // Use the logged users routes
        app.use('/api', loggedUsersRouters);

        // Use the lab encyclopedia routes
        app.use('/api', labsEncyclopediaRouters);

        // Use the disease encyclopedia routes
        app.use('/api', diseasesEncyclopediaRouters);

        // Use the disease reports routes
        app.use('/api', diseaseReportsRouters);

        // Use the lab tests reports routes
        app.use('/api', labTestReportsRouters);


        // Start the server after successfully connecting to MongoDB
        app.listen(port, () => {
            console.log(`Server is running on port ${port}`);
        });
    })
    .catch((error) => {
        console.error('Error connecting to MongoDB:', error.message);
    });
    