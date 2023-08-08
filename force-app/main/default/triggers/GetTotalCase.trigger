trigger GetTotalCase on Case (After insert) {

    // Declare variables
   // List<Contact> lstContact = New List<Contact>();
   Contact con = New Contact();
    List<ID> CaseContactID=new List<ID>();
    
    for (Case case1 : Trigger.New) {
        CaseContactID.add(case1.ContactId);
    }
    con = [select Id,Description from contact where Id in :CaseContactID];
    con.Description= string.valueOf( integer.valueof(con.Description)+1);
      
    update  con;  
}