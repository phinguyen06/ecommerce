package test.spring;
 
public class ByeServiceImpl implements ByeService {
	 public String sayBye(Name name) {
		return "Bye " + name.getFirstName() + " " + name.getLastName();
	}
}
