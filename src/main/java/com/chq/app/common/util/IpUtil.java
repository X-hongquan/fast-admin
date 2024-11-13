package com.chq.app.common.util;

import org.springframework.stereotype.Component;

import java.net.InetAddress;


public class IpUtil {


    public static boolean isPrivateIp(String ip) {
        try {
            InetAddress inetAddress = InetAddress.getByName(ip);
            String hostAddress = inetAddress.getHostAddress();

            // Check for site-local and loopback addresses
            if (inetAddress.isSiteLocalAddress() ||
                    inetAddress.isLoopbackAddress() ||
                    hostAddress.startsWith("127.")) {
                return true;
            }

            // Check for A, B, and C class private IP ranges
            if (hostAddress.startsWith("10.")) {
                return true;
            }
            if (hostAddress.startsWith("172.")) {
                int secondOctet = Integer.parseInt(hostAddress.split("\\.")[1]);
                return secondOctet >= 16 && secondOctet <= 31;
            }
            if (hostAddress.startsWith("192.168.")) {
                return true;
            }

            // Additional checks for other private or link-local addresses if needed
            if (hostAddress.startsWith("169.254.")) { // Link-local
                return true;
            }

        } catch (Exception e) {
            throw new IllegalArgumentException("Invalid IP address: " + ip, e);
        }
        return false;
    }
}
