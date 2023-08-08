trigger ct1 on Contact (before insert) {

for (Contact c: trigger.new){
if (c.firstName==null){
c.addError('No First Name1');
}
}

}