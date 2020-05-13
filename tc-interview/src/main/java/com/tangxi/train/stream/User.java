package com.tangxi.train.stream;

/**
 * @author: Administrator
 * @date: 2019/11/14
 * @description:
 */
public class User {
    private Long id;
    private String name;
    private Integer age;
    private String school;

    public User(Long id, String name, Integer age, String school) {
        this.id = id;
        this.name = name;
        this.age = age;
        this.school = school;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }
}
