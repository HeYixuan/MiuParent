package org.igetwell.common.thread;

import java.util.concurrent.*;

public class ThreadExecutor {

    private static ThreadFactory namedThreadFactory = Executors.defaultThreadFactory();

    private static ExecutorService executor = new ThreadPoolExecutor(2, 5,
            1L, TimeUnit.MILLISECONDS,
            new LinkedBlockingQueue<>(3), namedThreadFactory, new ThreadPoolExecutor.AbortPolicy());

    public static void main(String[] args) {
        for (int i = 0; i < 100; i++) {
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    System.out.println(Thread.currentThread().getName()+Thread.currentThread().getId());
                }
            });

        }
        //executor.shutdown();
    }

}
