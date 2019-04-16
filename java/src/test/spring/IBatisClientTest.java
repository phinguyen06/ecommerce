package test.spring;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.ebiz.data.Status;
import test.spring.IBatisReference;

public class IBatisClientTest {
    public static void main(String[] args) {
        try {
            System.out.println("IBatisClient started");

            // load spring beans
            ApplicationContext ctx = new ClassPathXmlApplicationContext("spring_applicationContext.xml");
            System.out.println("Classpath loaded");
            IBatisReference service = (IBatisReference) ctx.getBean("statusService");            
            
            //execute service impl
            Status[] statuses = service.getStatus();
            for( int i=0; i<statuses.length; i++ ){
            	System.out.println("status["+i+"] : " + statuses[i]);
            }

            System.out.println("Hurry!!!! Its done!");
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
}
