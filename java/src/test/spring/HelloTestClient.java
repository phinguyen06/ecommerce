package test.spring;

import org.springframework.context.support.ClassPathXmlApplicationContext;

import test.spring.HelloBean;
import test.spring.Name;

public class HelloTestClient {
	public static void main(String[] args) {
		try {
			System.out.println("TestClient started");
		
			//Load the hello.xml to classpath
			ClassPathXmlApplicationContext appContext = 
			new ClassPathXmlApplicationContext(new String[] { "spring_hello.xml" });
		
			System.out.println("Classpath loaded");
		
			HelloBean helloBean = (HelloBean) appContext.getBean("helloBean");
		
			Name name = new Name();
			name.setFirstName("Phi");
			name.setLastName("Nguyen");
			String str = helloBean.wishMe(name);
		
			System.out.println(str);
			System.out.println("TestClient end");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
