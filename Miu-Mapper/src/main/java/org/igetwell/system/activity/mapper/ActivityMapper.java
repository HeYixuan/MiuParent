package org.igetwell.system.activity.mapper;

import org.igetwell.system.activity.domain.Activity;
import tk.mybatis.mapper.common.Mapper;

import java.util.Collection;

public interface ActivityMapper extends Mapper<Activity> {

    /**
     *
     */
    Collection<Activity> getList();
}