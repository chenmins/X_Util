<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:p="http://www.springframework.org/schema/p"
       xmlns:dubbo="http://code.alibabatech.com/schema/dubbo"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
	http://www.springframework.org/schema/beans/spring-beans-3.1.xsd
    http://code.alibabatech.com/schema/dubbo
    http://code.alibabatech.com/schema/dubbo/dubbo.xsd">

    <dubbo:application name="" />

    <dubbo:registry protocol="zookeeper" address="${r"${zookeeper.address}"}" />

    <dubbo:protocol name="dubbo" port="${r"${zookeeper.port}"}" />

    <!-- 监控中心配置，protocol="registry"，表示从注册中心发现监控中心地址 -->
    <dubbo:monitor protocol="registry"/>

    <!-- 当ProtocolConfig和ServiceConfig某属性没有配置时,采用此缺省值 -->
    <dubbo:provider timeout="30000" threadpool="fixed" threads="100" accepts="1000"/>

    <#list tables as table>
    <dubbo:service interface="${servicePackage}.${table.javaName?cap_first}Service" version="1.0.0" timeout=""
                   ref="${table.javaName}Service" />
    </#list>
</beans>