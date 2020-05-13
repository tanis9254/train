package com.tangxi.train.jvm;

import java.util.ArrayList;

/**
 * @author: tang.xi
 * @date: 2020/4/20
 * @description:
 */
public class oom {
    public static final Integer K = 1024;
    public static void main(String[] args) {
        int size = K * K * 8;
        ArrayList<byte[]> bytes = new ArrayList<>();
        for (int i = 0; i < K; i ++){
            System.out.println("JVM写入数据"+(i+1)+"M");
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e){
                e.printStackTrace();
            }
            bytes.add(new byte[size]);
        }
    }

}
