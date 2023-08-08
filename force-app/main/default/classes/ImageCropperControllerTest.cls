@isTest
private class ImageCropperControllerTest {
    
    @TestSetup
    static void setupTestdata() {
        Account newAccount = new Account();
        newAccount.Name = 'Test Account';
        insert newAccount;
    }

    @isTest
    static void testImageCropperControllerTest() {
        Account newAccount = [SELECT Id FROM Account WHERE Name = 'Test Account'];
        ImageCropperController.saveImage(newAccount.Id, 'Test Image', 'Test Image Data');
    }

}