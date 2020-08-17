public class EducationCtrl {
    
    public Education__c education;
    public String accId;
    public String reviewAccountId;
    public Account acct{get;set;}
    public List<Education__c> educationList{get;set;}
    public List<Education__c> educationDeleteList;
    public Integer deleteEducationIndex{get;set;}
    public boolean check{get;set;}
    public Boolean msgFlag{get;set;}
    
    public EducationCtrl(ApexPages.StandardController sc) {
        
        msgFlag = false;
        educationDeleteList = new List<Education__c>();
        accId= ApexPages.currentPage().getParameters().get('id');
        check = true;
        
        System.debug(check);
        try{
            if(accId != null){
                educationList = new List<Education__c>();
                List<Education__c> eduList = [Select Id, Account__c, School_Name__c, Year_Completed__c, Diploma_Degree__c,
                                              Type__c, Describe_Course_of_Study__c,
                                              Describe_Specialized_Training__c from Education__c Where Account__c =:accId];
                if(eduList.size()>0) {
                    educationList.addAll(eduList);
                }else {
                    addNewEducation();
                }
            }
            
            if(accId == null){
                educationList = new List<Education__c>();
                reviewAccountId = ApexPages.currentPage().getParameters().get('reviewId');
                if(reviewAccountId != null)
                    check = false;
                accId = reviewAccountId;
                acct=[SELECT Id,IsAllInformationFilled__c,Translating_Language__c FROM Account WHERE Id=:accId];
                //education = [Select Id,Account__c,School_Name__c,Year_Completed__c,Diploma_Degree__c,Type__c ,Describe_Course_of_Study__c,Describe_Specialized_Training__c from Education__c Where Account__c=:reviewAccountId limit 1];   
                List<Education__c > listOfeducation = [Select Id,Account__c,School_Name__c,Year_Completed__c,Diploma_Degree__c,Type__c ,Describe_Course_of_Study__c,Describe_Specialized_Training__c from Education__c Where Account__c=:reviewAccountId];   
                if(listOfeducation  != null && listOfeducation.size() > 0 ){
                    educationList.addAll(listOfeducation );
                }
            } else{
                acct=[SELECT Id,IsAllInformationFilled__c,Translating_Language__c FROM Account WHERE Id=:accId];
                education= new Education__c();
                education.Account__c = accId;
            }
        }catch(Exception ex){
            System.debug('Error message '+ex.getMessage());
        }
    }
    
    public PageReference saveEducationDetails() {
        try{
            if(educationDeleteList != null ){
                delete educationDeleteList;
            }
            
            if(educationList != null && educationList.size() >0){
                upsert educationList;
            }
            
            PageReference page;
            if(reviewAccountId !=null){
                page = new Pagereference('/apex/ReviewPage?id='+accId+'#educationInformationId');
            } else{
                page = new Pagereference('/apex/Language_Form?id='+accId);
            }
            page.setRedirect(true);
            return page; 
        }
        catch(Exception ex){
            //msgFlag = true;
            ApexPages.addMessages(ex);
            return null;
        }
    }  
    
    public PageReference cancel(){
        try{
            PageReference page;
            if(reviewAccountId !=null){
                page = new Pagereference('/apex/ReviewPage?id='+accId);
            }
            else{
                if(acct.IsAllInformationFilled__c==false)
                    delete acct;
                page = new Pagereference('/apex/WelcomePage');
            }
            page.setRedirect(true);
            return page;  
        }  catch(Exception ex){
            msgFlag = true;
            ApexPages.addMessages(ex);
            return null;
        }
    }
    
    public PageReference previousFromEF(){
        PageReference parentPage;
        parentPage = new PageReference('/apex/ApplForEmployment_Form?id='+accId);
        parentPage.setRedirect(true);
        return parentPage;
    } 
    
    public void addNewEducation(){
        education = new Education__c();
        education.Account__c = accId;
        educationList.add(education);
    }
    
    public void deleteEducationRecord(){
        try{
            Education__c deleteEducation;
            integer listSize = educationList.size() - 1; 
            if(listSize != null ) {
                deleteEducation = educationList[listSize];
                if(deleteEducation.id!=null)
                    educationDeleteList.add(deleteEducation);
                educationList.remove(listSize);
            }
            if(educationList.size() == 0) {
                education = new Education__c();
                education.Account__c = accId;
                educationList.add(education);
            }
        } catch(Exception ex){
            System.debug('Error message in add row'+ex.getMessage());
        }
    }
    
    public void deleteSelectedEducationRecord(){
        try{
            Education__c deleteEducation;
            integer listSize = educationList.size() - 1; 
            //System.debug(listSize);
            //System.debug(educationList);
            //System.debug(deleteEducationIndex);
            
            if(listSize != null ) {
                deleteEducation = educationList[deleteEducationIndex - 1];
                if(deleteEducation.id!=null)
                    educationDeleteList.add(deleteEducation);
                educationList.remove(deleteEducationIndex - 1);
            }
            
            if(educationList.size() == 0) {
                education = new Education__c();
                education.Account__c = accId;
                educationList.add(education);
            }
        } catch(Exception ex){
            System.debug('Error message in add row'+ex.getMessage());
        }
    }
    
}