<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:context="http://www.springframework.org/schema/context"
	xmlns:mvc="http://www.springframework.org/schema/mvc" 
	xmlns:aop="http://www.springframework.org/schema/aop"
	xsi:schemaLocation="http://www.springframework.org/schema/beans 
		http://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context 
        http://www.springframework.org/schema/context/spring-context-3.1.xsd
        http://www.springframework.org/schema/mvc 
        http://www.springframework.org/schema/mvc/spring-mvc-3.1.xsd
		http://www.springframework.org/schema/aop
		http://www.springframework.org/schema/aop/spring-aop-3.1.xsd">

	<context:component-scan base-package="${controllerPackage}" />

	<!-- 启用 @AspectJ	-->
	<aop:aspectj-autoproxy />

	<!--fastjson支持配置开始 -->
    <mvc:annotation-driven>
        <!--不使用默认消息转换器 -->
        <mvc:message-converters register-defaults="false">
            <!--spring消息转换器 -->
            <bean class="org.springframework.http.converter.ByteArrayHttpMessageConverter"/>
            <bean class="org.springframework.http.converter.BufferedImageHttpMessageConverter"/>

            <!--解决@Responcebody中文乱码问题 -->
            <bean class="org.springframework.http.converter.StringHttpMessageConverter">
                <constructor-arg value="UTF-8"/>
            </bean>
            <!--配合fastjson支持 -->
            <bean class="com.alibaba.fastjson.support.spring.FastJsonHttpMessageConverter">
                <property name="supportedMediaTypes">
                    <list>
                        <!--顺序保持这样,避免IE下载出错 -->
                        <value>text/html;charset=UTF-8</value>
                        <value>application/json</value>
                    </list>
                </property>
                <property name="fastJsonConfig" ref="fastJsonConfig"/>
            </bean>
        </mvc:message-converters>
    </mvc:annotation-driven>

    <!--fastJsonConfig -->
    <bean id="fastJsonConfig" class="com.alibaba.fastjson.support.config.FastJsonConfig">
        <!--默认编码格式 -->
        <property name="charset" value="UTF-8"/>

        <property name="serializerFeatures">
            <list>
                <value>WriteNullListAsEmpty</value>
                <!--设置使用文本方式输出日期，fastjson默认是long-->
                <value>WriteDateUseDateFormat</value>
                <value>PrettyFormat</value>
                <!--设置null值也要输出，fastjson默认是关闭的-->
                <value>WriteMapNullValue</value>
                <value>WriteNullStringAsEmpty</value>
                <value>WriteNullListAsEmpty</value>
                <value>DisableCircularReferenceDetect</value>
            </list>
        </property>

    </bean>
    <!--fastjson支持配置结束 -->

	<mvc:annotation-driven />
    <mvc:resources location="/static/" mapping="/static/**"/>

	<bean id="multipartResolver"
		class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
		<property name="defaultEncoding" value="utf-8" />
		<property name="maxUploadSize" value="10485760000" />
		<property name="maxInMemorySize" value="40960" />
		<property name="resolveLazily" value="true" />
	</bean>

    <!--视图解析器-->
    <!--配置试图解析器  -->
    <bean class="org.springframework.web.servlet.view.freemarker.FreeMarkerViewResolver">
        <property name="order" value="1"></property>
        <property name="suffix" value=".ftl"></property>
        <property name="contentType" value="text/html;charset=utf-8"></property>
        <property name="viewClass">
            <value>org.springframework.web.servlet.view.freemarker.FreeMarkerView</value>
        </property>
        <property name="requestContextAttribute" value="request"></property>
    </bean>
    <!--加载freemarker属性  -->
    <bean id="propertySetting" class="org.springframework.beans.factory.config.PropertiesFactoryBean">
        <property name="locations">
            <list>
                <value>classpath:freemarker.properties</value>
            </list>
        </property>
    </bean>
    <!--freemarker配置  -->
    <bean id="freemarkerConfig" class="org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer">
        <property name="templateLoaderPath">
            <value>/WEB-INF/ftl/</value>
        </property>
        <property name="freemarkerSettings" ref="propertySetting"></property>
    </bean>

</beans>