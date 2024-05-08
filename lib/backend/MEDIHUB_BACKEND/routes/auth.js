//IMPORT
const express = require('express');
const authRouter = express.Router();
const User = require('../model/usermodel');
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');


authRouter.get('/api/get',(req,res)=>{
    res.status(200).json({
        msg : "success true"
    });
});


//SIGNUP

authRouter.post('/api/signup', async(req,res)=>{

    try{

            const {name, email, password} = req.body;

            const existinguser = await User.findOne({email});
            if(existinguser){
                return res.status(400).json({
                    success : false,
                    msg : "Email already exists!! Try another email."
                });
            }

            const hashPassword = await bcryptjs.hash(password,8);

            let newUser = new User({
                name ,
                email ,
                password : hashPassword
            });

            newUser = await newUser.save();

            res.status(200).json({
                success : true,
                msg : "User created succcessfully.",
                data : newUser
            });


    }catch(e){
        res.status(500).json({
            success : false,
            msg : e.message
        });
    }

});


//SIGNIN

authRouter.post('/api/signin',async(req,res)=>{
    
    try{

        const { email , password } = req.body;

        const isUser = await User.findOne({email});

        if(!isUser){

           return res.status(400).json({
                success : false ,
                msg : "User doesn't exists"
            });
        }

        const isMatch = await bcryptjs.compare(password,isUser.password);

        if(!isMatch){
            
            return res.status(400).json({
                success : false ,
                msg : "Invalid Password!!"
            });
        }

        const token = await jwt.sign({id : isUser._id}, "passwordKey");

        res.status(200).json({
            success : true ,
            msg : "User Logged in",
            ...isUser._doc,
            token : token
        });

    }catch(e){

        res.status(500).json({
            success : false ,
            msg : e.message
        });
    }
})

module.exports = authRouter;