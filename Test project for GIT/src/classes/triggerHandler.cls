public class triggerHandler {
	@future
  	public static void userUpdateMethod(Set<Id> userIdSet) {
  	List<User> uList = new List<User>();
	List<User> finalUserList = new List<User>();
  	uList = [Select u.IsActive, u.Id, u.FirstName, u.Email From User u where u.Id IN: userIdSet];
		for(User u : uList){
			u.IsActive = false;
			finalUserList.add(u);
		}
		update finalUserList;
  }
}