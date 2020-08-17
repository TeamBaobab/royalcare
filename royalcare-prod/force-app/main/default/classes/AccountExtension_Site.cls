public without sharing class AccountExtension_Site{
    public Account acct{get;set;}
    public Account acc{get;set;}//use for getting name
    public String hIVMedicaRCS_Date {get;set;}
    public String photoIAck_Date {get;set;}
    public String nYSDOH_Date {get;set;}
    public String hHA_Pledge_Date {get;set;}
    public String hHA_Attestation_Date {get;set;}
    public String deficitReductionActDate {get;set;}
    public String PAAckReceiptDate {get;set;}
    Public boolean btest {get;set;}
    public String choosedlanguage{get; set;}
    public String reviewAccountId;
    public String reviewforcdpapAccountId;
    public boolean check{get;set;}
    public Boolean msgFlag{get;set;}
    Public Account tempAcc{get;set;}    
    Public String accountId;
   
    public AccountExtension_Site(ApexPages.StandardController stdController) {
        tempAcc = new Account();
        msgFlag = false;
        choosedlanguage = ApexPages.currentPage().getParameters().get('lid');
        accountId = ApexPages.currentPage().getParameters().get('id');
        reviewforcdpapAccountId = ApexPages.currentPage().getParameters().get('reviewforcdpapid');
        reviewAccountId= ApexPages.currentPage().getParameters().get('reviewid');
        check = true;
        if(reviewforcdpapAccountId != null || reviewAccountId != null)
            check = false;
        acc =  new Account();
        if(accountId  == Null){
            if(reviewforcdpapAccountId != null){
                accountId = reviewforcdpapAccountId;
            }
            if(reviewAccountId != null ){
                accountId = reviewAccountId;
            }
        }
        acct = [Select id,PhotoIAck_SSN__c, PERSONAL_ASSISTANT_S_CHOICES__c, HEPATITIS_SSN__c, HEPATITIS_Form_Date__c, IsAllInformationFilled__c,PhotoIAck_Date__c,HIVMedicaRCS_Date__c,HIVMedicaRCS_SSN__c,SSN__c,Birthplace__c,Gender__c,Race__c,Height__c,Weight__c,Eye_Color__c,Hair_Color__c,
                PersonBirthdate, Work_Permit_If_Under_18__c, Previously_Applied__c , Previously_filed_application_date__c, Previously_employed_here__c , Previously_employed_here_date__c , 
                Immigration_Status__c, Date_available_for_work__c,Avalibility__c,Desired_shift__c,Felony_Conviction_within_7_years__c,Conviction_Explination__c,Date_of_Application__c,
                HHA_Pledge_Date__c, HHA_Pledge_SSN__c, HHA_Attestation_Date__c, HHA_Attestation_SSN__c, NYSDOH_Date__c , NYSDOH_SSN__c, Deficit_Reduction_Act_Date__c, Deficit_Reduction_Act_SSN__c,
                At_least_18_years_of_age__c,Valid_Social_Security_Number__c,Accepted_employment_from_a_Royal_FI_Cons__c,Accurately_completed_and_signed__c,Agree_for_physical_examination__c,   
                Spouse_or_parent_of_the_consumer__c,Personal_Assistant_SSN_for_Validation__c,Validation_Form_Date__c,
                PA_Ack_Receipt_SSN__c, PA_Ack_Receipt_Date__c,Translating_Language__c FROM Account Where id =:accountId];
        acc = [Select id,Name,HIVMedicaRCS_Date__c,PhotoIAck_Date__c,NYSDOH_Date__c,HHA_Attestation_Date__c,HHA_Pledge_Date__c, Deficit_Reduction_Act_Date__c, Deficit_Reduction_Act_SSN__c,
               PA_Ack_Receipt_SSN__c, PA_Ack_Receipt_Date__c FROM Account Where id =:accountId];
        
        if(acct.HEPATITIS_Form_Date__c == NULL) {
            acct.HEPATITIS_Form_Date__c= Date.parse(Date.today().format());
        }
        else{
            acct.HEPATITIS_Form_Date__c = Date.parse(acct.HEPATITIS_Form_Date__c.format());
        }
        
        if(acc.HIVMedicaRCS_Date__c == null)
            hIVMedicaRCS_Date = Date.Today().format();
        else
            hIVMedicaRCS_Date = acc.HIVMedicaRCS_Date__c.format();
        
        acct.HIVMedicaRCS_Date__c = date.parse(HIVMedicaRCS_Date);
        
        
        if(acc.PhotoIAck_Date__c == null)
            photoIAck_Date = Date.Today().format();
        else
            photoIAck_Date = acc.PhotoIAck_Date__c.format();
        
        acct.PhotoIAck_Date__c = date.parse(HIVMedicaRCS_Date);
        
        
        if(acc.NYSDOH_Date__c == null)
            nYSDOH_Date = Date.Today().format();
        else
            nYSDOH_Date = acc.NYSDOH_Date__c.format();
        
        acct.NYSDOH_Date__c = date.parse(NYSDOH_Date);
        
        
        if(acc.HHA_Attestation_Date__c == null)
            hHA_Attestation_Date = Date.Today().format();
        else
            hHA_Attestation_Date = acc.HHA_Attestation_Date__c.format();
        
        acct.HHA_Attestation_Date__c = date.parse(HHA_Attestation_Date);
        
        if(acc.HHA_Pledge_Date__c == null)
            hHA_Pledge_Date = Date.Today().format();
        else
            hHA_Pledge_Date = acc.HHA_Pledge_Date__c.format();
        
        acct.HHA_Pledge_Date__c = date.parse(HHA_Pledge_Date);
        
        if(acc.Deficit_Reduction_Act_Date__c == null)
            deficitReductionActDate = Date.Today().format();
        else
            deficitReductionActDate = acc.Deficit_Reduction_Act_Date__c.format();
        
        acct.Deficit_Reduction_Act_Date__c = date.parse(deficitReductionActDate);
        
        if(acc.PA_Ack_Receipt_Date__c == null)
            PAAckReceiptDate = Date.Today().format();
        else
            PAAckReceiptDate = acc.PA_Ack_Receipt_Date__c.format();
        
        acct.PA_Ack_Receipt_Date__c = date.parse(PAAckReceiptDate);
        System.debug(acct);
        
        if(acct.Validation_Form_Date__c == NULL) {
            acct.Validation_Form_Date__c= Date.parse(Date.today().format());
        }
        else{
            acct.Validation_Form_Date__c = Date.parse(acct.Validation_Form_Date__c.format());
        }
        
        tempAcc.PERSONAL_ASSISTANT_S_CHOICES__c = acct.PERSONAL_ASSISTANT_S_CHOICES__c;   
        tempAcc.HEPATITIS_SSN__c =acct.HEPATITIS_SSN__c;
        tempAcc.HEPATITIS_Form_Date__c = acct.HEPATITIS_Form_Date__c ;
        
        tempAcc.Deficit_Reduction_Act_SSN__c = acct.Deficit_Reduction_Act_SSN__c;
        tempAcc.Deficit_Reduction_Act_Date__c = acct.Deficit_Reduction_Act_Date__c; 
        
        tempAcc.PA_Ack_Receipt_SSN__c = acct.PA_Ack_Receipt_SSN__c;
        tempAcc.PA_Ack_Receipt_Date__c = acct.PA_Ack_Receipt_Date__c;
        
        tempAcc.At_least_18_years_of_age__c= acct.At_least_18_years_of_age__c;   
        tempAcc.Valid_Social_Security_Number__c= acct.Valid_Social_Security_Number__c;   
        tempAcc.Accepted_employment_from_a_Royal_FI_Cons__c= acct.Accepted_employment_from_a_Royal_FI_Cons__c;   
        tempAcc.Accurately_completed_and_signed__c= acct.Accurately_completed_and_signed__c;   
        tempAcc.Agree_for_physical_examination__c= acct.Agree_for_physical_examination__c;   
        tempAcc.Spouse_or_parent_of_the_consumer__c= acct.Spouse_or_parent_of_the_consumer__c;  
        tempAcc.Personal_Assistant_SSN_for_Validation__c = acct.Personal_Assistant_SSN_for_Validation__c;  
        tempAcc.Validation_Form_Date__c = acct.Validation_Form_Date__c ;
    }
    
  
    
    public PageReference previousHEPATITIS(){
        PageReference parentPage ;
       // parentPage = new PageReference('/apex/EmercontForCDPAP?id='+acct.Id);
        parentPage = new PageReference('/apex/Consumer_Information_Form?id='+acct.Id);
        parentPage.setRedirect(true);
        return parentPage;
    }
    
    
    public PageReference saveAndReturnForHEPATITIS()
    {
        try{
            if(choosedlanguage!=null){
                acct.Translating_Language__c = choosedlanguage;
            }
     
            Account userUpdateValue = new Account();
            userUpdateValue = acct.clone();
            userUpdateValue.id = accountId;
            
            userUpdateValue.PERSONAL_ASSISTANT_S_CHOICES__c = tempAcc.PERSONAL_ASSISTANT_S_CHOICES__c;    
            userUpdateValue.HEPATITIS_SSN__c = tempAcc.HEPATITIS_SSN__c ;    
            userUpdateValue.HEPATITIS_Form_Date__c = tempAcc.HEPATITIS_Form_Date__c ;    
           
            update userUpdateValue;
            
       
            PageReference parentPage;
            if(reviewforcdpapAccountId!=null){
                parentPage= new Pagereference('/apex/ReviewForCDPAPForm?id='+acct.Id+'#hepatitisBId');
            }
            else{
                parentPage = new PageReference('/apex/Deficit_Reduction_Act_Form?id=' + acct.Id);
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
        if(reviewAccountId!=null){
            page = new Pagereference('/apex/ReviewPage?id='+acct.Id);
        }
        else{
            if(reviewforcdpapAccountId!=null){
                page = new Pagereference('/apex/ReviewForCDPAPForm?id='+acct.Id);
            }
            else{
                System.debug('value of filled field : ' + acct.IsAllInformationFilled__c);
                if(acct.IsAllInformationFilled__c == false)
                    delete acct;
                page = new Pagereference('/apex/WelcomePage');
            }
        }
        page.setRedirect(true);
        return page;   
    }
    
    public PageReference previousFromDeficitRAForm(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/HEPATITISBFORM?id='+acct.Id);
        parentPage.setRedirect(true);
        return parentPage;
    }
    
    public PageReference saveAndReturnForDeficitReductionAct()
    {
        try{
            Account userUpdateValue = new Account();
            userUpdateValue= acct.clone();
            userUpdateValue.Id = accountId;
            userUpdateValue.Deficit_Reduction_Act_SSN__c = tempAcc.Deficit_Reduction_Act_SSN__c;
            userUpdateValue.Deficit_Reduction_Act_Date__c = tempAcc.Deficit_Reduction_Act_Date__c; 
            
             if(userUpdateValue.Deficit_Reduction_Act_Date__c == null)
                userUpdateValue.Deficit_Reduction_Act_Date__c = Date.Today();
            
            update userUpdateValue;
            PageReference parentPage;
            if(reviewforcdpapAccountId != null){  
                parentPage = new PageReference('/apex/UploadfilesCDPAP?reviewforcdpapid='+accountId+'&id='+accountId+'#PADisclosureStatementId');
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
   
    //for PersonalAssistAckofFalseClaimsform page
     public PageReference previousFromPAAckOfFC(){
        PageReference parentPage ;
         parentPage = new PageReference('/apex/Deficit_Reduction_Act_Form?id='+acct.Id);
        parentPage.setRedirect(true);
        return parentPage;
    }
    public PageReference saveAndReturnForPAAckReceipt()
    {
        try{
            if(acct.PA_Ack_Receipt_Date__c == null)
                acct.PA_Ack_Receipt_Date__c = Date.Today();
        
            Account userUpdateValue = new Account();
            userUpdateValue= acct.clone();
            userUpdateValue.Id = accountId;
          
            userUpdateValue.PA_Ack_Receipt_SSN__c = tempAcc.PA_Ack_Receipt_SSN__c ; 
            userUpdateValue.PA_Ack_Receipt_Date__c= tempAcc.PA_Ack_Receipt_Date__c; 

            update userUpdateValue;
            PageReference parentPage;
            if(reviewforcdpapAccountId!=null){
                parentPage= new Pagereference('/apex/ReviewForCDPAPForm?id='+acct.Id+'#PAAckReceiptId');
            }
            else{
                parentPage = new PageReference('/apex/SIGNATURE_VERIFICATION_FORM?id=' + acct.Id);
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
   
    // End PersonalAssistAckofFalseClaimsform page

    //sahil added new methods
    /* public PageReference saveAndNextForSignature() {
        try{
            Account userUpdateValue = new Account();
            
            userUpdateValue= acct.clone();
            userUpdateValue.Id = accountId;
            
            userUpdateValue.At_least_18_years_of_age__c= tempAcc.At_least_18_years_of_age__c;    
            userUpdateValue.Valid_Social_Security_Number__c= tempAcc.Valid_Social_Security_Number__c;   
            userUpdateValue.Accepted_employment_from_a_Royal_FI_Cons__c= tempAcc.Accepted_employment_from_a_Royal_FI_Cons__c;   
            userUpdateValue.Accurately_completed_and_signed__c= tempAcc.Accurately_completed_and_signed__c;   
            userUpdateValue.Agree_for_physical_examination__c= tempAcc.Agree_for_physical_examination__c;   
            userUpdateValue.Spouse_or_parent_of_the_consumer__c= tempAcc.Spouse_or_parent_of_the_consumer__c;  
            userUpdateValue.Personal_Assistant_SSN_for_Validation__c = tempAcc.Personal_Assistant_SSN_for_Validation__c;  
            userUpdateValue.Validation_Form_Date__c = tempAcc.Validation_Form_Date__c;
           
  
            update userUpdateValue;
            
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
        parentPage = new PageReference('/apex/PersonalAssistAckofFalseClaimsform?id='+acc.id);
        parentPage.setRedirect(true);
        return parentPage;
    }*/
  
}