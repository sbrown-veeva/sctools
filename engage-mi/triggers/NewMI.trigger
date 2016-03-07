trigger NewMI on Multichannel_Activity_Line_vod__c (after insert){ 

List <Medical_Inquiry_vod__c> MIInserts = new List<Medical_Inquiry_vod__c>();

for (Multichannel_Activity_Line_vod__c MCALNew : Trigger.New)    {   

            if (MCALNew.View_Order_vod__c == 1){    
                Medical_Inquiry_vod__c   MedicalInquiry = new Medical_Inquiry_vod__c (Inquiry_Text__c= MCALNew.Customer_field__c, Account_vod__c= [SELECT Account_vod__c FROM Multichannel_Activity_vod__c WHERE Id=:MCALNew.Multichannel_Activity_vod__c LIMIT 1].Account_vod__c);
                if (MedicalInquiry.Account_vod__c != null) {
                    // if (MedicalInquiry.Account_vod__c != '') {
                        MIInserts.add( MedicalInquiry ); 
                    // }
                }
            }
 }
insert MIInserts ;  
 }