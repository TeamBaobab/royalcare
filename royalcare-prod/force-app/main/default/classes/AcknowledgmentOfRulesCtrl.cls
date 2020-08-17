public class AcknowledgmentOfRulesCtrl {
    
    public Account acc{get;set;}
    public String reviewAccountId ;
    public boolean check{get;set;}
    public Boolean msgFlag{get;set;}
    public String accId;
    public Account tempAcc{get;set;}
    
    public AcknowledgmentOfRulesCtrl(ApexPages.StandardController sc){
        
        msgFlag = false; 
        check = true;
        tempAcc = new Account();
        
        accId = ApexPages.currentPage().getParameters().get('id');
        if(accId == null){
            reviewAccountId = ApexPages.currentPage().getParameters().get('reviewId');
            if(reviewAccountId != null)
                check = false;
            accId =reviewAccountId;
        }
        
        acc = [SELECT Id, IsAllInformationFilled__c,  Employed_by_other_Licensed_Agency__c, Employed_by_Unlicensed_organization__c,Translating_Language__c,
               Start_hour_at_other_Org__c, End_hour_at_other_Org__c,
               Employment_Days_of_Week__c, Varying_outside_hours_of_employement__c, Currently_Not_Employed__c,
               Acknowledgment_of_Rules_SSN__c, Acknowledgment_of_Rules_Date__c, PersonTitle FROM Account WHERE Id =: accId ];
        System.debug(acc);
        
        
        if(acc.Acknowledgment_of_Rules_Date__c == NULL) {
            acc.Acknowledgment_of_Rules_Date__c= Date.parse(Date.today().format());
        }else{
            acc.Acknowledgment_of_Rules_Date__c= Date.parse(acc.Acknowledgment_of_Rules_Date__c.format());
        }
        
        // changes for sites ----------------------- 
        tempAcc.Employed_by_other_Licensed_Agency__c = acc.Employed_by_other_Licensed_Agency__c;
        tempAcc.Employed_by_Unlicensed_organization__c = acc.Employed_by_Unlicensed_organization__c;
        tempAcc.Start_hour_at_other_Org__c = acc.Start_hour_at_other_Org__c;
        tempAcc.End_hour_at_other_Org__c = acc.End_hour_at_other_Org__c;
        tempAcc.Employment_Days_of_Week__c = acc.Employment_Days_of_Week__c;
        tempAcc.Varying_outside_hours_of_employement__c = acc.Varying_outside_hours_of_employement__c;
        tempAcc.Currently_Not_Employed__c = acc.Currently_Not_Employed__c;
        tempAcc.Acknowledgment_of_Rules_SSN__c = acc.Acknowledgment_of_Rules_SSN__c;
        tempAcc.Acknowledgment_of_Rules_Date__c = acc.Acknowledgment_of_Rules_Date__c;
        
        
        
    }
    
    public PageReference updateAccountForAckOfRulesDetails(){
        try{
            
            if(!tempAcc.Employed_by_other_Licensed_Agency__c && !tempAcc.Employed_by_Unlicensed_organization__c && !tempAcc.Varying_outside_hours_of_employement__c && !tempAcc.Currently_Not_Employed__c ){
                //msgFlag = true;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,System.Label.Select_at_least_one_checkbox));
                return null;
            }
            
            Account userUpdatedValue = new Account();
            userUpdatedValue = acc.clone();
            userUpdatedValue.Id = accId;
            userUpdatedValue.Employed_by_other_Licensed_Agency__c = tempAcc.Employed_by_other_Licensed_Agency__c;
            userUpdatedValue.Employed_by_Unlicensed_organization__c = tempAcc.Employed_by_Unlicensed_organization__c;
            userUpdatedValue.Start_hour_at_other_Org__c = tempAcc.Start_hour_at_other_Org__c;
            userUpdatedValue.End_hour_at_other_Org__c = tempAcc.End_hour_at_other_Org__c;
            userUpdatedValue.Employment_Days_of_Week__c = tempAcc.Employment_Days_of_Week__c;
            userUpdatedValue.Varying_outside_hours_of_employement__c = tempAcc.Varying_outside_hours_of_employement__c;
            userUpdatedValue.Currently_Not_Employed__c = tempAcc.Currently_Not_Employed__c;
            userUpdatedValue.Acknowledgment_of_Rules_SSN__c = tempAcc.Acknowledgment_of_Rules_SSN__c;
            userUpdatedValue.Acknowledgment_of_Rules_Date__c = tempAcc.Acknowledgment_of_Rules_Date__c;
            
            update userUpdatedValue;
            
            PageReference parentPage ;
            if(reviewAccountId != null){
                parentPage = new PageReference('/apex/ReviewPage?id='+acc.Id+'#acknowledgmentOfRulesId');
            }
            else{
                parentPage = new PageReference('/apex/Emer_cont_Info_Form?id=' + acc.Id);
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
            page = new Pagereference('/apex/ReviewPage?id='+acc.Id);
        }
        else{
            if(acc.IsAllInformationFilled__c==false)
                delete acc;
            page = new Pagereference('/apex/WelcomePage');
        }
        page.setRedirect(true);
        return page;   
    }
    
    public PageReference previousFromAck(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/HIVMedicalRCStatement?id='+acc.Id);
        parentPage.setRedirect(true);
        return parentPage;
    }
    
}