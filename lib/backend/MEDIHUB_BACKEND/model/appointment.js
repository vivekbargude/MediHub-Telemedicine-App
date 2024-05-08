const mongoose = require('mongoose');

const appointmentSchema = mongoose.Schema({

    doctorId : {
        type : mongoose.Types.ObjectId, 
        required : true,
        ref : 'Doctor'
    },

    doctorName : {
        type: String,
        required : true
    },

    doctorCategory : {
        type : String ,
        required : true
    },

    doctorImage : {
        type : String,
        required : true
    },

    patientId : {
        type : mongoose.Types.ObjectId,
        required : true,
        ref : 'User'
    },

    date : {
        type : String,
        required : true,
    },

    timeslot : {

        type : String,
        required : true,

    },

    status : {

        type: String,
        enum: ['scheduled', 'cancelled','completed'],
        default: 'scheduled',
          
    },

    isConfirmed : {
        type : Boolean,
        default : false
    }

});

const AppointmentModel = mongoose.model('Appointment',appointmentSchema);

module.exports = AppointmentModel;

