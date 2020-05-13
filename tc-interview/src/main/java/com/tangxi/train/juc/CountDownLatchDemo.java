package com.tangxi.train.juc;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;
import java.util.concurrent.CountDownLatch;

/**
 * @author unkown
 */
public class CountDownLatchDemo {

    public static void main(String[] args) {
        CountDownLatch countDownLatch = new CountDownLatch(6);
        List<String> teachers = Arrays.asList("语文老师", "数学老师", "英语老师", "物理老师", "化学老师", "生物老师");
        Random random = new Random();
        // 创建6个线程，模拟6个科目的老师同时开始阅卷
        List<Thread> threads = new ArrayList<>(6);
        for (int i = 0; i < 6; i++) {
            threads.add(new Thread(() -> {
                System.out.println(Thread.currentThread().getName() + "阅卷完成");
                // 每位老师阅卷完成后，就让计数器减1
                countDownLatch.countDown();
            }, teachers.get(i)));
        }
        for (Thread thread : threads) {
            thread.start();
        }
        // 让主线程等待所有老师阅卷完成后，再开始计算总分，进行排名
        try {
            countDownLatch.await();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("所有科目的老师均已阅卷完成");
        System.out.println("开始计算总分，然后排名");
    }
}
