const express = require('express');
const app = express();
const authRouter = require('../routes/auth');
const doctorRouter = require('../routes/doctor');
const pharmacyRouter = require('../routes/pharmacy');
const Addrouter = require('../routes/upload');
const fileUpload = require('express-fileupload');
const cartRouter = require('../routes/cart');
const appointmentRouter = require('../routes/appointment');
const emergencyRouter = require('../routes/emergency');

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(fileUpload({
    useTempFiles: true,
}));
app.use('/',authRouter);
app.use('/',doctorRouter);
app.use('/',pharmacyRouter);
app.use('/',Addrouter);
app.use('/',cartRouter);
app.use('/',appointmentRouter);
app.use('/',emergencyRouter);


module.exports = app;