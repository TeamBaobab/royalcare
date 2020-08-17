public with sharing class TM_createTaskOrderController {
    
    public String reviewAccountId;    
    public Account Task{get;set;}
    public transient String base64;
    public Boolean TaskSec {get;set;}
    public Boolean file {get;set;}
    public Consumer_Information__c consumer{get;set;}
    public List<Consumer_Information__c> listOfConsumers {get;set;}
    public String accountId;
    public Account acc {get;set;}
    public String reviewforcdpapAccountId;
    public boolean check{get;set;}
    public Boolean msgFlag{get;set;}
    Public Account tempAcc{get;set;}   
    
    public TM_createTaskOrderController(ApexPages.StandardController sc) {
          
        TaskSec = true;
        file=false;
        
        tempAcc = new Account();
        
        
        msgFlag = false;
        accountId = ApexPages.currentPage().getParameters().get('id');
        reviewforcdpapAccountId = ApexPages.currentPage().getParameters().get('reviewforcdpapid');
        reviewAccountId = ApexPages.currentPage().getParameters().get('reviewId');
        check = true;
        if(reviewforcdpapAccountId != null )
            check = false;
        
        if(reviewforcdpapAccountId != null)
            accountId = reviewforcdpapAccountId;
           if(reviewAccountId != null)
           {
            accountId = reviewAccountId;
                check = false;
           }
        
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
               FirstName,MiddleName,LastName,Location_Team__c FROM Account WHERE Id =:accountId];
        
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
    /* public void save11(){   

try{	
insert Task;    
TaskSec = false;
file=true;

}
catch (Exception ex) {

}
} */
    public String getBase64()
    {
        return base64;
    }
    public void setbase64(String base64)
    {
        this.base64 = base64;
    }
    public String fileName {get; set;}
    public String contentType {get; set;}
    
    public void saveFile()
    {
        System.debug('base64' +base64);
        String base641 = base64;
        System.debug('base641' +base641);
       // String str = base641.split('base64,')[1];
        
        //str = str.replace('data:text/plain;base64,', '');
       // System.debug('str ' + str);
        Attachment a = new Attachment(parentId = accountId, Body =  EncodingUtil.base64Decode(base641), name = fileName,ContentType = contentType);
        //Attachment a = new Attachment(parentId = accountId, Body =  EncodingUtil.base64Decode(str), name = fileName,ContentType = contentType);
        insert a;
    }
    
    
    
    public pageReference cancel(){
        PageReference page;
        if(reviewforcdpapAccountId!=null){
            page = new Pagereference('/apex/ReviewForCDPAPForm?id='+acc.Id);
        }
        else{
            if(reviewAccountId!=null){
            page = new Pagereference('/apex/ReviewPage?id='+acc.Id);
        }
            else
            {
                System.debug('value of filled field : ' + acc.IsAllInformationFilled__c);
                if(acc.IsAllInformationFilled__c == false)
                    delete acc;
                if(acc.Location_Team__c =='OnlineUser')
                {
                    page = new Pagereference('/apex/cdpapapplication');
                }
                else
                {
                    page = new Pagereference('/apex/WelcomePage');
                }
                
            }
        }
        page.setRedirect(true);
        return page;   
    }
    
     public pageReference cancelHHA(){
    //     public pageReference cancel(){
        PageReference page;
        if(reviewAccountId!=null){
            page = new Pagereference('/apex/ReviewPage?reviewAccountId='+acc.Id);
        }
        else{
            if(reviewforcdpapAccountId!=null){
                page = new Pagereference('/apex/ReviewForCDPAPForm?reviewAccountId='+acc.Id);
            }
            else{
                System.debug('value of filled field : ' + acc.IsAllInformationFilled__c);
                if(acc.IsAllInformationFilled__c == false)
                    delete acc;
                page = new Pagereference('/apex/WelcomePage');
            }
        }
        page.setRedirect(true);
        return page;   
       
    }
    
     public PageReference previousFromPADisclosureForm(){
        PageReference parentPage ;
      //  parentPage = new PageReference('/apex/PA_Disclosure_Statement_Form?id='+acc.Id);
        parentPage = new PageReference('/apex/Deficit_Reduction_Act_Form?id='+acc.Id);
        parentPage.setRedirect(true);
        return parentPage;
    }
    public PageReference previousFromfileUploadHHAForm(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/Emer_cont_Info_Form?id='+acc.Id);
        parentPage.setRedirect(true);
        return parentPage;
    }
    
     public PageReference saveNext(){
        PageReference parentPage ;
        parentPage = new PageReference('/application/ReviewForCDPAPForm?id='+acc.Id);
        parentPage.setRedirect(true);
        return parentPage;
    }
    
      public PageReference saveNextHHA(){
        PageReference parentPage ;
        parentPage = new PageReference('/application/ReviewPage?id='+acc.Id);
        parentPage.setRedirect(true);
        return parentPage;
    }
    
    
    
    
    
}