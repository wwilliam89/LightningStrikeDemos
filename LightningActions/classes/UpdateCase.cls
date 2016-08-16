public class UpdateCase {

    @AuraEnabled
    public static String updateCase(String caseId) {
        Case caseInstance = [SELECT OwnerId,Status FROM Case WHERE id=:caseId];
        if (caseInstance.Status == 'In Progress') {
            return 'Already Claimed';
        }
        caseInstance.OwnerId = UserInfo.getUserId();
        caseInstance.Status = 'In Progress';
        update caseInstance;
        return 'Success';
    }
    
}