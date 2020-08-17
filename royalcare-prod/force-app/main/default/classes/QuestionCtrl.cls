public class QuestionCtrl {
    
    public List<QuestionWrapper> questionWrapperList{get;set;}
    public Double scoreCount;
    public Account acc{get;set;}
    public Account accForlang{get;set;}
    public Boolean msgFlag{get;set;}
    public Map<String,String> ansMap ;
    public Boolean flag{get;set;}
    public Boolean reviewflag{get;set;}
    Public Account tempAcc{get;set;}
    public String revt{get;set;}
    
    
    public QuestionCtrl(ApexPages.StandardController sc){
        reviewflag = false;
        revt = ApexPages.currentPage().getParameters().get('revt');
        if(revt == 'true')
        {
            reviewflag = true;
        }
        System.debug('reviewflag : '+reviewflag);
        tempAcc = new Account();
        flag = false;
        accForlang = new Account();
        ansMap = new Map<String,String>();
        ansMap.put('1', 'A');
        ansMap.put('2', 'B');
        ansMap.put('3', 'C');
        ansMap.put('4', 'D');
        msgFlag = false;
        acc = (Account) sc.getRecord();
        questionWrapperList = new List<QuestionWrapper>();
        scoreCount = 0.0;
        List<SelectOption> optionList = new List<SelectOption>(); 
        List<Account> accList = [SELECT Translating_Language__c,HHA_Training_School__c,Hear_about_us_explanation__c,How_did_you_hear_about_us__c, IsAllInformationFilled__c, IsTestSolved__c,Location_Team__c FROM Account WHERE Id=:acc.Id];
        accForlang = accList.get(0);
        
        tempAcc.How_did_you_hear_about_us__c = accForlang.How_did_you_hear_about_us__c ;    
        tempAcc.Hear_about_us_explanation__c = accForlang.Hear_about_us_explanation__c ;    
        tempAcc.HHA_Training_School__c = accForlang.HHA_Training_School__c;   
        
        
        
        
        
      //  for(Question__c que : [SELECT Id, Name, Question__c, Option_1__c, Option_2__c, Option_3__c, Option_4__c, Correct_Answer__c, Number_of_Options__c,Language__c FROM Question__c WHERE Language__c =: accForlang.Translating_Language__c]){
        for(Question__c que : [SELECT Id, Name, Question__c, Option_1__c, Option_2__c, Option_3__c, Option_4__c, Correct_Answer__c, Number_of_Options__c,Language__c FROM Question__c WHERE Language__c =: accForlang.Translating_Language__c  ORDER BY Name ASC]){
            optionList = new List<SelectOption>(); 
            optionList.add(new SelectOption('1', que.Option_1__c));
            optionList.add(new SelectOption('2', que.Option_2__c));
            optionList.add(new SelectOption('3', que.Option_3__c));
            if(que.Option_4__c != Null){
                optionList.add(new SelectOption('4', que.Option_4__c));
            }
            
            questionWrapperList.add(new QuestionWrapper(que,optionList));
        }
    }
    
    public class QuestionWrapper{
        public Question__c question{get;set;}
        public String selectedAnswer{get;set;}
       
        public List<SelectOption> options{get;set;}
        public QuestionWrapper(Question__c question, List<SelectOption> options){
            this.question = question;
            this.options = options;
        }
    }
    
    public PageReference calculateScore(){
        Integer queNo = 0;
        scoreCount = 0.0;
        
        Boolean queSolveFlag = false;
        if(questionWrapperList != null){
            for(QuestionWrapper questionWrapper : questionWrapperList){
                queNo++;
                queSolveFlag = true;
                if(questionWrapper != null && questionWrapper.selectedAnswer != null && questionWrapper.question.Correct_Answer__c != null){
               System.debug('question number ' + queNo);
                    if(queNo == 1 )
                        acc.Question_1__c = ansMap.get(questionWrapper.selectedAnswer);
                    
                    if(queNo == 2 )
                        acc.Question_2__c = ansMap.get(questionWrapper.selectedAnswer);
                    
                    if(queNo == 3 )
                        acc.Question_3__c = ansMap.get(questionWrapper.selectedAnswer);
                    
                    if(queNo == 4 )
                        acc.Question_4__c = ansMap.get(questionWrapper.selectedAnswer);
                    
                    if(queNo == 5 )
                        acc.Question_5__c = ansMap.get(questionWrapper.selectedAnswer);
                    
                    if(queNo == 6 )
                        acc.Question_6__c = ansMap.get(questionWrapper.selectedAnswer);
                    
                    if(queNo == 7 )
                        acc.Question_7__c = ansMap.get(questionWrapper.selectedAnswer);
                    
                    if(queNo == 8 )
                        acc.Question_8__c = ansMap.get(questionWrapper.selectedAnswer);
                    
                    if(queNo == 9 )
                        acc.Question_9__c = ansMap.get(questionWrapper.selectedAnswer);
                    
                    if(queNo == 10 )
                        acc.Question_10__c = ansMap.get(questionWrapper.selectedAnswer);
                    
                    if(queNo == 11 )
                        acc.Question_11__c = ansMap.get(questionWrapper.selectedAnswer);
                    
                    if(queNo == 12 )
                        acc.Question_12__c = ansMap.get(questionWrapper.selectedAnswer);
                    
                    
                    if(questionWrapper.selectedAnswer.equalsIgnorecase(questionWrapper.question.Correct_Answer__c)){
                        // System.debug('scoreCount '+scoreCount );
                        scoreCount++; 
                       
                    }
                    
                    System.debug('acc.Question_1__c' + acc.Question_1__c);
                  
                }else{
                    queSolveFlag = false;
                    msgFlag = true;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, System.Label.All_Questions_are_compulsory_Solve_Que_No + ' ' + queNo));
                    break;
                }
            }
        }
        if(queSolveFlag){
            acc.Test_Score__c = ((scoreCount/12)*100);
            acc.IsTestSolved__c = true;
            update acc;
            if(scoreCount<9){
                PageReference parentPage = new PageReference('/apex/FailResult?id=' + acc.Id);
                parentPage.setRedirect(true);
                return parentPage;
            }
            else{
                PageReference parentPage = new PageReference('/apex/FingerPrintPIF_Form?id=' + acc.Id);
                parentPage.setRedirect(true);
                return parentPage;
            }
            
        }
            
        return null;
    }
    
    public pageReference cancelQuestionPage(){
        //System.debug('value of filled field : ' + accForlang.IsAllInformationFilled__c);
        if(accForlang.IsAllInformationFilled__c == false)
            delete acc;
        Pagereference  page = new Pagereference('/apex/WelcomePage');
        page.setRedirect(true);
        return page;   
    }
    
    public PageReference previousFromQuestionaries(){
        PageReference parentPage ;
        if(reviewflag != true)
        parentPage = new PageReference('/apex/Personal_Information_Form?id='+acc.Id+'&lid='+acc.Translating_Language__c+'&tyId=HHA'+'&loctnId=' + accForlang.Location_Team__c);
        else
        parentPage = new PageReference('/apex/reviewpage?id='+acc.Id);    
        parentPage.setRedirect(true);
        return parentPage;
    }
    public void savePrevQues()
    {
        try{
            
            
            Account userUpdateValue = new Account();
            userUpdateValue = accForlang.clone();
            userUpdateValue.id = accForlang.id;
            
            userUpdateValue.How_did_you_hear_about_us__c = tempAcc.How_did_you_hear_about_us__c;    
            userUpdateValue.Hear_about_us_explanation__c = tempAcc.Hear_about_us_explanation__c ;    
            userUpdateValue.HHA_Training_School__c = tempAcc.HHA_Training_School__c ;    
            
            update userUpdateValue;
           
            flag = true;
        }
        catch(Exception e)
        {
            System.debug('something went wrong' + e.getMessage());
        }
        
    }
    
    
     public PageReference savePrevQuesfromReview(){
         
          try{
            
            
            Account userUpdateValue = new Account();
            userUpdateValue = accForlang.clone();
            userUpdateValue.id = accForlang.id;
            
            userUpdateValue.How_did_you_hear_about_us__c = tempAcc.How_did_you_hear_about_us__c;    
            userUpdateValue.Hear_about_us_explanation__c = tempAcc.Hear_about_us_explanation__c ;    
            userUpdateValue.HHA_Training_School__c = tempAcc.HHA_Training_School__c ;    
            
            update userUpdateValue;
              PageReference parentPage ;
              parentPage = new PageReference('/apex/reviewpage?id='+acc.Id);
              parentPage.setRedirect(true);
              return parentPage;
            //flag = true;
        }
        catch(Exception e)
        {
          ApexPages.addMessages(e);
            return null;
        }
       
    }
}