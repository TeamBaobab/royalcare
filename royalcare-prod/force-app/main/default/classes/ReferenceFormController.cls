Public class ReferenceFormController {
    
    public Reference_Form__c referenceRecord{get;set;}
    public Employer__c employerRecord{get;set;}
    public List<Employer__c> listOfEmployer{get;set;}
    public List<Employer__c  > listOfemployerToDelete;
    public boolean hireBoolean{get;set;}
    public boolean noHireBoolean{get;set;}
    public Id accountIds;
    public Integer rowNum{get;set;}
    public String accId;
    public String referenceId;
    public Integer currentIndex{get;set;}
    public Account acc{get;set;}
    public boolean check{get;set;}
    public Boolean msgFlag{get;set;}
    
    
    
    public ReferenceFormController (ApexPages.StandardController controller ){
        msgFlag = false;
        referenceRecord =  new Reference_Form__c();
        listOfEmployer =  new List<Employer__c>();
        listOfemployerToDelete = new List<Employer__c> ();
        
        accId = ApexPages.currentPage().getParameters().get('id');
        check = true;
        if(accId == null){
            referenceId = ApexPages.currentPage().getParameters().get('pid');
            if(referenceId != null )
                check = false;
            if(referenceId  != null){
                //referenceRecord= [Select id ,Name,Account__r.Name,SSN_Code__c,Position_held__c,Date_Employed_From__c,Date_Employed_To__c ,Final_Title__c ,Comments__c,Reason_For_Leaving__c,Would_You_Hire__c,No_Hire__c,No_Hire_Comments__c,Final_Date__c From Reference_Form__c  Where Id=:referenceId Limit 1];
                List<Reference_Form__c>  listOfreferenceRecord= [Select id ,Name,Account__r.Name,SSN_Code__c,Position_held__c,Date_Employed_From__c,Date_Employed_To__c ,Final_Title__c ,Comments__c,Reason_For_Leaving__c,Would_You_Hire__c,No_Hire__c,No_Hire_Comments__c,Final_Date__c From Reference_Form__c  Where Account__c=:referenceId Limit 1];
                if(ListOfreferenceRecord != null && ListOfreferenceRecord.size() > 0){
                    referenceRecord =ListOfreferenceRecord[0];
                }
                accId=referenceId  ;
                acc = [SELECT Id,Translating_Language__c,IsAllInformationFilled__c FROM Account WHERE Id =:accId];
                listOfEmployer = [Select Id,Name,Phone__c,To__c,From__c,Employed_From_Date__c,Employed_To_Date__c,Work_Performed__c,Street_Address__c,Street_Address_2__c,City__c,State__c,Postal_Code__c,Job_Title__c,Hourly_Rate_Salary_Starting__c,Hourly_Rate_Salary_Final__c,Supervisor_Title__c,Reason_for_leaving__c,Can_be_contacted__c,Company__c From Employer__c where Applicant__c=:accId ];
                if(listOfEmployer.isEmpty()){
                    
                    employerRecord = new Employer__c ();
                    //employerRecord.Applicant__c = accountIds;
                    employerRecord.Applicant__c = accId;
                    //employerRecord.IsApexCreate__c =true;
                    listOfEmployer.add(employerRecord); 
                    System.debug('listOfEmployer 2:::'+listOfEmployer);
                }
            }
        }
        else{
            System.debug('accId ::'+accId +'  referenceId::'+referenceId );
            hireBoolean = false;
            noHireBoolean =  false;
            accountIds= accId;
            List<Reference_Form__c> listOfreferenceRecord = [Select id ,Name,Account__r.Name,SSN_Code__c,Position_held__c,Date_Employed_From__c,Date_Employed_To__c ,Final_Title__c ,Comments__c,Reason_For_Leaving__c,Would_You_Hire__c,No_Hire__c,No_Hire_Comments__c,Final_Date__c From Reference_Form__c  Where Account__c=:accountIds Limit 1];
            if(ListOfreferenceRecord != null && ListOfreferenceRecord.size() > 0){
                referenceRecord =ListOfreferenceRecord[0];
            }
            listOfEmployer =[Select Id,Name,To__c,From__c,Phone__c,Employed_From_Date__c,Employed_To_Date__c,Work_Performed__c,Street_Address__c,Street_Address_2__c,City__c,State__c,Postal_Code__c,Job_Title__c,Hourly_Rate_Salary_Starting__c,Hourly_Rate_Salary_Final__c,Supervisor_Title__c,Reason_for_leaving__c,Can_be_contacted__c,Company__c From Employer__c where Applicant__c=:accId];
            System.debug('listOfEmployer 1 :::'+listOfEmployer);
            if(listOfEmployer.isEmpty()){
                employerRecord = new Employer__c ();
                employerRecord.Applicant__c = accountIds;
                //employerRecord.IsApexCreate__c =true;
                listOfEmployer.add(employerRecord); 
                System.debug('listOfEmployer 2:::'+listOfEmployer);
            }
            
            referenceRecord.Account__c =accountIds;
            acc = [SELECT Id,Translating_Language__c,IsAllInformationFilled__c FROM Account WHERE Id =:accountIds];
        } 
    }
    
    public void addNew(){
        try{
            employerRecord =  new Employer__c ();
            employerRecord.Applicant__c = accId ;
            //employerRecord.IsApexCreate__c =true; 
            listOfEmployer.add(employerRecord); 
            System.debug('listOfEmployer::'+listOfEmployer);
        }
        catch(Exception ex){
            System.debug('Error message in add row'+ex.getMessage());
        }
    }
    
    public void delRow(){
        integer listSize =listOfEmployer.size() -1; 
        System.debug('listSize :::'+listSize );
        //listOfemployerToDelete = new List<Employer__c>();
        //if(listSize != null && listSize >0) {
        if(listSize != null) {
            Employer__c employerRecord = listOfEmployer[listSize];
            listOfemployerToDelete.add(employerRecord ); 
            listOfEmployer.remove(listSize);
            //if(employerRecord != null && employerRecord.Name != null)
            //delete employerRecord;
        }
        if(listSize==0){
            
            employerRecord = new Employer__c();
            employerRecord.Applicant__c = accountIds;
            listOfEmployer.add(employerRecord); 
        }
        system.debug('listOfEmployer'+listOfEmployer);
    }
    
    public void delCurrentRow(){
        integer listSize =listOfEmployer.size() -1; 
        System.debug('listSize :::'+listSize );
        //listOfemployerToDelete = new List<Employer__c>();
        //  if(listSize != null && listSize >0) {
        if(listSize != null) {
            Employer__c employerRecord = listOfEmployer[currentIndex-1];
            listOfemployerToDelete.add(employerRecord ); 
            listOfEmployer.remove(currentIndex-1);
            //if(employerRecord != null && employerRecord.Name != null)
            //delete employerRecord;
        }
        if(listSize==0){
            
            employerRecord = new Employer__c();
            employerRecord.Applicant__c = accountIds;
            listOfEmployer.add(employerRecord); 
        }
        system.debug('listOfEmployer'+listOfEmployer);
    }
    
    public pageReference saveReferenceData(){
        try
        {
            //   System.debug('toDate' + toDate);
            //   System.debug('fromDate' + fromDate);
            List<Integer> indexEmpRecList = new List<Integer>();
            System.debug('listOfEmployer='+listOfEmployer);
            for(Integer i =0;i<listOfEmployer.size();i++){
                Employer__c empRec = listOfEmployer.get(i);
                // if(empRec.Name == null && (empRec.Applicant__c != null || empRec.Applicant__c == null)){
                if(empRec.Name == null){
                    indexEmpRecList.add(i);
                }
            }
            System.debug('indexEmpRecList=='+indexEmpRecList.size()+indexEmpRecList);
            for(Integer i =0;i<indexEmpRecList.size();i++){
                listOfEmployer.remove(indexEmpRecList.get(i));
                System.debug('listOfemployerToDelete=='+listOfemployerToDelete);
            }
            indexEmpRecList = new List<Integer>();
            if(!listOfemployerToDelete.isEmpty()){
                for(Integer i =0;i<listOfemployerToDelete.size();i++){
                    Employer__c empRec = listOfemployerToDelete.get(i);
                    if(empRec.Name == null){
                        indexEmpRecList.add(i);
                    }
                }
            }
            for(Integer i =0;i<indexEmpRecList.size();i++){
                if(!listOfemployerToDelete.isEmpty()){
                    listOfemployerToDelete.remove(indexEmpRecList.get(i));
                }
            }
            System.debug('listOfEmployer='+listOfEmployer.size()+listOfEmployer);
            if(listOfEmployer != null && listOfEmployer.size() >0){
                for(Employer__c em:listOfEmployer)
                {
                    String from1 = em.From__c;
                    
                    String[] tempdate;
                    Date myDate;
                    //==================================
                    if(from1!=null)
                    {
                        tempdate =  from1.split('/');
                        
                        //System.debug('date-----'+tempdate.size());
                        if(tempdate.size()>0)
                        {
                            if(Integer.valueOf(tempdate[1])>31 || Integer.valueOf(tempdate[0])>12 || Integer.valueOf(tempdate[1]) == 0 || Integer.valueOf(tempdate[0]) == 0)
                            {
                                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,System.Label.Invalid_Date));
                                return null;
                            }
                            myDate = date.newinstance(Integer.valueOf(tempdate[2]),Integer.valueOf(tempdate[0]), Integer.valueOf(tempdate[1]));
                        }
                        if(myDate!=null)
                        {
                            em.Employed_From_Date__c = myDate;
                        }
                    }
                    //==============================
                    
                    
                    
                    String to = em.To__c;
                    String[] tempdateTo;
                    Date myDateTo;
                    //==================================
                    if(to!=null)
                    {
                        tempdateTo =  to.split('/');
                        
                        System.debug('tempdateTo-----'+tempdateTo.size());
                        if(tempdateTo.size()>0)
                        { 
                            
                             if(Integer.valueOf(tempdateTo[1])>31 || Integer.valueOf(tempdateTo[0])>12 ||Integer.valueOf(tempdateTo[1]) == 0 || Integer.valueOf(tempdateTo[0]) == 0)
                            {
                                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,System.Label.Invalid_Date));
                                return null;
                            }
                            System.debug('myDateTo'+myDateTo);
                            myDateTo = date.newinstance(Integer.valueOf(tempdateTo[2]),Integer.valueOf(tempdateTo[0]), Integer.valueOf(tempdateTo[1]));
                        }
                        if(myDateTo!=null)
                        {
                            
                            em.Employed_To_Date__c =myDateTo;
                        }
                    }
                }
                upsert listOfEmployer;
            }
            System.debug('==============>'+listOfemployerToDelete);
            if(listOfemployerToDelete != null){
                delete listOfemployerToDelete;
            }
        }
        catch(Exception e) {
            msgFlag = true;
            ApexPages.addMessages(e);
            return null;
        }  
        PageReference page;
        if(referenceId !=null){
            page = new Pagereference('/apex/ReviewPage?id='+accId+'#referenceFormId');
        }
        else{
            page = new Pagereference('/apex/PhotoIdAck_Form?id='+accId);
        }
        page.setRedirect(true);
        return page;     
    }
    
    public pageReference cancel(){
        PageReference page;
        if(referenceId !=null){
            page = new Pagereference('/apex/ReviewPage?id='+accId);
        }
        else{
            // page = new Pagereference('/'+accId);
            if(acc.IsAllInformationFilled__c==false)
                delete acc;
            page = new Pagereference('/apex/WelcomePage');
        }
        page.setRedirect(true);
        return page;   
    }
    
    
    
    public PageReference previousFromRF(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/Language_Form?id='+accId);
        parentPage.setRedirect(true);
        return parentPage;
    }
}