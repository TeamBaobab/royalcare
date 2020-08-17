@isTest
public class QuestionCtrlTest {
    
    // Test for two skipped questions
    static testMethod void  testSkippedQue(){
        Account acc =  TestDataFactory.createAccountsWithHHA();
        TestDataFactory.createQuestionList();
        List<Question__c> queList = new List<Question__c>();
        Question__c question = new Question__c();
        question.Question__c = 'When assisting your client from the bed to the wheelchair, which of these actions is the most important?';
        question.Option_1__c = 'Place the foot support of the wheelchair so he/she can step on them.';
        question.Option_2__c = 'Have a blanket draped on the wheelchair.';
        question.Option_3__c = 'Have the brakes on the wheelchair in the locked position';
        question.Option_4__c = 'Place a pillow on the seat of the wheel chair.';
        question.Correct_Answer__c = '3';
        question.Number_of_Options__c = '4';
        question.Language__c = 'en';
        queList.add(question);
        question = new Question__c();
        question.Question__c = 'Hydraulic lifts are used when?';
        question.Option_1__c = 'A client is incontinent.';
        question.Option_2__c = 'A client is very weak and immobilized.';
        question.Option_3__c = 'A client is blind.';
        question.Option_4__c = 'A client needs oxygen.';
        question.Correct_Answer__c = '2';
        question.Number_of_Options__c = '4';
        question.Language__c = 'en';
        queList.add(question);
        insert queList;
        
        Test.startTest();
        PageReference pageRef = Page.ShowQuestionsPage;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        QuestionCtrl queCtrl = new QuestionCtrl(sc);

        List<String> selectedAnsList = new List<String>{'3','4','2','2','3','2'};
            // two questions skipped
            for(Integer i = 1; i < queCtrl.questionWrapperList.size()-1; i++){
                QuestionCtrl.QuestionWrapper questionWrapper = queCtrl.questionWrapperList.get(i);
                questionWrapper.selectedAnswer = selectedAnsList.get(i);
            }
       	
        queCtrl.calculateScore();
        queCtrl.cancelQuestionPage();
        queCtrl.previousFromQuestionaries();
        queCtrl.savePrevQues();
        Test.stopTest();
       // System.assertEquals(queCtrl.questionWrapperList[1].selectedAnswer, queCtrl.questionWrapperList[1].question.Correct_Answer__c);        
    }
    
    // Test for two wrong questions
    static testMethod void  testWrongQue(){
        Account acc =  TestDataFactory.createAccountsWithHHA();
        TestDataFactory.createQuestionList();
        List<Question__c> queList = new List<Question__c>();
        Question__c question = new Question__c();
        question.Question__c = 'When assisting your client from the bed to the wheelchair, which of these actions is the most important?';
        question.Option_1__c = 'Place the foot support of the wheelchair so he/she can step on them.';
        question.Option_2__c = 'Have a blanket draped on the wheelchair.';
        question.Option_3__c = 'Have the brakes on the wheelchair in the locked position';
        question.Option_4__c = 'Place a pillow on the seat of the wheel chair.';
        question.Correct_Answer__c = '3';
        question.Number_of_Options__c = '4';
        question.Language__c = 'en';
        queList.add(question);
        question = new Question__c();
        question.Question__c = 'Hydraulic lifts are used when?';
        question.Option_1__c = 'A client is incontinent.';
        question.Option_2__c = 'A client is very weak and immobilized.';
        question.Option_3__c = 'A client is blind.';
        question.Option_4__c = 'A client needs oxygen.';
        question.Correct_Answer__c = '2';
        question.Number_of_Options__c = '4';
        question.Language__c = 'en';
        queList.add(question);
        insert queList;
        
        Test.startTest();
        PageReference pageRef = Page.ShowQuestionsPage;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        QuestionCtrl queCtrl = new QuestionCtrl(sc);
        
        // two wrong questions
        List<String> selectedAnsList = new List<String>{'3','4','2','2','4','1'};
            
            for(Integer i = 0; i < queCtrl.questionWrapperList.size(); i++){
                QuestionCtrl.QuestionWrapper questionWrapper = queCtrl.questionWrapperList.get(i);
                questionWrapper.selectedAnswer = selectedAnsList.get(i);
            }
        
        queCtrl.calculateScore();
        queCtrl.cancelQuestionPage();
        queCtrl.previousFromQuestionaries();
        queCtrl.savePrevQues();
        queCtrl.savePrevQuesfromReview();
        Test.stopTest();
      //  System.assertEquals(queCtrl.questionWrapperList[0].selectedAnswer, queCtrl.questionWrapperList[0].question.Correct_Answer__c);          
        }
    
}