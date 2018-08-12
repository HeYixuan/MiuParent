package org.igetwell.system.planet.domain;

import java.util.Date;
import javax.persistence.*;

@Table(name = "planet_said")
public class PlanetSaid {
    /**
     * 主键
     */
    @Id
    @Column(name = "ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 发表用户OPEN_ID
     */
    @Column(name = "OPEN_ID")
    private String openId;

    /**
     * 标签
     */
    @Column(name = "LABEL_NAME")
    private String labelName;

    /**
     * 坐标轴
     */
    @Column(name = "AXIS")
    private String axis;

    /**
     * 点赞数
     */
    @Column(name = "LIKE")
    private Integer like;

    /**
     * 发表时间
     */
    @Column(name = "CREATE_TIME")
    private Date createTime;

    /**
     * 文本内容
     */
    @Column(name = "TEXT")
    private String text;

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
     * 获取发表用户OPEN_ID
     *
     * @return OPEN_ID - 发表用户OPEN_ID
     */
    public String getOpenId() {
        return openId;
    }

    /**
     * 设置发表用户OPEN_ID
     *
     * @param openId 发表用户OPEN_ID
     */
    public void setOpenId(String openId) {
        this.openId = openId == null ? null : openId.trim();
    }

    /**
     * 获取标签
     *
     * @return LABEL_NAME - 标签
     */
    public String getLabelName() {
        return labelName;
    }

    /**
     * 设置标签
     *
     * @param labelName 标签
     */
    public void setLabelName(String labelName) {
        this.labelName = labelName == null ? null : labelName.trim();
    }

    /**
     * 获取坐标轴
     *
     * @return AXIS - 坐标轴
     */
    public String getAxis() {
        return axis;
    }

    /**
     * 设置坐标轴
     *
     * @param axis 坐标轴
     */
    public void setAxis(String axis) {
        this.axis = axis == null ? null : axis.trim();
    }

    /**
     * 获取点赞数
     *
     * @return LIKE - 点赞数
     */
    public Integer getLike() {
        return like;
    }

    /**
     * 设置点赞数
     *
     * @param like 点赞数
     */
    public void setLike(Integer like) {
        this.like = like;
    }

    /**
     * 获取发表时间
     *
     * @return CREATE_TIME - 发表时间
     */
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 设置发表时间
     *
     * @param createTime 发表时间
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    /**
     * 获取文本内容
     *
     * @return TEXT - 文本内容
     */
    public String getText() {
        return text;
    }

    /**
     * 设置文本内容
     *
     * @param text 文本内容
     */
    public void setText(String text) {
        this.text = text == null ? null : text.trim();
    }
}