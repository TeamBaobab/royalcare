public class PersonalInformationExtension {
    
    public List<Address__c> addList{get;set;}
    public String addtakeCity{get;set;}
    public String addtakeState{get;set;}
    public list<Address__C> templist{get;set;}
    transient public list<String> zipaddList{get;set;}
    
    Account acct;
   
    public String idOfAcccount{get;set;}
    public String reviewAccountId;
    public String accSalutation {get; set;}
    public String accFname{get; set;}
    public String accLname{get; set;}
    public String accMiddleName {get; set;}
    public String accEmail{get; set;}
    public String accPhone{get; set;}
    public String accMobile {get; set;}
 
    public String accMailingStreet{get; set;}
    public String accMailingCity {get; set;}
    public String accMailingState{get; set;}
    public String accMailingZip{get; set;}
 
    public String choosedlanguage{get; set;}
    public String accSSN{get; set;}
    public String accPersonBirthplace{get; set;}
    public Date accPersonBirthDate{get; set;}
    public String typeId;
    public String reviewforcdpapAccountId;
    public boolean check{get;set;}
    public Boolean msgFlag{get;set;}//may be this field not required.
    public String locationId{get;set;}
    //-------------------current date work------------------
    public String accDOB{get;set;}
   
    //------------------------------
    public PersonalInformationExtension (ApexPages.StandardController controller ){
        msgFlag = false;
        check = true;
        choosedlanguage = ApexPages.currentPage().getParameters().get('lid');
        locationId =  ApexPages.currentPage().getParameters().get('loctnId');
        idOfAcccount = ApexPages.currentPage().getParameters().get('id');
        reviewAccountId = ApexPages.currentPage().getParameters().get('reviewid');
        typeId = ApexPages.currentPage().getParameters().get('tyId');
        
        reviewforcdpapAccountId = ApexPages.currentPage().getParameters().get('reviewforcdpapid');
        if(reviewforcdpapAccountId != null || reviewAccountId != null)
            check = false;
        
      // Coming from review page
        if((idOfAcccount == null && reviewAccountId != null && reviewforcdpapAccountId == null) || (idOfAcccount == null && reviewAccountId == null && reviewforcdpapAccountId != null) ){
             
            if(reviewAccountId != null )
                idOfAcccount= reviewAccountId;
            if(reviewforcdpapAccountId != null)
                idOfAcccount= reviewforcdpapAccountId;
            System.debug('id of account is :' + idOfAcccount);
            acct =[Select Id,Birthplace__c,PersonBirthDate,SSN__c,IsAllInformationFilled__c,salutation,firstName,MiddleName,lastName,isPersonAccount,PersonEmail,Phone,PersonMobilePhone,Position__c,PersonMailingStreet,PersonMailingCity,PersonMailingState,PersonMailingPostalCode,PersonMailingCountry,IsTestSolved__c From Account Where Id=:idOfAcccount and isPersonAccount=:true Limit 1];
            accSalutation = acct.Salutation;
            accFname = acct.FirstName;
            accLname = acct.LastName;
            accMiddleName = acct.MiddleName;
            accEmail = acct.PersonEmail;
            accMobile = acct.PersonMobilePhone;
        
            accMailingStreet = acct.PersonMailingStreet ;
            accMailingCity = acct.PersonMailingCity;
            accMailingState = acct.PersonMailingState;
            accMailingZip = acct.PersonMailingPostalCode;
        
            accSSN = acct.SSN__c;
            accPersonBirthplace = acct.Birthplace__c;
             //accPersonBirthDate = acct.PersonBirthDate;
            accDOB = String.valueOf(acct.PersonBirthDate);
             System.debug('accDOB--'+accDOB);
            accPhone = acct.Phone;
        }
        // coming when hit previous
        else if(idOfAcccount != null){
            
            acct =[Select Id,Birthplace__c,SSN__c,PersonBirthDate,IsAllInformationFilled__c,salutation,firstName,MiddleName,lastName,isPersonAccount,PersonEmail,Phone,PersonMobilePhone,Position__c,PersonMailingStreet,PersonMailingCity,PersonMailingState,PersonMailingPostalCode,PersonMailingCountry,IsTestSolved__c From Account Where Id=:idOfAcccount Limit 1];  
            accSalutation = acct.Salutation;
            accFname = acct.FirstName;
            accLname = acct.LastName;
            accMiddleName = acct.MiddleName;
            accEmail = acct.PersonEmail;
            accMobile = acct.PersonMobilePhone;
        
            accMailingStreet = acct.PersonMailingStreet ;
            accMailingCity = acct.PersonMailingCity;
            accMailingState = acct.PersonMailingState;
            accMailingZip = acct.PersonMailingPostalCode;
       
            accSSN = acct.SSN__c;
            //accPersonBirthDate = acct.PersonBirthDate;
            accDOB = String.valueOf(acct.PersonBirthDate);
            System.debug('accDOB--'+accDOB);
            accPersonBirthplace = acct.Birthplace__c;
            accPhone = acct.Phone;
        }
        else{
            acct = new Account();
        }
        
    }
    
    
    
    public PageReference savePersonalInfo() {
        try {
            
            RecordType recType;
            if(typeId == 'HHA' || reviewAccountId !=null)
                recType = [select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='account' and name = 'HHA' limit 1];
            if(typeId == 'CDPAP' || reviewforcdpapAccountId != null)
                recType = [select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='account' and name = 'CDPAP' limit 1];
           
            // if someone try to play with url.
           /* if(typeId!='HHA' && typeId!='CDPAP')
            {
                PageReference parentPage ;
                parentPage = new PageReference('/apex/WelcomePage');
                parentPage.setRedirect(true);
                return parentPage;
                //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,System.Label.Something_went_wrong_please_click_on_cancel_button));
              
            }*/
            
            
            acct.recordtypeid = recType.id;
            acct.Salutation=accSalutation;
           
          /*  String rep_name = accFname;
            List<String> elems = rep_name.split(' ');
            rep_name = '';
            for (String x : elems)
            {
                rep_name += x.substring(0,1).toUpperCase()+x.substring(1,x.length()) + ' ';
            }
            System.debug('>>>'+rep_name);
            accFname = rep_name;*/
            //acct.FirstName=accFname;working code
            acct.FirstName = capitalizeWords(accFname);
            
            acct.LastName=capitalizeWords(accLname);
            acct.MiddleName=capitalizeWords(accMiddleName);
            acct.PersonEmail=accEmail;
            acct.PersonMobilePhone=accMobile;
            
            system.debug('PersonMobilePhone***'+ acct.PersonMobilePhone);
            
         
            acct.PersonMailingStreet=accMailingStreet;
            acct.PersonMailingCity=accMailingCity;
            acct.PersonMailingState=accMailingState;
            acct.PersonMailingPostalCode=accMailingZip;
       
            acct.SSN__c =  accSSN;
            acct.Birthplace__c = accPersonBirthplace;
            String[] tempdate;
            Date myDate;
            System.debug('accDOB'+accDOB);
            if(accDOB!=null)
            {
                tempdate =  accDOB.split('/');
            }
            System.debug('date-----'+tempdate.size());
            if(tempdate.size()>0)
            {
                myDate = date.newinstance(Integer.valueOf(tempdate[2]),Integer.valueOf(tempdate[0]), Integer.valueOf(tempdate[1]));
            }
          //  acct.PersonBirthDate = accPersonBirthDate;
           acct.PersonBirthDate = myDate;
            acct.Phone = accPhone ;
            System.debug('choosed lang=='+choosedlanguage);
            if(choosedlanguage!=null){
                acct.Translating_Language__c = choosedlanguage;
            } 
            
             if(locationId!=null){
                acct.Location_Team__c = locationId;
            } 
            
            
            //==============================
            System.debug(acct);
            System.debug(accSSN);
            System.debug(acct.SSN__c);
            
      
            // ssn validation for first page.
            if(acct.SSN__c != null && acct.SSN__c != '') {
                if(acct.SSN__c.length() < 2 ){
                    msgFlag = true;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,System.Label.SSN_is_required_In_XXX_XX_XXXX_format));
                    return null;
                }
                
                
                if(!Pattern.matches('[0-9]{9}', acct.SSN__c) ){
                    msgFlag = true;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,System.Label.SSN_is_required_In_XXX_XX_XXXX_format));
                    return null;
                }
            }
        //-=--------------     5) Create a field where SSN number can be seen completely     ----------------------------------------               
            acct.SSN_new__c = accSSN;
                
                
        //-=------------------------------------------------------       
       
            
        //======================================09-10 Employment Stage changes ======================================

            System.debug('idOfAcccount'+idOfAcccount);
            if( idOfAcccount == null )
            {
                List<account> empStageUpdateAccList = new List<account>();
                if(typeId == 'HHA')
                {
                    System.debug('recType'+recType.id);
                    for(Account accempssn :[SELECT id, Employment_Stage__c, SSN_new__c FROM Account WHERE SSN_new__c = :accSSN AND Employment_Stage__c != 'Abandoned: Duplicate' AND recordtypeid =:recType.id ])
                    {
                        accempssn.Employment_Stage__c = 'Abandoned: Duplicate';
                        empStageUpdateAccList.add(accempssn);
                        
                    }
                }
                
                 if(typeId == 'CDPAP')
                {
                    for(Account accempssn :[SELECT id, Employment_Stage__c, SSN_new__c FROM Account WHERE SSN_new__c = :accSSN AND Employment_Stage__c != 'Abandoned: Duplicate' AND recordtypeid =:recType.id ])
                    {
                        accempssn.Employment_Stage__c = 'Abandoned: Duplicate';
                        empStageUpdateAccList.add(accempssn);
                        
                    }
                }
                if(empStageUpdateAccList.size()>0)
                {
                    update empStageUpdateAccList;
                }
                    
            }
            //======================================09-10 Employment Stage changes ======================================
            upsert acct ;
            if(idOfAcccount == null)
                idOfAcccount = acct.id;
            PageReference parentPage ;
            if(reviewAccountId != null){
                parentPage = new PageReference('/apex/ReviewPage?id='+idOfAcccount+'#personalInfoId');//+'#personalInfoId'
            }
            else
            { 
                if(reviewforcdpapAccountId != null)
                {
                    parentPage = new PageReference('/apex/ReviewForCDPAPForm?id='+idOfAcccount+'#personalInformationId');
                }
                else
                {
                    if(typeId == 'HHA')
                    {
                        if(acct.IsTestSolved__c == false)
                            parentPage = new Pagereference('/apex/ShowQuestionsPage?id='+idOfAcccount);
                            
                        else
                            parentPage = new Pagereference('/apex/FingerPrintPIF_Form?id='+idOfAcccount);
                    }
                    else{
                        parentPage = new Pagereference('/apex/EmercontForCDPAP?id='+idOfAcccount);
                        
                    }
                }
            }
            
            parentPage .setRedirect(true);
            return parentPage ; 
            
        }
        catch(Exception e) {
            System.debug(''+e.getMessage()+'\t'+e.getLineNumber());
          //  msgFlag = true;
          //  ApexPages.addMessages(e);
            return null;
        }  
        return null;
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
                if(idOfAcccount!=null){
                    if(acct.IsAllInformationFilled__c == false)
                        delete acct;
                }
                page = new Pagereference('/apex/WelcomePage');
            }
        }
        page.setRedirect(true);
        return page;   
    }
    
    public PageReference previousFromPIF(){
        try{
            if(acct.IsAllInformationFilled__c == false)
                delete acct;
        }
        catch(Exception ex){
            
        }     
        PageReference parentPage ;
        parentPage = new PageReference('/apex/WelcomePage');
        parentPage.setRedirect(true);
        return parentPage;
    } 
    
    public void changeSalutation(){
        if(idOfAcccount!=null)
            acct.Salutation = accSalutation;
    }
    
    public void zipAddress(){
       
        addList = new List<Address__C>();
        addtakeState = 'State not found';
        addtakeCity = 'City not found';
       
        String tempzip = accMailingZip.trim(); 
        addList = [SELECT Id,City__c,State__c,Zip__c FROM Address__c WHERE Zip__C =:tempzip LIMIT 1];
        System.debug('size== '+addList.size());
        if(addList.size()>0){
            addtakeState = addList[0].State__c;
            addtakeCity = addList[0].City__c;
        }
        
    }
    
    public void zipSuggestion()
    {
        zipaddList = new list<String>();
        templist = new list<Address__C>();
        String sql = 'SELECT Id,Zip__c FROM Address__c WHERE Zip__C Like \'%'+accMailingZip+'%\' limit 10000';
        templist = database.query(sql);
        for(Address__c  ac:templist )
        {
            zipaddList.add((ac.Zip__c).trim());
        }
      
    }
    
    
    
    
    static String capitalizeWords(String input)
    {
        String output = '';
        if(input!=null)
        {
            Matcher m = Pattern.compile('(\\w+|\\W+)').matcher(input);
            while (m.find()) output += m.group().capitalize();
            System.debug('output---'+output);
        }
        return output;
        
        
    }
    
    
}