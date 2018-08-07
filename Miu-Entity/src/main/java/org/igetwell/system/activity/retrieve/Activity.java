package org.igetwell.system.activity.retrieve;

import lombok.Data;
import java.util.Date;

@Data
public class Activity {

    /**
     * 主键
     */
    private Integer id;

    /**
     * 报名开始时间
     */
    private Date enrollStartTime;

    /**
     * 报名结束时间
     */
    private Date enrollEndTime;

    /**
     * 活动开始时间
     */
    private Date activityStartTime;

    /**
     * 活动结束时间
     */
    private Date activityEndTime;

    /**
     * 0免费；1付费
     */
    private Integer feeType;

    /**
     * 0已删除；1草稿；2审核中；3报名中；4报名结束；5进行中；6已完成；7审核通过；8审核拒绝
     */
    private Integer activityStatus;

    /**
     * 创建时间
     */
    private Date createTime;

}
