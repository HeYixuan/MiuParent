package org.igetwell.system.activity.mapper;

import org.igetwell.system.activity.domain.ActivityEnroll;
import org.igetwell.system.activity.retrieve.ActivityEnrollQuery;
import tk.mybatis.mapper.common.Mapper;

public interface ActivityEnrollMapper extends Mapper<ActivityEnroll> {

    /**
     * 检查活动和用户是否报名
     * @param enroll
     * @return
     */
    boolean getTotal(ActivityEnrollQuery enroll);
}