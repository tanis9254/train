package com.rsy.rxf.springmvc.exception;


import com.netflix.hystrix.exception.HystrixBadRequestException;
import feign.Response;
import feign.Util;
import feign.codec.ErrorDecoder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;

import java.io.IOException;

/**
 * feign异常处理类
 *
 * @author: fei.yao
 * @date: 2018/7/1
 * @modified by:
 */
@Configuration
public class BizExceptionFeignErrorDecoder implements ErrorDecoder {

    private static final Logger logger = LoggerFactory.getLogger(BizExceptionFeignErrorDecoder.class);

    @Override
    public Exception decode(String methodKey, Response response) {
        String body = "";
        try {
            if (response.body() != null) {
                body = Util.toString(response.body().asReader());
            }
        } catch (IOException ignored) {
        }
        Exception exception = new BusinessException(response.status(), body);

        logger.warn("methodKey" + "\n" + exception.getMessage() + "\n" + response.toString());
        if (response.status() >= 400 && response.status() <= 499) {
            return new HystrixBadRequestException("request exception wrapper", exception);
        }
        return feign.FeignException.errorStatus(methodKey, response);
    }
}
