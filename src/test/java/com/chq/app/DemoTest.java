package com.chq.app;

import org.junit.jupiter.api.Test;


public class DemoTest {

    @Test
    public void test() {
        System.out.println();
        String[] split = "hello world".split(":");
        for (String s : split){
            System.out.println(s);
        }
    }


}
