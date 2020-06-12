package com.rsy.rxf.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 验证码
 * 
 * @author huagang.liao
 */
public class MobileAuthCodeUtils {

    private final static Logger LOGGER = LoggerFactory.getLogger(MobileAuthCodeUtils.class);

    private MobileAuthCodeUtils(){
    }

    private static MobileAuthCodeUtils instance = null;

    public static MobileAuthCodeUtils getInstance() {
        if (instance == null) {
            instance = new MobileAuthCodeUtils();
        }
        return instance;
    }

    public String generateCode() {
        return (int) ((Math.random() * 9 + 1) * 100000) + "";
    }

    public String generateFourCode() {
        return (int) ((Math.random() * 9 + 1) * 1000) + "";
    }

}
