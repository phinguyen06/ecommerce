package test.spring;

public class HelloServiceImpl implements HelloService {
	 public String sayHello(Name name) {
		 return "Hello  " + name.getFirstName() + " " + name.getLastName();
	 }
}
