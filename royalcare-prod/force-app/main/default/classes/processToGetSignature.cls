public class processToGetSignature
{
    public PageReference getPageLink( )
    {
            id eContractId = ApexPages.currentPage().getParameters().get('econtractid');
            id conid = apexPages.currentPage().getParameters().get('contactid');
            list<Sertifi2_0__TestContract__c> eContractList = new  list<Sertifi2_0__TestContract__c>();
            String fileId, documentId;
            if(eContractId != null )
            {
                 eContractList = [SELECT id, Sertifi2_0__ContractID__c, (SELECT id, Sertifi2_0__Sertifi_ID__c FROM Sertifi2_0__EDocuments__r) FROM Sertifi2_0__TestContract__c WHERE id =: eContractId ];
            }
            if(eContractList.size() > 0)
            {
                for(Sertifi2_0__TestContract__c eContract : eContractList)
                {
                    if(eContract.Sertifi2_0__ContractID__c != null)
                        fileId = eContract.Sertifi2_0__ContractID__c ;
                    
                    if(eContract.Sertifi2_0__EDocuments__r.size() > 0)
                    {
                        if(eContract.Sertifi2_0__EDocuments__r[0].Sertifi2_0__Sertifi_ID__c != null)
                            documentId = eContract.Sertifi2_0__EDocuments__r[0].Sertifi2_0__Sertifi_ID__c;
                    }
                }
            }
            
            //fileId = '.AQBzkd6HPELO69nquk9_Xcjj0';
            //documentId = '.AQCYq7swkLsuR6SkCNBGNRTk0';
            System.debug('I am here ----'+conid);
            contact con = [SELECT id,Email FROM Contact WHERE id =:conid];
            System.debug('I am here2 ----');
            List<Sertifi2_0.GetLinkParameter> lst = new List<Sertifi2_0.GetLinkParameter>();
            System.debug('fileId - '+fileId);
            System.debug('documentId - '+documentId);
            //Create request parameter
            Sertifi2_0.GetLinkParameter l = new Sertifi2_0.GetLinkParameter();
            l.FileId = fileId;//'<!-- FileId -->';
            l.DocumentId = documentId;//'<!-- DocumentId -->';
            l.LinkType = Sertifi2_0.GetLinkType.FileSigningPageLink;
            l.SignerEmail = con.email;//'sertifysigner@sample.com';//'<!-- SignerEmail -->';
            lst.add(l);
            
            l = new Sertifi2_0.GetLinkParameter();
            l.FileId = fileId;//'<!-- FileId -->';
            l.DocumentId = documentId;//'<!-- DocumentId -->';
            l.LinkType = Sertifi2_0.GetLinkType.SigningPageLink;
            l.SignerEmail = con.email;//'sertifysigner@sample.com';//'<!-- SignerEmail -->';
            lst.add(l);
            
            //Creating GetLink request
            Sertifi2_0.GetLinkRequest request = new Sertifi2_0.GetLinkRequest();
            request.LinkParameters = lst;
            request.SettingsName = 'Settings'; //set default settings name
            
            //Make the call
            Sertifi2_0.GetLinkResponse response = Sertifi2_0.SertifiSFAPI.GetLink(request);
            //System.Debug('Results: ' + response.Results);
            
            //Iterate over results
            for (Sertifi2_0.GetLinkResult result : response.Results) {
                System.Debug('Type: ' + result.LinkType + ' Link: ' + result.Link);
            }
            
            //access the links directly.  The links will be returned in the same order they were sent
            //so it is not neccesary to check link types
            //the response results has everything that was in the request as well as the returned link and error if any
            //  String DocumentId
            //  String Error
            //  String FileId
            //  String Link
            //  Sertifi2_0.GetLinkType LinkType
            //  String SignerEmail
            if(response != null && !test.isRunningTest())
            {
                    string permalinkLandingPage = response.Results[0].Link;
                    string permalinkSigningPage = response.Results[1].Link;    
                    
                    //It is probably a good idea to check for errors
                    if (response.Results[0].Error != null)
                        system.debug('Error retrieving landing page link: ' + response.Results[0].Error);
                    else
                        System.Debug('Landing page link: ' + permalinkLandingPage);
                        
                    if (response.Results[1].Error != null)   
                            system.debug('Error retrieving signing page link: ' + response.Results[1].Error);
                    else
                            System.Debug('Signing page link: ' + permalinkSigningPage);
                  
                  if(permalinkSigningPage != null)
                  {
                    //  System.debug('permalinkSigningPage @@ '+ permalinkSigningPage);
                   //   permalinkSigningPage = permalinkSigningPage+'&redirecturl=https://developer-royalcareapptest.cs50.force.com/application/';
                    //  System.debug('permalinkSigningPage--'+ permalinkSigningPage);
                      PageReference pg = new PageReference(permalinkSigningPage);
                      pg.setRedirect(true);
                      return pg;
                  }
              }
              
        return null;
    }
}