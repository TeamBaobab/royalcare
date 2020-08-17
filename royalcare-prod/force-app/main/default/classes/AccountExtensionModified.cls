public without sharing class AccountExtensionModified {
    public Account acct{get;set;}
    public Account tempAcc{get;set;}
    public Account acc{get;set;}//use for getting name
    public String hIVMedicaRCS_Date {get;set;}
    public String photoIAck_Date {get;set;}
    public String nYSDOH_Date {get;set;}
    public String hHA_Pledge_Date {get;set;}
    public String hHA_Attestation_Date {get;set;}
    public String deficitReductionActDate {get;set;}
    public String PAAckReceiptDate {get;set;}
    Public Boolean btest {get;set;}
    public String choosedlanguage{get; set;}
    public String reviewAccountId;
    public String reviewforcdpapAccountId;
    public Boolean check{get;set;}
    public Boolean msgFlag{get;set;}
    public String accountId;
    Public String predateApp{get;set;}
    Public String predateEmp{get;set;}
    Public String avlWorkDate{get;set;}
   // Public String checktest{get;set;}
     public String selectedValue { get; set; }
    public String selectedValue1 { get; set; }
    
    public AccountExtensionModified(ApexPages.StandardController stdController) {
        
        msgFlag = false;
        tempAcc = new Account();
        choosedlanguage = ApexPages.currentPage().getParameters().get('lid');
        System.debug('choosedlanguage==>'+choosedlanguage);
        
        accountId = ApexPages.currentPage().getParameters().get('id');
        
        
        
        reviewforcdpapAccountId = ApexPages.currentPage().getParameters().get('reviewforcdpapid');
        reviewAccountId= ApexPages.currentPage().getParameters().get('reviewid');
        check = true;
        
        if(reviewforcdpapAccountId != null || reviewAccountId != null)
            check = false;
        
        System.debug('d=='+accountId);
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
                PA_Ack_Receipt_SSN__c, PA_Ack_Receipt_Date__c,Translating_Language__c,Location_Team__c 
                //-----------------------------
                ,Do_have_a_final_finding_of_patient__c,Do_not_have_a_final_finding_of_patient__c,Have_convicted_crime__c,Have_not_convicted_crime__c, Have_Do_Explanation__c
                //-----------------------------
                FROM Account Where id =:accountId];
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
        
        //FPIF
        tempAcc.Gender__c = acct.Gender__c;
        tempAcc.Race__c = acct.Race__c;
        tempAcc.Height__c = acct.Height__c;
        tempAcc.Weight__c = acct.Weight__c;
        tempAcc.Eye_Color__c =acct.Eye_Color__c;
        tempAcc.Hair_Color__c = acct.Hair_Color__c;
        
        //ApplForEmployment_Form
        tempAcc.Work_Permit_If_Under_18__c = acct.Work_Permit_If_Under_18__c;
        tempAcc.Previously_Applied__c = acct.Previously_Applied__c;
        tempAcc.Previously_filed_application_date__c = acct.Previously_filed_application_date__c;
        tempAcc.Previously_employed_here__c = acct.Previously_employed_here__c;
        tempAcc.Previously_employed_here_date__c = acct.Previously_employed_here_date__c;
        tempAcc.Immigration_Status__c = acct.Immigration_Status__c;
        tempAcc.Date_available_for_work__c = acct.Date_available_for_work__c;
        tempAcc.Avalibility__c = acct.Avalibility__c;
        tempAcc.Desired_shift__c = acct.Desired_shift__c;
        tempAcc.Felony_Conviction_within_7_years__c = acct.Felony_Conviction_within_7_years__c;
        tempAcc.Conviction_Explination__c = acct.Conviction_Explination__c;
        predateApp = String.valueOf(acct.Previously_filed_application_date__c);
        predateEmp = String.valueOf(acct.Previously_employed_here_date__c);
        avlWorkDate = String.valueOf(acct.Date_available_for_work__c);
        
        //PhotoIdAck_Form
        tempAcc.PhotoIAck_SSN__c = acct.PhotoIAck_SSN__c;
        tempAcc.PhotoIAck_Date__c = acct.PhotoIAck_Date__c;
        
        //Substance_Abuse_Relationship_Form
        tempAcc.HHA_Attestation_SSN__c = acct.HHA_Attestation_SSN__c;
        tempAcc.HHA_Attestation_Date__c = acct.HHA_Attestation_Date__c;
        tempAcc.HHA_Pledge_SSN__c = acct.HHA_Pledge_SSN__c;
        tempAcc.HHA_Pledge_Date__c = acct.HHA_Pledge_Date__c;
        
        //Substance_Abuse_Relationship_Form
        tempAcc.NYSDOH_Date__c = acct.NYSDOH_Date__c;
        tempAcc.NYSDOH_SSN__c = acct.NYSDOH_SSN__c;
        
        //HIVMedicalRCStatement 
        tempAcc.HIVMedicaRCS_SSN__c = acct.HIVMedicaRCS_SSN__c;
        tempAcc.HIVMedicaRCS_Date__c = acct.HIVMedicaRCS_Date__c;
        
        
         //DOH  Do_have_a_final_finding_of_patient__c,Do_not_have_a_final_finding_of_patient__c,Have_convicted_crime__c,Have_not_convicted_crime__c,Have_Do_Explanation__c
        if(acct.Do_have_a_final_finding_of_patient__c == true)
            selectedValue = '1';
        
        if(acct.Do_not_have_a_final_finding_of_patient__c == true)
            selectedValue = '2';
        
        if(acct.Have_convicted_crime__c == true)
            selectedValue1 = '3';
        
        if(acct.Have_not_convicted_crime__c == true)
            selectedValue1 = '4';
      
        
        
             
       // tempAcc.Do_not_have_a_final_finding_of_patient__c = acct.Do_not_have_a_final_finding_of_patient__c;
      //  tempAcc.Have_convicted_crime__c = acct.Have_convicted_crime__c;
       // tempAcc.Have_not_convicted_crime__c = acct.Have_not_convicted_crime__c;
        tempAcc.Have_Do_Explanation__c = acct.Have_Do_Explanation__c;

        
    }
    
    public PageReference previousFromFPIF(){
        PageReference parentPage ;
        
        parentPage = new PageReference('/apex/Personal_Information_Form?id='+acct.Id+'&lid='+acct.Translating_Language__c+'&tyId=HHA'+ '&loctnId=' + acct.Location_Team__c);
        
        parentPage.setRedirect(true);
        return parentPage;
    }
    
    public PageReference saveAndReturnforFPIF()
    {
        try{
            
            
            Account userUpdatedValue = new Account();
            userUpdatedValue= acct.clone();
            userUpdatedValue.id = accountId;
            userUpdatedValue.Gender__c = tempAcc.Gender__c ;
            userUpdatedValue.Race__c = tempAcc.Race__c ;
            userUpdatedValue.Height__c = tempAcc.Height__c ;
            userUpdatedValue.Weight__c = tempAcc.Weight__c ;
            userUpdatedValue.Eye_Color__c = tempAcc.Eye_Color__c ;
            userUpdatedValue.Hair_Color__c = tempAcc.Hair_Color__c ;
            
            if(userUpdatedValue.FPIFDate__c == null)
                userUpdatedValue.FPIFDate__c = Date.Today();
            
            update userUpdatedValue;
            
            PageReference parentPage ;
            if(reviewAccountId != null){
                parentPage = new PageReference('/apex/ReviewPage?id='+accountId+'#fingerprintInformationPageId');
            }
            else{
                parentPage = new PageReference('/apex/ApplForEmployment_Form?id=' + accountId);
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
    
    public PageReference previousFromAFEF(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/FingerPrintPIF_Form?id='+acct.Id);
        parentPage.setRedirect(true);
        return parentPage;
    }
    
    public PageReference saveAndReturn()
    {
        try{
            
            if(tempAcc.Previously_Applied__c != 'Yes')
                tempAcc.Previously_filed_application_date__c = null;
            if(tempAcc.Previously_employed_here__c != 'Yes')
                tempAcc.Previously_employed_here_date__c = null;
            if(tempAcc.Felony_Conviction_within_7_years__c != 'Yes')
                tempAcc.Conviction_Explination__c = '';
            btest = false;
            //=====================
            if(predateApp.length()>3)
            {
               // System.debug('predateApp'+predateApp);
                tempAcc.Previously_filed_application_date__c = convdateFormat(predateApp);
            }
            else
            {
                 tempAcc.Previously_filed_application_date__c = null;
            }
            if(predateEmp.length()>3)
            {
                System.debug('predateEmp'+predateEmp);
                tempAcc.Previously_employed_here_date__c = convdateFormat(predateEmp);
            }
            else
            {
                 tempAcc.Previously_employed_here_date__c = null;
            }
            
            
            if(avlWorkDate.length()>3)
            {
                System.debug('avlWorkDate'+avlWorkDate);
                tempAcc.Date_available_for_work__c = convdateFormat(avlWorkDate);
            }
            
              else
            {
                 tempAcc.Date_available_for_work__c = null;
            }
            
            if(tempAcc.Previously_Applied__c == 'Yes' && tempAcc.Previously_filed_application_date__c == null){
                msgFlag = true;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,System.Label.Please_enter_date_in_Previously_filed_application_date));
                btest = true;
                return null;
            }
            
            if(tempAcc.Previously_employed_here__c == 'Yes' && tempAcc.Previously_employed_here_date__c == null){
                msgFlag = true;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,System.Label.Please_enter_date_in_Previously_employed_date));
                return null;
            }
            
            if(tempAcc.Felony_Conviction_within_7_years__c == 'Yes' && tempAcc.Conviction_Explination__c == null){
                msgFlag = true;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,System.Label.Please_fill_explanation_Conviction_Explanation));
                return null;
            }
            
            Account userUpdatedValue = new Account();
            
            //ApplForEmployment_Form
            userUpdatedValue= acct.clone();
            userUpdatedValue.Id = accountId;
            userUpdatedValue.Work_Permit_If_Under_18__c = tempAcc.Work_Permit_If_Under_18__c;
            userUpdatedValue.Previously_Applied__c = tempAcc.Previously_Applied__c;
            userUpdatedValue.Previously_filed_application_date__c = tempAcc.Previously_filed_application_date__c;
            userUpdatedValue.Previously_employed_here__c = tempAcc.Previously_employed_here__c;
            userUpdatedValue.Previously_employed_here_date__c = tempAcc.Previously_employed_here_date__c;
            userUpdatedValue.Immigration_Status__c = tempAcc.Immigration_Status__c;
            userUpdatedValue.Date_available_for_work__c = tempAcc.Date_available_for_work__c;
            userUpdatedValue.Avalibility__c = tempAcc.Avalibility__c;
            userUpdatedValue.Desired_shift__c = tempAcc.Desired_shift__c;
            userUpdatedValue.Felony_Conviction_within_7_years__c = tempAcc.Felony_Conviction_within_7_years__c;
            userUpdatedValue.Conviction_Explination__c = tempAcc.Conviction_Explination__c;
            
            if(userUpdatedValue.Date_of_Application__c == null)
                userUpdatedValue.Date_of_Application__c = Date.Today();
            
            update userUpdatedValue;
            
            PageReference parentPage;
            if(reviewAccountId != null){
                parentPage = new PageReference('/apex/ReviewPage?id='+acct.Id+'#applicationForEmploymentId');
            }
            else{
                parentPage = new PageReference('/apex/Education_Form?id=' + acct.Id);
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
    
    public PageReference previousFromPIAF(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/ReferenceFormPage?id='+acct.Id);
        parentPage.setRedirect(true);
        return parentPage;
    }
    
    public PageReference saveAndReturnforPhotoIdAck()
    {
        try{
            
            Account userUpdatedValue = new Account();
            userUpdatedValue= acct.clone();
            userUpdatedValue.id = accountId;
            userUpdatedValue.PhotoIAck_Date__c = tempAcc.PhotoIAck_Date__c ;
            userUpdatedValue.PhotoIAck_SSN__c = tempAcc.PhotoIAck_SSN__c ;
            
            if(userUpdatedValue.PhotoIAck_Date__c == null)
                userUpdatedValue.PhotoIAck_Date__c = Date.Today();
            
            update userUpdatedValue;
            
            PageReference parentPage ;
            if(reviewAccountId != null){
                parentPage = new PageReference('/apex/ReviewPage?id='+acct.Id+'#photoIdentificationAckId');
            }
            else{
                parentPage = new Pagereference('/apex/Substance_Abuse_Relationship_Form?id='+acct.Id);
            }
            parentPage .setRedirect(true);
            return parentPage;
        }
        catch(Exception ex){
            msgFlag = true;
            ApexPages.addMessages(ex);
            System.debug('line number' + ex.getLineNumber() + ex.getStackTraceString() );
            return null;
        }
    }
    
    public PageReference previousFromSARF(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/PhotoIdAck_Form?id='+acct.Id);
        parentPage.setRedirect(true);
        return parentPage;
    }
    
    public PageReference saveAndReturnforSubstanceAbuse()
    {
        try{
            
            if(tempAcc.HHA_Attestation_Date__c == null)
                tempAcc.HHA_Attestation_Date__c = Date.Today();
            
            
            if(tempAcc.HHA_Pledge_Date__c == null)
                tempAcc.HHA_Pledge_Date__c = Date.Today();
            
            Account userUpdatedValue = new Account();
            userUpdatedValue = acct.clone();
            userUpdatedValue .Id = accountId;
            
            userUpdatedValue.HHA_Attestation_SSN__c = tempAcc.HHA_Attestation_SSN__c;
            userUpdatedValue.HHA_Attestation_Date__c = tempAcc.HHA_Attestation_Date__c;
            userUpdatedValue.HHA_Pledge_SSN__c = tempAcc.HHA_Pledge_SSN__c;
            userUpdatedValue.HHA_Pledge_Date__c = tempAcc.HHA_Pledge_Date__c;
            
            update userUpdatedValue ;
            
            PageReference parentPage;
            if(reviewAccountId!=null){
                parentPage= new Pagereference('/apex/ReviewPage?id='+acct.Id+'#substanceAbuseId');
            }
            else{
                parentPage = new PageReference('/apex/NYSDOH_HC_Registry_Form?id=' + acct.Id);
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
    
    public PageReference previousFromNYSDOHF(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/Substance_Abuse_Relationship_Form?id='+acct.Id);
        parentPage.setRedirect(true);
        return parentPage;
    }
    
    public PageReference saveAndReturnforNYSDOH()
    {
        try{
            Account userUpdatedValue = new Account();
            userUpdatedValue = acct.clone();
            userUpdatedValue.Id = accountId;
            
            userUpdatedValue.NYSDOH_Date__c = tempAcc.NYSDOH_Date__c;
            userUpdatedValue.NYSDOH_SSN__c = tempAcc.NYSDOH_SSN__c;
            
            if(acct.NYSDOH_Date__c == null)
                acct.NYSDOH_Date__c = Date.Today();
            update userUpdatedValue ;
            
            PageReference parentPage ;
            if(reviewAccountId != null){
                parentPage = new PageReference('/apex/ReviewPage?id='+acct.Id+'#NYSDOHId');
            }
            else{
                parentPage = new PageReference('/apex/DOHRCHRC?id='+acct.Id);
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
    
    public PageReference previousFromHIVF(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/DOHRCHRC?id='+acct.Id);
        parentPage.setRedirect(true);
        return parentPage;
    }
    
    
    public PageReference saveAndReturnforHivMedical()
    {
        try
        {
            if(tempAcc.HIVMedicaRCS_Date__c == null)
                tempAcc.HIVMedicaRCS_Date__c = Date.Today();
            Account userUpdatedValue = new Account();
            userUpdatedValue = acct.clone();
            userUpdatedValue.Id = accountId;
            
            userUpdatedValue.HIVMedicaRCS_SSN__c = tempAcc.HIVMedicaRCS_SSN__c;
            userUpdatedValue.HIVMedicaRCS_Date__c = tempAcc.HIVMedicaRCS_Date__c;
            
            update userUpdatedValue;
            
            
            PageReference parentPage ;
            if(reviewAccountId != null){
                parentPage = new PageReference('/apex/ReviewPage?id='+acct.Id+'#HIVMedicalRecordId');
            }
            else{
                parentPage = new PageReference('/apex/Acknowledgment_of_Rules_Form?id='+acct.Id);
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
    
    public Date convdateFormat (String allDate)
    {
        System.debug('allDate---'+allDate);
        String[] tempdate;
        Date myDate;
        System.debug('allDate'+allDate);
        if(allDate!=null)
        {
            tempdate =  allDate.split('/');
        }
        System.debug('date-----'+tempdate.size());
        if(tempdate.size()>0)
        {
            myDate = date.newinstance(Integer.valueOf(tempdate[2]),Integer.valueOf(tempdate[0]), Integer.valueOf(tempdate[1]));
        }
        return myDate;
    }
    
    
    
     
    
    
    
    //-----------------------------
    
    
    public PageReference previousFromDOH(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/NYSDOH_HC_Registry_Form?id='+acct.Id);
        parentPage.setRedirect(true);
        return parentPage;
    }
    
    
    public PageReference saveAndReturnforDOH()
    {
        try
        {
           //Do_have_a_final_finding_of_patient__c,Do_not_have_a_final_finding_of_patient__c,Have_convicted_crime__c,Have_not_convicted_crime__c,Have_Do_Explanation__c
            Account userUpdatedValue = new Account();
            userUpdatedValue = acct.clone();
            userUpdatedValue.Id = accountId;
            
           System.debug('selectedValue'+selectedValue);
            if(selectedValue == '1')
                userUpdatedValue.Have_convicted_crime__c = True;
            else
                userUpdatedValue.Have_convicted_crime__c = False;
            
            if(selectedValue == '2')
                userUpdatedValue.Have_not_convicted_crime__c = True;
            else
             userUpdatedValue.Have_not_convicted_crime__c = False;
            
            if(selectedValue1 == '3')
                userUpdatedValue.Do_have_a_final_finding_of_patient__c = True;
            else
                userUpdatedValue.Do_have_a_final_finding_of_patient__c = False;
            
            if(selectedValue1 == '4')
                userUpdatedValue.Do_not_have_a_final_finding_of_patient__c = True;
            else
                userUpdatedValue.Do_not_have_a_final_finding_of_patient__c = False;
            
            System.debug('selectedValue : ' + selectedValue + 'selectedValue1 : ' +selectedValue1);
            if(selectedValue == null && selectedValue1 == null)
            {
                System.debug('hii');
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,System.Label.Select_at_least_one_checkbox));
                return null;
            }
            
            
           /* userUpdatedValue.Do_not_have_a_final_finding_of_patient__c = tempAcc.Do_not_have_a_final_finding_of_patient__c;
            
            userUpdatedValue.Have_convicted_crime__c = tempAcc.Have_convicted_crime__c;
            userUpdatedValue.Have_not_convicted_crime__c = tempAcc.Have_not_convicted_crime__c;*/
            userUpdatedValue.Have_Do_Explanation__c = tempAcc.Have_Do_Explanation__c;
            
            
            update userUpdatedValue;
            
            
            PageReference parentPage ;
            if(reviewAccountId != null){
                parentPage = new PageReference('/apex/ReviewPage?id='+acct.Id+'#DOHCHRC');
            }
            else{
                parentPage = new PageReference('/apex/HIVMedicalRCStatement?id='+acct.Id);
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
    
   public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('1','Have')); 
        options.add(new SelectOption('2','Have not been convicted of a crime in New York State or any other jurisdiction')); 
        return options; 
    }   
    
     public List<SelectOption> getItems1() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('3','Do')); 
        options.add(new SelectOption('4','Do not have a final finding of patient or resident abuse')); 
        return options; 
    }   
    //-----------------------------
}