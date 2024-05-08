const express = require('express');
const doctorRouter = express.Router();
const Doctor = require('../model/doctormodel');
const bcryptjs = require('bcryptjs');
const TimeSlot = require('../model/timeslots');
const auth = require('../middlewares/auth');

// admin to add doctor
doctorRouter.post('/api/admin/add-doctor', async (req, res) => {

    try {

        const { doctId, doctEmail, doctName, doctPassword, doctImage, doctDesc, doctCategory, } = req.body;
        const isExistingDoctor = await Doctor.findOne({ doctId });

        if (isExistingDoctor) {
            return res.status(400).json({
                success: false,
                msg: "Doctor already exists!!"
            });
        }

        const hashPassword = await bcryptjs.hash(doctPassword, 8);

        let doctor = new Doctor({
            doctId,
            doctName,
            doctEmail,
            doctPassword: hashPassword,
            doctImage,
            doctCategory,
            doctDesc,
        });

        const newDoctor = await doctor.save();

        res.status(200).json({
            success: true,
            msg: "Doctor added successfully",
            data: newDoctor
        });

    } catch (e) {

        res.status(500).json({
            success: false,
            msg: e.message
        })

    }

});


//admin to delete doctors

doctorRouter.post('/api/admin/delete-doctor', async (req, res) => {

    try {

        const _id = req.body;
        let doctor = await Doctor.findByIdAndDelete(_id);

        if (!doctor) {

            return res.status(400).json({
                success: false,
                msg: "Doctor not found."
            });
        }
        doctor = await doctor.save();

        res.status(200).json({
            success: true,
            msg: "Doctor deleted successfully.",
            data: doctor
        });

    } catch (e) {

        res.status(500).json({
            success: false,
            msg: e.message
        });
    }
});

// For admin to get all doctors
doctorRouter.get('/api/get-doctors', async (req, res) => {

    try {
        console.log("hit1");
        const doctors = await Doctor.find({}, { doctId: 1, doctName: 1, doctImage: 1, doctDesc: 1, doctCategory: 1, });

        if (!doctors) {

            res.status(400).json({
                success: false,
                msg: "No Doctors Found"
            });
        }

        res.status(200).json({
            success: true,
            msg: "Doctors data fetched successfully",
            data: doctors
        });

    } catch (e) {

        res.status(500).json({
            success: false,
            msg: e.message
        });
    }
});

// get doctor according on basis of category
// api/doctor-by-category?doctCategory=Example

doctorRouter.get('/api/doctor-by-category', async (req, res) => {

    try {
        console.log("hit");
        const doctCategory = req.query.doctCategory;
        const doctors = await Doctor.find({ doctCategory }, { doctId: 1, doctName: 1, doctImage: 1, doctDesc: 1, doctCategory: 1, });

        if (!doctors) {

            return res.status(400).json({
                success: false,
                msg: "Doctor not found."
            });
        }

        res.status(200).json({
            success: true,
            msg: "Doctor fetched successfully",
            data: doctors
        });

    } catch (e) {

        res.status(500).json({
            success: false,
            msg: e.message
        });
    }

});

doctorRouter.get('/api/doctor-details', async (req, res) => {

    try {

        const doctId = req.query.doctId;
        const isDoctor = await Doctor.findOne({ doctId }, { doctId: 1, doctName: 1, doctImage: 1, doctDesc: 1, doctCategory: 1, });

        if (!isDoctor) {
            return res.status(400).json({
                success: false,
                msg: "No doctor found"
            });
        }

        res.status(200).json({
            success: true,
            msg: "Doctor details fetched successfuly",
            data: isDoctor
        });


    } catch (e) {

        res.status(500).json({
            success: false,
            msg: e.message
        });
    }

});

doctorRouter.post('/api/add-slot',async(req,res)=>{

    try {

        const {doctorId , startTime, endTime} = req.body;
        
        const timeslot = new TimeSlot({
            startTime,
            endTime,
        });

        await timeslot.save();

        const doctor = await Doctor.findById(doctorId).populate('slots');

        if(!doctor){
            return res.status(400).json({
                success : false ,
                msg : "Doctor not found"
            });
        }

        doctor.slots.push(timeslot);
        await doctor.save();

        res.status(200).json({
            success : true,
            msg : "Timeslot added successfully"
        });

        
    } catch (error) {
        res.status(500).json({
            success:false,
            msg : "Internal Server Error!"
        });
    }
});


///api/free-slots?doctorId=

doctorRouter.get('/api/free-slots',async(req,res)=>{
    
    try {
         const doctId = req.query.doctorId;
         const doctor = await Doctor.findOne({doctId}).populate('slots');

         if (!doctor) {
         return res.status(404).json({ success: false, message: 'Doctor not found' });
         }

         const freeTimeSlots = doctor.slots.filter(slot => !slot.isBooked);
         return res.status(200).json({ success: true, freeTimeSlots });
        
    } catch (error) {
        res.status(500).json({
            success : false,
            msg : "Server error!"
        });
    }
});

doctorRouter.get('/api/fetch-doctors',auth,async(req,res)=>{

    try {
        
    } catch (error) {

        res.status(500).json({
            success:false,
            msg:"Internal Server Error"
        })
        
    }

})



module.exports = doctorRouter;


// try{

// }catch(e){

//     res.status(500).json({
//         success : false,
//         msg : e.message
//     });
// }