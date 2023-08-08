public class SignDemo{


    //Create attachment and return id of the attachment.


@RemoteAction
    public static string GenerateImage(string dataurl){

        Attachment myAttach = new Attachment();

        myAttach.name = 'Sign.png';
        myAttach.ParentId ='5002800000KhJOVAA3';  //Add ID of the parent object for the attachment (Account,Contact,etc..)
        myAttach.body = ((Blob) EncodingUtil.base64Decode(dataurl.split(',')[1]));
        insert myAttach;
        return myAttach.Id;
    }
}