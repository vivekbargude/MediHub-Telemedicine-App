const express = require('express');
const pharmacyRouter = express.Router();
const {PharmacyModel} = require('../model/pharmacymodel');

// to add new medicine

pharmacyRouter.post('/api/add-medicine', async (req, res) =>{

    const {medId, medName, medImage, medQuantity, medPrice, medDesc} = req.body;

    try {

        const isExisting = await PharmacyModel.findOne({medName});

        if(isExisting){
            return res.status(400).json({
                success : false,
                msg : "Medicine already exists!!",
            });
        }

        let medicine = new PharmacyModel({
            medId,
            medName,
            medImage,
            medQuantity,
            medPrice,
            medDesc
        });

        const newMedicine = await medicine.save();

        res.status(200).json({
            success :  true,
            msg : "Medicine added successfully!!",
            data : newMedicine
        });


    }catch(e){
    
        res.status(500).json({
            success : false,
            msg : e.message
        });
    }

});

//query string /api/medicine-details?medName=<name>

// this is for details page for each medicine
pharmacyRouter.get('/api/medicine-details', async (req,res)=>{

    try{

        const medName = req.query.medName;
        const isMedicine = await PharmacyModel.findOne({medName});

        if(!isMedicine){
            return res.status(400).json({
                success : false,
                msg : "Medicine not found"
            });
        }

        res.status(200).json({
            success : true,
            msg : "Medicine details fetched successfully",
            data : isMedicine
        });


        }catch(e){
        
            res.status(500).json({
                success : false,
                msg : e.message
            });
        }

});

// to display the 10 data  of all medicines in homepage

pharmacyRouter.get('/api/get-pharmacy', async(req,res)=>{

    try {

        const medicines = await  PharmacyModel.find().limit(10);

        if(!medicines){
            return res.status(400).json({
                success : false,
                msg : "No data available"
            });
        }

        res.status(200).json({
            medicines
        });

    }catch(e){

        res.status(500).json({
            success : false,
            msg : e.message
        });

    }
})


module.exports = pharmacyRouter;