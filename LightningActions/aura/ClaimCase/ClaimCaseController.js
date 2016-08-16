({

    init : function(component, event, helper) {
        //Update the Case Status to "In Progress" and set the User to the current user
        var action = component.get("c.updateCase");
        action.setParams({"caseId": component.get("v.recordId")});
    
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(component.isValid() && state == "SUCCESS"){
                if (response.getReturnValue() == "Already Claimed") {
                    component.set("v.isCaseClaimed", true);
                } else {
                    $A.get("e.force:closeQuickAction").fire();
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Success!",
                        "message": "Case Status Updated"
                    });
                    toastEvent.fire();	
                    component.set("v.isCaseClaimed", true);
                    $A.get('e.force:refreshView').fire();
                }
             } else {
                console.log('There was a problem and the state is: '+state);
             }
         });
         $A.enqueueAction(action);
    },
    
    cancel : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    }
    
})