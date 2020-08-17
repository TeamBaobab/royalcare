public class FinalSubmissionController {
    public Account acc{get;set;}
    public FinalSubmissionController(){
         id idOfAcccount = ApexPages.currentPage().getParameters().get('id');
        acc = [SELECT id, Translating_Language__c FROM Account WHERE id=:idOfAcccount];
    }
    public PageReference ws_generateEDocument()
    {
       
        
        id eContractId = apexPages.currentPage().getParameters().get('econtractId');
        id conid = apexPages.currentPage().getParameters().get('contactid');
        Sertifi2_0__SertifiSettings__c sertifiSettings = Sertifi2_0__SertifiSettings__c.getInstance('Settings');
        String response = Sertifi2_0.SertifiSFAPI.sendEContractToSertifi(eContractId, sertifiSettings );
        System.Debug('Sertifi API call response: ' + response);
        
        
        PageReference page = new Pagereference('/apex/ProcessToGetSignature?econtractid='+eContractId+'&contactid='+conid );
        page.setRedirect(true);
        return page;
        
    }
   
    
    
}