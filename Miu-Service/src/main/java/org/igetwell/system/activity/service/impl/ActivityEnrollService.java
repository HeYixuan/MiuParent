package org.igetwell.system.activity.service.impl;

import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.activity.domain.ActivityEnroll;
import org.igetwell.system.activity.mapper.ActivityEnrollMapper;
import org.igetwell.system.activity.service.IActivityEnrollService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ActivityEnrollService implements IActivityEnrollService {

    @Autowired
    private ActivityEnrollMapper enrollMapper;

    @Override
    public ResponseEntity save() {
        ActivityEnroll enroll = new ActivityEnroll();
        enroll.setOpenId("wx1");
        enroll.setActivityId(1);
        enrollMapper.insert(enroll);
        return new ResponseEntity();
    }
}
