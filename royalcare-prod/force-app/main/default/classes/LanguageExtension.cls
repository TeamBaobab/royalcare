public class LanguageExtension {
    public Language__c lan {get;set;}
    public List<Language__c> listOfLanguages {get;set;}
    public String accountId;
    public String langId;
    public Account acc {get;set;}
    public List<Language__c> listOfdeleteLanguage ; 
    public Integer delIndex {get;set;}
    public boolean check{get;set;}
    public Boolean msgFlag{get;set;}
    
    public LanguageExtension (ApexPages.StandardController stdController) {
       
        msgFlag = false;
        accountId = ApexPages.currentPage().getParameters().get('id');
        
        listOfLanguages = new List<Language__c>();
        listOfdeleteLanguage = new List<Language__c>();
        
        check = true;
        langId  = ApexPages.currentPage().getParameters().get('reviewid');
        
        if(langId != null )
            check = false;
        if(accountId==null )
            accountId = langId;
        listOfLanguages =[SELECT Id,Name,Reading_capabilities__c,Spoken_skill_level__c,Writing_capabilites__c,Account__c FROM Language__c WHERE ( Account__c =:accountId)];  
        if(langId != null){
            accountId =langId ;
            
           
        }
     
        if(listOfLanguages.size() == 0)
        {
            lan = new Language__c();
            lan.Account__c = accountId;
            listOfLanguages.add(lan);
        }
        
        acc = [SELECT Id,Translating_Language__c,IsAllInformationFilled__c FROM Account WHERE Id =:accountId];
    }
    
    public PageReference saveAndReturnforLang(){
        try{
            if(listOfdeleteLanguage != null ){
                System.debug('I am in save' + listOfdeleteLanguage);
                delete listOfdeleteLanguage;
            }
            
            if(listOfLanguages != null && listOfLanguages.size() >0){
                upsert listOfLanguages;
            }
            PageReference parentPage;
            if(langId != null){  
                parentPage = new PageReference('/apex/ReviewPage?id='+accountId+'#languageContainerId');
            }
            else{
               
                parentPage = new PageReference('/apex/ReferenceFormPage?id='+accountId);
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
    
   
    
    public void addNew(){
        try{
            lan = new Language__c();
            lan.Account__c = accountId;
            lan.IsApexCreate__c = true;
            listOfLanguages.add(lan);
        }
        catch(Exception ex){
            System.debug('Error message in add row'+ex.getMessage());
        }
    }
    
    
    public void delRow(){
        Language__c deleteLanguage;
        integer listSize =listOfLanguages.size() -1; 
        System.debug('listSize :::'+listSize );
        if(listSize != null ) {//if(listSize != null && listSize >0)
            
            deleteLanguage = listOfLanguages[listSize];
            
            if(deleteLanguage.id!=null)
                listOfdeleteLanguage.add(deleteLanguage) ;
            System.debug('list of deleted language : ' + listOfdeleteLanguage); 
            
            listOfLanguages.remove(listSize);
            
        }
        
        
        system.debug('listOfEmployer'+listOfLanguages);
        if(listOfLanguages.size()==0)
        {
            lan = new Language__c();
            lan.Account__c = accountId;
            listOfLanguages.add(lan);
        }
        system.debug('listOfEmployer'+listOfLanguages);
    }
    
    
    public void delSingleRow(){
        //System.debug('n is here' + n);
        Language__c deleteLanguage;
        integer listSize =listOfLanguages.size() -1; 
        System.debug('listSize :::'+listSize );
        if(listSize != null ) {//if(listSize != null && listSize >0)
            
            deleteLanguage = listOfLanguages[delIndex-1];
            
            if(deleteLanguage.id!=null)
                listOfdeleteLanguage.add(deleteLanguage) ;
            System.debug('list of deleted language : ' + listOfdeleteLanguage); 
            
            listOfLanguages.remove(delIndex-1);
            
        }
        
        
        system.debug('listOfEmployer'+listOfLanguages);
        if(listOfLanguages.size()==0)
        {
            lan = new Language__c();
            lan.Account__c = accountId;
            listOfLanguages.add(lan);
        }
        system.debug('listOfEmployer'+listOfLanguages);
    }
    
    public pageReference cancel(){
        PageReference page;
        if(langId !=null){
            page = new Pagereference('/apex/ReviewPage?id='+accountId);
        }
        else{
            if(acc.IsAllInformationFilled__c==false)
                delete acc;
            page = new Pagereference('/apex/WelcomePage');
        }
        page.setRedirect(true);
        return page;   
    }
    
    public PageReference previousFromLang(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/Education_Form?id='+accountId);
        parentPage.setRedirect(true);
        return parentPage;
        
        
    }
}