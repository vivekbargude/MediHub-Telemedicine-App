const Upload = require('../helpers/upload');

const UploadFile = async (req,res) => {
    
    try {

        const upload = await Upload.uploadFile(req.file.path);
        const url = upload.secure_url;
        console.log(url);

        res.status(200).json({
            success : true ,
            msg : "File Uploadded Successfully",
            url : url
        });


    }catch(e){
        res.status(500).json({success : false,msg : e.message});
    }
}

module.exports = {
    UploadFile,
}