package com.chq.app.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

public class JwtUtil {


    private static final String secretKey = "appwqtqweq";

    public static String createJwt(String id) {
        String jwt = Jwts.builder()
                .setId(id)
                .signWith(SignatureAlgorithm.HS512, secretKey).compact();
        return jwt;
    }

    public static String parser(String jwt) {
        Jws<Claims> claimsJws = Jwts.parser().setSigningKey(secretKey).parseClaimsJws(jwt);
        Claims claims = claimsJws.getBody();
        String uuid = claims.getId();
        return uuid;
    }
}
