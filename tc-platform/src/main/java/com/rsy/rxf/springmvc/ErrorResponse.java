package com.rsy.rxf.springmvc;

/**
 * Created by fai.yao on 2016/11/29.
 */
public class ErrorResponse {

    public ErrorResponse(){}

    public ErrorResponse(Object code, String message){
        this.code = code;
        this.message = message;
    }

    private Object code;
    private String message;

    public Object getCode() {
        return code;
    }

    public void setCode(Object code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
