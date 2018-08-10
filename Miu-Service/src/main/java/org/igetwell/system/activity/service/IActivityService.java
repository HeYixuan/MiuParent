package org.igetwell.system.activity.service;


import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.Pagination;
import org.igetwell.system.activity.domain.Activity;
import org.igetwell.system.activity.retrieve.ActivityEnrollQuery;

import javax.servlet.http.HttpServletRequest;

public interface IActivityService {

    /**
     * 获取活动列表
     * @return
     */
    ResponseEntity<Pagination<Activity>> getList();

    /**
     * 获取活动详情
     * @param activityId
     * @return
     */
    ResponseEntity<Activity> getActivity(Integer activityId);

    /**
     * 报名活动
     * @param activityEnrollQuery
     * @return
     */
    ResponseEntity apply(HttpServletRequest request, ActivityEnrollQuery activityEnrollQuery);
}
