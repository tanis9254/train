package com.tangxi.train.proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

/**
 * @author: tang.xi
 * @date: 2019/11/15
 * @description:
 */
public class TestJDKProxy implements InvocationHandler {

    //代理目标对象
    private Object targetObject;

    //构造代理对象
    public Object newProxy(Object targetObject) {
        this.targetObject = targetObject;
        return Proxy.newProxyInstance(targetObject.getClass().getClassLoader(),
                targetObject.getClass().getInterfaces(), this);
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        //模拟事务开始
        assumeBeginTransaction();
        //原执行逻辑
        Object ret = method.invoke(targetObject, args);
        //模拟事务提交
        assumeCommitTransaction();
        return ret;
    }

    private void assumeBeginTransaction() {
        System.out.println("模拟事务开始...");
    }

    private void assumeCommitTransaction() {
        System.out.println("模拟事务提交...");
    }
}
