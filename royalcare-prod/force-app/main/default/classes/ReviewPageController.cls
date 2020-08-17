Public class ReviewPageController{
    public List<Employer__c> listOfEmployer{get;set;}
    public List<Emergency_Contact__c > listOfEmployerContacts{get;set;}
    public List<Language__c> listOfLanguage{get;set;}
    public List<Education__c> listOfEducationRecord{get;set;}
    public String accountId{get;set;}
    public Education__c  educationRecord{get;set;}
    public Consumer_Information__c consumer {get;set;}
    public List<Consumer_Information__c> listOfConsumers {get;set;}
    public Account acc{get;set;}
    public Boolean msgFlag{get;set;}
    public Account tempAcc{get;set;}
    
    public ReviewPageController(ApexPages.StandardController sc){
         tempAcc = new Account();
        msgFlag = false;
        accountId = sc.getId();
        listOfEmployer = new List<Employer__c> ();
        listOfEmployerContacts =  new List<Emergency_Contact__c >();
        listOfLanguage = new List<Language__c>();
        educationRecord = new Education__c ();
        System.debug(accountId);
        if(accountId != null){ 
            acc = [select id,Firstname,LastName,MiddleName,PersonContactID,PersonEmail, Representative__c, Applicant_SSN__c,Translating_Language__c, IsAllInformationFilled__c, Applicant_Date__c,OwnerId,Owner.Name,LastModifiedDate,LastModifiedById,PersonBirthdate from Account Where Id =:accountId limit 1];
            System.debug(acc.Applicant_SSN__c);
            if(acc.Applicant_Date__c == NULL) {
                acc.Applicant_Date__c= Date.parse(Date.today().format());
            }
            else{
                acc.Applicant_Date__c= Date.parse(acc.Applicant_Date__c.format());
            }
            
            listOfEmployer = [Select Id,Name,Phone__c,Employed_From_Date__c,Employed_To_Date__c,Work_Performed__c,Street_Address__c,Street_Address_2__c,City__c,State__c,Postal_Code__c,Job_Title__c,Hourly_Rate_Salary_Starting__c,Hourly_Rate_Salary_Final__c,Supervisor_Title__c,Reason_for_leaving__c,Can_be_contacted__c,Company__c From Employer__c where Applicant__c=:accountId ];
            listOfEmployerContacts  = [Select id,Name,Account__c,Emp_LastName__c,RelatioshipNew__c,HomePhone__c,CellPhone__c,Street__c,City__c,State__c,Zip__c,Email__c from Emergency_Contact__c Where Account__c =:accountId  ];
            listOfLanguage = [Select Id,Name,Reading_capabilities__c,Spoken_skill_level__c,Writing_capabilites__c  from  Language__c Where  Account__c =:accountId];
            listOfEducationRecord =[Select Id,Account__c,School_Name__c,Year_Completed__c,Diploma_Degree__c,Type__c ,Describe_Course_of_Study__c,Describe_Specialized_Training__c from Education__c Where (Account__c  != null and Account__c =:accountId)]; 
            listOfConsumers = [select id, Name, Consumer_Number__c, Street__c, City__c, State__c, Zip__c,
                           Cannot_be_paid_to_work_as_a_PA__c, Disclose_to_Royal_Care__c, Identify_relationship_with_consumer__c,
                           Related_to_the_consumer__c, Reside_at_consumer_address__c,Relationship_with_Consumer__c,Consumer_SSN_for_Validation__c,
                           Consumer_Surrogate_SSN__c, Consumer_Surrogate_Date__c, Representative__c from Consumer_Information__c where Account__c =:accountId];
            if(listOfConsumers.size()>0)
            {
                consumer = listOfConsumers[0];
            }
           
        }
        tempAcc.Applicant_SSN__c = acc.Applicant_SSN__c;
        System.debug(acc.Applicant_SSN__c+'acc.Applicant_SSN__c');
        tempAcc.Applicant_Date__c = acc.Applicant_Date__c;
        tempAcc.IsAllInformationFilled__c = acc.IsAllInformationFilled__c;
        tempAcc.Representative__c = acc.Representative__c;
       
    }
    
    public pageReference redirectOnApplicantStmt(){
        try{
             Account userUpdatedValue = new Account();
            
            userUpdatedValue.Applicant_SSN__c = tempAcc.Applicant_SSN__c ;
            userUpdatedValue.Applicant_Date__c = tempAcc.Applicant_Date__c ;
            
            tempAcc = acc.clone();
            tempAcc.Id = accountId;
            
            System.debug( tempAcc.Applicant_SSN__c+' tempAcc.Applicant_SSN__c');
            tempAcc.Applicant_SSN__c = userUpdatedValue.Applicant_SSN__c;
            tempAcc.Applicant_Date__c = userUpdatedValue.Applicant_Date__c ;
            tempAcc.IsAllInformationFilled__c = true;
            
            update tempAcc;
                        
          //  PageReference p1 = new PageReference('/apex/TM_generateDocument?id='+ accountId);
            PageReference p1 ;
            if(acc.Translating_Language__c == 'en' )
            p1 = new PageReference('/apex/TM_generateDocument?id='+ accountId);
            if(acc.Translating_Language__c == 'es' )
            p1 = new PageReference('/apex/TM_generateDocumentSpanish?id='+ accountId); 
            if(acc.Translating_Language__c == 'ru' )
            p1 = new PageReference('/apex/TM_generateDocumentRussian?id='+ accountId); 
            if(acc.Translating_Language__c == 'zh_CN' )
            p1 = new PageReference('/apex/TM_generateDocumentChinese?id='+ accountId); 
          
            
            Blob content;
            if(Test.IsrunningTest()) 
            {
              content = Blob.valueOf('test');
            }
            else
            { 
              content = p1.getContentAsPdf();
            }
            Attachment att = new Attachment();
            att.ParentId = accountId;
            att.name = acc.Firstname+' '+acc.LastName+'.pdf';
            att.body = content;
            att.ContentType = 'application/pdf';
            insert att;
            
         //   list<contact> contactList = [SELECT id FROM contact WHERE Name = 'Sertify Signer'  LIMIT 1];
         
       //  System.debug('tempAcc.PersonContactID' + tempAcc.PersonContactID);
            Sertifi2_0__TestContract__c eContract_Inserted = new Sertifi2_0__TestContract__c();
             //================================
            Contact con = new Contact();
            con.FirstName = acc.FirstName;
            con.LastName = acc.LastName;
            con.Email = acc.PersonEmail;
            String em = acc.PersonEmail;
            System.debug('----------------------------'+acc.PersonEmail);
            if(em==null)
                 con.Email = 'isaac@royalcare.nyc';//'sfuser.royalcare@technomile.com';
            //con.AccountId = acc.id;
            insert con;
            System.debug('con' + con);
            
            //=========================
            
                eContract_Inserted  = insertEContract(accountId, con.id, att.id);//contactList[0].id
          
            
         
           PageReference page = new PageReference('/apex/Final_Submission_Form?id=' + accountId+'&econtractid='+eContract_Inserted.id+'&contactid='+con.id);
            page.setRedirect(true);
            return page;   
        }
        catch(Exception e) {
            //msgFlag = true;
            ApexPages.addMessages(e);
            return null;
        }  
    }
    
    public Sertifi2_0__TestContract__c  insertEContract(id AccountId, id contactId, id attachmentId)
    {
        Sertifi2_0__TestContract__c eContract = new Sertifi2_0__TestContract__c();
        eContract.name = acc.Firstname+' '+acc.LastName+'-'+String.valueOf(System.now());
        eContract.Sertifi2_0__Account__c = AccountId;
        Account acnew = [SELECT Id, Name,Location_Team__c FROM Account WHERE Id =:AccountId LIMIT 1];
        eContract.Sertifi2_0__Settings__c = 'Settings';
        
        if(acnew.Location_Team__c == 'OnlineUser')
        {
              eContract.Sertifi2_0__Redirect_On_Signing_Page_Action__c = 'https://royalcare.secure.force.com/application/cdpapapplication';
        }
        else
        {
        //============
        eContract.Sertifi2_0__Redirect_On_Signing_Page_Action__c = 'http://royalcare.force.com/application/WelcomePage';
        //==============
        }
        insert eContract;
        
        insertEDocument(eContract.Id, AccountId, attachmentId);
        insertSigner(contactId, eContract.id);
        
        return eContract;
        
    }    
    
    public Sertifi2_0__ContractContactJunction__c insertSigner(id contactId, id eContractId)
    {
        Sertifi2_0__ContractContactJunction__c signer = new Sertifi2_0__ContractContactJunction__c();
        signer.Sertifi2_0__Contact__c = contactId;
        signer.Sertifi2_0__TestContract__c = eContractId;
        signer.Sertifi2_0__Signer_Order__c = 1;
        
        insert signer; 
        
        
        
        return signer;
        
        
    }
    
    public Sertifi2_0__EDocument__c insertEDocument(id eContractId, id AccountId, id attachmentId)
    {
        Sertifi2_0__EDocument__c eDocument = new Sertifi2_0__EDocument__c();
        eDocument.Sertifi2_0__TestContract__c = eContractId;
        eDocument.Sertifi2_0__Document_Type__c = 'Signing Document';
       // eDocument.Sertifi2_0__Name__c = 'sertifi_demo.pdf';
        eDocument.Sertifi2_0__Name__c = acc.Firstname+'_'+acc.LastName+'.pdf';
        insert eDocument;
        
        list<Attachment> AttachmentList = [SELECT id, name, body, contentType FROM Attachment WHERE id =: attachmentId];
        if(AttachmentList.size() > 0)
        {
            Attachment eDocumentAttachment = new Attachment();
            eDocumentAttachment = AttachmentList[0].clone();
            eDocumentAttachment.parentId = eDocument.id;
            
            insert eDocumentAttachment;
        }
        
        return eDocument;
    }
    
    public pageReference cancel(){  
        try{
            //System.debug('I am in cancel');
            if(acc.IsAllInformationFilled__c==false)
                delete acc;
            
            PageReference page;
            page = new Pagereference('/apex/WelcomePage');
            // System.debug('I am in cancel');
            page.setRedirect(true);
            return page;
        } catch(Exception e) {
            //msgFlag = true;
            ApexPages.addMessages(e);
            return null;
        }
    }
  /*  
     public PageReference cancelsession(){  
        try{
            //System.debug('I am in cancel');
            if(acc.IsAllInformationFilled__c==true)
            { 
            
            PageReference page;
            page = new Pagereference('/apex/WelcomePage');
            // System.debug('I am in cancel');
            page.setRedirect(true); 
            return page;
            }
            else
                 return null;
        } catch(Exception e) {
            //msgFlag = true;
            ApexPages.addMessages(e);
            return null;
        }
    }
    */
    public pageReference cancelForCDPAP(){   
        try{
            
            PageReference page;
            if(acc.IsAllInformationFilled__c==false)
                delete acc;
            page = new Pagereference('/apex/WelcomePage');
            page.setRedirect(true);
            return page; 
        } catch(Exception e) {
            //msgFlag = true;
            ApexPages.addMessages(e);
            return null;
        }
    }
    
    public pageReference redirectOnFinalPage(){  
        try{
            
          /*   tempAcc = acc.clone();
            tempAcc.Id = accountId;
            tempAcc.IsAllInformationFilled__c = true;*/
            
             Account userUpdateValue = new Account();
            userUpdateValue = acc.clone();
            userUpdateValue.id = accountId;
            
            userUpdateValue.IsAllInformationFilled__c = true;
            userUpdateValue.Representative__c = tempAcc.Representative__c;   
            update userUpdateValue;
            PageReference p1 ;
            /*if(acc.Translating_Language__c != 'es' )
            p1 = new PageReference('/apex/TM_generateDocumentForCDPAP?id='+ accountId);
            else
            p1 = new PageReference('/apex/TM_generateDocumentForCDPAPspanish?id='+ accountId); */
            
            if(acc.Translating_Language__c == 'en' )
            p1 = new PageReference('/apex/TM_generateDocumentForCDPAP?id='+ accountId);
            if(acc.Translating_Language__c == 'es' )
            p1 = new PageReference('/apex/TM_generateDocumentForCDPAPspanish?id='+ accountId); 
            if(acc.Translating_Language__c == 'ru' )
            p1 = new PageReference('/apex/TM_generateDocumentForCDPAPRussian?id='+ accountId); 
            if(acc.Translating_Language__c == 'zh_CN' )
            p1 = new PageReference('/apex/TM_generateDocumentForCDPAPChinese?id='+ accountId); 
           
            Blob content;
        if(Test.IsrunningTest()) 
        {
          content = Blob.valueOf('test');
        }
        else
        { 
          content = p1.getContentAsPdf();
        }
        Attachment att = new Attachment();
        att.ParentId = accountId;
        att.name = acc.Firstname+' '+acc.LastName+'.pdf';
        att.body = content;
        att.ContentType = 'application/pdf';
        insert att;
          //upsert consumer;
             System.debug('acc.PersonContactID'+acc.PersonContactID);
             
          //================================
            Contact con = new Contact();
            con.FirstName = acc.FirstName;
            con.LastName = acc.LastName;
            con.Email = acc.PersonEmail;
            String em = acc.PersonEmail;
            System.debug('----------------------------'+acc.PersonEmail);
            if(em==null)
                 con.Email = 'isaac@royalcare.nyc';//'sfuser.royalcare@technomile.com';
            //con.AccountId = acc.id;
             System.debug('----------------------------'+acc.PersonEmail);
            insert con;
            System.debug('con' + con);
            
            //=========================
            Sertifi2_0__TestContract__c eContract_Inserted = new Sertifi2_0__TestContract__c();
            
                eContract_Inserted  = insertEContract(accountId, con.id, att.id);//contactList[0].id
          
            
         
           PageReference page = new PageReference('/apex/Final_Submission_Form?id=' + accountId+'&econtractid='+eContract_Inserted.id+'&contactid='+con.id);
        
            
            page.setRedirect(true);
            return page; 
        }
        catch(Exception e) {
            msgFlag = true;
            ApexPages.addMessages(e);
            return null;
        }  
    }
   
    
}