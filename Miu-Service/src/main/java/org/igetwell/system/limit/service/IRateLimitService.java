package org.igetwell.system.limit.service;

import org.igetwell.common.utils.ResponseEntity;

public interface IRateLimitService {

    /**
     * 获取令牌
     * @return
     */
    ResponseEntity tryAcquire();

}
