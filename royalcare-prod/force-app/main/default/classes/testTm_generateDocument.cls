@isTest
public class testTm_generateDocument{

    static testMethod void myUnitTest(){
        
        Account acc;
        
        acc =  TestDataFactory.createAccountsWithHHA();
        
        Test.startTest();
        PageReference pageRef = Page.TM_generateDocument;
        pageRef.getParameters().put('id', acc.id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        Tm_generateDocument genrtDoc= new Tm_generateDocument(sc);
    }
}