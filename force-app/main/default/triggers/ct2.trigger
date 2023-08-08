trigger ct2 on Contact (after update) {

MedicalStore__c ms=new MedicalStore__c();

for(Contact c : Trigger.new){
ms.contact_email__c=c.lastname;
}


}