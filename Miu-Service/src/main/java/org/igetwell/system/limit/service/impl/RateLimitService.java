package org.igetwell.system.limit.service.impl;

import com.google.common.util.concurrent.RateLimiter;
import org.igetwell.system.limit.service.IRateLimitService;
import org.springframework.stereotype.Service;

@Service
public class RateLimitService implements IRateLimitService {

    /*每秒控制5个许可*/
    RateLimiter limit = RateLimiter.create(5.0);

    @Override
    public boolean tryAcquire() {

        return limit.tryAcquire();
        /*if (limit.tryAcquire()){
            return new ResponseEntity();
        }
        return new ResponseEntity(HttpStatus.TOO_MANY_REQUESTS,"当前请求过多,请稍后尝试!");*/
    }
}
