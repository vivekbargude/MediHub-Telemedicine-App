const cloudinary = require('cloudinary');

cloudinary.v2.config({
  cloud_name: 'drerbcnk2',
  api_key: '595443969329562',
  api_secret: 'tnog_ydnLBw4xIgv1hSVMz0G2Ao',
  secure: true,
});

const uploadFile = async (filepath) => {

    try{

        const result = await cloudinary.UploadStream.upload(filepath);
        console.log(result);
        return result;

    }catch(e){
        console.log(e.message);
    }
}

module.exports = {
    uploadFile,
}