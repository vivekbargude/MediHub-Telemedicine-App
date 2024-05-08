const mongoose = require('mongoose');

const pharmacySchema = mongoose.Schema({


    medId : {
        type : String,
        required : true
    },

    medName : {
        type : String,
        required : true,
        trim : true
    },

    medImage : {
        type : String,
        required : true
    },

    medQuantity : {
        type : String,
        required : true
    }, 

    medPrice : {
        type : String,
        required : true
    },

    medDesc : {
        type : String,
        required : true
    },
    
    medRating : {
        type : Number,
    },

},{timestamps: true});

const PharmacyModel = mongoose.model('Pharmacy',pharmacySchema);
module.exports = {PharmacyModel,pharmacySchema};