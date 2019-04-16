package test.spring;

import java.util.Calendar;

import test.spring.ByeService;
import test.spring.HelloService;

public class HelloBean {
	
	public Name name;
	public HelloService helloService;
	public ByeService byeService;
	//---------------------------------------------- Getters & Setters
	public void setHelloService(HelloService helloService) {
		this.helloService = helloService;
	}
	
	public void setByeService(ByeService byeService) {
		this.byeService = byeService;
	}
	
	public Name getName() {
		return name;
	}

	public void setName(Name name) {
		this.name = name;
	}  

	//---------------------------------------------- Domain methods
	
	public String wishMe(Name name) {
		Calendar calendar = Calendar.getInstance();
		//simple if-else to check the time
		if(calendar.get(Calendar.HOUR_OF_DAY) <  12){
		//Invoking the injected helloService
			return helloService.sayHello(name); 
		} else {
		//Invoking the injected byeService
			return byeService.sayBye(name); 
		}
	}

}