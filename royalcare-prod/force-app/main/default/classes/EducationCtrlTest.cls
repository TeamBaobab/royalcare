@isTest
public class EducationCtrlTest {
    
    static testMethod void  testEducationInfoWithId(){
        Account acc =  TestDataFactory.createAccountsWithHHA();
        List<Education__c> eduList = new List<Education__c>();
        Education__c education = new Education__c();
        education.Account__c = acc.Id;
        eduList.add(education);
        education = new Education__c();
        education.Account__c = acc.Id;
        eduList.add(education);
        insert eduList;
        
        Test.startTest();
        PageReference pageRef = Page.Education_Form;
        pageRef.getParameters().put('id', String.valueOf(acc.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        EducationCtrl eduCtrl = new EducationCtrl(sc);
        
        eduCtrl.addNewEducation();
        eduCtrl.saveEducationDetails();
        eduCtrl.deleteEducationRecord();
        eduCtrl.deleteEducationIndex = 1;
        eduCtrl.deleteSelectedEducationRecord();
        eduCtrl.previousFromEF();
        eduCtrl.cancel();
        Test.stopTest();
    }
    
    static testMethod void  testEducationInfoWithReviewId(){
        Account acc =  TestDataFactory.createAccountsWithHHA();
        List<Education__c> eduList = new List<Education__c>();
        Education__c education = new Education__c();
        education.Account__c = acc.Id;
        eduList.add(education);
        education = new Education__c();
        education.Account__c = acc.Id;
        eduList.add(education);
        insert eduList;
        
        Test.startTest();
        PageReference pageRef = Page.Education_Form;
        pageRef.getParameters().put('reviewId', String.valueOf(acc.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        EducationCtrl eduCtrl = new EducationCtrl(sc);
        
        eduCtrl.addNewEducation();
        eduCtrl.saveEducationDetails();
        eduCtrl.deleteEducationRecord();
        eduCtrl.deleteEducationIndex = 1;
        eduCtrl.deleteSelectedEducationRecord();
        eduCtrl.previousFromEF();
        eduCtrl.cancel();
        Test.stopTest();
    }
    
    static testMethod void  testEducationInfoWithoutId(){
        Account acc =  TestDataFactory.createAccountsWithHHA();

        Education__c education = new Education__c();
        education.Account__c = acc.Id;
        insert education;
        
        Test.startTest();
        PageReference pageRef = Page.Education_Form;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        EducationCtrl eduCtrl = new EducationCtrl(sc);
        
        eduCtrl.addNewEducation();
        eduCtrl.saveEducationDetails();
        eduCtrl.deleteEducationRecord();
        eduCtrl.deleteEducationIndex = 1;
        eduCtrl.deleteSelectedEducationRecord();
        eduCtrl.previousFromEF();
        eduCtrl.cancel();
        Test.stopTest();
    }
    
    static testMethod void  testEducationInfoWithoutOldData(){
        Account acc =  TestDataFactory.createAccountsWithHHA();
                
        Test.startTest();
        PageReference pageRef = Page.Education_Form;
        pageRef.getParameters().put('id', String.valueOf(acc.Id));
        pageRef.getParameters().put('reviewId', String.valueOf(acc.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        EducationCtrl eduCtrl = new EducationCtrl(sc);
        
        eduCtrl.addNewEducation();
        eduCtrl.saveEducationDetails();
        eduCtrl.deleteEducationRecord();
        eduCtrl.deleteEducationIndex = 1;
        eduCtrl.deleteSelectedEducationRecord();
        eduCtrl.previousFromEF();
        eduCtrl.cancel();
        Test.stopTest();
    }
    
}