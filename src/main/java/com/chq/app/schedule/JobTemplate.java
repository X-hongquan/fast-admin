package com.chq.app.schedule;

public class JobTemplate {


    @Job("print")
    public void print() {
        System.out.println("我打印一");
    }

    @Job("print2")
    public void print2() {
        System.out.println("我打印二");
    }
}
