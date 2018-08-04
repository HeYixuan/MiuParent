package org.igetwell.web.wechat;

public class TestA {
    public static void main(String[] args) {
        for (int i = 0; i < 50; i++) {
            ThreadTest threadA = new ThreadTest();
            threadA.start();
        }
    }
}
