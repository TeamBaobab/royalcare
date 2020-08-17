@isTest
public class ReferenceFormControllerTest {
    
    static testMethod void testEmployerInfoWithId(){
        Account acc =  TestDataFactory.createAccountsWithHHA();
        List<Employer__c> employerList = new List<Employer__c>();
        Employer__c employer =  new Employer__c ();
        employer.Applicant__c = acc.Id;
        employer.Postal_Code__c = '12345';
        employer.Phone__c = '1234567890';
        employerList.add(employer); // first record
        employer =  new Employer__c();
        employer.Applicant__c = acc.Id;
        employer.Postal_Code__c = '12345';
        employer.Phone__c = '1234567890';
        employerList.add(employer); // second record
        insert employerList;
        
        Test.startTest();
        PageReference pageRef = Page.ReferenceFormPage;
        pageRef.getParameters().put('id', String.valueOf(acc.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ReferenceFormController referenceFormCtrl = new ReferenceFormController(sc);
        referenceFormCtrl.addNew();
        referenceFormCtrl.saveReferenceData();
        referenceFormCtrl.delRow();
        referenceFormCtrl.currentIndex = 1;
        referenceFormCtrl.delCurrentRow();
        referenceFormCtrl.previousFromRF();
        Test.stopTest();
        System.assertEquals(2, [SELECT COUNT() FROM Employer__c]);
    }
    
    static testMethod void testEmployerInfoWithReviewId(){
        Account acc =  TestDataFactory.createAccountsWithHHA();
        List<Employer__c> employerList = new List<Employer__c>();
        Employer__c employer =  new Employer__c();
        employer.Applicant__c = acc.Id ;
        employer.Postal_Code__c = '12345';
        employer.Phone__c = '1234567890';
        employerList.add(employer);
        employer =  new Employer__c();
        employer.Postal_Code__c = '12345';
        employer.Phone__c = '1234567890';
        employer.To__c = '09/08/2017';
        employer.From__c  = '09/08/2017';
        employer.Applicant__c = acc.Id ;
        
        employerList.add(employer);
        
        insert employerList;
        
        Test.startTest();
        PageReference pageRef = Page.ReferenceFormPage;
        pageRef.getParameters().put('pid', String.valueOf(acc.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ReferenceFormController referenceFormCtrl = new ReferenceFormController(sc);
        referenceFormCtrl.addNew();
        referenceFormCtrl.saveReferenceData();
        referenceFormCtrl.delRow();
        referenceFormCtrl.currentIndex = 1;
        referenceFormCtrl.delCurrentRow();
        referenceFormCtrl.previousFromRF();
        referenceFormCtrl.cancel();
        Test.stopTest();
        System.assertEquals(2, [SELECT COUNT() FROM Employer__c]);
    }
  
    static testMethod void testEmployerInfoWithoutOldData(){
        Account acc =  TestDataFactory.createAccountsWithHHA();
        
        Test.startTest();
        PageReference pageRef = Page.ReferenceFormPage;
        pageRef.getParameters().put('id', String.valueOf(acc.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ReferenceFormController referenceFormCtrl = new ReferenceFormController(sc);
        referenceFormCtrl.addNew();
        referenceFormCtrl.saveReferenceData();
        referenceFormCtrl.delRow();
        referenceFormCtrl.currentIndex = 1;
        referenceFormCtrl.delCurrentRow();
        referenceFormCtrl.previousFromRF();
        referenceFormCtrl.cancel();
        Test.stopTest();
        System.assertEquals(0, [SELECT COUNT() FROM Employer__c]);

    }
    
}