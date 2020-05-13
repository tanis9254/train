package com.egao.shicloud.framework.bloomfilter;


import com.google.common.hash.BloomFilter;
import com.google.common.hash.Funnels;

/**
 * @author: tang.xi
 * @date: 2020/5/5
 * @description:
 */
public class TestBloomFilter {
    private static final int TOTAL = 10000;
    private static final BloomFilter<Integer> BF = BloomFilter.create(Funnels.integerFunnel(), TOTAL, 0.0001);

    public static void main(String[] args) {
        for (int i = 0; i < TOTAL; i++) {
            BF.put(i);
        }
        for (int i = 0; i < TOTAL; i++) {
            if (!BF.mightContain(i)) {
                System.out.println("有坏人逃脱了~~~");
            }
        }
        int count = 0;
        for (int i = TOTAL; i < TOTAL + 10000; i++) {
            if (BF.mightContain(i)) {
                count++;
            }
        }
        System.out.println("误伤的数量：" + count);
    }
}
