public class WelcomePageCtrl {
    
    public boolean displayPopup {get; set;}     
    public String selectedLanguage{get;set;}
    public String selectedApplicationType{get;set;}
    public String selectedLocation{get;set;}
    String accId;
    Account acc;
    public List<SelectOption> loacationList{get;set;}
    public WelcomePageCtrl(ApexPages.StandardController sc){
        displayPopup = false;    
        
        accId = ApexPages.currentPage().getParameters().get('id');
        if(accId != Null){
            acc = [SELECT Id, Translating_Language__c FROM Account WHERE Id=:accId];
        }else{
            acc = (Account)sc.getRecord();
        }
        
        
    }
    
    public SelectOption[] getlanguages() {
        return new SelectOption[] { new SelectOption('en', 'ENGLISH'), new SelectOption('es', 'SPANISH'),
            new SelectOption('zh_CN', 'CHINESE'), new SelectOption('ru', 'RUSSIAN')};
                }
    
    public SelectOption[] getApplicationTypes() {
        return new SelectOption[] {new SelectOption('', '--Select--'), new SelectOption('CDPAP', 'CDPAP'), new SelectOption('HHA', 'HHA')};
            }
    
    /* public SelectOption[] getLocation() {
return new SelectOption[] {new SelectOption('', '--Select--'), new SelectOption('Brooklyn - R1', 'Brooklyn - R1'),
new SelectOption('Brooklyn - C1', 'Brooklyn - C1'),
new SelectOption('Bronx - R1', 'Bronx - R1'),
new SelectOption('Bronx - C1', 'Bronx - C1'),
new SelectOption('Jamaica - R1', 'Jamaica - R1'),
new SelectOption('Jamaica - C1', 'Jamaica - C1'),
new SelectOption('Flushing - R1', 'Flushing - R1'),
new SelectOption('Flushing - C1', 'Flushing - C1'),
new SelectOption('Staten Island', 'Staten Island')};

}*/
    
    public PageReference saveAndRedirectOnPerInfoPage(){
        
        try{
            acc.Translating_Language__c = selectedLanguage;
            
            if(acc.Translating_Language__c == null)
                acc.Translating_Language__c = 'en';
            
            PageReference parentPage;
            
            if(accId!=null){
                
                update acc;
                parentPage = new PageReference('/apex/Personal_Information_Form?id=' + accId + '&lid='+selectedLanguage + '&tyId=' + selectedApplicationType);
            }
            else
            {
                parentPage = new PageReference('/apex/Personal_Information_Form?lid='+selectedLanguage+ '&tyId=' + selectedApplicationType + '&loctnId=' + selectedLocation);
            }
            
            parentPage.setRedirect(true);
            return parentPage;
            
            
        }catch(Exception e)
        {
            System.debug('e========='+e);
            acc.Translating_Language__c = 'en';
            
            return null;
        }
        
    }
    
    public void changeLanguage(){
        if(accId!=null)
            acc.Translating_Language__c = selectedLanguage;
    }
    public list <SelectOption> getlocationTem()
    {
        loacationList = new list<SelectOption>();
        loacationList.add(new SelectOption('', '--Select--'));
        Schema.DescribeFieldResult fieldResult = Account.Location_Team__c.getDescribe();
        List <Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        if(ple.size()>0)
        {
            for(Schema.PicklistEntry f : ple)
            { 
               if(f.getValue() != 'OnlineUser')
                loacationList.add(new SelectOption(f.getLabel(), f.getValue())); 
            }
        }
        return loacationList;
    }
    public void showPopup() {        
        displayPopup = true;    
    }
     public void hidePopup() {        
        displayPopup = false;    
    }
    
}