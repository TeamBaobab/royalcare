@isTest
public class Test_TM_createTaskOrderController {
    
    
     static testMethod void  testUnit(){
     
         Account acc =  TestDataFactory.createAccountsWithCDPAP();
         acc.IsAllInformationFilled__c = true;
         update acc;
        Test.startTest();
        PageReference pageRef = Page.UploadFilesCDPAP;
        pageRef.getParameters().put('id', String.valueOf(acc.Id));
        pageRef.getParameters().put('reviewforcdpapAccountId', String.valueOf(acc.Id));
        Test.setCurrentPage(pageRef);
        
         ApexPages.StandardController sc = new ApexPages.StandardController(acc);
         TM_createTaskOrderController consumrObj = new TM_createTaskOrderController(sc);
         consumrObj.getBase64();
         consumrObj.cancel();
         consumrObj.cancelHHA();
         consumrObj.saveNext();
         consumrObj.saveNextHHA();
         consumrObj.previousFromPADisclosureForm();
         consumrObj.previousFromfileUploadHHAForm();
         consumrObj.setbase64('str');
       
     }
    
}