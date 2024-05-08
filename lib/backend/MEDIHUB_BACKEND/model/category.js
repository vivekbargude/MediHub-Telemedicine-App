const mongoose = require('mongoose');

const categorySchema = mongoose.Schema({

    catName : {
        
    }
});

const CategoryModel = mongoose.model('Category',categorySchema);

module.exports = CategoryModel;