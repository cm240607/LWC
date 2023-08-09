public class Chinmoy {
public static List<Account> getAccounts(Date accountDate){
        System.debug('Date passed in: ' + accountDate);
        System.debug('Accounts: ' + [SELECT Id FROM Account WHERE CreatedDate =: accountDate]);
        System.debug('Accounts created in the last 52 days: ' + [SELECT Id FROM Account WHERE CreatedDate = LAST_N_DAYS:45 );
            
        return [SELECT Id FROM Account WHERE CreatedDate =: accountDate];
    }

}