@echo off


@rem #####################
@rem  Edit these variables
@rem #####################
set HOME=c:/projects/java/ebiz/paypal
set ROOT=%HOME%
set CLASSDIR=%ROOT%/classes
set JAVA_HOME=c:/java/jdk1.6.0_02
@rem set JAVA_HOME=c:/java/j2sdk1.4.2_12
set ANT_HOME=c:/java/apache-ant-1.6.5
set AXIS_HOME=C:/java/axis2-1.4


@rem ########################
@rem  Don't touch this stuff!
@rem ########################

set EAI_CLASSPATH=%VSHOME%/classes;
set EAI_CLASSPATH=%EAI_CLASSPATH%;%ROOT%
set EAI_CLASSPATH=%EAI_CLASSPATH%;%HOME%/resources

set AXIS_LIB=%AXIS_HOME%/lib/axis2-kernel-1.1.1.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/axiom-api-1.2.2.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/axiom-dom-1.2.2.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/axis2-adb-1.1.1.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/axis2-java2wsdl-1.3.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/axis2-jaxbri-1.1.1.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/axiom-impl-1.2.2.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/axis2-jibx-1.1.1.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/axis2-saaj-1.1.1.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/axis2-spring-1.1.1.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/axis2-tools-1.1.1.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/axis2-xmlbeans-1.1.1.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/stax-api-1.0.1.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/activation-1.1.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/annogen-0.1.0.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/backport-util-concurrent-2.2.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/commons-codec-1.3.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/commons-fileupload-1.1.1.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/commons-httpclient-3.0.1.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/commons-io-1.2.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/commons-logging-1.1.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/geronimo-spec-jms-1.1-rc4.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/jakarta-httpcore-4.0-alpha2.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/jaxb-api-2.0.2.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/jaxb-impl-2.0.2.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/jaxb-xjc-2.0.2.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/jaxen-1.1-beta-10.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/jibx-bind-1.1.3.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/jibx-run-1.1.3.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/mail-1.4.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/neethi-2.0.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/servletapi-2.3.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/woden-1.0.0M6.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/wsdl4j-1.6.2.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/wstx-asl-3.2.0.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/xalan-2.7.0.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/xbean-2.2.0.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/xercesImpl-2.8.1.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/xml-apis-1.3.03.jar
set AXIS_LIB=%AXIS_LIB%;%AXIS_HOME%/lib/XmlSchema-1.2.jar

set AXIS2_HOME=%AXIS_HOME%

set CLASSPATH=;%CLASSDIR%;%EAI_CLASSPATH%;%AXIS_LIB%

set PATH=%JAVA_HOME%/bin;%ANT_HOME%/bin;%PATH%;%AXIS_HOME%/bin

echo %CLASSPATH%

java -version


 
