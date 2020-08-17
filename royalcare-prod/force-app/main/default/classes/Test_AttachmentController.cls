@isTest
public class Test_AttachmentController {

    static testMethod void  testUnit(){
     
         Account acc =  TestDataFactory.createAccountsWithCDPAP();
         acc.IsAllInformationFilled__c = true;
         transient String base64;
        String base641 = base64;
         update acc;
       
         Test.startTest();
         PageReference pageRef = Page.UploadFilesCDPAP;
         pageRef.getParameters().put('id', String.valueOf(acc.Id));
         pageRef.getParameters().put('UploadfilesManually', String.valueOf(acc.Id));
         Test.setCurrentPage(pageRef);
         ApexPages.StandardController sc = new ApexPages.StandardController(acc);
         AttachmentController consumrObj = new AttachmentController(sc);
         consumrObj.setbase64('str');
         consumrObj.getBase64();
         consumrObj.getAttachment();
        
        //System.assertEquals('0017A00000aQsO8QAK', consumrObj.accountId);
        System.assertEquals(null, consumrObj.fileName);
        System.assertEquals(null, consumrObj.contentType);
        //System.assertEquals(consumrObj.getAttachment(), consumrObj.attach);
        System.assertEquals(false, consumrObj.file);
        Test.stopTest();
        
        
         
    }
    
    
}