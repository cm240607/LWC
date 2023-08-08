({
	 onSelect : function(cmp, event, helper) {
		//alert("hii");
        var selectedPicklistValue= cmp.find("selectObject").get("v.value");
      // alert(selectedPicklistValue);
      cmp.set("v.selectedColor",selectedPicklistValue);
    },
    handleClick : function(cmp, event, helper) {		 
        var selectedPicklistValue= cmp.find("selectObject").get("v.value");
       alert(selectedPicklistValue);
      cmp.set("v.selectedColor",selectedPicklistValue);
	},
    loadOptions : function(cmp, event, helper) {		 
        var action = component.get("c.getObjectList");
        action.setParams({ objName : component.get("v.objName") });
	}   
   
})