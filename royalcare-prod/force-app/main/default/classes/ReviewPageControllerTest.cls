@isTest
public class ReviewPageControllerTest {
    
    static testMethod void testReviewHHAInfoWithId(){
        Account acc = TestDataFactory.createAccountsWithHHA();
        Test.startTest();
        PageReference pageRef = Page.ReviewPage;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ReviewPageController reviewPageCtrl = new ReviewPageController(sc);
        reviewPageCtrl.redirectOnApplicantStmt();
        Test.stopTest();
        System.assertEquals('123456789', acc.Applicant_SSN__c);
    }
    
    static testMethod void testReviewCDPAPInfoWithId(){
        Account acc = TestDataFactory.createAccountsWithCDPAP();
        Test.startTest();
        PageReference pageRef = Page.ReviewForCDPAPForm;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ReviewPageController reviewPageCtrl = new ReviewPageController(sc);
        pageRef = reviewPageCtrl.redirectOnFinalPage();
        Sertifi2_0__TestContract__c eContract_Inserted = [SELECT id FROM Sertifi2_0__TestContract__c WHERE Sertifi2_0__Account__c =: acc.id];
        contact con = new contact();
        con.LastName = acc.LastName;
        con.FirstName = acc.FirstName;
        con.Email = 'abc@test.com';
        insert con;
         pageRef = Page.Final_Submission_Form; 
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', acc.id);
        ApexPages.currentPage().getParameters().put('&econtractId', eContract_Inserted.id);
        ApexPages.currentPage().getParameters().put('&contactid', con.id);
        FinalSubmissionController fnctrl = new FinalSubmissionController();
        fnctrl.ws_generateEDocument();
        pageRef = page.ProcessToGetSignature;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', acc.id);
        ApexPages.currentPage().getParameters().put('econtractId', eContract_Inserted.id);
        ApexPages.currentPage().getParameters().put('contactid', con.id);
        processToGetSignature poc = new processToGetSignature();
        poc.getPageLink();
        
        Test.stopTest();
        System.assertEquals(true, acc.IsAllInformationFilled__c);
    }
    
    //Old data - Account having Applicant Statement Date
    static testMethod void testReviewHHAInfoWithOldData(){
        Account acc = TestDataFactory.createAccountsWithHHA();
        acc.Applicant_Date__c = Date.today();
        update acc;
        Test.startTest();
        PageReference pageRef = Page.ReviewPage;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ReviewPageController reviewPageCtrl = new ReviewPageController(sc);
        reviewPageCtrl.redirectOnApplicantStmt();
        reviewPageCtrl.cancel();
        Test.stopTest();
        System.assertEquals(Date.today(), acc.Applicant_Date__c);
    }
  
    static testMethod void testReviewHHAInfoForAccDeletion(){
        Account acc = TestDataFactory.createAccountsWithHHA();
        acc.IsAllInformationFilled__c = false;
        update acc;
        Test.startTest();
        PageReference pageRef = Page.ReviewPage;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ReviewPageController reviewPageCtrl = new ReviewPageController(sc);
        reviewPageCtrl.cancel();
        Test.stopTest();
        System.assertEquals(0, [SELECT COUNT() FROM Account WHERE Id= :acc.Id]);
    }
    
    static testMethod void testReviewCDPAPInfoForAccDeletion(){
        Account acc = TestDataFactory.createAccountsWithCDPAP();
        acc.IsAllInformationFilled__c = false;
        update acc;
        Test.startTest();
        PageReference pageRef = Page.ReviewForCDPAPForm;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ReviewPageController reviewPageCtrl = new ReviewPageController(sc);
        reviewPageCtrl.cancelForCDPAP();
        Test.stopTest();
        System.assertEquals(0, [SELECT COUNT() FROM Account WHERE Id= :acc.Id]);
    }
    
}