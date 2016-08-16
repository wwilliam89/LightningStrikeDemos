({    
    init : function(component, event, helper) {
        var action = component.get("c.getCaseStudy");
        action.setParams({"recordId": component.get("v.recordId")});
    
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(component.isValid() && state == "SUCCESS"){
                component.set("v.caseStudy", response.getReturnValue());
             } else {
                console.log('There was a problem and the state is: '+state);
             }
         });
         $A.enqueueAction(action);
	},
    
	saveUserForm : function(component, event, helper) {
        
        var passwordCmp = component.find("userPassword");
        var emailCmp = component.find("userEmail");
        
        helper.validatePassword(component, event, helper);
        helper.validateEmail(component, event, helper);

        if (passwordCmp.get("v.errors") == null && emailCmp.get("v.errors") == null) {
            component.set("v.hasErrors", false);
        	helper.save(component,name,password,email);         
        } else {
            component.set("v.hasErrors", true);
        }
    },
    
    cancel : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    }
})