public with sharing class AttachmentController {

    public List<Attachment> attach = null;
    public String accountId;
    public transient String base64;
    public Boolean file {get;set;}
    public Account acc {get;set;}
	//final string APPLICATION_GUEST_USER = '00541000003I0XhAAK';
	final string UPLOAD_GUEST_USER = '0052M0000093YsOQAU';
    final string WORK_FLOW_AUTOMATION = '0052M000008zDxPQAU';
    
    public AttachmentController(ApexPages.StandardController sc) {
        file = false;
        accountId = ApexPages.currentPage().getParameters().get('id');
        
        acc = [SELECT Id,Translating_Language__c,IsAllInformationFilled__c,
               FirstName,MiddleName,LastName,Location_Team__c FROM Account WHERE Id =:accountId];
        
    }
    
    public String getBase64()
    {
        return base64;
    }
    public void setbase64(String base64)
    {
        this.base64 = base64;
    }
    public String fileName {get; set;}
    public String contentType {get; set;}
    
    public void saveFile()
    {
        System.debug('base64' +base64);
        String base641 = base64;
        System.debug('base641' +base641);
       
        Attachment a = new Attachment(parentId = accountId, Body =  EncodingUtil.base64Decode(base641), name = fileName,ContentType = contentType);
        insert a;
    }
    
    /**
     * This method only displays documents for application guest user.
     * This means that user with a role of workflow or any other role won't see any list of documents 
     * on the uploadManually form.
     * 
     * */
    public List<Attachment> getAttachment() {
        
            attach = [select Id,parentId,name,ownerId from Attachment where (parentId =:accountId and ownerId=:this.UPLOAD_GUEST_USER) ];
        	System.debug('attachment attributes == ' + attach);
        	if(attach.size() < 1){
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No Attachment To Display'));
             return null;       
       		}
           
            return attach;
    }
    
}