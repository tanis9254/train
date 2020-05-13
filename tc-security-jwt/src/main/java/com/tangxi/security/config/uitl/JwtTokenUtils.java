package com.tangxi.security.config.uitl;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;


/**
 * @author: tang.xi
 * @date: 2019-05-24
 * @description:
 */
@Component
public class JwtTokenUtils {
    private static final Logger LOGGER = LoggerFactory.getLogger(JwtTokenUtils.class);

    public static final String TOKEN_HEADER = "Authorization";
    public static final String TOKEN_PREFIX = "Bearer ";

    private static final String CLAIM_KEY_USERNAME = "sub";
    private static final String CLAIM_KEY_CREATED = "created";

    private static final String CLAIM_KEY_USER_ID = "jti";

    private static final String CLAIM_KEY_SOURCE = "source";

    private static String key;

    private static Integer ttl;

    @Value("${jwt.config.key}")
    public void setKey(String key) {
        JwtTokenUtils.key = key;
    }

    @Value("${jwt.config.ttl}")
    public void setTtl(Integer ttl) {
        JwtTokenUtils.ttl = ttl;
    }

    public static Integer getTtl() {
        return ttl;
    }

    /**
     * 验证token是否还有效
     *
     * @param authToken   客户端传入的token
     * @param userDetails 从数据库中查询出来的用户信息
     */
    public static boolean validateToken(String authToken, UserDetails userDetails) {
        if (userDetails == null) {
            return false;
        }
        String username = getUsername(authToken);
        if (username == null) {
            return false;
        }
        return username.equals(userDetails.getUsername()) && !isTokenExpired(authToken);
    }

    public static String generateToken(Long id, String userName) {
        Map<String, Object> claims = new HashMap<>();
        claims.put(CLAIM_KEY_USERNAME, userName);
        claims.put(CLAIM_KEY_USER_ID, id + "");
        claims.put(CLAIM_KEY_CREATED, new Date());
        return generateToken(id + "", claims);
    }

    public static String getSource(String token) {
        Claims claims = getClaims(token);
        return claims == null ? null : (String) claims.get(CLAIM_KEY_SOURCE);
    }

    /**
     * 解析JWT
     *
     * @param jwtStr * @return
     */
    public static Claims parseJWT(String jwtStr) {
        return Jwts.parser()
                .setSigningKey(key)
                .parseClaimsJws(jwtStr)
                .getBody();
    }

    public static String getUsername(String token) {
        Claims claims = getTokenBody(token);
        return claims == null ? null : claims.getSubject();
    }

    public static String getUserId(String token) {
        Claims claims = getTokenBody(token);
        return claims == null ? null : claims.getId();
    }

    public static String getUserRole(String token) {
        return "ROLE_ADMIN";
    }


    /**
     * 判断token是否已经失效
     */
    public static boolean isTokenExpired(String token) {
        Date expiredDate = getExpiredDate(token);
        if (expiredDate == null) {
            return true;
        }
        return expiredDate.before(new Date());
    }

    /**
     * 从token中获取过期时间
     */
    public static Date getExpiredDate(String token) {
        Claims claims = getClaims(token);
        return claims == null ? null : claims.getExpiration();
    }

    /**
     * 从token中获取JWT中的负载
     */
    private static Claims getClaims(String token) {
        Claims claims = null;
        try {
            claims = Jwts.parser()
                    .setSigningKey(key)
                    .parseClaimsJws(token)
                    .getBody();
        } catch (Exception e) {
            LOGGER.info("JWT格式验证失败:{}", token);
        }
        return claims;
    }

    /**
     * 根据负责生成JWT的token
     */
    private static String generateToken(String id, Map<String, Object> claims) {
        return Jwts.builder().setId(id)
                .setClaims(claims)
                .setExpiration(generateExpirationDate())
                .signWith(SignatureAlgorithm.HS256, key)
                .compact();
    }

    /**
     * 生成token的过期时间
     */
    private static Date generateExpirationDate() {
        return new Date(System.currentTimeMillis() + ttl);
    }


    private static Claims getTokenBody(String token) {
        return getClaims(token);
    }

}

