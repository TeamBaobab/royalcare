public class ConsumerExtension_Site {
    public Consumer_Information__c consumer{get;set;}
    public List<Consumer_Information__c> listOfConsumers {get;set;}
    public String accountId;
    public Account acc {get;set;}
    public String reviewforcdpapAccountId;
    public boolean check{get;set;}
    public Boolean msgFlag{get;set;}

    //Properties byHarshal//
    
    Public Account tempAcc{get;set;}    
    
    //End//
    
    
    public ConsumerExtension_Site (ApexPages.StandardController stdController) {
        
       tempAcc = new Account();
        
        
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
        }
        
        
        //tempAcc.FirstName= acc.FirstName; 
        //tempAcc.MiddleName= acc.MiddleName; 
        //tempAcc.LastName= acc.LastName; 
        tempAcc.PA_SSN__c= acc.PA_SSN__c; 
        tempAcc.PA_Date__c= acc.PA_Date__c; 
        
        tempAcc.At_least_18_years_of_age__c= acc.At_least_18_years_of_age__c;   
        tempAcc.Valid_Social_Security_Number__c= acc.Valid_Social_Security_Number__c;   
        tempAcc.Accepted_employment_from_a_Royal_FI_Cons__c= acc.Accepted_employment_from_a_Royal_FI_Cons__c;   
        tempAcc.Accurately_completed_and_signed__c= acc.Accurately_completed_and_signed__c;   
        tempAcc.Agree_for_physical_examination__c= acc.Agree_for_physical_examination__c;   
        tempAcc.Spouse_or_parent_of_the_consumer__c= acc.Spouse_or_parent_of_the_consumer__c;  
        tempAcc.Personal_Assistant_SSN_for_Validation__c = acc.Personal_Assistant_SSN_for_Validation__c;  
        tempAcc.Validation_Form_Date__c = acc.Validation_Form_Date__c ;
        
        
        
    }
    
    
     ////////////////// Code start by Harshal.k//////////////////
        
        //for PA_Disclosure_Statement_Form page.
        
      public PageReference previousFromPADisclosureForm(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/Deficit_Reduction_Act_Form?id='+acc.Id);
        parentPage.setRedirect(true);
        return parentPage;
    }
    
    public PageReference savePADisclosureInfo(){
        try{
             System.debug('consumer:'+consumer);
            System.debug('-----' + consumer.Identify_relationship_with_consumer__c);
            
            Account userUpdateValue = new Account();
            userUpdateValue= acc.clone();
            userUpdateValue.Id = accountId;
            //userUpdateValue.FirstName= tempAcc.FirstName; 
            //userUpdateValue.MiddleName= tempAcc.MiddleName; 
            //userUpdateValue.LastName= tempAcc.LastName; 
            userUpdateValue.PA_SSN__c= tempAcc.PA_SSN__c; 
            userUpdateValue.PA_Date__c= tempAcc.PA_Date__c;  
            
           
          
            //tempAcc.FirstName= userUpdateValue.FirstName; 
            //tempAcc.MiddleName= userUpdateValue.MiddleName; 
            //tempAcc.LastName= userUpdateValue.LastName; 
            //tempAcc.PA_SSN__c= userUpdateValue.PA_SSN__c; 
            //tempAcc.PA_Date__c= userUpdateValue.PA_Date__c; 
          
           // consumer.Identify_relationship_with_consumer__c = 'Son';
            upsert consumer;
            upsert userUpdateValue;
            
            PageReference parentPage;
            if(reviewforcdpapAccountId != null){  
                parentPage = new PageReference('/apex/ReviewForCDPAPForm?id='+accountId+'#PADisclosureStatementId');
            }
            else{
                parentPage = new PageReference('/apex/ReviewForCDPAPForm?id='+accountId);
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
    
    public pageReference cancel(){
        PageReference page;
        if(reviewforcdpapAccountId!=null){
            page = new Pagereference('/apex/ReviewForCDPAPForm?id='+acc.Id);
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
    
    
    //newly added by sahil 23-09-19
    public PageReference saveandUploadFiles(){
        try{
             System.debug('consumer:'+consumer);
            System.debug('-----' + consumer.Identify_relationship_with_consumer__c);
            
            Account userUpdateValue = new Account();
            userUpdateValue= acc.clone();
            userUpdateValue.Id = accountId;
            //userUpdateValue.FirstName= tempAcc.FirstName; 
            //userUpdateValue.MiddleName= tempAcc.MiddleName; 
            //userUpdateValue.LastName= tempAcc.LastName; 
            userUpdateValue.PA_SSN__c= tempAcc.PA_SSN__c; 
            userUpdateValue.PA_Date__c= tempAcc.PA_Date__c;  
            
           
          
            //tempAcc.FirstName= userUpdateValue.FirstName; 
            //tempAcc.MiddleName= userUpdateValue.MiddleName; 
            //tempAcc.LastName= userUpdateValue.LastName; 
            //tempAcc.PA_SSN__c= userUpdateValue.PA_SSN__c; 
            //tempAcc.PA_Date__c= userUpdateValue.PA_Date__c; 
          
           // consumer.Identify_relationship_with_consumer__c = 'Son';
            upsert consumer;
            upsert userUpdateValue;
            
            PageReference parentPage;
            if(reviewforcdpapAccountId != null){  
                parentPage = new PageReference('/apex/UploadfilesCDPAP?id='+accountId+'#PADisclosureStatementId');
            }
            else{
                parentPage = new PageReference('/apex/UploadfilesCDPAP?id='+accountId);
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
    
    // for SIGNATURE_VERIFICATION_FORM page
    
   /*  public PageReference previousFromSignature(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/PersonalAssistAckofFalseClaimsform?id='+acc.id);
        parentPage.setRedirect(true);
        return parentPage;
    }
    
    
    public PageReference saveAndNextForSignature() {
        try{
        
            
            Account userUpdateValue = new Account();
            
            userUpdateValue= acc.clone();
            userUpdateValue.Id = accountId;
            
            userUpdateValue.At_least_18_years_of_age__c= tempAcc.At_least_18_years_of_age__c;    
            userUpdateValue.Valid_Social_Security_Number__c= tempAcc.Valid_Social_Security_Number__c;   
            userUpdateValue.Accepted_employment_from_a_Royal_FI_Cons__c= tempAcc.Accepted_employment_from_a_Royal_FI_Cons__c;   
            userUpdateValue.Accurately_completed_and_signed__c= tempAcc.Accurately_completed_and_signed__c;   
            userUpdateValue.Agree_for_physical_examination__c= tempAcc.Agree_for_physical_examination__c;   
            userUpdateValue.Spouse_or_parent_of_the_consumer__c= tempAcc.Spouse_or_parent_of_the_consumer__c;  
            userUpdateValue.Personal_Assistant_SSN_for_Validation__c = tempAcc.Personal_Assistant_SSN_for_Validation__c;  
            userUpdateValue.Validation_Form_Date__c = tempAcc.Validation_Form_Date__c;
  
            upsert userUpdateValue;
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
    
    // end SIGNATURE_VERIFICATION_FORM page
    
     ////////////////// Code End  by Harshal.k//////////////////
    
    /*
    public PageReference saveandnewForConsInfo(){
        try{
            upsert consumer;
            upsert acc;
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
    public PageReference previousFromcomsInfo(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/EmercontForCDPAP?id='+acc.Id);
        parentPage.setRedirect(true);
        return parentPage;
    }
    
    public PageReference previousFromPADisclosureForm(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/Deficit_Reduction_Act_Form?id='+acc.Id);
        parentPage.setRedirect(true);
        return parentPage;
    }
    
    public pageReference cancel(){
        PageReference page;
        if(reviewforcdpapAccountId!=null){
            page = new Pagereference('/apex/ReviewForCDPAPForm?id='+acc.Id);
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
    */
}