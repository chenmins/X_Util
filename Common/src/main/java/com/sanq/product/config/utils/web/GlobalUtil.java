package com.sanq.product.config.utils.web;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializeConfig;
import com.alibaba.fastjson.serializer.SerializeFilter;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.sanq.product.config.utils.entity.Base;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public class GlobalUtil {

    public static String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip != null && ip.length() != 0 && !"unknown".equalsIgnoreCase(ip)) {
            // 多次反向代理后会有多个ip值，第一个ip才是真实ip
            if (ip.indexOf(",") != -1) {
                ip = ip.split(",")[0];
            }
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("X-Real-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

    public static Map<String, Object> bean2Map(Object entity) {
//        Map<String, Object> map = new HashMap<>();
//        if (entity == null) {
//            return map;
//        }
//        Class clazz = entity.getClass();
//        Field[] fields = clazz.getDeclaredFields();
//        try {
//            for (Field field : fields) {
//                field.setAccessible(true);
//                if (field.get(entity) != null) {
//                    map.put(field.getName(), field.get(entity));
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return map;
        return (Map<String, Object>) JSON.toJSON(entity);
    }
}
