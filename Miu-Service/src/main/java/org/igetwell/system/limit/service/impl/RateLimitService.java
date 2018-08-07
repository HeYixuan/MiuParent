package org.igetwell.system.limit.service.impl;

import com.google.common.util.concurrent.RateLimiter;
import org.igetwell.common.enums.HttpStatus;
import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.limit.service.IRateLimitService;
import org.springframework.stereotype.Service;

@Service
public class RateLimitService implements IRateLimitService {

    /*每秒控制5个许可*/
    RateLimiter limit = RateLimiter.create(5.0);

    @Override
    public ResponseEntity tryAcquire() {

        if (limit.tryAcquire()){
            return new ResponseEntity();
        }
        return new ResponseEntity(HttpStatus.TOO_MANY_REQUESTS,"请求太频繁!");
    }
}
