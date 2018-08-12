package org.igetwell.system.planet.domain;

import java.util.Date;
import javax.persistence.*;

@Table(name = "planet_comment")
public class PlanetComment {
    /**
     * 主键
     */
    @Id
    @Column(name = "ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 星球说ID
     */
    @Column(name = "PLANET_ID")
    private Integer planetId;

    /**
     * 评论用户OPEN_ID
     */
    @Column(name = "OPEN_ID")
    private String openId;

    /**
     * 评论用户的父节点用户
     */
    @Column(name = "PARENT_ID")
    private String parentId;

    /**
     * 评论用户父节点用户昵称
     */
    @Column(name = "PARENT_NAME")
    private String parentName;

    /**
     * 评论内容
     */
    @Column(name = "TEXT")
    private String text;

    /**
     * 评论时间
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
     * 获取星球说ID
     *
     * @return PLANET_ID - 星球说ID
     */
    public Integer getPlanetId() {
        return planetId;
    }

    /**
     * 设置星球说ID
     *
     * @param planetId 星球说ID
     */
    public void setPlanetId(Integer planetId) {
        this.planetId = planetId;
    }

    /**
     * 获取评论用户OPEN_ID
     *
     * @return OPEN_ID - 评论用户OPEN_ID
     */
    public String getOpenId() {
        return openId;
    }

    /**
     * 设置评论用户OPEN_ID
     *
     * @param openId 评论用户OPEN_ID
     */
    public void setOpenId(String openId) {
        this.openId = openId == null ? null : openId.trim();
    }

    /**
     * 获取评论用户的父节点用户
     *
     * @return PARENT_ID - 评论用户的父节点用户
     */
    public String getParentId() {
        return parentId;
    }

    /**
     * 设置评论用户的父节点用户
     *
     * @param parentId 评论用户的父节点用户
     */
    public void setParentId(String parentId) {
        this.parentId = parentId == null ? null : parentId.trim();
    }

    /**
     * 获取评论用户父节点用户昵称
     *
     * @return PARENT_NAME - 评论用户父节点用户昵称
     */
    public String getParentName() {
        return parentName;
    }

    /**
     * 设置评论用户父节点用户昵称
     *
     * @param parentName 评论用户父节点用户昵称
     */
    public void setParentName(String parentName) {
        this.parentName = parentName == null ? null : parentName.trim();
    }

    /**
     * 获取评论时间
     *
     * @return CREATE_TIME - 评论时间
     */
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 设置评论时间
     *
     * @param createTime 评论时间
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}