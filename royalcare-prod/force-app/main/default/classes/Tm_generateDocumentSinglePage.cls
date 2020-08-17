public class Tm_generateDocumentSinglePage {
    public List<Contact> conList {get;set;}
  /*  public List<Employer__c> empList{get;set;}
    public List<Language__c> langList{get;set;}
    public List<Education__c> eduList{get;set;}
    public List<Emergency_Contact__c> emgencyContactList{get;set;}*/
    public List<Reference_Form__c> refList{get;set;}
  /*  Public String hEPASSNY{get;set;}
    Public String hEPADateY{get;set;}
    Public String hEPASSNN{get;set;}
    Public String hEPADateN{get;set;}*/
    public String  accId;
    public Account acc;
    
    public Tm_generateDocumentSinglePage(ApexPages.StandardController controller) {
        accId = ApexPages.currentPage().getParameters().get('id');
        conList =[Select id,MailingStreet,MailingCity,MailingState,MailingPostalCode,MobilePhone,Email,Birthdate from Contact where AccountId =:accId  ];
        
        refList =[Select id, name,Comments__c,Date_Employed_From__c,Date_Employed_To__c,Final_Date__c,Final_Title__c,No_Hire__c,No_Hire_Comments__c,Position_held__c,Reason_For_Leaving__c,Would_You_Hire_Rehire_Fornula__c,Would_You_Hire__c From Reference_Form__c where Account__c=:accId ];
        
         acc = [SELECT id ,Firstname, LastName,PERSONAL_ASSISTANT_S_CHOICES__c,HEPATITIS_SSN__c,HEPATITIS_Form_Date__c FROM Account WHERE id =: accId] ;
        
       // getAttachment();
        
    }
    
    public pageReference getAttachment(){
        try{
            
            PageReference p1 = new PageReference('/apex/TM_generateDocument?id='+ accId);
            
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
            att.ParentId = accId;
            att.name = acc.Firstname+' '+acc.LastName+'Referance' +'.pdf';
            att.body = content;
            att.ContentType = 'application/pdf';
            System.debug('I am here');
            insert att;
           // return null;
           PageReference page = new PageReference('/' + accId);
            page.setRedirect(true);
            return null;   
        }
        catch(Exception e) {
            //msgFlag = true;
            ApexPages.addMessages(e);
            return null;
        }  
        
        
    }
}