package com.tangxi.train.proxy;

/**
 * @author: tang.xi
 * @date: 2019/11/15
 * @description:
 */
public class Test {
    public static void main(String[] args) {
        TestJDKProxy jdkProxy = new TestJDKProxy();
        JDKProxyTestService proxy = (JDKProxyTestService) jdkProxy.newProxy(new JDKProxyTestServiceImpl());
        proxy.run();
    }
}
