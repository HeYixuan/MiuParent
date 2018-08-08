package org.igetwell.web.wechat;


import org.igetwell.common.lock.RedisLock;

public class ThreadTest extends Thread {



    volatile int n=500;

    @Override
    public void run() {
        RedisLock lock = new RedisLock();

        lock.lock("lock", "3000");
//        String identifier = lock.lockWithTimeout("resource", 5000, 1000);
        System.out.println(Thread.currentThread().getName() + "获得了锁");
        n = --n;
        System.out.println(n);
//        lock.releaseLock("resource", identifier);
        lock.unlock("lock");
    }

}

