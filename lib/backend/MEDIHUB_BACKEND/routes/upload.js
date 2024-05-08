const cloudinary = require('cloudinary');
const express = require('express');
const Addrouter = express.Router();
const {Pharmacy} = require('../model/pharmacymodel');

// Configure Cloudinary
cloudinary.v2.config({
    cloud_name: 'drerbcnk2',
    api_key: '595443969329562',
    api_secret: 'tnog_ydnLBw4xIgv1hSVMz0G2Ao',
    secure: true,
  });

// Upload route

Addrouter.post('/api/upload', async (req, res) => {
  try {

    console.log(req.body);
    // Check if file is uploaded
    if (!req.files || !req.files.medImage) {
      return res.status(400).json({ success: false, msg: 'No file uploaded' });
    }

    const file = req.files.medImage;

    // Upload image to Cloudinary
    const result = await cloudinary.uploader.upload(file.tempFilePath);
    console.log(result);

    // // Extract other data from the request
    const { medId, medName, medQuantity, medPrice, medDesc } = req.body;

    // Create an object with all the data including the Cloudinary URL
    let pharmacyData = new Pharmacy({
      medId,
      medName,
      medImage: result.secure_url,
      medQuantity,
      medPrice,
      medDesc
    });

    console.log(pharmacyData);

    // Save medicine data to the database
    const newPharmacy = await pharmacyData.save();
    // Send success response with data including Cloudinary URL
    res.status(200).json({
      success: true,
      msg: "Medicine data with image uploaded successfully",
      data: newPharmacy
    });
  } catch (error) {
    console.error('Error:', error.message);

    // Send error response
    res.status(500).json({ success: false, msg: 'Error uploading medicine data with image', error: error.message });
  }
});


module.exports = Addrouter;
