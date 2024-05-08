const mongoose = require('mongoose');
const {pharmacySchema} = require('./pharmacymodel');

const cartSchema = mongoose.Schema({

    userId : {
        type : mongoose.Types.ObjectId, 
        required : true,
    },

    userCart : [
        {
            pharmacy : pharmacySchema,
            quantity : {
                type : Number ,
                required : true
            }
        }
    ]
});

const CartModel = mongoose.model('Cart',cartSchema);

module.exports = CartModel;