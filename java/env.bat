@echo on


@rem #####################
@rem  Edit these variables aaa
@rem #####################
set HOME=c:/projects/java/ebiz/java
set ROOT=%HOME%
set CLASSDIR=%ROOT%/classes
set JAVA_HOME=c:/java/jdk1.6.0_02
set ANT_HOME=c:/java/apache-ant-1.6.5
set AXIS_HOME=C:/java/axis2-1.1.1

@rem ########################
@rem  Don't touch this stuff!
@rem ########################

set _CLASSPATH=%VSHOME%/classes;
set _CLASSPATH=%_CLASSPATH%;%HOME%/lib/mysql-connector-java-5.0.4-bin.jar
set _CLASSPATH=%_CLASSPATH%;C:/java/jdom-1.0/lib/jdom.jar
set _CLASSPATH=%_CLASSPATH%;%HOME%/lib/commons-dbcp-1.2.1.jar
set _CLASSPATH=%_CLASSPATH%;%HOME%/lib/commons-pool-1.3.jar
set _CLASSPATH=%_CLASSPATH%;%HOME%/lib/paypal_base.jar
set _CLASSPATH=%_CLASSPATH%;%AXIS_HOME%/lib/mail-1.4.jar
set _CLASSPATH=%_CLASSPATH%;%AXIS_HOME%/lib/activation-1.1.jar





set CLASSPATH=;%CLASSDIR%;%_CLASSPATH%

set PATH=%JAVA_HOME%/bin;%ANT_HOME%/bin;%PATH%;%AXIS_HOME%/bin

echo %CLASSPATH%

java -version


 
