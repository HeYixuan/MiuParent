package org.igetwell.common.thread;

import java.util.concurrent.CountDownLatch;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * AtomicInteger，一个提供原子操作的Integer的类。
 * 在Java语言中，++i和i++操作并不是线程安全的，在使用的时候，
 * 不可避免的会用到synchronized关键字。而AtomicInteger则通过一种线程安全的加减操作接口。
 */
public class ShopTickets {

    private static volatile AtomicInteger tickets = new AtomicInteger(10);
    public static void main(String[] args) throws InterruptedException {
        CountDownLatch doneSignal = new CountDownLatch(3);
        Executor exec = Executors.newCachedThreadPool();
        exec.execute(new TicketSales(doneSignal,"售票员1",tickets));
        exec.execute(new TicketSales(doneSignal,"售票员2",tickets));
        exec.execute(new TicketSales(doneSignal,"售票员3",tickets));
        doneSignal.await();
        System.out.println("票已售完,所有售票员，停止售票");
    }
}

class TicketSales implements Runnable {
    //加了这段代码防止超卖
    private static volatile AtomicBoolean isDoned = new AtomicBoolean(Boolean.TRUE);
    private final CountDownLatch doneSignal;
    private final AtomicInteger tickets;
    private String saleName;

    TicketSales(CountDownLatch doneSignal, String saleName,AtomicInteger tickets) {
        this.doneSignal = doneSignal;
        this.saleName = saleName;
        this.tickets = tickets;
    }
    public  void run() {
        doSales(tickets);
    }
    public  void  doSales(AtomicInteger tickets) {
        try {

            while(isDoned.get()){
                System.out.println(saleName+"卖完一张票，还有："+tickets.decrementAndGet()+"张");
                if(tickets.get()==0){
                    isDoned.compareAndSet(true, false);
                }
            }
            //TODO：注释调的代码会发生超卖
            /*while(tickets.get()>0){
                System.out.println(saleName+"卖完一张票，还有："+tickets.decrementAndGet()+"张");
                Thread.sleep(1000);
            }*/
            doneSignal.countDown();
        }catch (Exception e) {
            e.printStackTrace();
        }
    }
}
