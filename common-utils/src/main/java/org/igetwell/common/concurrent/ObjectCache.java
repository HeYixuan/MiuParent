package org.igetwell.common.concurrent;

import java.util.concurrent.Semaphore;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/**
 * 信号量实现的对象池
 * @param <T>
 */
public class ObjectCache<T> {

    //对象工厂
    public interface ObjectFactory<T> {
        T makeObject();
    }

    //将对象封装节点中，放到一个先进先出的队列中，即对象池
    class Node {
        T obj;
        Node next;
    }

    final int capacity;//线程次容量
    final ObjectFactory<T> factory;
    final Lock lock = new ReentrantLock();//保证对象获取，释放的线程安全
    final Semaphore semaphore;//信号量
    private Node head;
    private Node tail;

    public ObjectCache(int capacity, ObjectFactory<T> factory) {
        this.capacity = capacity;
        this.factory = factory;
        this.semaphore = new Semaphore(this.capacity);
        this.head = null;
        this.tail = null;
    }

    /**
     * 从对象池中，获取对象
     * @return
     * @throws InterruptedException
     */
    public T getObject() throws InterruptedException {
        semaphore.acquire();
        return getObjectFromPool();
    }

    /**
     * 线程安全地从对象池获取对象
     * @return
     */
    private T getObjectFromPool() {
        lock.lock();
        try {
            if (head == null) {
                return factory.makeObject();
            } else {
                Node ret = head;
                head = head.next;
                if (head == null)
                    tail = null;
                ret.next = null;// help GC
                return ret.obj;
            }
        } finally {
            lock.unlock();
        }
    }

    /**
     * 线程安全地，将对象放回对象池
     * @param t
     */
    private void putBackObjectToPool(T t) {
        lock.lock();
        try {
            Node node = new Node();
            node.obj = t;
            if (tail == null) {
                head = tail = node;
            } else {
                tail.next = node;
                tail = node;
            }
        } finally {
            lock.unlock();
        }
    }

    /**
     * 将对象放回对象池
     * @param t
     */
    public void putBackObject(T t) {
        putBackObjectToPool(t);
        semaphore.release();
    }
}
