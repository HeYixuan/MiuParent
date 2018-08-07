package org.igetwell.system.users.service;

import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.lock.DistributedLockHandler;
import org.igetwell.common.lock.Lock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class DistributedService {

    @Autowired
    private DistributedLockHandler distributedLockHandler;

    final Lock lock = new Lock("BIZ:LOCK:TEST", "BIZ:LOCK:TEST");


    public synchronized void doDistribute(){
        if (distributedLockHandler.tryLock(lock)) {

            log.info(Thread.currentThread().getName() + " : do something");
            try {
                Thread.sleep(10000L);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            distributedLockHandler.releaseLock(lock);

        }
    }

}
