trigger Demo_MC_Consent on Multichannel_Consent_vod__c (after insert, after update) {

    // updates Account based field for TOV opt in based on MC consent capture
    
    List<Multichannel_Consent_vod__c> mc = [select Id, RecordType.Name, Opt_Type_vod__c, Account_vod__c,
        Sub_Channel_Key_vod__c from Multichannel_Consent_vod__c where Id in :trigger.newMap.values()];
    List<Account> accUpd = new List<Account>();
    Set<Id> optinAcc = new Set<Id>();
    Set<Id> optoutAcc = new Set<Id>();
            
    for (Multichannel_Consent_vod__c m : mc) {
    
        if (m.RecordType.Name == 'MA reporting' && m.Sub_Channel_Key_vod__c == 'Transfer of Value Opt-in') {
            if (m.Opt_Type_vod__c == 'Opt_In_vod') {optinAcc.add(m.Account_vod__c);} else {optoutAcc.add(m.Account_vod__c);}
        }
    }
    
    // process opt ins then opt outs
    for (Id i1 : optinAcc) {
        accUpd.add(new Account(Id = i1, TOV_Opt_in__c = true));
    }
    update accUpd;
    
    accUpd = new List<Account>();
    
    for (Id i2 : optoutAcc) {
        accUpd.add(new Account(Id = i2, TOV_Opt_in__c = false));
    }
    update accUpd;
}