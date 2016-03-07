trigger NewMI on Multichannel_Activity_Line_vod__c (after insert){ 

List <Medical_Inquiry_vod__c> MIInserts = new List<Medical_Inquiry_vod__c>();

for (Multichannel_Activity_Line_vod__c MCALNew : Trigger.New)    {   

            if (MCALNew.Customer_field__c != null){
                // check if the customer field is populated
                if (MCALNew.Customer_field__c != '') {    
                
                    // create a new med inq
                    Medical_Inquiry_vod__c   MedicalInquiry = new Medical_Inquiry_vod__c (Inquiry_Text__c= MCALNew.Customer_field__c, Account_vod__c= [SELECT Account_vod__c FROM Multichannel_Activity_vod__c WHERE Id=:MCALNew.Multichannel_Activity_vod__c LIMIT 1].Account_vod__c);
                    
                    // check for MC content link and grab the product if possible
                    Multichannel_Content_vod__c[] mcc = [select Id, Product_vod__c, Product_vod__r.Name from Multichannel_Content_vod__c where Id = :MCALNew.Multichannel_Content_vod__c];
                    if (mcc.size()==1) {
                        // populate the product name on the med inq
                        MedicalInquiry.Product__c = mcc[0].Product_vod__r.Name;
                    }
                    if (MedicalInquiry.Account_vod__c != null) {
                        // if (MedicalInquiry.Account_vod__c != '') {
                            // add the MI for insert, if the account is valid
                            MIInserts.add( MedicalInquiry ); 
                        // }
                    }
                }
            }
 }
insert MIInserts ;  
 }