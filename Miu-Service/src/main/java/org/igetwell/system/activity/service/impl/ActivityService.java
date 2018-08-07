package org.igetwell.system.activity.service.impl;

import com.github.pagehelper.PageHelper;
import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.Pagination;
import org.igetwell.system.activity.domain.Activity;
import org.igetwell.system.activity.mapper.ActivityMapper;
import org.igetwell.system.activity.service.IActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;

@Service
public class ActivityService implements IActivityService {

    @Autowired
    private ActivityMapper activityMapper;

    /**
     * 获取活动列表
     * @return
     */
    public ResponseEntity<Pagination<Activity>> getList(){
        PageHelper.startPage(1,10);
        Collection<Activity> activities = activityMapper.getList();
        Pagination<Activity> pagination = new Pagination<Activity>(activities);
        return new ResponseEntity<Pagination<Activity>>(pagination);
    }
}
