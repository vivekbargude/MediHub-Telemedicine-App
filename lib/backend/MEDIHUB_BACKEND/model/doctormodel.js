const mongoose = require('mongoose');

const doctorSchema = mongoose.Schema({

    //image
    //name
    //email
    //password
    //specification
    //desc
    //distance optional
    //rating optinal

    doctId : {
        type : String,
        required : true
    },

    doctName : {
        type : String,
        required : true,
        trim : true
    },

    doctEmail : {
        type : String,
        required : true,
        trim : true,
        validate : {
            validator : (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message : 'Please enter a valid email address'
        },
    },

    doctPassword : {
        type : String,
        required : true
    }, 

    doctImage : {
        type : String,
        required : true
    },

    doctCategory : {
        type : String,
        required : true
    },

    doctDesc : {
        type : String,
        required : true
    },

    doctDistance : {
        type : Number
    },

    doctRating : {
        type : Number
    },

    slots : 
        [{
            type: mongoose.Types.ObjectId,
            ref: 'TimeSlot'
        }],

},{timestamps: true});

const DoctorModel = mongoose.model('Doctor',doctorSchema);
module.exports = DoctorModel;