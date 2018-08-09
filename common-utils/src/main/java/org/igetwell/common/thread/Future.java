package org.igetwell.common.thread;

import java.util.concurrent.*;

public class Future {

    public static void main(String[] args) {
        CountDownLatch startSignal = new CountDownLatch(1);
        CountDownLatch doneSignal = new CountDownLatch(3);
        ExecutorService exec = Executors.newCachedThreadPool();
        RunnableMan rm1 = new RunnableMan(startSignal, doneSignal, 1000);
        RunnableMan rm2 = new RunnableMan(startSignal, doneSignal, 2000);
        RunnableMan rm3 = new RunnableMan(startSignal, doneSignal, 3000);
        java.util.concurrent.Future<Integer> score1 = exec.submit(rm1);
        java.util.concurrent.Future<Integer> score2 = exec.submit(rm2);
        java.util.concurrent.Future<Integer> score3 = exec.submit(rm3);
        System.out.println("开始赛跑......");
        startSignal.countDown();
        try {
            doneSignal.await();
        } catch (InterruptedException e1) {
            e1.printStackTrace();
        }
        int sumScores =0;
        try {
            try {
                sumScores  = score1.get()+score2.get()+score3.get();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        } catch (ExecutionException e) {
            e.printStackTrace();
        }
        System.out.println("团队赛跑结束,最后成绩为："+sumScores);
        exec.shutdown();
    }

}
    class RunnableMan implements Callable<Integer> {
        private final CountDownLatch startSignal;
        private final CountDownLatch doneSignal;
        private final int i;

        RunnableMan(CountDownLatch startSignal, CountDownLatch doneSignal, int i) {
            this.startSignal = startSignal;
            this.doneSignal = doneSignal;
            this.i = i;
        }
        @Override
        public Integer call() throws Exception {
            try {
                startSignal.await();
                doRun(i);
            } catch (Exception e){
                e.printStackTrace();
            }
            doneSignal.countDown();
            return new Integer(i);
        }

        void doRun(int i) throws InterruptedException {
            System.out.println("选手"+i/1000+"正在赛跑中........");
            Thread.sleep(i*2);
        }
}
