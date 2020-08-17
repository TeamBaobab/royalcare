@isTest
public class ConsumerExtensionTest{

     static testMethod void  testUnit(){
     
         Account acc =  TestDataFactory.createAccountsWithHHA();
         acc.IsAllInformationFilled__c = true;
         update acc;
        Test.startTest();
        PageReference pageRef = Page.Consumer_Information_Form;
        pageRef.getParameters().put('id', String.valueOf(acc.Id));
        pageRef.getParameters().put('reviewforcdpapAccountId', String.valueOf(acc.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ConsumerExtension consumrObj = new ConsumerExtension(sc);
        consumrObj.saveandnewForConsInfo();
        consumrObj.previousFromcomsInfo();
        consumrObj.cancel();
       
     }
    static testMethod void  testUnitFail(){
        Account acc =  TestDataFactory.createAccountsWithHHA();
         acc.IsAllInformationFilled__c = false;
         update acc;
        Test.startTest();
        PageReference pageRef = Page.Consumer_Information_Form;
        //pageRef.getParameters().put('id', String.valueOf(acc.Id));
        pageRef.getParameters().put('reviewforcdpapid', String.valueOf(acc.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ConsumerExtension consumrObj = new ConsumerExtension(sc);
        consumrObj.saveandnewForConsInfo();
        consumrObj.previousFromcomsInfo();
        consumrObj.cancel();	
        
    }
}