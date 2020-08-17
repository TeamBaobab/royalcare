@isTest
public class TestTm_generateDocumentSinglePage {

     static testMethod void myUnitTest(){
        
        Account acc;
        
        acc =  TestDataFactory.createAccountsWithHHA();
        
        Test.startTest();
        PageReference pageRef = Page.PdfForReferance;
        pageRef.getParameters().put('id', acc.id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        Tm_generateDocumentSinglePage genrtDoc= new Tm_generateDocumentSinglePage(sc);
        genrtDoc.getAttachment();
    }
    
    
}