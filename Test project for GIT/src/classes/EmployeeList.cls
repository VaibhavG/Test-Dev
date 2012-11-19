public with sharing class EmployeeList {
	public List<Helper> helperList {get;set;}
	public Map<String, Job_Role__c> mapConJob;
	public Map<String, Leave_Request__c> mapConLeave;
	public EmployeeList(){
		generateList();
	}
	
	public void generateList(){
		List<Contact> conList = new List<Contact>([Select c.User__c, c.Title, c.SystemModstamp, c.Status__c, c.Salutation, c.ReportsToId, c.Phone, c.OwnerId, c.OtherStreet, c.OtherState, c.OtherPostalCode, c.OtherPhone, c.OtherCountry, c.OtherCity, c.Name, c.MobilePhone, c.MasterRecordId, c.MailingStreet, c.MailingState, c.MailingPostalCode, c.MailingCountry, c.MailingCity, c.Level__c, c.LeadSource, c.LastName, c.LastModifiedDate, c.LastModifiedById, c.LastCUUpdateDate, c.LastCURequestDate, c.LastActivityDate, c.Languages__c, c.JigsawContactId, c.Jigsaw, c.IsDeleted, c.Id, c.HomePhone, c.FirstName, c.Fax, c.EmailBouncedReason, c.EmailBouncedDate, c.Email, c.Description, c.Department, c.CreatedDate, c.CreatedById, c.Birthdate, c.AssistantPhone, c.AssistantName, c.Approval_Status__c, c.AccountId From Contact c order by c.name asc limit 10]);
		system.debug('===========conList========' +conList);
		mapConJob = new Map<String, Job_Role__c>();
		mapConLeave = new Map<String, Leave_Request__c>();
		for(Contact c : conList){
			List<Job_Role__c> jList = new List<Job_Role__c>([Select j.SystemModstamp, j.Start_Date__c, j.Name, j.LastModifiedDate, j.LastModifiedById, j.LastActivityDate, j.Job_Title__c, j.IsDeleted, j.Id, j.End_Date__c, j.Employee__c, j.CreatedDate, j.CreatedById, j.Base_Salary__c From Job_Role__c j where j.Employee__c =: c.Id limit 1]);
			system.debug('===========jList========' +jList);
			if(jList != null){
				
				for(Job_Role__c j : jList){
					mapConJob.put(c.Id,j);
				}
				system.debug('===========mapConJob========' +mapConJob);
			}
			List<Leave_Request__c> lList = new List<Leave_Request__c>([Select l.SystemModstamp, l.Start_Date__c, l.Name, l.Leave_Taken__c, l.LastModifiedDate, l.LastModifiedById, l.LastActivityDate, l.IsDeleted, l.Id, l.End_Date__c, l.Employee__c, l.CreatedDate, l.CreatedById From Leave_Request__c l where l.Employee__c =: c.Id limit 1]);
			system.debug('===========lList========' +lList);
			if(lList != null && lList.size() == 1){
				
				for(Leave_Request__c l : lList){
					mapConLeave.put(c.Id,l);
				}
				system.debug('===========mapConLeave========' +mapConLeave);
			}
		}
		helperList = new List<Helper>();
		for(Contact c : conList){
			Helper helperObj = new Helper();
			helperObj.empName = c.Name;
			if(mapConJob.get(c.Id) != null){
				Job_Role__c j = new Job_Role__c();
				j = mapConJob.get(c.Id);
				helperObj.jobTitle = j.Name;
				helperObj.baseSalary = j.Base_Salary__c;
			}
			if(mapConLeave.get(c.Id) != null){	
				Leave_Request__c l = new Leave_Request__c();
				l =  mapConLeave.get(c.Id);
				helperObj.leaveTaken = l.Leave_Taken__c;
			}
			helperList.add(helperObj);
			system.debug('===========helperList========' +helperList);
		}
	}
	
	public class Helper{
		public String empName{get;set;}
		public String jobTitle{get;set;}
		public decimal baseSalary{get;set;}
		public decimal leaveTaken{get;set;}
	}
}