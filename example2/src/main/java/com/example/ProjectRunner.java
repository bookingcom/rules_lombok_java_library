package com.example;

import com.example.cmdline.LombokExample;

public class ProjectRunner {
    public static void main(String args[]) {
        Greeting.sayHi();
        LombokExample l = new LombokExample("Test");
        System.out.println(l.getName());
        com.example.LombokExample le = new com.example.LombokExample("Me");
        System.out.println(le.getLastName());
    }
}
