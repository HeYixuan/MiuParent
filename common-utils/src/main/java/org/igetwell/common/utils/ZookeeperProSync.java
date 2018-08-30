package org.igetwell.common.utils;

import lombok.extern.slf4j.Slf4j;
import org.apache.zookeeper.WatchedEvent;
import org.apache.zookeeper.Watcher;
import org.apache.zookeeper.ZooKeeper;
import org.apache.zookeeper.data.Stat;

import java.util.concurrent.CountDownLatch;

@Slf4j
public class ZookeeperProSync implements Watcher {

    private static CountDownLatch countDownLatch = new CountDownLatch(1);
    public static Stat stat = new Stat();
    ZooKeeper zk;
    static String path = "/username";

    public static void main(String [] args) {
        //连接zk
        ZooKeeper zk = null;
        try {
            zk = new ZooKeeper("127.0.0.1:2181", 5000, new ZookeeperProSync());
            countDownLatch.await();
            System.err.println(zk.getData(path, true, stat));
        } catch (Exception e) {
            log.error("连接创建失败，发生异常：", e);
        }



    }

    @Override
    public void process(WatchedEvent event) {
        if (Event.KeeperState.SyncConnected == event.getState()){
            if (Event.EventType.None == event.getType() && null == event.getPath()){
                countDownLatch.countDown();
            } else if (event.getType() == Event.EventType.NodeDataChanged){
                try{
                    System.err.println("配置已修改，新值为："+ new String(zk.getData(event.getPath(),true, stat)));
                } catch (Exception e){
                    e.printStackTrace();
                }
            } else if (event.getType() == Event.EventType.NodeChildrenChanged){
                try{
                    System.err.println("子节点配置已修改，新值为："+ zk.getChildren(event.getPath(),true, stat));
                } catch (Exception e){
                    e.printStackTrace();
                }

            }
        }
    }
}
