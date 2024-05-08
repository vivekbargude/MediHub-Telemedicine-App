const express = require('express');
const cartRouter = express.Router();
const User = require("../model/usermodel");
const { PharmacyModel } = require("../model/pharmacymodel");
const auth = require('../middlewares/auth');
const Cart = require('../model/cart');

cartRouter.post('/api/add-to-cart', auth, async (req, res) => {
    try {
        console.log("add");
        const { id } = req.body;
        const product = await PharmacyModel.findById(id);
        const user = await User.findById(req.user);
        let cart = await Cart.findOne({ userId: user._id });

        if (!cart) {
            cart = new Cart({ userId: user._id, userCart: [] });
        }

        let isPharmacyFound = false;

        for (let i = 0; i < cart.userCart.length; i++) {
            if (cart.userCart[i].pharmacy._id.equals(product._id)) {
                isPharmacyFound = true;
                break;
            }
        }

        if (isPharmacyFound) {
            let existPharmacy = cart.userCart.find(item => item.pharmacy._id.equals(product._id));
            existPharmacy.quantity += 1;
        } else {
            cart.userCart.push({ pharmacy: product, quantity: 1 });
        }

        await cart.save();

        res.json({ cart });
    } catch (error) {
        res.status(500).json({
            success: false,
            msg: error.message
        });
    }
});

cartRouter.get('/api/get-cart',auth,async(req,res)=>{

    try {
        console.log("get");
        
        const uuser = await User.findById(req.user);
        const cart = await Cart.findOne({userId : uuser._id});
        
        if(!cart){
            return res.status(400).json({
                success : false,
                msg : "No items to fetch"
            });
        }

        res.status(200).json({
            success : true,
            msg : 'Cart fetched successfully',
            cart : cart
        });


    } catch (error) {
        res.status(500).json({
            success:false,
            msg:"Internal Server Error"
        });
        
    }
});

module.exports = cartRouter;
