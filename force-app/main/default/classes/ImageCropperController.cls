public with sharing class ImageCropperController {
    
    @AuraEnabled
    public static String saveImage(String recordId, String fileName, String imageData) {
        fileName = (String.isNotBlank(fileName) ? fileName : 'Image') + '-' + System.now().format('YYYY-MM-DD hh:mm:ss') + '.png';
        ContentVersion contentVersion = new ContentVersion();
        contentVersion.ContentLocation = 'S';
        contentVersion.VersionData = EncodingUtil.base64Decode(imageData);
        contentVersion.Title = fileName;
        contentVersion.PathOnClient = filename;
        insert contentVersion;

        ContentDocumentLink newContentDocumentLink = new ContentDocumentLink();
        newContentDocumentLink.LinkedEntityId = recordId;
        newContentDocumentLink.ContentDocumentId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :contentVersion.Id].ContentDocumentId;
        newContentDocumentLink.ShareType = 'I';
        newContentDocumentLink.Visibility = 'AllUsers';
        insert newContentDocumentLink;

        return 'Image save successfully.';
    }

}