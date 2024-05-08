const mongoose = require('mongoose');
const { pharmacySchema } = require('./pharmacymodel');

const UserSchema = mongoose.Schema({

    name : {
        type : String,
        trim : true,
        required : true
    },

    email : {
        required : true,
        trim : true,
        type : String,
        validate : {
            validator : (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message : 'Please enter a valid email address'
        },
    },

    password : {
        type : String,
        required : true,
        // validate : {
        //     validator : (value) => {
                
        //         return value.length > 6;
        //     },
        //     message : 'Please enter a valid password'
        // },

    },

    address : {
        type : String,
        default : ""
    },
    age:{
        type : String,
        default : ""
        
    },

    type : {
        type : String,
        default : "user"
    },

    isVerified: {
        type : "Boolean",
        default : false
    },

    cart:[
        {
            pharmacy : pharmacySchema,
            quantity : {
                type : Number ,
                required : true
            }
        }
    ],


});

const UserModel = mongoose.model('User',UserSchema);

module.exports = UserModel;