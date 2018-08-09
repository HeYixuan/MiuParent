package org.igetwell.system.limit.service.impl;

import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.locks.LockSupport;

public class RequestQueue {

    private final AtomicBoolean locked = new AtomicBoolean(false); //原子锁
    private final Queue<Thread> waiters = new ConcurrentLinkedQueue<Thread>();//线程等待队列

    //加锁
    public void lock() {
      boolean wasInterrupted = false;
        //获取当前线程加入到，线程等待队列
      Thread current = Thread.currentThread();
      waiters.add(current);

      // Block while not first in queue or cannot acquire lock
        //当前线程，不是队列的头部，并且获取锁失败，则park当前线程
      while (waiters.peek() != current || !locked.compareAndSet(false, true)) {
         LockSupport.park(this);
         //如果线程处于中断状态，则wasInterrupted为true
         if (Thread.interrupted()) // ignore interrupts while waiting
           wasInterrupted = true;
      }
      //如果是队列的头部，且获取锁成功，从队列中移除，当前线程
      waiters.remove();
      if (wasInterrupted)          // reassert interrupt status on exit
         current.interrupt();
    }

    //解锁
    public void unlock() {
        locked.set(false);//设置锁为打开状态
        LockSupport.unpark(waiters.peek());//unpark队列头部线程
    }


}
