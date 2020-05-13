package com.tangxi.security.config.filters;

import cn.hutool.json.JSONUtil;
import com.tangxi.security.config.uitl.JwtTokenUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import rxf.springmvc.ResultModel;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class JwtAuthenticationTokenFilter extends OncePerRequestFilter {

    public static final String CURRENT_ACCOUNT_TOKEN_KEY = "CURRENT_LOGIN_ACCOUNT:JWT_TOKEN:";

    @Autowired
    private UserDetailsService jwtUserDetailService;
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String authHeader = request.getHeader(JwtTokenUtils.TOKEN_HEADER);
        if (authHeader == null || !authHeader.startsWith(JwtTokenUtils.TOKEN_PREFIX)) {
            // 没有token 直接下一步
            filterChain.doFilter(request, response);
            return;
        }
        String authToken = authHeader.substring(JwtTokenUtils.TOKEN_PREFIX.length());
        String userId = JwtTokenUtils.getUserId(authToken);
        if (userId == null) {
            filterChain.doFilter(request, response);
            return;
        }
        String key = CURRENT_ACCOUNT_TOKEN_KEY + userId;
        if (!redisTemplate.hasKey(key)) {
            filterChain.doFilter(request, response);
            return;
        }
        //todo:由于账号不足，暂时先允许同一账号多次登录。
        String newToken = (String) redisTemplate.opsForValue().get(key);
        if (!StringUtils.equals(newToken, authToken)) {
            notLoginResponse(response);
            return;
        }
        String username = JwtTokenUtils.getUsername(authToken);
        if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
            UserDetails userDetails = null;
            // 处理账户被删除的情况
            try {
                String usernameAndSource = username;
                String source = JwtTokenUtils.getSource(authToken);
                if (StringUtils.isNotEmpty(source)) {
                    usernameAndSource = usernameAndSource.concat("@@").concat(source);
                }
                userDetails = this.jwtUserDetailService.loadUserByUsername(usernameAndSource);
            } catch (Exception e) {}
            if (userDetails == null) {
                notLoginResponse(response);
                return;
            }
            if (JwtTokenUtils.validateToken(authToken, userDetails)) {
                UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
                authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }
        } else {
            notLoginResponse(response);
            return;
        }
        filterChain.doFilter(request, response);
    }

    private void notLoginResponse(HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.getWriter().println(JSONUtil.parse(ResultModel.failure(401,"暂未登录或token已经过期")));
        response.getWriter().flush();
    }
}
