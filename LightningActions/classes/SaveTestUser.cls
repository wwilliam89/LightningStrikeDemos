public class SaveTestUser {
    
    @AuraEnabled 
    public static Test_User__c saveUser(String name, String password, String email, String caseStudy) {  
    
        Test_User__c testUser = new Test_User__c(Name=name, Password__c=password, Email__c=email, Case_Study__c=caseStudy);

        upsert testUser;
        return testUser;
    }
    
    @AuraEnabled
    public static String getCaseStudy(String recordId) {
        Case_Study__c caseStudyInstance = [SELECT Name FROM Case_Study__c WHERE id=:recordId];
        return caseStudyInstance.Name;
    }

}