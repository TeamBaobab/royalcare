@isTest
public class TestClass {
    
    static testMethod void  testHHAwithid()
    {
        Account acc =  TestDataFactory.createAccountsWithHHA();
        Test.startTest();
        PageReference pageRef = Page.WelcomePage;
        pageRef.getParameters().put('id', String.valueOf(acc.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        WelcomePageCtrl wc = new WelcomePageCtrl(sc);
        
        wc.getlanguages();
        wc.getApplicationTypes();
        wc.changeLanguage();
     //   wc.changeType();
        wc.getlocationTem();
        wc.saveAndRedirectOnPerInfoPage();
        
        Test.stopTest();
        System.assertEquals('en', acc.Translating_Language__c);
    }

    static testMethod void  testHHAwithoutidHHA()
    {
        Account acc;
       
            acc =  TestDataFactory.createAccountsWithHHA();
             Test.startTest();
            PageReference pageRef = Page.WelcomePage;
            pageRef.getParameters().put('id', null);
            Test.setCurrentPage(pageRef);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(acc);
            WelcomePageCtrl wc = new WelcomePageCtrl(sc);
            
            wc.saveAndRedirectOnPerInfoPage();
            Test.stopTest();
        System.assertEquals('en', acc.Translating_Language__c);
       
    }
    
    static testMethod void testPersonAccountwithidHHA()
    {
        Account acct =  TestDataFactory.createAccountsWithHHA();
       
    
        PageReference pageRef = Page.Personal_Information_Form;
        
        pageRef.getParameters().put('lid', 'en');
        pageRef.getParameters().put('id', acct.id);
        pageRef.getParameters().put('tyId', 'HHA');
        pageRef.getParameters().put('reviewid', acct.id);
        String choosedlanguage = ApexPages.currentPage().getParameters().get('lid');
        
       
        //insert acct;
        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acct);
        
        PersonalInformationExtension perinfoext = new PersonalInformationExtension(sc);
        perinfoext.accDOB = '07/28/1993';
        
       
        perinfoext.changeSalutation();
        perinfoext.previousFromPIF();
        perinfoext.zipAddress();
        perinfoext.zipSuggestion();
        perinfoext.cancel(); 
        perinfoext.savePersonalInfo();
        Test.stopTest();
        System.assertEquals('accLname', acct.LastName);
    }
    
     static testMethod void testPersonAccountwithoutidHHA()
    {
       Account acct =  TestDataFactory.createAccountsWithHHA();
       
        PageReference pageRef = Page.Personal_Information_Form;
        
        pageRef.getParameters().put('lid', 'en');
     //   pageRef.getParameters().put('id', acct.id);
        pageRef.getParameters().put('tyId', 'HHA');
        pageRef.getParameters().put('reviewid', acct.id);
        String choosedlanguage = ApexPages.currentPage().getParameters().get('lid');
        
       
        //insert acct;
        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acct);
        PersonalInformationExtension perinfoext = new PersonalInformationExtension(sc);
        perinfoext.savePersonalInfo();
        Test.stopTest();
        System.assertEquals('accLname', acct.LastName);
    }
   
    static testMethod void testPersonAccountwithidCDPAP()
    {
        Account acct =  TestDataFactory.createAccountsWithCDPAP();
       
      //  acct.SSN__c =  '1234-45-6789';
        PageReference pageRef = Page.Personal_Information_Form;
        
        pageRef.getParameters().put('lid', 'en');
        pageRef.getParameters().put('id', acct.id);
        pageRef.getParameters().put('tyId', 'CDPAP');
        pageRef.getParameters().put('reviewforcdpapid', acct.id);
        String choosedlanguage = ApexPages.currentPage().getParameters().get('lid');
        
       
        //insert acct;
        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acct);
        
        PersonalInformationExtension perinfoext = new PersonalInformationExtension(sc);
        
        
        perinfoext.savePersonalInfo();
        perinfoext.changeSalutation();
        perinfoext.previousFromPIF();
        perinfoext.cancel();
        Test.stopTest();
        System.assertEquals('accLname', acct.LastName);
       
    }
    
     static testMethod void testPersonAccountwithoutidCDPAP()
    {
       Account acct =  TestDataFactory.createAccountsWithCDPAP();
       
        PageReference pageRef = Page.Personal_Information_Form;
        
        pageRef.getParameters().put('lid', 'en');
     //   pageRef.getParameters().put('id', acct.id);
        pageRef.getParameters().put('tyId', 'CDPAP');
        pageRef.getParameters().put('reviewforcdpapid', acct.id);
        String choosedlanguage = ApexPages.currentPage().getParameters().get('lid');
        
        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acct);
        PersonalInformationExtension perinfoext = new PersonalInformationExtension(sc);
        perinfoext.savePersonalInfo();
        Test.stopTest();
        System.assertEquals('accLname', acct.LastName);
    } 
    
    static testMethod void testAckRulesFormwithid()
    {
       Account acct =  TestDataFactory.createAccountsWithHHA();
       PageReference pageRef = Page.Acknowledgment_of_Rules_Form;
       pageRef.getParameters().put('id', acct.id);
      // pageRef.getParameters().put('reviewid', acct.id);

        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acct);
        AcknowledgmentOfRulesCtrl ack = new AcknowledgmentOfRulesCtrl(sc);
        ack.updateAccountForAckOfRulesDetails();
        ack.previousFromAck();
        ack.cancel();
        Test.stopTest();
        System.assertEquals('accLname', acct.LastName);
    }
    
    
    
    static testMethod void testAckRulesFormwithreviewid()
    {
       Account acct =  TestDataFactory.createAccountsWithHHA();
        acct.Acknowledgment_of_Rules_Date__c = Date.parse(Date.today().format());
        update acct;
       PageReference pageRef = Page.Acknowledgment_of_Rules_Form;
      // pageRef.getParameters().put('id', acct.id);
       pageRef.getParameters().put('reviewid', acct.id);

        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acct);
        AcknowledgmentOfRulesCtrl ack = new AcknowledgmentOfRulesCtrl(sc);
        ack.updateAccountForAckOfRulesDetails();
        ack.previousFromAck();
        ack.cancel();
        Test.stopTest();
        System.assertEquals('accLname', acct.LastName);
    }
   
    static testMethod void testEmerExtidWithHHA()
    {
         Account acct =  TestDataFactory.createAccountsWithHHA();
         Emergency_Contact__c con = TestDataFactory.createEmerCon();
          con.Account__c = acct.id;
        
        PageReference pageRef = Page.Emer_cont_Info_Form;
     // pageRef.getParameters().put('id', acct.id);
        pageRef.getParameters().put('reviewId', acct.id);

        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(con);
        EmerContExtension emer = new EmerContExtension(sc);
        emer.saveAndReturnforEmerCont();
       // emer.saveAndReturnforEmerContCDPAP();
        emer.addNew();
        emer.delRow();
      //  emer.delSelectedRow();
        emer.previousFromEmer();
        emer.previousFromEmerCDPAP();
        emer.cancel();
         
        Test.stopTest();
        System.assertEquals('12345', con.Zip__c);
    }
    
    static testMethod void testEmerExtidWithCDPAP()
    {
         Account acct =  TestDataFactory.createAccountsWithCDPAP();
         Emergency_Contact__c con = TestDataFactory.createEmerCon();
         con.Account__c = acct.id;
       
        
        PageReference pageRef = Page.EmercontForCDPAP;
     // pageRef.getParameters().put('id', acct.id);
        pageRef.getParameters().put('reviewforcdpapid', acct.id);

        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(con);
        EmerContExtension emer = new EmerContExtension(sc);
       // emer.saveAndReturnforEmerCont();
        emer.saveAndReturnforEmerContCDPAP();
        emer.addNew();
        emer.delRow();
     //   emer.delSelectedRow();
        emer.previousFromEmer();
        emer.previousFromEmerCDPAP();
        emer.cancel();
         
        Test.stopTest();
        System.assertEquals('12345', con.Zip__c);
    }
    
    static testMethod void testEmerExtidWithid()
    {
         Account acct =  TestDataFactory.createAccountsWithCDPAP();
         Emergency_Contact__c con = TestDataFactory.createEmerCon();
         con.Account__c = acct.id;
         con = TestDataFactory.createEmerCon();
         con.Account__c = acct.id;
        
        update con;
        PageReference pageRef = Page.Emer_cont_Info_Form;
        pageRef.getParameters().put('id', acct.id);
       // pageRef.getParameters().put('reviewforcdpapid', acct.id);

        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(con);
        EmerContExtension emer = new EmerContExtension(sc);
        emer.addNew();
        emer.delRow();
        emer.saveAndReturnforEmerCont();
        emer.saveAndReturnforEmerContCDPAP();
        
        
        emer.deleteEmerConIndex = 1;
       
        
       // emer.setdeleteEmerConIndex(i);
       // emer.getdeleteEmerConIndex();
        emer.delSelectedRow();
        emer.previousFromEmer();
        emer.previousFromEmerCDPAP();
        emer.cancel();
         
        Test.stopTest();
        System.assertEquals('12345', con.Zip__c);
    }
    
    
    //==========================================================================================
    
     static testMethod void testLanguageExtidWithHHA()
    {
         Account acct =  TestDataFactory.createAccountsWithHHA();
         Language__c lan = TestDataFactory.createLanguage();
         lan.Account__c = acct.id;
        
        PageReference pageRef = Page.Emer_cont_Info_Form;
     // pageRef.getParameters().put('id', acct.id);
        pageRef.getParameters().put('reviewId', acct.id);

        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(lan);
        LanguageExtension lanExt = new LanguageExtension(sc);
        lanExt.saveAndReturnforLang();
       // emer.saveAndReturnforEmerContCDPAP();
        lanExt.addNew();
        lanExt.delRow();
      //  emer.delSelectedRow();
        lanExt.previousFromLang();
        
        lanExt.cancel();
         
        Test.stopTest();
        System.assertEquals('English', lan.Name);
    }
    
   
    
    static testMethod void testLanguageExtidWithid()
    {
          Account acct =  TestDataFactory.createAccountsWithHHA();
         Language__c lan = TestDataFactory.createLanguage();
         lan.Account__c = acct.id;
        
        PageReference pageRef = Page.Emer_cont_Info_Form;
     // pageRef.getParameters().put('id', acct.id);
        pageRef.getParameters().put('reviewId', acct.id);

        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(lan);
        LanguageExtension lanExt = new LanguageExtension(sc);
        
        lanExt.delRow();
        lanExt.saveAndReturnforLang();
        lanExt.addNew();
        lanExt.delRow();
       
        
        
        lanExt.delIndex = 1;
       
        
       // emer.setdeleteEmerConIndex(i);
       // emer.getdeleteEmerConIndex();
        lanExt.delSingleRow();
        lanExt.previousFromLang();
       
        lanExt.cancel();
         
        Test.stopTest();
        System.assertEquals('English', lan.Name);
    }
    
    static testMethod void testAccountExtidWithid()
    {
        Account acct =  TestDataFactory.createAccountsWithHHA();
        
     

        PageReference pageRef = Page.FingerPrintPIF_Form;
         pageRef.getParameters().put('id', acct.id);
       // pageRef.getParameters().put('reviewId', acct.id);
        
        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acct);
        AccountExtensionModified accExt = new AccountExtensionModified(sc);
        accExt.predateApp = '03/03/2017';
        accExt.predateEmp = '03/03/2017';
        accExt.avlWorkDate = '03/03/2017';
        accExt.saveAndReturn();
        accExt.saveAndReturnforFPIF();
        accExt.saveAndReturnforHivMedical();
        accExt.saveAndReturnforPhotoIdAck();
        accExt.saveAndReturnforNYSDOH();
        accExt.saveAndReturnforSubstanceAbuse();
       // accExt.saveAndReturnForDeficitReductionAct();
       // accExt.saveAndReturnForHEPATITIS();
      //  accExt.saveAndReturnForPAAckReceipt();
        accExt.cancel();
        accExt.previousFromFPIF();
        accExt.previousFromAFEF();
        accExt.previousFromPIAF();
        accExt.previousFromSARF();
        accExt.previousFromHIVF();
        accExt.previousFromNYSDOHF();
      //  accExt.previousFromPAAckOfFC();
       // accExt.previousFromDeficitRAForm();
       // accExt.previousHEPATITIS();
        //accExt.cancelForCDPAP();
        Test.stopTest();
        System.assertEquals('Male', acct.Gender__c);
        
    }
   
     static testMethod void testAccountExtidWithreviewId()
    {
        Account acct =  TestDataFactory.createAccountsWithHHA();
        
        acct.HEPATITIS_Form_Date__c = Date.parse(Date.today().format());
        acct.hIVMedicaRCS_Date__c = Date.parse(Date.today().format()); 
        acct.nYSDOH_Date__c = Date.parse(Date.today().format());
        acct.hHA_Attestation_Date__c = Date.parse(Date.today().format());
        acct.hHA_Pledge_Date__c = Date.parse(Date.today().format());
        acct.Deficit_Reduction_Act_Date__c = Date.parse(Date.today().format());
        acct.PA_Ack_Receipt_Date__c = Date.parse(Date.today().format());
        acct.Previously_Applied__c = 'Yes';
        acct.Previously_filed_application_date__c = null;
        acct.Previously_employed_here__c = 'Yes';
        acct.Previously_employed_here_date__c = null ;
        acct.Felony_Conviction_within_7_years__c = 'Yes';
        acct.Conviction_Explination__c = null;
        Update acct;    
        PageReference pageRef = Page.ApplForEmployment_Form;
         //pageRef.getParameters().put('id', acct.id);
        pageRef.getParameters().put('reviewId', acct.id);
        
        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acct);
        AccountExtensionModified accExt = new AccountExtensionModified(sc);
        accExt.saveAndReturn();
        accExt.saveAndReturnforFPIF();
        accExt.saveAndReturnforHivMedical();
        accExt.saveAndReturnforPhotoIdAck();
        accExt.saveAndReturnforNYSDOH();
        accExt.saveAndReturnforSubstanceAbuse();
        //accExt.saveAndReturnForDeficitReductionAct();
        //accExt.saveAndReturnForHEPATITIS();
       // accExt.saveAndReturnForPAAckReceipt();
        accExt.cancel();
        accExt.previousFromFPIF();
        accExt.previousFromAFEF();
        accExt.previousFromPIAF();
        accExt.previousFromSARF();
        accExt.previousFromHIVF();
        accExt.previousFromNYSDOHF();
      //  accExt.previousFromPAAckOfFC();
      //  accExt.previousFromDeficitRAForm();
      //  accExt.previousHEPATITIS();
       // accExt.cancelForCDPAP();
        Test.stopTest();
        System.assertEquals(Date.parse(Date.today().format()), acct.hHA_Pledge_Date__c);
        
        
    }
   
    static testMethod void testAccountExtidWithreviewforcdpapid()
    {
        Account acct =  TestDataFactory.createAccountsWithHHA();
            acct.HEPATITIS_Form_Date__c = null;
        acct.hIVMedicaRCS_Date__c = null; 
        acct.nYSDOH_Date__c = null;
        acct.hHA_Attestation_Date__c = null;
        acct.hHA_Pledge_Date__c = null;
        acct.Deficit_Reduction_Act_Date__c = null;
        acct.PA_Ack_Receipt_Date__c = null;
        
        PageReference pageRef = Page.PhotoIdAck_Form;
        //pageRef.getParameters().put('id', acct.id);
        pageRef.getParameters().put('reviewforcdpapid', acct.id);
        
        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acct);
        AccountExtension_Site accExt = new AccountExtension_Site(sc);
        
        accExt.saveAndReturnForDeficitReductionAct();
        accExt.saveAndReturnForHEPATITIS();
        accExt.saveAndReturnForPAAckReceipt();
        accExt.cancel();
        
        accExt.previousFromPAAckOfFC();
        accExt.previousFromDeficitRAForm();
        accExt.previousHEPATITIS();
       
        Test.stopTest();
        System.assertEquals('123456789', acct.PhotoIAck_SSN__c);
    }
    
    static testMethod void testAccountExtidWithreviewforcdpapidnew()
    {
        Account acct =  TestDataFactory.createAccountsWithHHA();
        
        acct.HEPATITIS_Form_Date__c = Date.parse(Date.today().format());
        acct.hIVMedicaRCS_Date__c = Date.parse(Date.today().format()); 
        acct.nYSDOH_Date__c = Date.parse(Date.today().format());
        acct.hHA_Attestation_Date__c = Date.parse(Date.today().format());
        acct.hHA_Pledge_Date__c = Date.parse(Date.today().format());
        acct.Deficit_Reduction_Act_Date__c = Date.parse(Date.today().format());
        acct.PA_Ack_Receipt_Date__c = Date.parse(Date.today().format());
        
        PageReference pageRef = Page.PhotoIdAck_Form;
        //pageRef.getParameters().put('id', acct.id);
        pageRef.getParameters().put('reviewforcdpapid', acct.id);
        
        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acct);
        AccountExtension_Site accExt = new AccountExtension_Site(sc);
        
        accExt.saveAndReturnForDeficitReductionAct();
        accExt.saveAndReturnForHEPATITIS();
        accExt.saveAndReturnForPAAckReceipt();
        accExt.cancel();
        
        accExt.previousFromPAAckOfFC();
        accExt.previousFromDeficitRAForm();
        accExt.previousHEPATITIS();
       
        Test.stopTest();
        System.assertEquals('123456789', acct.PhotoIAck_SSN__c);
    }
    
    
    
     static testMethod void testSubstance_Abuse_Relationship_Form()
    {
         Account acct =  TestDataFactory.createAccountsWithHHA();
        PageReference pageRef = Page.Substance_Abuse_Relationship_Form;
        //pageRef.getParameters().put('id', acct.id);
        pageRef.getParameters().put('reviewforcdpapid', acct.id);
        
        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acct);
        AccountExtensionModified accExt = new AccountExtensionModified(sc);
        accExt.saveAndReturnforSubstanceAbuse();
        accExt.previousFromSARF();
        Test.stopTest();
        System.assertEquals('123456789', acct.HHA_Attestation_SSN__c);
    }
    
     static testMethod void testNYSDOH_HC_Registry_Form()
    {
         Account acct =  TestDataFactory.createAccountsWithHHA();
        PageReference pageRef = Page.NYSDOH_HC_Registry_Form;
        //pageRef.getParameters().put('id', acct.id);
        pageRef.getParameters().put('reviewforcdpapid', acct.id);
        
        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acct);
        AccountExtensionModified accExt = new AccountExtensionModified(sc);
        accExt.saveAndReturnforNYSDOH();
        accExt.previousFromNYSDOHF();
        Test.stopTest();
        System.assertEquals('123456789', acct.NYSDOH_SSN__c);
    }
    
    static testMethod void testHIVMedicalRCStatement()
    {
         Account acct =  TestDataFactory.createAccountsWithHHA();
        PageReference pageRef = Page.HIVMedicalRCStatement;
        //pageRef.getParameters().put('id', acct.id);
        pageRef.getParameters().put('reviewforcdpapid', acct.id);
        
        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acct);
        AccountExtensionModified accExt = new AccountExtensionModified(sc);
        accExt.saveAndReturnforHivMedical();
        accExt.previousFromHIVF();
        Test.stopTest();
        System.assertEquals('123456789', acct.HIVMedicaRCS_SSN__c);
    }
    
     static testMethod void testHEPATITISBFORM()
    {
         Account acct =  TestDataFactory.createAccountsWithHHA();
        PageReference pageRef = Page.HEPATITISBFORM;
        //pageRef.getParameters().put('id', acct.id);
        pageRef.getParameters().put('reviewforcdpapid', acct.id);
        
        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acct);
        AccountExtension_site accExt = new AccountExtension_site(sc);
        accExt.saveAndReturnForHEPATITIS();
        accExt.previousHEPATITIS();
        Test.stopTest();
        System.assertEquals('123456789', acct.HEPATITIS_SSN__c);
    }
     static testMethod void testDOHRCHRC()
    {
         Account acct =  TestDataFactory.createAccountsWithHHA();
        PageReference pageRef = Page.DOHRCHRC;
        pageRef.getParameters().put('id', acct.id);
       // pageRef.getParameters().put('reviewforcdpapid', acct.id);
        
        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acct);
        AccountExtensionModified accExt = new AccountExtensionModified(sc);
        accExt.saveAndReturnforDOH();
        accExt.previousFromDOH();
        accExt.getItems();
         accExt.getItems1();
        Test.stopTest();
        System.assertEquals('123456789', acct.HEPATITIS_SSN__c);
    }
    
      static testMethod void testConsumerExtension()
    {
        Account acct =  TestDataFactory.createAccountsWithCDPAP();
        PageReference pageRef = Page.PA_Disclosure_Statement_Form;
        pageRef.getParameters().put('id', acct.id);
       // pageRef.getParameters().put('reviewforcdpapid', acct.id);
        
        Test.startTest();
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acct);
        ConsumerExtension_Site consExten = new ConsumerExtension_Site(sc);
        consExten.savePADisclosureInfo();
        consExten.cancel();
        consExten.previousFromPADisclosureForm();
        consExten.saveandUploadFiles();
        // consExten.getItems1();
        Test.stopTest();
       // System.assertEquals('123456789', acct.HEPATITIS_SSN__c);
    }
   
   
}