/*
* Apex controller that currently contains only one method to send sms message
*/
global class TwilioSendSMSController {

  /*
  * This method uses the Twilio for Salesforce library class and method to
  * send the message using the Twilio api.
  */
  @AuraEnabled
    webService static String sendMessages(String mobNumber, String message, Id contactId) {
        System.debug('the mobNumber is: '+ mobNumber + ' and the message is: '+ message + ' and contactId is: ' + contactId);
        
        if (mobNumber == null) {
          mobNumber = getPhoneNumber(contactId);
        }
            
        try {
            TwilioRestClient client = TwilioAPI.getDefaultClient();

            Map<String,String> params = new Map<String,String> {
                    'To'   => mobNumber,
                    'From' => '<your Twilio number>',
                    'Body' => message
                };
            TwilioSMS sms = client.getAccount().getSMSMessages().create(params);
            return sms.getStatus();
        } catch(exception ex) {
            System.debug('oh no, it failed: '+ex);
            return 'failed';
        }
    }
    
    @AuraEnabled
    public static String getPhoneNumber(Id contactId) {
          Contact currentRecord = [SELECT Phone FROM Contact WHERE Id = :contactId];      
          return currentRecord.Phone.replace(' ', '').replace('-', '').replace(')', '').replace('(', '');
    }
}
