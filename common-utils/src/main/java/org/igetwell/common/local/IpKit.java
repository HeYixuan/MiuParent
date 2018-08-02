package org.igetwell.common.local;

import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.HttpServletRequest;

public class IpKit {

    public static final String getIpAddr(final HttpServletRequest request) {
        /*if (request == null) {
            throw new Exception("getIpAddr method HttpServletRequest Object is null");
        }*/
        String ipString = request.getHeader("x-forwarded-for");
        if ( StringUtils.isEmpty(ipString) || "unknown".equalsIgnoreCase(ipString)) {
            ipString = request.getHeader("Proxy-Client-IP");
        }
        if ( StringUtils.isEmpty(ipString) || "unknown".equalsIgnoreCase(ipString)) {
            ipString = request.getHeader("WL-Proxy-Client-IP");
        }
        if ( StringUtils.isEmpty(ipString) || "unknown".equalsIgnoreCase(ipString) ) {
            ipString = request.getHeader("HTTP_CLIENT_IP");
        }
        if ( StringUtils.isEmpty(ipString) || "unknown".equalsIgnoreCase(ipString) ) {
            ipString = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (StringUtils.isEmpty(ipString) || "unknown".equalsIgnoreCase(ipString)) {
            ipString = request.getRemoteAddr();
        }
        return ipString;
    }
}
