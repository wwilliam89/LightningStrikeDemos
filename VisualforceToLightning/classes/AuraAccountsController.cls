public class AuraAccountsController {

   @AuraEnabled
   public static List<Account> getAccounts() {
       return [SELECT name, Type, NumberOfEmployees, Phone
               FROM Account LIMIT 5];
   }

}