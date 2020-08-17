public with sharing class Tm_generateDocument {
    public List<Contact> conList {get;set;}
    public List<Employer__c> empList{get;set;}
    public List<Language__c> langList{get;set;}
    public List<Education__c> eduList{get;set;}
    public List<Consumer_Information__c> consuList{get;set;}
    public List<Emergency_Contact__c> emgencyContactList{get;set;}
    public List<Reference_Form__c> refList{get;set;}
    public String trnsLang{get;set;} 
    Public String hEPASSNY{get;set;}
    Public String hEPADateY{get;set;}
    Public String hEPASSNN{get;set;}
    Public String hEPADateN{get;set;}
    
    public Tm_generateDocument(ApexPages.StandardController controller) {
        hEPADateN = '';
        String  accId = ApexPages.currentPage().getParameters().get('id');
        conList =[Select id,MailingStreet,MailingCity,MailingState,MailingPostalCode,MobilePhone,Email,Birthdate from Contact where AccountId =:accId  ];
        empList =[Select id,name,Can_be_contacted__c,City__c,Company__c,Employed_From_Date__c,Employed_To_Date__c,Hourly_Rate_Salary_Final__c,Hourly_Rate_Salary_Starting__c,
                  Job_Title__c,Name_of_supervisor__c,Phone__c,Postal_Code__c,Supervisor_Title__c,Work_Performed__c,Reason_for_leaving__c   from Employer__c where Applicant__c=:accId];
        langList =[Select id,name,Reading_capabilities__c,Spoken_skill_level__c,Writing_capabilites__c from Language__c where Account__c=:accId];    
        eduList =[Select id, name,School_Name__c,Type__c,Diploma_Degree__c,Describe_Course_of_Study__c ,Describe_Specialized_Training__c from Education__c where Account__c=:accId ];      
        emgencyContactList= [Select id, name,CellPhone__c,City__c,Date__c,Email__c,HomePhone__c,Emp_LastName__c,RelatioshipNew__c,State__c,Street__c,Zip__c From Emergency_Contact__c where Account__c=:accId ];
        refList =[Select id, name,Comments__c,Date_Employed_From__c,Date_Employed_To__c,Final_Date__c,Final_Title__c,No_Hire__c,No_Hire_Comments__c,Position_held__c,Reason_For_Leaving__c,Would_You_Hire_Rehire_Fornula__c,Would_You_Hire__c From Reference_Form__c where Account__c=:accId ];
        consuList = [Select id, Name, Consumer_Number__c, Street__c, City__c, State__c, Zip__c,
                           Cannot_be_paid_to_work_as_a_PA__c, Disclose_to_Royal_Care__c, Identify_relationship_with_consumer__c,
                           Related_to_the_consumer__c, Reside_at_consumer_address__c,Relationship_with_Consumer__c,Consumer_SSN_for_Validation__c,
                           Consumer_Surrogate_SSN__c, Consumer_Surrogate_Date__c, Representative__c FROM Consumer_Information__c where Account__c=:accId];
        if(consuList.size()==0)
        {
            Consumer_Information__c coninfo = new Consumer_Information__c();
            consuList.add(coninfo);
        }
            
        Account acc = [SELECT id , PERSONAL_ASSISTANT_S_CHOICES__c,HEPATITIS_SSN__c,HEPATITIS_Form_Date__c,Translating_Language__c FROM Account WHERE id =: accId] ;
        trnsLang = acc.Translating_Language__c;
        if(acc.PERSONAL_ASSISTANT_S_CHOICES__c == 'Yes')
        {
            hEPASSNY = acc.HEPATITIS_SSN__c;
            if(acc.HEPATITIS_Form_Date__c!=null)
            hEPADateY = acc.HEPATITIS_Form_Date__c.format();
            hEPASSNN = '';
            
        }
        else
        {
           hEPASSNY = '';
           
            hEPASSNN = acc.HEPATITIS_SSN__c;
            if(acc.HEPATITIS_Form_Date__c!=null)
            hEPADateN = acc.HEPATITIS_Form_Date__c.format();
 
        }
        
        
        
    }
    
}