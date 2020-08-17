public class ConsumerExtension {
    public Consumer_Information__c consumer {get;set;}
    public List<Consumer_Information__c> listOfConsumers {get;set;}
    public String accountId;
    public Account acc {get;set;}
    public String reviewforcdpapAccountId;
    public boolean check{get;set;}
    public Boolean msgFlag{get;set;}

    
    public ConsumerExtension (ApexPages.StandardController stdController) {
        msgFlag = false;
        accountId = ApexPages.currentPage().getParameters().get('id');
        reviewforcdpapAccountId = ApexPages.currentPage().getParameters().get('reviewforcdpapid');
        check = true;
        if(reviewforcdpapAccountId != null )
            check = false;
        
        if(reviewforcdpapAccountId != null)
            accountId = reviewforcdpapAccountId;
        
        listOfConsumers = [SELECT id, Name, Consumer_Number__c, Street__c, City__c, State__c, Zip__c,
                           Cannot_be_paid_to_work_as_a_PA__c, Disclose_to_Royal_Care__c, Identify_relationship_with_consumer__c,
                           Related_to_the_consumer__c, Reside_at_consumer_address__c,Relationship_with_Consumer__c,Consumer_SSN_for_Validation__c,
                           Consumer_Surrogate_SSN__c, Consumer_Surrogate_Date__c, Representative__c FROM Consumer_Information__c WHERE (Account__c =:accountId) LIMIT 1];
        
        if(listOfConsumers.size() == 0)
        {
            consumer = new Consumer_Information__c();
            consumer.Account__c = accountId;
        }
        else
        {
            consumer = listOfConsumers[0];
        }
        
        
       acc = [SELECT Id,PA_Date__c,PA_SSN__c,Translating_Language__c,IsAllInformationFilled__c,At_least_18_years_of_age__c,Valid_Social_Security_Number__c,Accepted_employment_from_a_Royal_FI_Cons__c,
               Accurately_completed_and_signed__c,Agree_for_physical_examination__c,Spouse_or_parent_of_the_consumer__c,Personal_Assistant_SSN_for_Validation__c,Validation_Form_Date__c,
               FirstName,MiddleName,LastName FROM Account WHERE Id =:accountId];
      /*   
        if(acc.PA_Date__c == NULL) {
            acc.PA_Date__c= Date.parse(Date.today().format());
        }
        else{
            acc.PA_Date__c = Date.parse(acc.PA_Date__c.format());
        }
        
        if(consumer.Consumer_Surrogate_Date__c == NULL) {
            consumer.Consumer_Surrogate_Date__c= Date.parse(Date.today().format());
        }
        else{
            consumer.Consumer_Surrogate_Date__c = Date.parse(consumer.Consumer_Surrogate_Date__c.format());
        }
        
        if(acc.Validation_Form_Date__c == NULL) {
            acc.Validation_Form_Date__c= Date.parse(Date.today().format());
        }
        else{
            acc.Validation_Form_Date__c = Date.parse(acc.Validation_Form_Date__c.format());
        }*/
        
    }
    
    public PageReference saveandnewForConsInfo(){
        try{
            if(consumer.Name != null)
            upsert consumer;
            else if(consumer.id != null)
             delete consumer;
           // upsert acc;
            PageReference parentPage;
            if(reviewforcdpapAccountId != null){  
                parentPage = new PageReference('/apex/ReviewForCDPAPForm?id='+accountId+'#consumerInfoId');
            }
            else{
                parentPage = new PageReference('/apex/HEPATITISBFORM?id='+accountId);
            }
            parentPage.setRedirect(true);
            return parentPage;
        }
        catch(Exception ex){
            msgFlag = true;
            ApexPages.addMessages(ex);
            return null;
        }
    }
    
   /* public PageReference savePADisclosureInfo(){
        try{
            upsert consumer;
            upsert acc;
            PageReference parentPage;
            if(reviewforcdpapAccountId != null){  
                parentPage = new PageReference('/apex/ReviewForCDPAPForm?id='+accountId+'#PADisclosureStatementId');
            }
            else{
                parentPage = new PageReference('/apex/PersonalAssistAckofFalseClaimsform?id='+accountId);
            }
            parentPage.setRedirect(true);
            return parentPage;
        }
        catch(Exception ex){
            msgFlag = true;
            ApexPages.addMessages(ex);
            return null;
        }
    }
    
    public PageReference saveAndNextForSignature() {
        try{
            upsert acc;
            upsert consumer;
            PageReference parentPage;
            if(reviewforcdpapAccountId != null){  
                parentPage = new PageReference('/apex/ReviewForCDPAPForm?id='+accountId+'#signatureVerificationFormId');
            }
            else{
                parentPage = new PageReference('/apex/ReviewForCDPAPForm?id=' + acc.Id);
            }
            parentPage.setRedirect(true);
            return parentPage;
        }
        catch(Exception ex){
            msgFlag = true;
            ApexPages.addMessages(ex);
            return null;
        }
    } 
    
    public PageReference previousFromSignature(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/PersonalAssistAckofFalseClaimsform?id='+acc.Id);
        parentPage.setRedirect(true);
        return parentPage;
    }
   
    
    public PageReference previousFromPADisclosureForm(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/Deficit_Reduction_Act_Form?id='+acc.Id);
        parentPage.setRedirect(true);
        return parentPage;
    }
    */
    
     public PageReference previousFromcomsInfo(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/EmercontForCDPAP?id='+accountId);
        parentPage.setRedirect(true);
        return parentPage;
    }
    
    public pageReference cancel(){
        PageReference page;
        if(reviewforcdpapAccountId!=null){
            page = new Pagereference('/apex/ReviewForCDPAPForm?id='+accountId);
        }
        else{
            System.debug('value of filled field : ' + acc.IsAllInformationFilled__c);
            if(acc.IsAllInformationFilled__c == false)
                delete acc;
            page = new Pagereference('/apex/WelcomePage');
        }
        page.setRedirect(true);
        return page;   
    }
    
}