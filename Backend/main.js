const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');

dotenv.config();

const app = express();
const port = process.env.PORT || 4000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

mongoose.connect(process.env.MONGODB_URI)
  .then(() => {
    console.log('Connected to MongoDB');

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
    const doctorLoginRouter = require('./routers/doctorLogin'); // Add doctorLogin router
    const doctorsRouters = require('./routers/doctorsRouters');

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
    app.use('/api', doctorLoginRouter); // Use doctorLogin router
    app.use('/api', doctorsRouters);

    app.listen(port, () => {
      console.log(`Server is running on port ${port}`);
    });
  })
  .catch((error) => {
    console.error('Error connecting to MongoDB:', error.message);
  });

module.exports = app;
