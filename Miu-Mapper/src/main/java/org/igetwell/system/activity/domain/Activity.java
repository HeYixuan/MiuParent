package org.igetwell.system.activity.domain;

import java.util.Date;
import javax.persistence.*;

public class Activity {
    /**
     * 主键
     */
    @Id
    @Column(name = "ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 活动名称
     */
    @Column(name = "TITLE")
    private String title;

    /**
     * 报名开始时间
     */
    @Column(name = "ENROLL_START_TIME")
    private Date enrollStartTime;

    /**
     * 报名结束时间
     */
    @Column(name = "ENROLL_END_TIME")
    private Date enrollEndTime;

    /**
     * 活动开始时间
     */
    @Column(name = "ACTIVITY_START_TIME")
    private Date activityStartTime;

    /**
     * 活动结束时间
     */
    @Column(name = "ACTIVITY_END_TIME")
    private Date activityEndTime;

    /**
     * 活动封面
     */
    @Column(name = "ACTIVITY_COVER")
    private String activityCover;

    /**
     * 活动地点
     */
    @Column(name = "DISPLAY_LOCATION")
    private String displayLocation;

    /**
     * 0免费；1付费
     */
    @Column(name = "FEE_TYPE")
    private Integer feeType;

    /**
     * 活动费
     */
    @Column(name = "ACTIVITY_FEE")
    private Integer activityFee;

    /**
     * 浏览次数
     */
    @Column(name = "VIEWS")
    private Integer views;

    /**
     * 0已删除；1草稿；2审核中；3报名中；4报名结束；5进行中；6已完成；7审核通过；8审核拒绝
     */
    @Column(name = "ACTIVITY_STATUS")
    private Integer activityStatus;

    /**
     * 创建时间
     */
    @Column(name = "CREATE_TIME")
    private Date createTime;

    /**
     * 活动介绍
     */
    @Column(name = "ACTIVITY_DESC")
    private String activityDesc;

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
     * 获取活动名称
     *
     * @return TITLE - 活动名称
     */
    public String getTitle() {
        return title;
    }

    /**
     * 设置活动名称
     *
     * @param title 活动名称
     */
    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    /**
     * 获取报名开始时间
     *
     * @return ENROLL_START_TIME - 报名开始时间
     */
    public Date getEnrollStartTime() {
        return enrollStartTime;
    }

    /**
     * 设置报名开始时间
     *
     * @param enrollStartTime 报名开始时间
     */
    public void setEnrollStartTime(Date enrollStartTime) {
        this.enrollStartTime = enrollStartTime;
    }

    /**
     * 获取报名结束时间
     *
     * @return ENROLL_END_TIME - 报名结束时间
     */
    public Date getEnrollEndTime() {
        return enrollEndTime;
    }

    /**
     * 设置报名结束时间
     *
     * @param enrollEndTime 报名结束时间
     */
    public void setEnrollEndTime(Date enrollEndTime) {
        this.enrollEndTime = enrollEndTime;
    }

    /**
     * 获取活动开始时间
     *
     * @return ACTIVITY_START_TIME - 活动开始时间
     */
    public Date getActivityStartTime() {
        return activityStartTime;
    }

    /**
     * 设置活动开始时间
     *
     * @param activityStartTime 活动开始时间
     */
    public void setActivityStartTime(Date activityStartTime) {
        this.activityStartTime = activityStartTime;
    }

    /**
     * 获取活动结束时间
     *
     * @return ACTIVITY_END_TIME - 活动结束时间
     */
    public Date getActivityEndTime() {
        return activityEndTime;
    }

    /**
     * 设置活动结束时间
     *
     * @param activityEndTime 活动结束时间
     */
    public void setActivityEndTime(Date activityEndTime) {
        this.activityEndTime = activityEndTime;
    }

    /**
     * 获取活动封面
     *
     * @return ACTIVITY_COVER - 活动封面
     */
    public String getActivityCover() {
        return activityCover;
    }

    /**
     * 设置活动封面
     *
     * @param activityCover 活动封面
     */
    public void setActivityCover(String activityCover) {
        this.activityCover = activityCover == null ? null : activityCover.trim();
    }

    /**
     * 获取活动地点
     *
     * @return DISPLAY_LOCATION - 活动地点
     */
    public String getDisplayLocation() {
        return displayLocation;
    }

    /**
     * 设置活动地点
     *
     * @param displayLocation 活动地点
     */
    public void setDisplayLocation(String displayLocation) {
        this.displayLocation = displayLocation == null ? null : displayLocation.trim();
    }

    /**
     * 获取0免费；1付费
     *
     * @return FEE_TYPE - 0免费；1付费
     */
    public Integer getFeeType() {
        return feeType;
    }

    /**
     * 设置0免费；1付费
     *
     * @param feeType 0免费；1付费
     */
    public void setFeeType(Integer feeType) {
        this.feeType = feeType;
    }

    /**
     * 获取活动费
     *
     * @return ACTIVITY_FEE - 活动费
     */
    public Integer getActivityFee() {
        return activityFee;
    }

    /**
     * 设置活动费
     *
     * @param activityFee 活动费
     */
    public void setActivityFee(Integer activityFee) {
        this.activityFee = activityFee;
    }

    /**
     * 获取浏览次数
     *
     * @return VIEWS - 浏览次数
     */
    public Integer getViews() {
        return views;
    }

    /**
     * 设置浏览次数
     *
     * @param views 浏览次数
     */
    public void setViews(Integer views) {
        this.views = views;
    }

    /**
     * 获取0已删除；1草稿；2审核中；3报名中；4报名结束；5进行中；6已完成；7审核通过；8审核拒绝
     *
     * @return ACTIVITY_STATUS - 0已删除；1草稿；2审核中；3报名中；4报名结束；5进行中；6已完成；7审核通过；8审核拒绝
     */
    public Integer getActivityStatus() {
        return activityStatus;
    }

    /**
     * 设置0已删除；1草稿；2审核中；3报名中；4报名结束；5进行中；6已完成；7审核通过；8审核拒绝
     *
     * @param activityStatus 0已删除；1草稿；2审核中；3报名中；4报名结束；5进行中；6已完成；7审核通过；8审核拒绝
     */
    public void setActivityStatus(Integer activityStatus) {
        this.activityStatus = activityStatus;
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

    /**
     * 获取活动介绍
     *
     * @return ACTIVITY_DESC - 活动介绍
     */
    public String getActivityDesc() {
        return activityDesc;
    }

    /**
     * 设置活动介绍
     *
     * @param activityDesc 活动介绍
     */
    public void setActivityDesc(String activityDesc) {
        this.activityDesc = activityDesc == null ? null : activityDesc.trim();
    }
}