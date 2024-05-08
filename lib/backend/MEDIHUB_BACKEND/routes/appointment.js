const express = require('express');
const appointmentRouter = express.Router();
const Doctor = require('../model/doctormodel');
const TimeSlot = require('../model/timeslots');
const User = require('../model/usermodel');
const AppointmentModel = require('../model/appointment');
const auth = require('../middlewares/auth');


appointmentRouter.post('/api/book-appointment',auth,async(req,res)=>{

    try {
        console.log("enter");
        const {doctorId, timeslotId, date} = req.body;
        const patientId = req.user;
        console.log(patientId);
        console.log(doctorId);
        console.log(timeslotId);
        const doctor =  await Doctor.findOne({doctId:doctorId});
        console.log("1");

        const patient = await User.findById(patientId);
        console.log("2");

        if(!doctor){
            console.log("bhrhbr");
            return res.status(400).json({
                success : false,
                msg : "Doctor not found"
            });
        }
        console.log("3");

        if(!patient){
            console.log();
            return res.status(400).json({
                success : false,
                msg : "Patient not found"
            });
        }
        console.log("hebbbhebehdsbhehd2bb");
        const timeslot = await TimeSlot.findById(timeslotId);

        if(!timeslot){
            console.log("errorsjejen");
            return res.status(400).json({
                success : false,
                msg : "TimeSlot not found"
            });
        }

        if(timeslot.isBooked){
            console.log("hjcjfejfdjc");
            return res.status(400).json({
                success : false,
                msg : "TimeSlot already booked"
            }); 
        }

        timeslot.isBooked = true;
        await timeslot.save();
      
        const appointment = new AppointmentModel({
            doctorId: doctor._id,
            doctorName : doctor.doctName,
            doctorCategory : doctor.doctCategory,
            doctorImage : doctor.doctImage,
            patientId,
            date,
            timeslot: timeslot.startTime,
            status: 'scheduled',
            isConfirmed : false
        });
        
        const appoint = await appointment.save();
     
        console.log('p1');
        res.status(200).json({
            success : true,
            msg : "Appointment booked successfully",
            appoint
        });
        
    } catch (error) {
        res.status(500).json({
            success : false,
            msg : "Internal server error"
        });
    }
});

appointmentRouter.get('/api/get-appointments',auth,async(req,res)=>{

    try {
    
        const user = await User.findById(req.user);
        if( !user ) {
            return res.status(400).json({
                success : false,
                msg : "User not found!"
            });
        }

        const appointments = await AppointmentModel.find({patientId : req.user});

        if(!appointments){
            return res.status(400).json({
                success : false,
                msg : "No appointments found for this user."
            });
        }

        res.status(200).json({
            success : true,
            msg : "Appointments fetched Successfully.",
            data : appointments
        });
        
    } catch (error) {
        res.status(500).json({
            success : false,
            msg : "Internal Server Error!"
        });
    }
});

module.exports = appointmentRouter;