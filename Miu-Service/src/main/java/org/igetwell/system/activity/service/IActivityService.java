package org.igetwell.system.activity.service;


import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.Pagination;
import org.igetwell.system.activity.domain.Activity;

public interface IActivityService {

    /**
     * 获取活动列表
     * @return
     */
    ResponseEntity<Pagination<Activity>> getList();
}
