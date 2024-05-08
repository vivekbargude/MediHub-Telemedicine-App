const mongoose = require('mongoose');
const colors = require('colors');
const DB_URL = "mongodb+srv://medihubdevelopersteam:uoDoBvjExHs5gr5n@medihub.sd4eyw6.mongodb.net/?retryWrites=true&w=majority&appName=MEDIHUB"


const connection = mongoose
.connect(DB_URL)
.then(()=>{
    console.log("Database Connected.".green.bold);
}).catch((e)=>{
    console.log("Connection Failed!!".red.bold);
});

module.exports = connection;