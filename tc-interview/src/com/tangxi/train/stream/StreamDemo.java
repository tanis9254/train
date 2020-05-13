package com.tangxi.train.stream;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author: Administrator
 * @date: 2019/11/14
 * @description:
 */
public class StreamDemo {
    public static void main(String[] args) {
        List<User> list = new ArrayList<User>(){
            {
                add(new User(1L,"张三",10, "清华大学"));
                add(new User(2L,"李四",12, "清华大学"));
                add(new User(3L,"王五",15, "清华大学"));
                add(new User(4L,"赵六",12, "清华大学"));
                add(new User(5L,"田七",25, "北京大学"));
                add(new User(6L,"小明",16, "北京大学"));
                add(new User(7L,"小红",14, "北京大学"));
                add(new User(8L,"小华",14, "浙江大学"));
                add(new User(9L,"小丽",17, "浙江大学"));
                add(new User(10L,"小何",10, "浙江大学"));
            }
        };
        List<User> userList = list.stream().filter(user -> "清华大学".equals(user.getSchool())).collect(Collectors.toList());
        List<Integer> collect = list.stream().map(User::getAge).distinct().collect(Collectors.toList());
        System.out.print(collect);

    }
}
