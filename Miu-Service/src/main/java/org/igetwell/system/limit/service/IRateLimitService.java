package org.igetwell.system.limit.service;

public interface IRateLimitService {

    /**
     * 获取令牌
     * @return
     */
    boolean tryAcquire();

}
