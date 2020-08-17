public class EmerContExtension {
    
    public List<Address__c> addList{get;set;}
    public String addtakeCity{get;set;}
    public String addtakeState{get;set;}
    public String zipCodeprm{get;set;}
    public String postalcodeNumber{set;get;}
    
    public Emergency_Contact__c con {get;set;}
    public Account acc {get;set;}
    public List<Emergency_Contact__c> listOfEmergencyContact {get;set;}
    public String accountId;
    public String reviewAccountId;
    public List<Emergency_Contact__c> listtodeleteEmerCon ;
    public Integer deleteEmerConIndex{get;set;}
    public String reviewforcdpapAccountId;
    public boolean check{get;set;}
    public Boolean msgFlag{get;set;}
    
    public EmerContExtension(ApexPages.StandardController stdController) {
        msgFlag = false;
        accountId = ApexPages.currentPage().getParameters().get('id');
        listOfEmergencyContact = new List<Emergency_Contact__c>();
        listtodeleteEmerCon = new List<Emergency_Contact__c>();
        reviewforcdpapAccountId = ApexPages.currentPage().getParameters().get('reviewforcdpapid');
        reviewAccountId = ApexPages.currentPage().getParameters().get('reviewId');
        check = true;
        if(reviewforcdpapAccountId != null || reviewAccountId != null)
            check = false;
        System.debug(check);
        if(accountId == null){
            accountId = reviewAccountId;
        }
        
        if(accountId == null){
            accountId = reviewforcdpapAccountId;
        }
        
        listOfEmergencyContact =[Select Id,Name,Emp_LastName__c,RelatioshipNew__c,HomePhone__c,Account__c,CellPhone__c,Street__c,City__c,State__c,Zip__c,Email__c From Emergency_Contact__c  WHERE ( Account__c =:accountId)];   
        
        System.debug('id is : ' + accountId);
        acc = [SELECT id,FirstName, LastName,Translating_Language__c, PersonEmail, PersonMailingStreet,PersonMailingCity,PersonMailingState,PersonMailingPostalCode,
               Phone,PersonMobilePhone,isPersonAccount,IsAllInformationFilled__c,Location_Team__c  FROM Account WHERE Id=:accountId];
        
        if(listOfEmergencyContact.size() == 0)
        {
            con = new Emergency_Contact__c();
            con.Account__c = accountId;
            listOfEmergencyContact.add(con);
        }
        
    }
    
    public PageReference saveAndReturnforEmerCont(){
        
        try{
            
            if(listtodeleteEmerCon != null ){// if(listtodeleteEmerCon != null && listtodeleteEmerCon.size() >0)
                delete listtodeleteEmerCon;
            }
            
            if(listOfEmergencyContact != null && listOfEmergencyContact.size() >0){
                 for(Emergency_Contact__c temp:listOfEmergencyContact)
                {
                    temp.Name = capitalizeWords(temp.Name);
                    temp.Emp_LastName__c = capitalizeWords(temp.Emp_LastName__c);
                }
                
                upsert listOfEmergencyContact;
            }
            
            PageReference parentPage ;
            System.debug(reviewAccountId);
            if(reviewAccountId != null){
                parentPage = new PageReference('/apex/UploadFileHHA?reviewId='+acc.Id+'&id='+acc.Id+'#emergencyContactId');
            }
            else{
                parentPage = new PageReference('/apex/UploadFileHHA?id='+acc.Id);
            }
            parentPage.setRedirect(true);
            return parentPage;
        }
        catch(Exception ex){
            msgFlag = true;
            ApexPages.addMessages(ex);
            System.debug(''+ex.getMessage());
            return null;
            
        }
    }
    
    
    public PageReference saveAndReturnforEmerContCDPAP(){
        
        try{
            if(listtodeleteEmerCon != null ){// if(listtodeleteEmerCon != null && listtodeleteEmerCon.size() >0)
                delete listtodeleteEmerCon;
            }
            
            if(listOfEmergencyContact != null && listOfEmergencyContact.size() >0){
                for(Emergency_Contact__c temp:listOfEmergencyContact)
                {
                    temp.Name = capitalizeWords(temp.Name);
                    temp.Emp_LastName__c = capitalizeWords(temp.Emp_LastName__c);
                }
               
                upsert listOfEmergencyContact;
            }
            
            PageReference parentPage ;
            if(reviewforcdpapAccountId != null){
                parentPage = new PageReference('/apex/ReviewForCDPAPForm?id='+acc.Id+'&id='+acc.Id+'#emergencyContactId');
            }
            else{
              //  parentPage = new PageReference('/apex/HEPATITISBFORM?id='+acc.Id);
                parentPage = new PageReference('/apex/Consumer_Information_Form?id='+acc.Id);
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
    
    
    public void addNew(){
        try{
            con = new Emergency_Contact__c ();
            con.Account__c = accountId;
            con.IsApexCreate__c = true;
            listOfEmergencyContact.add(con);
        }
        catch(Exception ex){
            System.debug('Error message in add row'+ex.getMessage());
        }
    }
    
    
    public void delRow(){
        Emergency_Contact__c deleteEmeCon;
        integer listSize =listOfEmergencyContact.size() -1; 
        System.debug('listSize :::'+listSize );
        if(listSize != null ) {//if(listSize != null && listSize >0)
            deleteEmeCon = listOfEmergencyContact[listSize];
            if(deleteEmeCon.id!=null)
                listtodeleteEmerCon.add(deleteEmeCon) ;
            listOfEmergencyContact.remove(listSize);
        }
        if(listOfEmergencyContact.size() == 0)
        {
            con = new Emergency_Contact__c();
            con.Account__c = accountId;
            listOfEmergencyContact.add(con);
        }
        system.debug('listOfEmployer'+listOfEmergencyContact);
    }
    
    public void delSelectedRow(){
        Emergency_Contact__c deleteEmeCon;
        integer listSize =listOfEmergencyContact.size() -1; 
        System.debug('listSize :::'+listSize );
        if(listSize != null ) {//if(listSize != null && listSize >0)
            deleteEmeCon = listOfEmergencyContact[deleteEmerConIndex - 1];
            if(deleteEmeCon.id!=null)
                listtodeleteEmerCon.add(deleteEmeCon) ;
            listOfEmergencyContact.remove(deleteEmerConIndex - 1);
        }
        if(listOfEmergencyContact.size() == 0)
        {
            con = new Emergency_Contact__c();
            con.Account__c = accountId;
            listOfEmergencyContact.add(con);
        }
        system.debug('listOfEmployer'+listOfEmergencyContact);
    }
    
    public pageReference cancel(){
        PageReference page;
        if(reviewAccountId!=null){
            page = new Pagereference('/apex/ReviewPage?id='+acc.Id);
        }
        else{
            if(reviewforcdpapAccountId!=null){
                page = new Pagereference('/apex/ReviewForCDPAPForm?id='+acc.Id);
            }
            else{
                System.debug('value of filled field : ' + acc.IsAllInformationFilled__c);
                if(acc.IsAllInformationFilled__c == false)
                    delete acc;
                page = new Pagereference('/apex/WelcomePage');
            }
        }
        page.setRedirect(true);
        return page;   
    }
    
    public PageReference previousFromEmer(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/Acknowledgment_of_Rules_Form?id='+accountId);
        parentPage.setRedirect(true);
        return parentPage;
    }
    
    public PageReference previousFromEmerCDPAP(){
        PageReference parentPage ;
        parentPage = new PageReference('/apex/Personal_Information_Form?id='+accountId+'&lid='+acc.Translating_Language__c+'&tyId=CDPAP' + '&loctnId=' + acc.Location_Team__c);
        parentPage.setRedirect(true);
        return parentPage;
    }
    public void zipAddress(){
        System.debug('I am in zip address-'+zipCodeprm+ '-');
        addList = new List<Address__C>();
        addtakeState = 'State not found';
        addtakeCity = 'City not found';
        
       addList = [SELECT Id,City__c,State__c,Zip__c FROM Address__c WHERE Zip__C =:zipCodeprm LIMIT 1];
        System.debug('size== '+addList.size());
        System.debug('addList'+addList);
       if(addList.size()>0){
            addtakeState = addList[0].State__c;
            addtakeCity = addList[0].City__c;
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