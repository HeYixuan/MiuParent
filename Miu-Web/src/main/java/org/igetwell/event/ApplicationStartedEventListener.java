package org.igetwell.event;

import org.igetwell.common.lock.RedisLock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationStartedEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;



@Component
public class ApplicationStartedEventListener implements ApplicationListener<ApplicationStartedEvent> {
    volatile int n = 500;

    @Autowired
    private RedisLock lock;

    @Override
    public void onApplicationEvent(ApplicationStartedEvent applicationStartedEvent) {
        System.err.println(applicationStartedEvent.getSpringApplication().getMainApplicationClass().getName() + "服务启动完毕...");

        System.err.println("1");
        ApplicationStartedEventListener listener = new ApplicationStartedEventListener();
        for (int i = 0; i < 50; i++) {
            ThreadA threadA = new ThreadA(listener);
            threadA.start();
        }
    }

    class ThreadA extends Thread {

        private ApplicationStartedEventListener eventListener;

        public ThreadA(ApplicationStartedEventListener eventListener) {
            this.eventListener = eventListener;
        }

        @Override
        public void run() {
            lock.lock("lock:"+ Thread.currentThread().getName(), "3000");
            System.out.println(Thread.currentThread().getName() + "获得了锁");
            //int i = --n;
            System.out.println(--n);
            lock.unlock("lock:"+Thread.currentThread().getName());
        }
    }
}
