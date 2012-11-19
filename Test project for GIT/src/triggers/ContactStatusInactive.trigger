/*---Trigger contacins very basic funcitonality that when contact is 
	 created or updated and value of Status field of contact changed to In-active then related user will
	 be Inactive ----- */
	
trigger ContactStatusInactive on Contact (after insert, after update) {
	List<Contact> conList = new List<Contact>();
	List<Contact> refinedConList = new List<Contact>();
	Set<Id> userIdSet = new Set<Id>();
	List<User> uList = new List<User>();
	List<User> finalUserList = new List<User>();
	//if(Trigger.isInsert){
		conList = trigger.new ;
	//}else if(Trigger.isUpdate){
		conList = trigger.new;
	//}		
		for(Contact c : conList){
			if(c.Status__c == 'In-active'){
				//refinedConList.add(c);
				userIdSet.add(c.User__c);
				
			}
		}
		triggerHandler.userUpdateMethod(userIdSet);
}