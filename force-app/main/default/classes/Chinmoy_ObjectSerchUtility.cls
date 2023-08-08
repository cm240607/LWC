global class Chinmoy_ObjectSerchUtility {
    @AuraEnabled
    global static list <String> getObjectList()
    {
        //Return all objects in A-Z order
       list<schema.sObjectType> allObjects = Schema.getGlobalDescribe().Values();
        return null;
    }
@AuraEnabled
	global static object getObjectDetailList(String ObjectName)
    {
        //Return all objects in A-Z order
        return null;
    }
    
}