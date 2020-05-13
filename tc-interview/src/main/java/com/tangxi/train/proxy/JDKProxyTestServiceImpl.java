package com.tangxi.train.proxy;

/**
 * @author: tang.xi
 * @date: 2019/11/15
 * @description:
 */
public class JDKProxyTestServiceImpl implements JDKProxyTestService {
    @Override
    public void run() {
        System.out.println("do something...");
    }
}
