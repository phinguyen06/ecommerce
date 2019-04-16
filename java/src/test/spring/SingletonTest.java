package test.spring;

import org.springframework.context.*;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.ebiz.cache.LoggerDataProvider;

public class SingletonTest {
	public static void main(String[] args) throws Exception
	{
		ApplicationContext context =
			new ClassPathXmlApplicationContext(new String[] {"spring_services.xml"});
		
		//at this point spring framework should load our singleton already!
		System.out.println("BEFORE log size:"+LoggerDataProvider.getInstance().getData());
		LoggerDataProvider.getInstance().debug("This is a test");
		System.out.println("AFTER log size:"+LoggerDataProvider.getInstance().getData());
	}
}
