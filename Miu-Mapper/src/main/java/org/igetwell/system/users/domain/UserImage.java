package org.igetwell.system.users.domain;

import javax.persistence.*;

@Table(name = "user_image")
public class UserImage {
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
     * 图片地址
     */
    @Column(name = "IMG_URL")
    private String imgUrl;

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
     * 获取图片地址
     *
     * @return IMG_URL - 图片地址
     */
    public String getImgUrl() {
        return imgUrl;
    }

    /**
     * 设置图片地址
     *
     * @param imgUrl 图片地址
     */
    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl == null ? null : imgUrl.trim();
    }
}