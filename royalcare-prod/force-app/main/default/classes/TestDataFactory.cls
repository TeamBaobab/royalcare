public class TestDataFactory {
    public static Account createAccountsWithHHA()
    {
        
        Account acct = new Account();
        
        acct.Translating_Language__c = 'en';
        
        RecordType recType;
        recType = [select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='account' and name = 'HHA' limit 1];
        
        acct.recordtypeid = recType.id;
        acct.Salutation =  'Mr.';
        acct.FirstName='accFname';
        acct.LastName='accLname';
        acct.MiddleName='accMiddleName';
        acct.PersonEmail='abc@gmail.com';
        acct.PersonMobilePhone='1234567890';
        acct.Position__c='developer';
        acct.PersonMailingStreet='Street';
        acct.PersonMailingCity='city';
        acct.PersonMailingState='State';
        acct.PersonMailingPostalCode='00605';
        acct.PersonMailingCountry='USA';
        acct.SSN__c =  '123456789';
        acct.Birthplace__c = 'test';
        acct.PA_SSN__c = '123456789';
        acct.Acknowledgment_of_Rules_SSN__c = '123456789';
        acct.Currently_Not_Employed__c = true;
        acct.PA_Date__c = Date.parse(Date.today().format());
        acct.Validation_Form_Date__c = Date.parse(Date.today().format());
        acct.PersonBirthDate = Date.parse(Date.today().format());
        acct.Phone = '123456789';
        
        acct.PhotoIAck_SSN__c = '123456789';
        acct.PERSONAL_ASSISTANT_S_CHOICES__c = 'No';
        acct.HEPATITIS_SSN__c = '123456789';
        acct.HEPATITIS_Form_Date__c = Date.parse(Date.today().format());
        acct.IsAllInformationFilled__c =true;
        acct.PhotoIAck_Date__c = null;
        acct.HIVMedicaRCS_Date__c = null;
        acct.HIVMedicaRCS_SSN__c = '123456789';
        acct.SSN__c = '123456789';
        acct.Gender__c = 'Male';
        acct.Race__c = 'Other';
        acct.Height__c = '5\'10\'\'';
        acct.Weight__c = 143;
        acct.Eye_Color__c = 'Black';
        acct.Hair_Color__c = 'Black';
        acct.Work_Permit_If_Under_18__c = 'No';
        acct.Previously_Applied__c  = 'No';
        acct.Previously_filed_application_date__c = null;
        acct.Previously_employed_here__c  = 'No';
        acct.Previously_employed_here_date__c  = null;
        acct.Immigration_Status__c = 'No';
        acct.Date_available_for_work__c= null;
        acct.Avalibility__c= null;
        acct.Desired_shift__c= null;
        acct.Felony_Conviction_within_7_years__c= null;
        acct.Conviction_Explination__c= null;
        acct.Date_of_Application__c= null;
        acct.HHA_Pledge_Date__c = null;
        acct.HHA_Pledge_SSN__c = '123456789';
        acct.HHA_Attestation_Date__c = null;
        acct.HHA_Attestation_SSN__c = '123456789';
        acct.NYSDOH_Date__c  = null;
        acct.NYSDOH_SSN__c = '123456789';
        acct.Deficit_Reduction_Act_Date__c = null;
        acct.Deficit_Reduction_Act_SSN__c = '123456789';
        
        acct.PA_Ack_Receipt_SSN__c = '123456789';
        acct.PA_Ack_Receipt_Date__c = null;
        
        acct.Applicant_SSN__c = '123456789';
        acct.Applicant_Date__c = null;
        
        
        insert acct;
        
        return acct;
    }
    
    public static Account createAccountsWithCDPAP()
    {
        
        Account acct = new Account();
        
        acct.Translating_Language__c = 'en';
        
        RecordType recType;
        recType = [select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='account' and name = 'CDPAP' limit 1];
        
         acct.recordtypeid = recType.id;
        acct.Salutation =  'Mr.';
        acct.FirstName='accFname';
        acct.LastName='accLname';
        acct.MiddleName='accMiddleName';
        acct.PersonEmail='abc@gmail.com';
        acct.PersonMobilePhone='1234567890';
        acct.Position__c='developer';
        acct.PersonMailingStreet='Street';
        acct.PersonMailingCity='city';
        acct.PersonMailingState='State';
        acct.PersonMailingPostalCode='00605';
        acct.PersonMailingCountry='USA';
        acct.SSN__c =  '123456789';
        acct.Birthplace__c = 'test';
        acct.Acknowledgment_of_Rules_SSN__c = '123456789';
        acct.Currently_Not_Employed__c = true;
        acct.PA_Date__c = Date.parse(Date.today().format());
        acct.Validation_Form_Date__c = Date.parse(Date.today().format());
        acct.PersonBirthDate = Date.parse(Date.today().format());
        acct.Phone = '1234567890';
        
        acct.PhotoIAck_SSN__c = '123456789';
        acct.PERSONAL_ASSISTANT_S_CHOICES__c = 'No';
        acct.HEPATITIS_SSN__c = '123456789';
        acct.HEPATITIS_Form_Date__c = null;
        acct.IsAllInformationFilled__c =true;
        acct.PhotoIAck_Date__c = null;
        acct.HIVMedicaRCS_Date__c = null;
        acct.HIVMedicaRCS_SSN__c = '123456789';
        acct.SSN__c = '123456789';
        acct.Gender__c = 'Male';
        acct.Race__c = 'Other';
        acct.Height__c = '5\'10';
        acct.Weight__c = 143;
        acct.Eye_Color__c = 'Black';
        acct.Hair_Color__c = 'Black';
        acct.Work_Permit_If_Under_18__c = 'No';
        acct.Previously_Applied__c  = 'No';
        acct.Previously_filed_application_date__c = null;
        acct.Previously_employed_here__c  = 'No';
        acct.Previously_employed_here_date__c  = null;
        acct.Immigration_Status__c = 'No';
        acct.Date_available_for_work__c= null;
        acct.Avalibility__c= null;
        acct.Desired_shift__c= null;
        acct.Felony_Conviction_within_7_years__c= null;
        acct.Conviction_Explination__c= null;
        acct.Date_of_Application__c= null;
        acct.HHA_Pledge_Date__c = null;
        acct.HHA_Pledge_SSN__c = '123456789';
        acct.HHA_Attestation_Date__c = null;
        acct.HHA_Attestation_SSN__c = '123456789';
        acct.NYSDOH_Date__c  = null;
        acct.NYSDOH_SSN__c = '123456789';
        acct.Deficit_Reduction_Act_Date__c = null;
        acct.Deficit_Reduction_Act_SSN__c = '123456789';
        
        acct.PA_Ack_Receipt_SSN__c = '123456789';
        acct.PA_Ack_Receipt_Date__c = null;
        insert acct;
        
        return acct;
    }
    
    public static List<Question__c> createQuestionList(){
        List<Question__c> queList = new List<Question__c>();
        Question__c question = new Question__c();
        question.Question__c = 'A friend of yours knows one of your patients, and asks you how patient’s recovery from surgery is going. What should you do?';
        question.Option_1__c = 'Tell her in general terms how the patient is feeling';
        question.Option_2__c = 'Ask your friend how well she knows the patient and then decide how much to tell her.';
        question.Option_3__c = 'Explain that it\'s a violation of the patient\'s privacy for you to discuss your patient\'s condition';
        question.Option_4__c = 'None of the above.';
        question.Correct_Answer__c = '3';
        question.Number_of_Options__c = '4';
        question.Language__c = 'en';
        queList.add(question);
        question = new Question__c();
        question.Question__c = 'Which of the following is included when you follow universal precautions?';
        question.Option_1__c = 'Use gloves.';
        question.Option_2__c = 'Wash hands.';
        question.Option_3__c = 'Make sure soiled diapers are placed in double plastic bags.';
        question.Option_4__c = 'All of the above.';
        question.Correct_Answer__c = '4';
        question.Number_of_Options__c = '4';
        question.Language__c = 'en';
        queList.add(question);
        question = new Question__c();
        question.Question__c = 'A patient had a fall early in the morning before you arrived. She states "I have no pain, so I don\'t want to bother" You:';
        question.Option_1__c = 'Don\'t report it so the patient doesn\'t get upset.';
        question.Option_2__c = 'Call the Scheduling Coordinator.';
        question.Option_3__c = 'Wait and see if the patient really has no pain.';
        question.Correct_Answer__c = '2';
        question.Number_of_Options__c = '3';
        question.Language__c = 'en';
        queList.add(question);
        question = new Question__c();
        question.Question__c = 'If you are running late and patient offers to clock in for you. You should';
        question.Option_1__c = 'Give patient your clock-in information';
        question.Option_2__c = 'Inform patient only you can clock-in for yourself and then inform your coordinator';
        question.Option_3__c = 'Tell patient you will send timesheet';
        question.Correct_Answer__c = '2';
        question.Number_of_Options__c = '3';
        question.Language__c = 'en';
        queList.add(question);
        insert queList;
        return queList;
    } 
    
   
    
    public static Emergency_Contact__c createEmerCon()
    {
        Emergency_Contact__c con = new Emergency_Contact__c();
        con.Name = 'Test';
        con.Emp_LastName__c = 'Test';
        con.RelatioshipNew__c = 'Other';
        con.HomePhone__c = '1235467890';
        
        con.CellPhone__c = '123456789';
        con.Street__c = 'Test';
        con.City__c = 'Test';
        con.State__c = 'Test';
        con.Zip__c = '12345';
        con.Email__c = 'abc@gmail.com';
        insert con;
        return con;
    }
    
    public static Language__c createLanguage()
    {
        Language__c lan = new Language__c();
        lan.Name = 'English';
        lan.Reading_capabilities__c = 'Well';
        lan.Spoken_skill_level__c = 'Well';
        lan.Writing_capabilites__c = 'Well';
        insert lan;
        return lan;
    }
    
    public static Address__c insertaddresses()
    {
        Address__c add = new Address__c();
        add.State__c = '00605';
        add.State__c = 'Aguadilla';
        add.City__c = 'PR';
        return add;
    }
    
    
}