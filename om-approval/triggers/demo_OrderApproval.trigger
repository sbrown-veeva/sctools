trigger demo_OrderApproval on Order_vod__c (after update) {
    for (Integer i = 0; i < Trigger.new.size(); i++) {
 
        if (Trigger.new[i].Status_vod__c == 'Submitted_vod' 
            && (Trigger.old[i].Status_vod__c != Trigger.new[i].Status_vod__c)) {
 
            // create the new approval request to submit
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Submitted for approval. Please approve.');
            req.setObjectId(Trigger.new[i].Id);
            // submit the approval request for processing
            try{
            Approval.ProcessResult result = Approval.process(req);
            
            // display if the reqeust was successful
            System.debug('Submitted for approval successfully: '+result.isSuccess());
             }
             catch(System.DmlException ex)
             {
             System.debug('No Applicable approval process for the submited order');
             }
         }
    }
}