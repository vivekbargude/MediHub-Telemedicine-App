//IMPORT
// const dotenv = require('dotenv');
// const colors = require('colors');
const db = require('./config/db');
const express = require('express');
const app = express();
const PORT = 3000

const authRouter = require('./routes/auth');
const doctorRouter = require('./routes/doctor');
const pharmacyRouter = require('./routes/pharmacy');
const Addrouter = require('./routes/upload');
const fileUpload = require('express-fileupload');
const cartRouter = require('./routes/cart');
const appointmentRouter = require('./routes/appointment');
const emergencyRouter = require('./routes/emergency');

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

app.get('/',(req,res)=>{
    res.status(200).json({
        "msg" : "server running"
    });
});


// var io = require('socket.io')(server,{
//     cors:{
//         origin:"*",
//     }

// });

// io.on( 'connection', ( socket ) => {
//     console.log("New user connected");
//     print(socket.id);
// });




//SERVER CONNECTION
app.listen(PORT,'0.0.0.0',()=>{
    console.log(`Server is listening at http://localhost:${PORT}`.blue.underline.bold);
});