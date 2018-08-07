package org.igetwell.system.activity.domain;

import java.util.Date;
import javax.persistence.*;

@Table(name = "activity_enroll")
public class ActivityEnroll {
    /**
     * 主键
     */
    @Id
    @Column(name = "ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 用户OPEN_ID
     */
    @Column(name = "OPEN_ID")
    private String openId;

    /**
     * 活动ID
     */
    @Column(name = "ACTIVITY_ID")
    private Integer activityId;

    /**
     * 创建时间
     */
    @Column(name = "CREATE_TIME")
    private Date createTime;

    /**
     * 获取主键
     *
     * @return ID - 主键
     */
    public Integer getId() {
        return id;
    }

    /**
     * 设置主键
     *
     * @param id 主键
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * 获取用户OPEN_ID
     *
     * @return OPEN_ID - 用户OPEN_ID
     */
    public String getOpenId() {
        return openId;
    }

    /**
     * 设置用户OPEN_ID
     *
     * @param openId 用户OPEN_ID
     */
    public void setOpenId(String openId) {
        this.openId = openId == null ? null : openId.trim();
    }

    /**
     * 获取活动ID
     *
     * @return ACTIVITY_ID - 活动ID
     */
    public Integer getActivityId() {
        return activityId;
    }

    /**
     * 设置活动ID
     *
     * @param activityId 活动ID
     */
    public void setActivityId(Integer activityId) {
        this.activityId = activityId;
    }

    /**
     * 获取创建时间
     *
     * @return CREATE_TIME - 创建时间
     */
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 设置创建时间
     *
     * @param createTime 创建时间
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}