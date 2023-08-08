public with sharing class TheController {

    public List<Account> getAccounts()

    {

        return [Select Id, Name, AccountNumber, OwnerId, Phone, Fax From Account limit 10];

    }

}