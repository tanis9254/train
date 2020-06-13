package com.tangxi.idempotent.interceptor;

import com.tangxi.idempotent.annotation.ApiIdempotent;
import com.tangxi.idempotent.service.ApiIdempotentTokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;

/**
 * @author: tang.xi
 * @date: 2020/6/13
 * @description:
 */
@Component
public class ApiIdempotentInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private ApiIdempotentTokenService apiIdempotentTokenService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        if (!(handler instanceof HandlerMethod)) {
            return true;
        }

        HandlerMethod handlerMethod = (HandlerMethod) handler;
        Method method = handlerMethod.getMethod();

        ApiIdempotent methodAnnotation = method.getAnnotation(ApiIdempotent.class);
        if (methodAnnotation != null) {
            check(request);
        }

        return true;
    }

    private void check(HttpServletRequest request) {
        apiIdempotentTokenService.checkToken(request);
    }
}
