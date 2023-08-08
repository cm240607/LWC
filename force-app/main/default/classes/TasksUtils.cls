public class TasksUtils
{
    @InvocableMethod
    public static void AccountValidated(List<Id> accountIds)
    {
        List<Contact> cont=[select id from contact
                          where AccountID in :accountIds];
 
        delete cont;
    }
}